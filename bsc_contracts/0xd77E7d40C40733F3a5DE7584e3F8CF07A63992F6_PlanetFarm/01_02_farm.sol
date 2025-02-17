pragma solidity ^0.8.15;

// SPDX-License-Identifier: MIT

import "./Dependencies.sol";


interface IStrategy {

    // Sum of all shares of users
    function sharesTotal() external view returns (uint256);

    // Get wantLockedTotal and sharesTotal  
    function getShares() external view returns (uint256, uint256);

    // Transfer want tokens gammaFarm -> strategy
    function deposit(uint256 _wantAmt) external returns (uint256);

    // for gamma reward deposits
    function deposit(uint256 _wantAmt, bool _chargeFee) external returns (uint256);

    // Transfer want tokens strategy -> gammaFarm
    function withdraw(uint256 _wantAmt) external returns (uint256, uint256);

    // Transfer infinity want tokens strategy -> gammaFarm
    function unstake(uint256 _wantAmt, bool instantly) external returns (uint256, uint256);

    // Transfer want tokens without claiming pending rewards strategy -> gammaFarm
    function emergencyWithdraw(uint256 _wantAmt) external returns (uint256, uint256);

    // Exchange rate between gTokens and iTokens
    function iTokenExchangeRate() external view returns (uint256);

    // Transfer rewards for autocompounding gammaFarm -> strategy
    function earnGammaProfits() external returns (uint256);

    // get pending Rewards generated by strategy
    function getStratPendingRewards() external view returns (uint256);
}

interface Reservoir {
    
    // Get farm drip rate per block 
    function farmV2DripRate() external view returns(uint);

    // Drip rewards reservoir -> gammaFarm
    function drip() external;
    
}

interface IToken {

    // Mint iTokens
    function mint(address accountAddress, uint256 amount) external;

    // Burn iTokens
    function burn(address accountAddress, uint256 amount) external;
}

interface GToken {
    function exchangeRateStored() external view returns (uint256);
}

interface GammaTroller {
    // Called at the time of deposit, withdraw or transfer of iGAMMA to update the factor in green planet markets
    function updateFactor(address _user, uint256 _newiGammaBalance) external;
}


contract PlanetFarm is Initializable, OwnableUpgradeable, ReentrancyGuardUpgradeable {

    using SafeERC20 for IERC20;
    using Math for uint256;

    // Info of each user.
    struct UserInfo {
        uint256 shares; // Number of shares that the user has in the pool.
        uint256 rewardDebt; // Reward adjustment that the user should not receive at the next distribution.
        uint256 factor; // Square root of user.shares * iGammaBalance. This decides the share of boosted rewards that the user receives.
        
        // infinity vault related variables
        uint256 iTokenToBeUnstaked; // keep track of how much iToken the user has started unstaking
        uint256 unstakeStartTime;  // keep track of timestamp at which startUnstakeProcess function is called
        uint256 minTimeToWithdraw; // keep track of minTimeToWithdraw when startUnstakeProcess function is called
        uint256 gTokenToBeUnstaked; //keep track of how much  gToken the user has given for unstaking
        uint256 unstakingRewardDebt; // keep track of the reward debt lost due to unstaking
    }

    struct PoolInfo {
        uint256 allocPoint; //  Number of allocation points assigned to this pool. It determines the share of GAMMA distributed to this pool in the farm.
        uint256 lastRewardBlock; // Block number at which the last GAMMA distribution occurred.
        uint256 accGAMMAPerShare; // Accumulated GAMMA per share, times 1e12.
        uint256 accGAMMAPerFactorPerShare; // Boosted GAMMA rewards to be provided to users per user factor
        uint256 gammaRewardBoostPercentage; // Portion of the total GAMMA rewards to be rewarded to user as boosted rewards
        uint256 totalFactor; // Total factor of the pool. This is the sum of the user factors of all the users in the pool.
        IERC20 want; // Address of the want/lp token.
        address strat; // Address of the strategy that will store or compound want tokens.
        address gToken; // address of gToken associated with the infinity pool
        address iToken; // address of iToken associated with the infinity pool
        bool isInfinity; // whether the pool is any infinity pool
        bool hasStratRewards; // whether the pool has strategy generating extra rewards inaddition to the farm rewards
        bool isBoosted; // whether the pool has boosted rewards
    }

    uint256 public minTimeToWithdraw;
    uint256 public totalAllocPoint; // Total allocation points. Must be the sum of all allocation points in all pools.
    
    uint256 public iGammaPid; 
    address public iGammaAddress; // To handle GAMMA infinity vault separately from all other pools
    
    address public constant GAMMA = 0xb3Cb6d2f8f2FDe203a022201C81a96c167607F15; 
    bool public isDrip; // Specifies if rewards from reservor are turned on for the farm
    bool public autoStakeGamma; // controls whether to stake users rewards to stake to infinity vault or transfer to user

    PoolInfo[] public poolInfo; // Info of each pool.
    Reservoir public ReservoirAddress;
    GammaTroller public GammaTrollerAddress;
    mapping(uint256 => mapping(address => UserInfo)) public userInfo; // Info of each user that stakes tokens.
    mapping(address => uint256) internal usersClaimableGamma;
    mapping(address => uint256) internal lifeTimeRewards;
    mapping(address => uint256) internal gammaDeposited;
    mapping(address => uint256) internal gammaWithdrawn;

    mapping(address => uint256[]) public usersPoolList;

    // Controls whether a given address/user can deposit to gamma infinity vault on behalf of someone else 
    mapping(address => bool) public authorized; 
    
    event Deposit(address indexed user, uint256 indexed pid, uint256 amount);
    event Withdraw(address indexed user, uint256 indexed pid, uint256 amount);

    function initialize() public initializer(){
        __Ownable_init();
        __ReentrancyGuard_init();
        ReservoirAddress = Reservoir(0x7cF0E175908Fc6D7f51CE793271D5c0BD674660F);
        GammaTrollerAddress = GammaTroller(0x1e0C9D09F9995B95Ec4175aaA18b49f49f6165A3);
        minTimeToWithdraw = 21 days;
        isDrip = true;
        autoStakeGamma = true;
    }

    function poolLength() external view returns (uint256) {
        return poolInfo.length;
    }

    // Add a new token to the pool. Can only be called by the owner.
    function add(uint256 _allocPoint, IERC20 _want, address _strat, uint256 _gammaRewardBoostPercentage, bool _withUpdate, bool _isInfinity, address _iToken, address _gToken, bool _hasStratRewards) external onlyOwner{
        require(_gammaRewardBoostPercentage <= 10_000, ">10k");
        // _withudpate should always be true. Made it optional as if we have too many pools, this function might fail. 
        // In that case we call massUpdatePools separately first and then call this fucntion with _withUpdate set to false.
        if (_withUpdate) {
            massUpdatePools();
        }
        //uint256 lastRewardBlock = block.number;
        totalAllocPoint += _allocPoint;
        
        PoolInfo memory poolData = PoolInfo({
            want: _want,
            allocPoint: _allocPoint,
            lastRewardBlock: block.number,
            accGAMMAPerShare: 0,
            strat: _strat,
            accGAMMAPerFactorPerShare: 0, // user's GAMMA share per factor 
            gammaRewardBoostPercentage: _gammaRewardBoostPercentage, // percentage of total dripped that will go for boosted rewards
            totalFactor: 0,
            isInfinity: _isInfinity,
            iToken: _iToken,
            gToken: _gToken,
            hasStratRewards: _hasStratRewards,
            isBoosted: true
        });

        poolInfo.push(poolData);
    
    }
    // Updates the given pool's GAMMA allocation point and gammaRewardBoostPercentage. Can only be called by the owner.
    function set(uint256 _pid, uint256 _allocPoint, uint256 _gammaRewardBoostPercentage, bool _withUpdate, bool _hasStratRewards) external onlyOwner{
        require(_gammaRewardBoostPercentage <= 10_000, ">10k");
        if (_withUpdate) {
            massUpdatePools();
        }
        totalAllocPoint = (totalAllocPoint - poolInfo[_pid].allocPoint) + _allocPoint;
        poolInfo[_pid].allocPoint = _allocPoint;
        poolInfo[_pid].gammaRewardBoostPercentage = _gammaRewardBoostPercentage;
        // This should be true for pools that has startegies generating rewards 
        poolInfo[_pid].hasStratRewards = _hasStratRewards;
    }

    /// @notice Removes pool from the boosted list
    /// @param _pid poolInfo pid that needs to be removed
    function deprecateBoostForPool(uint256 _pid) external onlyOwner {
        require(poolInfo[_pid].gammaRewardBoostPercentage == 0, "boost !0");
        
        //PoolInfo storage poolData = poolInfo[_pid];
        poolInfo[_pid].isBoosted = false;  

    }

    /// @notice Removes pool from users pool list 
    /// @param _pid poolInfo pid that needs to be removed
    /// @param _user user for which the pid is to be removed from the list
    function _removePoolFromUsersPoolList(uint256 _pid, address _user) internal {

        uint256 userPoolListLength = usersPoolList[_user].length;
        for(uint256 i = 0; i < userPoolListLength; ++i){
            if(usersPoolList[_user][i] == _pid){
                usersPoolList[_user][i] = usersPoolList[_user][userPoolListLength - 1];
                usersPoolList[_user].pop();
                break;
            }
        }
    }

    // Return reward multiplier over the given _from to _to block.
    function getMultiplier(uint256 _from, uint256 _to) internal view returns (uint256){
        if(!isDrip){
            return 0;
        }
        return _to - _from;
    }

    // View function to calculate pending GAMMA for one pool.
    function _pendingGAMMA(uint256 _pid, address _user) internal view returns (uint256) {
        if (_pid == iGammaPid){
            return 0;
        }
        PoolInfo memory pool = poolInfo[_pid];
        uint256 userShares = userInfo[_pid][_user].shares;

        if(pool.isInfinity) {
            userShares = IERC20(pool.iToken).balanceOf(_user) - userInfo[_pid][_user].iTokenToBeUnstaked;
        }

        uint256 sharesTotal = IStrategy(pool.strat).sharesTotal();
        if (block.number > pool.lastRewardBlock && sharesTotal != 0) {
            uint256 multiplier = getMultiplier(pool.lastRewardBlock, block.number);
            uint256 GAMMAReward = (multiplier * ReservoirAddress.farmV2DripRate() * pool.allocPoint)/totalAllocPoint;

            if(pool.hasStratRewards){
                    GAMMAReward = GAMMAReward + IStrategy(pool.strat).getStratPendingRewards();
            }

            pool.accGAMMAPerShare = pool.accGAMMAPerShare + ((GAMMAReward*1e12)*(10_000 - pool.gammaRewardBoostPercentage))/(sharesTotal*10_000);

            if(pool.gammaRewardBoostPercentage != 0 && pool.totalFactor != 0){
                pool.accGAMMAPerFactorPerShare = pool.accGAMMAPerFactorPerShare + (GAMMAReward*1e12*pool.gammaRewardBoostPercentage)/(pool.totalFactor*10_000);
            }            
        }
        return (userShares*pool.accGAMMAPerShare + userInfo[_pid][_user].factor*pool.accGAMMAPerFactorPerShare)/1e12 - userInfo[_pid][_user].rewardDebt;
    }

    // View function to see pending GAMMA on frontend for all pools.
    function pendingGAMMAAllPools(address _user) external view returns (uint256) {
        uint256 poolLen = usersPoolList[_user].length;
        uint256 totalPendingGamma;

        for(uint256 i = 0; i < poolLen; ++i){
            totalPendingGamma +=  _pendingGAMMA(usersPoolList[_user][i], _user);
        }
        return totalPendingGamma + usersClaimableGamma[_user];
    }

    function getRewardsInfo(address _user) external view returns (uint256 gammaInfinityRewards, uint256 lifeRewards) {
        uint256 currentGammaBalance = (IERC20(iGammaAddress).balanceOf(_user) * IStrategy(poolInfo[iGammaPid].strat).iTokenExchangeRate() * GToken(poolInfo[iGammaPid].gToken).exchangeRateStored())/1e36;
        gammaInfinityRewards = currentGammaBalance + gammaWithdrawn[_user] - gammaDeposited[_user];
        lifeRewards = lifeTimeRewards[_user] + gammaInfinityRewards;
     }
    
    // Update reward variables for all pools. Be careful of gas spending!
    function massUpdatePools() public{
        for (uint256 pid = 0; pid < poolInfo.length; ++pid) {
            updatePool(pid);
        }
    }

    // Update reward variables of the given pool to be up-to-date.
    function updatePool(uint256 _pid) public{
        PoolInfo storage pool = poolInfo[_pid];

        uint256 lastRewardBlock = pool.lastRewardBlock;
        if (block.number <= lastRewardBlock) {
            return;
        }
        pool.lastRewardBlock = block.number;

        address strat = pool.strat;
        uint256 sharesTotal = IStrategy(strat).sharesTotal();
        uint256 multiplier = getMultiplier(lastRewardBlock, block.number);
        uint256 allocPoint = pool.allocPoint;

        if (sharesTotal == 0 || allocPoint == 0 || multiplier == 0) {
            return;
        }
    
        uint256 GAMMAReward = (multiplier * ReservoirAddress.farmV2DripRate() * allocPoint)/totalAllocPoint;

        // For GAMMA infinity vault, we send farm rewards to strategy and also collect green planet rewards in strategy 
        // and supply both to green planet right away. There are no rewards to be distributed to the user.
        if (_pid == iGammaPid){
            if(GAMMAReward > IERC20(GAMMA).balanceOf(address(this)))
                ReservoirAddress.drip();

            IERC20(GAMMA).safeTransfer(strat, GAMMAReward);
            IStrategy(strat).earnGammaProfits();

            return;
        }
        // For any pools that are generating extra rewards in the strategy, in addition to the farm rewards, (for example, AQUA infinity vault), 
        // we claim rewards from strategy and bring back to farm so that those rewards are included in reward distribution
        if (pool.hasStratRewards) {           
            GAMMAReward += IStrategy(strat).earnGammaProfits();
        }

        uint256 gammaRewardBoostPercentage = pool.gammaRewardBoostPercentage;
        //Reserving gamma based on gammaRewardBoostRate to reward the gamma stakers only
        //So before 100% gamma went to everyone now updatePool function divides total gamma dripped
        //into two bags one for boosted rewards other for the normal rewards. 
        if(pool.totalFactor != 0){
            pool.accGAMMAPerFactorPerShare += ((GAMMAReward * 1e12 * gammaRewardBoostPercentage)/(pool.totalFactor*10_000));
        }
        //Common gamma to distributed to everyone else
        pool.accGAMMAPerShare += ((GAMMAReward * 1e12 * (10_000 - gammaRewardBoostPercentage))/(sharesTotal*10_000));
    }

    // Want tokens moved from user -> GammaFarm (GAMMA allocation) -> Strategy
    function deposit(uint256 _pid, uint256 _wantAmt) external nonReentrant {
        if(_pid == iGammaPid){
       	   depositAuthorized(_msgSender(), _wantAmt, true, true);
    	   return;
	    }
        updatePool(_pid);
        PoolInfo storage pool = poolInfo[_pid];
        UserInfo storage user = userInfo[_pid][_msgSender()];
        uint256 sharesAdded; // same as mint amount in case of infinity vaults
        
        address iToken = pool.iToken;
        address strat = pool.strat;
        uint256 userShares = user.shares;
        uint256 userFactor = user.factor;
        uint256 iTokens;
        uint256 iTokenToBeUnstaked;


        if(pool.isInfinity){
            iTokens = IERC20(iToken).balanceOf(_msgSender());
            iTokenToBeUnstaked = user.iTokenToBeUnstaked;
            userShares = iTokens - iTokenToBeUnstaked;
        }  

        uint256 accGAMMAPerShare = pool.accGAMMAPerShare;
        uint256 accGAMMAPerFactorPerShare = pool.accGAMMAPerFactorPerShare;
    
        usersClaimableGamma[_msgSender()] += ((userShares * accGAMMAPerShare + userFactor * accGAMMAPerFactorPerShare)/1e12 - user.rewardDebt);

        if (_wantAmt != 0) {
            if(userShares == 0 && iTokens == 0){
                usersPoolList[_msgSender()].push(_pid);
            }

            pool.want.safeTransferFrom(address(_msgSender()), strat,_wantAmt);
            sharesAdded = IStrategy(strat).deposit(_wantAmt);

            if(pool.isInfinity) {
                IToken(iToken).mint(_msgSender(), sharesAdded);
                iTokens = IERC20(iToken).balanceOf(_msgSender());
                userShares = iTokens - iTokenToBeUnstaked;
            }
            else {
                user.shares = userShares = userShares + sharesAdded;
                uint256 newFactor = Math.sqrt(userShares * IERC20(iGammaAddress).balanceOf(_msgSender()));
                
                if (userFactor != newFactor){
                    pool.totalFactor = pool.totalFactor - userFactor + newFactor;
                    user.factor = userFactor = newFactor;
                }
            }
        }
        user.rewardDebt = (userShares * accGAMMAPerShare + userFactor * accGAMMAPerFactorPerShare)/1e12;
        emit Deposit(_msgSender(), _pid, _wantAmt);
    }

    // Want tokens moved from user -> GammaFarm (GAMMA allocation) -> Strategy
    // called by gammatroller
    function depositAuthorized(address _user,uint256 _wantAmt) external onlyAuthorized nonReentrant {
        depositAuthorized(_user, _wantAmt, true, false);
    }

    // Want tokens moved from user -> GammaFarm (GAMMA allocation) -> Strategy
    // called directly by farm
    function depositAuthorized(address _user,uint256 _wantAmt, bool takeWantFromMsgsender, bool _chargeFee) internal  {
        updatePool(iGammaPid);
        PoolInfo storage pool = poolInfo[iGammaPid];
        IERC20 want = pool.want;
        address strat = pool.strat;

        if (_wantAmt != 0) {
            if(takeWantFromMsgsender)
                want.safeTransferFrom(address(_msgSender()), strat, _wantAmt);
            else
                want.safeTransfer(strat, _wantAmt);
                
            uint256 mintAmount = IStrategy(strat).deposit(_wantAmt, _chargeFee);
            
            IToken(iGammaAddress).mint(_user, mintAmount);

            uint256 userShares = IERC20(iGammaAddress).balanceOf(_user);

            updateFactorInternal(_user, userShares);
            GammaTrollerAddress.updateFactor(_user, userShares);
            gammaDeposited[_user] += _wantAmt;
            lifeTimeRewards[_user] += _wantAmt; 
        }
        emit Deposit(_user, iGammaPid, _wantAmt);
    }
    
    function check_unstaking_bal_when_transfer(address _sender, address _recepient, uint256 _pid, uint256 _amount) external {
        
        PoolInfo storage pool = poolInfo[_pid];
        address iToken = pool.iToken;
        require((iToken == _msgSender()),"unauth");
        uint256 senderiTokenBalance = IERC20(iToken).balanceOf(_sender);
        uint256 senderiTokenToBeUnstaked = userInfo[_pid][_sender].iTokenToBeUnstaked;

        if(senderiTokenToBeUnstaked != 0 && senderiTokenBalance >= senderiTokenToBeUnstaked) {

            //if user has some iToken in unstaking process 
            uint256 amount_user_can_transfer = senderiTokenBalance - senderiTokenToBeUnstaked;
            
            if(_amount > amount_user_can_transfer){
                stopUnstakeProcessInternal(_sender, _pid);
                senderiTokenToBeUnstaked = 0;
            }
        }

        updatePool(_pid);

        uint256 accGAMMAPerShare = pool.accGAMMAPerShare;

        uint256 recepientiTokenBalance = IERC20(iToken).balanceOf(_recepient);
        uint256 recepientiTokenToBeUnstaked = userInfo[_pid][_recepient].iTokenToBeUnstaked;

        usersClaimableGamma[_sender] += (((senderiTokenBalance - senderiTokenToBeUnstaked) * accGAMMAPerShare) / 1e12 - userInfo[_pid][_sender].rewardDebt);
        usersClaimableGamma[_recepient] += (((recepientiTokenBalance - recepientiTokenToBeUnstaked) * accGAMMAPerShare) / 1e12 - userInfo[_pid][_recepient].rewardDebt);

        userInfo[_pid][_sender].rewardDebt = ((senderiTokenBalance - senderiTokenToBeUnstaked - _amount) * accGAMMAPerShare) / 1e12;
        userInfo[_pid][_recepient].rewardDebt = ((recepientiTokenBalance - recepientiTokenToBeUnstaked + _amount) * accGAMMAPerShare) / 1e12;

        if(recepientiTokenBalance == 0)
                usersPoolList[_recepient].push(_pid);
       
        if(senderiTokenBalance - _amount == 0)
               _removePoolFromUsersPoolList(_pid, _sender);
    }

    function updateFactorByItoken(address _sender, address _recepient) external {
        require(_msgSender() == iGammaAddress, "!iGAMMA");

        uint256 senderiGammaBalance = IERC20(iGammaAddress).balanceOf(_sender);
        uint256 recepientiGammaBalance = IERC20(iGammaAddress).balanceOf(_recepient);

        updateFactorInternal(_sender, senderiGammaBalance);
        updateFactorInternal(_recepient, recepientiGammaBalance);

        GammaTrollerAddress.updateFactor(_sender, senderiGammaBalance);
        GammaTrollerAddress.updateFactor(_recepient, recepientiGammaBalance);
    }

    /// @notice Updates factor after a iGamma token operation.
    /// This function needs to be called by the iGamma contract after
    /// every mint / burn.
    /// @param _user The users address we are updating
    function updateFactorInternal(address _user, uint256 _iGammaBalance) internal {

        uint256 len = usersPoolList[_user].length;
        uint256 pid;
        uint256 shares;
        uint256 oldFactor;
        uint256 accGAMMAPerShare;
        uint256 accGAMMAPerFactorPerShare;
        uint256 pendingRewards;
        uint256 newFactor;

        for(uint256 i = 0; i < len; ++i) {
            pid = usersPoolList[_user][i];
            PoolInfo storage pool = poolInfo[pid];
            UserInfo storage user = userInfo[pid][_user];

            // Skip if infinity pool or unboosted Pool
            if (!pool.isBoosted || pool.isInfinity) {
                continue;
            }

            shares = user.shares;
            // updating pool so that we can distribute rewards based on current user factor
            updatePool(pid);

            // distributing rewards to user based on the current user factor before it gets updated
            oldFactor = user.factor;
            (accGAMMAPerShare, accGAMMAPerFactorPerShare) = (pool.accGAMMAPerShare, pool.accGAMMAPerFactorPerShare);
            pendingRewards += ((shares*accGAMMAPerShare + oldFactor*accGAMMAPerFactorPerShare)/1e12 - user.rewardDebt);

            // Update user factor based on new iGamma Balance
            newFactor = Math.sqrt(shares * _iGammaBalance);
            user.factor = newFactor;
            pool.totalFactor = pool.totalFactor - oldFactor + newFactor;

            // update reward debt based on the latest distribution
            user.rewardDebt = (shares*accGAMMAPerShare + newFactor*accGAMMAPerFactorPerShare)/1e12;
        }

        usersClaimableGamma[_user] += pendingRewards;
    }

    // Withdraw LP tokens from Strategy.
    function withdraw(uint256 _pid, uint256 _wantAmt) external nonReentrant {    
        PoolInfo storage pool = poolInfo[_pid];
        require(!pool.isInfinity, "!infinity");

        updatePool(_pid);

        UserInfo storage user = userInfo[_pid][_msgSender()];

        uint256 userShares = user.shares;
        uint256 userFactor = user.factor;
        uint256 accGAMMAPerShare = pool.accGAMMAPerShare;
        uint256 accGAMMAPerFactorPerShare = pool.accGAMMAPerFactorPerShare;
        (uint256 wantLockedTotal, uint256 sharesTotal) = IStrategy(pool.strat).getShares();

        require(userShares !=0, "user.shares 0");
        require(sharesTotal !=0, "sharesTotal 0");

        usersClaimableGamma[_msgSender()] += ((userShares * accGAMMAPerShare + userFactor * accGAMMAPerFactorPerShare)/1e12 - user.rewardDebt);

        // Withdraw want tokens
        uint256 amount = (userShares*wantLockedTotal)/sharesTotal;
        if (_wantAmt > amount) {
            _wantAmt = amount;
        }

        uint256 toBeSentToUser;
        uint256 sharesRemoved;
        if (_wantAmt != 0) {
            (sharesRemoved, toBeSentToUser) = IStrategy(pool.strat).withdraw(_wantAmt);  

            userShares = userShares - sharesRemoved;
            user.shares = userShares;

            uint256 newFactor = Math.sqrt(userShares * IERC20(iGammaAddress).balanceOf(_msgSender()));
            if (userFactor != newFactor) {
                pool.totalFactor = pool.totalFactor - userFactor + newFactor;
                user.factor = userFactor = newFactor;
            }

            if(userShares == 0)
                _removePoolFromUsersPoolList(_pid, _msgSender());

            pool.want.safeTransfer(address(_msgSender()), toBeSentToUser);
        }

        user.rewardDebt = (userShares * accGAMMAPerShare + userFactor * accGAMMAPerFactorPerShare)/1e12;

        emit Withdraw(_msgSender(), _pid, sharesRemoved);
    }

    function claimAllPoolsPendingGamma() external nonReentrant {
        uint256 length = usersPoolList[_msgSender()].length;
        uint256 pendingRewards;
        uint256 pid;
        uint256 userShares;
        uint256 userFactor;
        uint256 accGAMMAPerShare;
        uint256 accGAMMAPerFactorPerShare;
        
        for(uint256 i = 0; i < length; ++i) {
            pid = usersPoolList[_msgSender()][i];
            updatePool(pid);

            PoolInfo storage pool = poolInfo[pid]; 
            UserInfo storage user = userInfo[pid][_msgSender()];

            userShares = user.shares;
            if(pool.isInfinity){
                userShares = IERC20(pool.iToken).balanceOf(_msgSender()) - user.iTokenToBeUnstaked;
            }
            userFactor = user.factor;
            accGAMMAPerShare = pool.accGAMMAPerShare;
            accGAMMAPerFactorPerShare = pool.accGAMMAPerFactorPerShare;
        
            pendingRewards += ((userShares * accGAMMAPerShare + userFactor * accGAMMAPerFactorPerShare)/1e12 - user.rewardDebt);
            user.rewardDebt = (userShares * accGAMMAPerShare + userFactor * accGAMMAPerFactorPerShare)/1e12;
        }

        pendingRewards += usersClaimableGamma[_msgSender()];
        usersClaimableGamma[_msgSender()] = 0;

        if(pendingRewards > IERC20(GAMMA).balanceOf(address(this)))
            ReservoirAddress.drip();

        if(pendingRewards != 0) {
            if(autoStakeGamma)
                depositAuthorized(_msgSender(),pendingRewards, false, false);
            else
                IERC20(GAMMA).safeTransfer(_msgSender(), pendingRewards);
        }
    }

    // Withdraw without caring about rewards. EMERGENCY ONLY.
    function emergencyWithdraw(uint256 _pid) external nonReentrant {
        PoolInfo storage pool = poolInfo[_pid];
        require(!pool.isInfinity , "infinity");
        UserInfo storage user = userInfo[_pid][_msgSender()];

        IERC20 want = pool.want;
        address strat = pool.strat;

        (uint256 wantLockedTotal, uint256 sharesTotal) = IStrategy(strat).getShares();
       
        uint256 amount = (user.shares*wantLockedTotal)/sharesTotal;
        
        uint256 wantBalBefore = want.balanceOf(address(this));
        IStrategy(strat).emergencyWithdraw(amount); 
        uint256 wantBal = want.balanceOf(address(this)) - wantBalBefore;
        if (wantBal < amount) {
            amount = wantBal;
        }

        user.shares = 0;
        user.rewardDebt = 0;
        pool.totalFactor = pool.totalFactor - user.factor;    
        user.factor = 0;
    
        _removePoolFromUsersPoolList(_pid, _msgSender());

        want.safeTransfer(address(_msgSender()), amount);
    }

    function inCaseTokensGetStuck(address _token, uint256 _amount) external onlyOwner{
        require(_token != GAMMA, "!safe");
        IERC20(_token).safeTransfer(_msgSender(), _amount);
    }

    function setReservoir(Reservoir _reservoir) external onlyOwner {
        ReservoirAddress = _reservoir;
    }

    function setGammaTroller(GammaTroller _gammaTroller) external onlyOwner {
        GammaTrollerAddress = _gammaTroller;
    }
    
    function changeIsDrip(bool _dripStatus, bool _withUpdate) external onlyOwner {
        require(_dripStatus != isDrip,"same");
        if (_withUpdate)
            massUpdatePools();

        isDrip = _dripStatus;        
    }

    function setAutoStakeGamma(bool _isAutoStakeGamma) external onlyOwner {
        autoStakeGamma = _isAutoStakeGamma;
    }
    
    function getUserITokenToBeUnstaked(address account, uint256 pid) external view returns(uint256) {
        return userInfo[pid][account].iTokenToBeUnstaked;
    }

    /**
     * @notice Starts unstaking phase for caller for specific iToken of user
     * @param unstakeAmount: number of tokens given for unstaking 
     */
    function startUnstakeProcess(uint256 _pid, uint256 unstakeAmount) external nonReentrant{
        PoolInfo storage pool = poolInfo[_pid];
        require(pool.isInfinity, "!infinity");
        UserInfo storage user = userInfo[_pid][_msgSender()];

        uint256 useriTokenBalance = IERC20(pool.iToken).balanceOf(_msgSender());
        uint256 iTokenAlreadyGivenForUnstake = user.iTokenToBeUnstaked; 

        require(useriTokenBalance > iTokenAlreadyGivenForUnstake,
        "useriToken<=iTokenAlreadyGivenForUnstake");
        
        // get rewards up to date to be claimed for AQUA infinity vault, and autocompound rewards in strategy for GAMMA infinity vault
        updatePool(_pid); 
        uint256 accGAMMAPerShare;


        // distribute rewards so far minus the rewards for already unstaking amount to the user        
        if(_pid != iGammaPid){
        accGAMMAPerShare = pool.accGAMMAPerShare;
        usersClaimableGamma[_msgSender()] += (((useriTokenBalance - iTokenAlreadyGivenForUnstake) * accGAMMAPerShare)/1e12 - user.rewardDebt);
        }

        uint256 exchangeRate = IStrategy(pool.strat).iTokenExchangeRate();
        uint256 gToken_exchange_rate = GToken(pool.gToken).exchangeRateStored();

        uint256 underlyingEquivalentOfUsersBal = ((useriTokenBalance - iTokenAlreadyGivenForUnstake) * exchangeRate * gToken_exchange_rate)/1e36;

        if (unstakeAmount > underlyingEquivalentOfUsersBal){
            unstakeAmount = underlyingEquivalentOfUsersBal;
        }

        uint256 unstakegTokenAmount =  (unstakeAmount * 1e18) / gToken_exchange_rate;
        uint256 unstakeItokenAmount = (unstakegTokenAmount * 1e18) / exchangeRate;     
        require(unstakeItokenAmount != 0,"!UnstakeiTokenAmount<=0");
        iTokenAlreadyGivenForUnstake += unstakeItokenAmount;

        user.iTokenToBeUnstaked = iTokenAlreadyGivenForUnstake;
        user.unstakeStartTime = block.timestamp;
        user.minTimeToWithdraw = minTimeToWithdraw;
        user.gTokenToBeUnstaked += unstakegTokenAmount;

        if(_pid != iGammaPid) {
            user.rewardDebt = (((useriTokenBalance - iTokenAlreadyGivenForUnstake) * accGAMMAPerShare) / (1e12));
            user.unstakingRewardDebt += (((unstakeItokenAmount) * accGAMMAPerShare) / (1e12));
        }
    }

    /**
     * @notice stops unstaking phase for caller if unstake phase is already started
     */
    function stopUnstakeProcess(uint256 _pid) external nonReentrant{
       /*
        * Stop ongoing unstake process if present for caller 
        */
        stopUnstakeProcessInternal(_msgSender(), _pid);
    }

    /**
     * @notice stops unstaking phase for caller if unstake phase is already started
     */
    function stopUnstakeProcessByIToken(address account, uint256 _pid) external nonReentrant{
        require((poolInfo[_pid].iToken == _msgSender()),"unauth");
        stopUnstakeProcessInternal(account, _pid);
    }

    function stopUnstakeProcessInternal(address userAddress, uint256 _pid) internal {
       /*
        * Stop ongoing unstake process if present for caller 
        */
        UserInfo storage user = userInfo[_pid][userAddress];
        require(user.iTokenToBeUnstaked != 0 , "Nothing's unstaking");
        user.rewardDebt += user.unstakingRewardDebt;
        user.unstakingRewardDebt = 0;
        user.iTokenToBeUnstaked = 0;
        user.unstakeStartTime = 0;
        user.minTimeToWithdraw = 0;
        user.gTokenToBeUnstaked = 0;
    }

    function unstakeInstantly(uint256 _pid, uint256 unstakeAmount ) external nonReentrant{
        PoolInfo storage pool = poolInfo[_pid];
        require(pool.isInfinity, "!infinity");
        UserInfo storage user = userInfo[_pid][_msgSender()];

        updatePool(_pid); 

        address iToken = pool.iToken;
        uint256 useriTokenBalance = IERC20(iToken).balanceOf(_msgSender());
        uint256 useriTokenToBeUnstaked = user.iTokenToBeUnstaked;

        if(_pid != iGammaPid){
            usersClaimableGamma[_msgSender()] += (((useriTokenBalance - useriTokenToBeUnstaked) * pool.accGAMMAPerShare)/1e12 - user.rewardDebt);
        }

        uint256 itokens;
        uint256 exchange_rate_before_withdraw  = IStrategy(pool.strat).iTokenExchangeRate();
        uint256 gToken_exchange_rate = GToken(pool.gToken).exchangeRateStored();

        uint256 underlyingEquivalentOfUsersBal = ((useriTokenBalance - useriTokenToBeUnstaked) * exchange_rate_before_withdraw*gToken_exchange_rate)/1e36;

        if (unstakeAmount > underlyingEquivalentOfUsersBal){
            unstakeAmount = underlyingEquivalentOfUsersBal;
        }
      
        uint256 currentAmount =  (unstakeAmount * 1e18) / gToken_exchange_rate;
        
        uint256 wantAmtTobeSentToUser;
        uint256 stratWantTokensRemoved;
        if (currentAmount != 0) {
            (wantAmtTobeSentToUser, stratWantTokensRemoved ) = IStrategy(pool.strat).unstake(currentAmount, true);
        }

        itokens = (stratWantTokensRemoved * 1e18) / exchange_rate_before_withdraw;

        IToken(iToken).burn(_msgSender(), itokens);

        useriTokenBalance = IERC20(iToken).balanceOf(_msgSender());

        if(_pid == iGammaPid ) {
            updateFactorInternal(_msgSender(), useriTokenBalance);
            GammaTrollerAddress.updateFactor(_msgSender(), useriTokenBalance);
            gammaWithdrawn[_msgSender()] += (stratWantTokensRemoved*gToken_exchange_rate)/1e18; 
        }
        else{
            user.rewardDebt = ((useriTokenBalance - useriTokenToBeUnstaked) * pool.accGAMMAPerShare)/1e12;
            if(useriTokenBalance == 0)
               _removePoolFromUsersPoolList(_pid, _msgSender());
        }


        pool.want.safeTransfer(_msgSender(), wantAmtTobeSentToUser);
        emit Withdraw(_msgSender(), _pid, stratWantTokensRemoved);    
    }

    function unstakeAfterMinWithdrawTime(uint256 _pid) external nonReentrant{        
        PoolInfo storage pool = poolInfo[_pid];
        require(pool.isInfinity, "!infinity");
        UserInfo storage user = userInfo[_pid][_msgSender()];

        updatePool(_pid); 

        address iToken = pool.iToken;
        address strat = pool.strat;
        uint256 useriTokenBalance = IERC20(iToken).balanceOf(_msgSender());
        uint256 totalItokensUnstaking = user.iTokenToBeUnstaked;
        uint256 itokens = totalItokensUnstaking;
        uint256 accGAMMAPerShare = pool.accGAMMAPerShare;

        require(itokens != 0, "itokens <= 0");
        require(user.unstakeStartTime + user.minTimeToWithdraw < block.timestamp, "too early");

        if(_pid != iGammaPid){
            usersClaimableGamma[_msgSender()] += (((useriTokenBalance - totalItokensUnstaking) * accGAMMAPerShare)/1e12 - user.rewardDebt);
        }

        uint256 currentAmount = user.gTokenToBeUnstaked;

        uint256 wantAmtTobeSentToUser;
        uint256 stratWantTokensRemoved;
        if (currentAmount != 0) {
            (wantAmtTobeSentToUser, stratWantTokensRemoved ) = IStrategy(strat).unstake(currentAmount, false);
        }

        itokens = (itokens * stratWantTokensRemoved) / currentAmount;
        require(itokens <= useriTokenBalance,"Withdraw amount exceeds balance");

        IToken(iToken).burn(_msgSender(), itokens);
        useriTokenBalance = IERC20(iToken).balanceOf(_msgSender());
        

        
        if(currentAmount > stratWantTokensRemoved && totalItokensUnstaking > itokens) {
       	   user.gTokenToBeUnstaked = currentAmount - stratWantTokensRemoved;
           user.iTokenToBeUnstaked = totalItokensUnstaking - itokens;
	    }
        else {
       	   user.gTokenToBeUnstaked = 0;
           user.iTokenToBeUnstaked = 0;
       	   user.unstakeStartTime = 0;
       	   user.minTimeToWithdraw = 0;
        }

        if(_pid == iGammaPid) {
            updateFactorInternal(_msgSender(), useriTokenBalance);
            GammaTrollerAddress.updateFactor(_msgSender(), useriTokenBalance);

            uint256 gToken_exchange_rate = GToken(pool.gToken).exchangeRateStored();
            gammaWithdrawn[_msgSender()] += (stratWantTokensRemoved*gToken_exchange_rate)/1e18; 
        }
        else { 
            if( useriTokenBalance == 0)
               _removePoolFromUsersPoolList(_pid, _msgSender());
            uint256 unstakingRewardDebt = user.unstakingRewardDebt;
            uint256 lostRewards = ((itokens * accGAMMAPerShare) / (1e12)) - ((unstakingRewardDebt* itokens)/totalItokensUnstaking);
            
            pool.accGAMMAPerShare += (lostRewards * 1e12 )/(IStrategy(strat).sharesTotal());
            user.rewardDebt = ((useriTokenBalance - (totalItokensUnstaking - itokens)) * accGAMMAPerShare)/1e12;
            user.unstakingRewardDebt = (((totalItokensUnstaking - itokens) * (unstakingRewardDebt * 1e12))/totalItokensUnstaking) / (1e12);
        }
        pool.want.safeTransfer(_msgSender(), wantAmtTobeSentToUser);
        emit Withdraw(_msgSender(), _pid, stratWantTokensRemoved);
    }

    function updateInfinityVaultVariables(uint256 _iGammaPid, address _iGammaAddress) external onlyOwner {
        iGammaPid = _iGammaPid;
        iGammaAddress =  _iGammaAddress;
    }

    function setMinTimeToWithdraw(uint256 newMinTimeToWithdraw) external onlyOwner{
        require(newMinTimeToWithdraw <= 365 days, "too high");
        minTimeToWithdraw = newMinTimeToWithdraw;
    }

    /**
    * @notice this will toggle vault authorized status 
    *         in the contract it is called by owner address only
    */
    function updateAuthorizedAddress(address _vault) external onlyOwner {
        require(_vault != address(0),"address(0)");
        authorized[_vault] = !authorized[_vault];
    }

    function _onlyAuthorized() internal view {
        require(authorized[_msgSender()] == true, "!authorized");
    }

    /**
    * @notice Checks if the _msgSender() is authorized or not
    */
    modifier onlyAuthorized() {
        _onlyAuthorized();
        _;
    }
}