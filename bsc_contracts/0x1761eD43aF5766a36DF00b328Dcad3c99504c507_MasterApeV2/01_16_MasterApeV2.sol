// SPDX-License-Identifier: GPL-3.0
pragma solidity 0.8.17;

/*
  ______                     ______                                 
 /      \                   /      \                                
|  ▓▓▓▓▓▓\ ______   ______ |  ▓▓▓▓▓▓\__   __   __  ______   ______  
| ▓▓__| ▓▓/      \ /      \| ▓▓___\▓▓  \ |  \ |  \|      \ /      \ 
| ▓▓    ▓▓  ▓▓▓▓▓▓\  ▓▓▓▓▓▓\\▓▓    \| ▓▓ | ▓▓ | ▓▓ \▓▓▓▓▓▓\  ▓▓▓▓▓▓\
| ▓▓▓▓▓▓▓▓ ▓▓  | ▓▓ ▓▓    ▓▓_\▓▓▓▓▓▓\ ▓▓ | ▓▓ | ▓▓/      ▓▓ ▓▓  | ▓▓
| ▓▓  | ▓▓ ▓▓__/ ▓▓ ▓▓▓▓▓▓▓▓  \__| ▓▓ ▓▓_/ ▓▓_/ ▓▓  ▓▓▓▓▓▓▓ ▓▓__/ ▓▓
| ▓▓  | ▓▓ ▓▓    ▓▓\▓▓     \\▓▓    ▓▓\▓▓   ▓▓   ▓▓\▓▓    ▓▓ ▓▓    ▓▓
 \▓▓   \▓▓ ▓▓▓▓▓▓▓  \▓▓▓▓▓▓▓ \▓▓▓▓▓▓  \▓▓▓▓▓\▓▓▓▓  \▓▓▓▓▓▓▓ ▓▓▓▓▓▓▓ 
         | ▓▓                                             | ▓▓      
         | ▓▓                                             | ▓▓      
          \▓▓                                              \▓▓         
 * App:             https://ApeSwap.finance
 * Medium:          https://ape-swap.medium.com
 * Twitter:         https://twitter.com/ape_swap
 * Telegram:        https://t.me/ape_swap
 * Announcements:   https://t.me/ape_swap_news
 * Discord:         https://discord.com/ApeSwap
 * Reddit:          https://reddit.com/r/ApeSwap
 * Instagram:       https://instagram.com/ApeSwap.finance
 * GitHub:          https://github.com/ApeSwapFinance
 */

import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@ape.swap/contracts/contracts/v0.8/access/ContractWhitelist.sol";
import "./interfaces/IRewarder.sol";
import "./interfaces/IMasterApeV2.sol";
import "./interfaces/IMasterApe.sol";

/// @notice The (older) MasterApe contract gives out a constant number of BANANA tokens per block.
/// It is the only address with minting rights for BANANA.
/// The idea for this MasterApeV2 (MAV2) contract is therefore to be the owner of a dummy token
/// that is deposited into the MasterApeV1 (MAV1) contract.
/// The allocation point for this pool on MAV1 is the total allocation point for all pools that receive incentives.
contract MasterApeV2 is IMasterApeV2, Initializable, Ownable, ContractWhitelist, ReentrancyGuard {
    using SafeMath for uint256;
    using SafeERC20 for IERC20;

    /// @notice Info of each user's pool deposit
    struct UserInfo {
        uint256 amount; // How many tokens the user has provided
        uint256 rewardDebt; // Reward debt. See explanation below
        //
        // We do some fancy math here. Basically, any point in time, the amount of BANANAs
        // entitled to a user but is pending to be distributed is:
        //
        //   pending reward = (user.amount * pool.accBananaPerShare) - user.rewardDebt
        //
        // Whenever a user deposits or withdraws tokens to a pool. Here's what happens:
        //   1. The pool's `accBananaPerShare` (and `lastRewardBlock`) gets updated.
        //   2. User receives the pending reward sent to his/her address.
        //   3. User's `amount` gets updated.
        //   4. User's `rewardDebt` gets updated.
    }

    /// @notice Info of each pool.
    struct PoolInfo {
        IERC20 stakeToken; // Address of stake token contract.
        IRewarder rewarder; // Address of rewarder contract.
        uint256 allocPoint; // How many allocation points assigned to this pool. BANANAs to distribute per block.
        uint256 totalStaked; // Amount of tokens staked in given pool
        uint256 lastRewardTime; // Last timestamp BANANAs distribution occurs.
        uint256 accBananaPerShare; // Accumulated BANANAs per share, times 1e12. Check code.
        uint16 depositFeeBP; // Deposit fee in basis points
    }

    /// @notice Address which is eligible to accept ownership of the MasterApeV1. Set by the current owner.
    address public pendingMasterApeV1Owner = address(0);
    /// @notice Address of MAV1 contract.
    IMasterApe public immutable masterApe;
    /// @notice The pool id of the MAV2 mock token pool in MAV1.
    uint256 public immutable masterPid;
    /// @notice The BANANA TOKEN!
    IERC20 public immutable banana;
    ///  @notice 40 BANANAs per block in MAV1
    uint256 public constant MASTER_APE_BANANA_PER_BLOCK = 10 ether;
    /// @notice BNB Chain has 3 second block times at the time of deployment
    uint256 public constant MASTER_APE_BANANA_PER_SECOND_ESTIMATE = MASTER_APE_BANANA_PER_BLOCK / 3;
    uint256 public bananaPerSecond;
    uint256 public hardCap = 420000000 ether;
    /// @notice keeps track of unallocated BANANA in the contract
    uint256 public unallocatedBanana;

    /// @notice Deposit Fee address
    address public feeAddress;
    /// @dev Max deposit fee is 10% or 1000 BP
    uint256 public constant MAX_DEPOSIT_FEE_BP = 1000;
    uint256 private constant DEPOSIT_FEE_BP = 10000;

    /// @notice Info of each pool.
    PoolInfo[] public poolInfo;

    /// @notice Info of each user that stakes tokens.
    mapping(uint256 => mapping(address => UserInfo)) public userInfo;
    /// @notice Total allocation points. Must be the sum of all allocation points in all pools.
    uint256 public totalAllocPoint;
    /// @dev tracks existing pools to avoid duplicates
    mapping(IERC20 => bool) public poolExistence;

    event Deposit(address indexed user, uint256 indexed pid, uint256 amount);
    event Withdraw(address indexed user, uint256 indexed pid, uint256 amount);
    event EmergencyWithdraw(address indexed user, uint256 indexed pid, uint256 amount);
    event SetFeeAddress(address indexed user, address indexed newAddress);
    event UpdateEmissionRate(address indexed user, uint256 bananaPerSecond);
    event UpdateHardCap(address indexed user, uint256 hardCap);

    event LogPoolAddition(
        uint256 indexed pid,
        uint256 allocPoint,
        IERC20 indexed stakeToken,
        uint16 depositFee,
        IRewarder indexed rewarder
    );
    event LogSetPool(uint256 indexed pid, uint256 allocPoint, uint16 depositFee, IRewarder indexed rewarder);
    event LogUpdatePool(uint256 indexed pid, uint256 lastRewardBlock, uint256 stakeSupply, uint256 accBananaPerShare);
    event SetPendingMasterApeOwner(address pendingMasterApeOwner);

    /// @dev modifier to avoid adding duplicate pools
    modifier nonDuplicated(IERC20 _stakeToken) {
        require(poolExistence[_stakeToken] == false, "nonDuplicated: duplicated");
        _;
    }

    /// @param banana_ the address of the BANANA token
    /// @param masterApe_ the address of MasterApe
    /// @param masterPid_ the pool id that will control all allocations
    /// @param bananaPerSecond_ the emission rates by second
    constructor(
        IERC20 banana_,
        IMasterApe masterApe_,
        uint256 masterPid_,
        uint256 bananaPerSecond_
    ) {
        banana = banana_;
        masterApe = masterApe_;
        masterPid = masterPid_;
        bananaPerSecond = bananaPerSecond_;
    }

    /// @notice Deposits a dummy token to `masterApe` MAV1.
    /// This is required because MAV1 holds the minting permission of BANANA.
    /// It will transfer all the `dummyToken` in the tx sender address.
    /// The allocation point for the dummy pool on MAV1 should be equal to the total amount of allocPoint.
    function initialize() external initializer onlyOwner {
        (address lpToken, , , ) = masterApe.getPoolInfo(masterPid);
        IERC20 dummyToken = IERC20(lpToken);
        uint256 balance = dummyToken.balanceOf(msg.sender);
        require(balance != 0, "MasterApeV2: bad balance");
        dummyToken.safeTransferFrom(msg.sender, address(this), balance);
        dummyToken.approve(address(masterApe), balance);
        masterApe.deposit(masterPid, balance);
    }

    /// @notice deposit tokens on behalf of sender
    /// @param _pid pool id in which to make deposit
    /// @param _amount amount of tokens to deposit
    function deposit(uint256 _pid, uint256 _amount) external {
        depositTo(_pid, _amount, msg.sender);
    }

    /// @notice withdraw tokens on behalf of sender
    /// @param _pid pool id in which to make withdraw
    /// @param _amount amount of tokens to withdraw
    function withdraw(uint256 _pid, uint256 _amount) external {
        withdrawTo(_pid, _amount, msg.sender);
    }

    /// @notice Withdraw without caring about rewards. EMERGENCY ONLY.
    function emergencyWithdraw(uint256 _pid) external nonReentrant {
        PoolInfo storage pool = poolInfo[_pid];
        UserInfo storage user = userInfo[_pid][msg.sender];
        uint256 amount = user.amount;
        user.amount = 0;
        user.rewardDebt = 0;
        pool.totalStaked = pool.totalStaked.sub(amount);
        pool.stakeToken.safeTransfer(address(msg.sender), amount);
        // Interactions
        if (address(pool.rewarder) != address(0)) {
            pool.rewarder.onReward(_pid, msg.sender, msg.sender, 0, user.amount);
        }
        emit EmergencyWithdraw(msg.sender, _pid, amount);
    }

    /// @notice updates the deposit fee receiver
    /// @param _feeAddress address that receives the fee
    function setFeeAddress(address _feeAddress) external {
        require(msg.sender == feeAddress || msg.sender == owner(), "setFeeAddress: FORBIDDEN");
        feeAddress = _feeAddress;
        emit SetFeeAddress(msg.sender, _feeAddress);
    }

    /// @notice updates the emission rate
    /// @dev reverts if above 3.33 per second
    /// @param _bananaPerSecond how many BANANA per second
    function updateEmissionRate(uint256 _bananaPerSecond) external onlyOwner {
        _updateEmissionRate(_bananaPerSecond);
        massUpdatePools();
    }

    /// @notice Set an address as the pending admin of the MasterApe. The address must accept to take ownership.
    /// @param _pendingMasterApeOwner Address to set as the pending owner of the MasterApe.
    function setPendingMasterApeOwner(address _pendingMasterApeOwner) external onlyOwner {
        pendingMasterApeV1Owner = _pendingMasterApeOwner;
        emit SetPendingMasterApeOwner(pendingMasterApeV1Owner);
    }

    /// @notice The pendingMasterApeOwner takes ownership through this call
    /// @dev Transferring MasterApe ownership away from this contract can brick this contract.
    function acceptMasterApeOwnership() external {
        require(msg.sender == pendingMasterApeV1Owner, "not pending owner");
        masterApe.transferOwnership(pendingMasterApeV1Owner);
        pendingMasterApeV1Owner = address(0);
    }

    /// @notice updates the hard cap
    /// @dev reverts if less than current
    /// @param _hardCap the new hard cap
    function updateHardCap(uint256 _hardCap) external onlyOwner {
        _updateHardCap(_hardCap);
    }

    /// @notice returns the amount of pools created
    function poolLength() external view returns (uint256) {
        return poolInfo.length;
    }

    /// @notice View function to see pending BANANAs on frontend.
    /// @param _pid PID on which to check pending BANANA
    /// @param _user address of which balance is being checked on
    function pendingBanana(uint256 _pid, address _user) external view returns (uint256) {
        PoolInfo memory pool = poolInfo[_pid];
        UserInfo memory user = userInfo[_pid][_user];
        uint256 accBananaPerShare = pool.accBananaPerShare;
        uint256 stakeSupply = pool.totalStaked;
        if (block.timestamp > pool.lastRewardTime && stakeSupply != 0) {
            uint256 multiplier = getMultiplier(pool.lastRewardTime, block.timestamp);
            uint256 bananaReward = multiplier.mul(bananaPerSecond).mul(pool.allocPoint).div(totalAllocPoint);
            accBananaPerShare = accBananaPerShare.add(bananaReward.mul(1e12).div(stakeSupply));
        }
        return user.amount.mul(accBananaPerShare).div(1e12).sub(user.rewardDebt);
    }

    /// @notice Adds a new pool into the Master Ape
    /// @param _allocPoint allocation points of new pool
    /// @param _stakeToken stake token of new pool. It cannot be duplicated
    /// @param _withUpdate if we should mass update all existing pools
    /// @param _depositFeeBP the basis points of the deposit fee
    /// @param _rewarder A rewarder compliant smart contract
    function add(
        uint256 _allocPoint,
        IERC20 _stakeToken,
        bool _withUpdate,
        uint16 _depositFeeBP,
        IRewarder _rewarder
    ) public onlyOwner nonDuplicated(_stakeToken) {
        // TODO: Look into this (probably bad PCS coding and can be fixed)
        // stake BANANA token will cause staked token and reward token mixed up,
        // may cause staked tokens withdraw as reward token,never do it.
        require(_stakeToken != banana, "BANANA can't be added");
        require(_depositFeeBP <= MAX_DEPOSIT_FEE_BP, "add: invalid deposit fee");

        if (_withUpdate) {
            massUpdatePools();
        }

        uint256 lastRewardTime = block.timestamp;
        totalAllocPoint = totalAllocPoint.add(_allocPoint);
        poolExistence[_stakeToken] = true;

        poolInfo.push(
            PoolInfo({
                stakeToken: _stakeToken,
                rewarder: _rewarder,
                allocPoint: _allocPoint,
                lastRewardTime: lastRewardTime,
                accBananaPerShare: 0,
                totalStaked: 0,
                depositFeeBP: _depositFeeBP
            })
        );

        emit LogPoolAddition(poolInfo.length.sub(1), _allocPoint, _stakeToken, _depositFeeBP, _rewarder);
    }

    /// @notice  Update the given pool's BANANA allocation point and deposit fee. Can only be called by the owner.
    /// @param _pid id of pool to update
    /// @param _allocPoint allocation points of new pool
    /// @param _withUpdate if we should mass update all existing pools
    /// @param _depositFeeBP the basis points of the deposit fee
    /// @param _rewarder A rewarder compliant smart contract
    function set(
        uint256 _pid,
        uint256 _allocPoint,
        bool _withUpdate,
        uint16 _depositFeeBP,
        IRewarder _rewarder
    ) public onlyOwner {
        require(_depositFeeBP <= MAX_DEPOSIT_FEE_BP, "set: invalid deposit fee");
        if (_withUpdate) {
            massUpdatePools();
        } else {
            updatePool(_pid);
        }

        totalAllocPoint = totalAllocPoint.sub(poolInfo[_pid].allocPoint).add(_allocPoint);
        poolInfo[_pid].allocPoint = _allocPoint;
        poolInfo[_pid].depositFeeBP = _depositFeeBP;
        poolInfo[_pid].rewarder = _rewarder;

        emit LogSetPool(_pid, _allocPoint, _depositFeeBP, _rewarder);
    }

    /// @notice Update reward variables for all pools. Be careful of gas spending!
    function massUpdatePools() public {
        uint256 length = poolInfo.length;
        for (uint256 pid = 0; pid < length; ++pid) {
            updatePool(pid);
        }
    }

    /// @notice Update reward variables of the given pool to be up-to-date.
    function updatePool(uint256 _pid) public {
        PoolInfo storage pool = poolInfo[_pid];
        if (block.timestamp <= pool.lastRewardTime) {
            return;
        }
        uint256 stakeSupply = pool.totalStaked;
        if (stakeSupply == 0 || pool.allocPoint == 0) {
            pool.lastRewardTime = block.timestamp;
            return;
        }
        uint256 multiplier = getMultiplier(pool.lastRewardTime, block.timestamp);
        uint256 totalBanana = multiplier.mul(bananaPerSecond).mul(pool.allocPoint).div(totalAllocPoint);
        if (totalBanana == 0) return;
        if (totalBanana > unallocatedBanana) harvestFromMasterApe();

        if (banana.totalSupply() + totalBanana - unallocatedBanana > hardCap) {
            // This is true when assigning more rewards than possible within the bounds of the hardcap
            harvestFromMasterApe();
            // Make sure we have the latest number for unallocatedBanana before doing any crazy stuff
            if (totalBanana >= unallocatedBanana) {
                // This can only be true if emissions stopped
                // (or if we are allocating more than 3.333 per second which should not be possible)
                // See _updateEmissionRate
                totalBanana = unallocatedBanana;
                if (bananaPerSecond != 0) {
                    // If we get here MasterApeV1 Emissions already stopped
                    // we allocate the remainder unallocatedBanana and stop emissions on MAv2
                    _updateEmissionRate(0);
                }
            }
        }

        pool.accBananaPerShare = pool.accBananaPerShare.add(totalBanana.mul(1e12).div(stakeSupply));
        pool.lastRewardTime = block.timestamp;
        unallocatedBanana -= totalBanana;
        emit LogUpdatePool(_pid, pool.lastRewardTime, stakeSupply, pool.accBananaPerShare);
    }

    /// @notice Deposit tokens to MasterApe for BANANA allocation.
    /// @param _pid pool id in which to make deposit
    /// @param _amount amount of tokens to deposit
    /// @param _to who receives the staked amount
    function depositTo(
        uint256 _pid,
        uint256 _amount,
        address _to
    ) public nonReentrant checkEOAorWhitelist {
        PoolInfo storage pool = poolInfo[_pid];
        UserInfo storage user = userInfo[_pid][_to];
        uint256 finalDepositAmount;
        uint256 pending;
        updatePool(_pid);
        if (user.amount > 0) {
            pending = user.amount.mul(pool.accBananaPerShare).div(1e12).sub(user.rewardDebt);
            if (pending > 0) {
                _safeBananaTransfer(_to, pending);
            }
        }
        if (_amount > 0) {
            // Prefetch balance to account for transfer fees
            uint256 preStakeBalance = pool.stakeToken.balanceOf(address(this));
            pool.stakeToken.safeTransferFrom(address(msg.sender), address(this), _amount);
            finalDepositAmount = pool.stakeToken.balanceOf(address(this)) - preStakeBalance;

            if (pool.depositFeeBP > 0) {
                uint256 depositFee = finalDepositAmount.mul(pool.depositFeeBP).div(DEPOSIT_FEE_BP);
                pool.stakeToken.safeTransfer(feeAddress, depositFee);
                finalDepositAmount = finalDepositAmount.sub(depositFee);
            }

            user.amount = user.amount.add(finalDepositAmount);
            pool.totalStaked = pool.totalStaked.add(finalDepositAmount);
        }
        // Interactions
        if (address(pool.rewarder) != address(0)) {
            pool.rewarder.onReward(_pid, _to, _to, pending, user.amount);
        }
        user.rewardDebt = user.amount.mul(pool.accBananaPerShare).div(1e12);
        emit Deposit(_to, _pid, finalDepositAmount);
    }

    /// @notice Withdraw tokens from MasterApe.
    /// @param _pid pool id in which to make withdraw
    /// @param _amount amount of tokens to withdraw
    /// @param _to address who receives the withdrawn amount
    function withdrawTo(
        uint256 _pid,
        uint256 _amount,
        address _to
    ) public nonReentrant {
        PoolInfo storage pool = poolInfo[_pid];
        UserInfo storage user = userInfo[_pid][msg.sender];
        require(user.amount >= _amount, "withdraw: insufficient");
        updatePool(_pid);
        uint256 pending = user.amount.mul(pool.accBananaPerShare).div(1e12).sub(user.rewardDebt);
        if (pending > 0) {
            _safeBananaTransfer(_to, pending);
        }
        if (_amount > 0) {
            user.amount = user.amount.sub(_amount);
            pool.totalStaked = pool.totalStaked.sub(_amount);
            pool.stakeToken.safeTransfer(_to, _amount);
        }
        // Interactions
        if (address(pool.rewarder) != address(0)) {
            pool.rewarder.onReward(_pid, msg.sender, _to, pending, user.amount);
        }
        user.rewardDebt = user.amount.mul(pool.accBananaPerShare).div(1e12);
        emit Withdraw(msg.sender, _pid, _amount);
    }

    /// @notice Harvests BANANA from `masterApe` MAV1 and pool `masterPid` to MAV2.
    function harvestFromMasterApe() public {
        uint256 beforeBananaBal = banana.balanceOf(address(this));
        masterApe.deposit(masterPid, 0);
        uint256 bananaTotalSupply = banana.totalSupply();
        if (banana.totalSupply() >= hardCap && masterApe.BONUS_MULTIPLIER() > 0) {
            masterApe.updateMultiplier(0);
            uint256 surplus = bananaTotalSupply - hardCap;
            uint256 currentBananaBal = banana.balanceOf(address(this));
            if (currentBananaBal >= surplus)
                banana.transfer(address(0x000000000000000000000000000000000000dEaD), surplus);
            else {
                /// @dev These are safeguards to avoid bricking the contract 
                /// nevertheless off-chain checks and interactions should make this case impossible
                /// This happens when the hard-cap block is missed by so much 
                /// that the surplus in the dev wallet exceeds what this contract can burn by itself
                unallocatedBanana = 0;
                banana.transfer(address(0x000000000000000000000000000000000000dEaD), currentBananaBal);
                return;
            }
        }
        uint256 bananaBal = banana.balanceOf(address(this));
        unallocatedBanana += bananaBal - beforeBananaBal;
    }

    /// @notice returns all pool info
    function getPoolInfo(uint256 _pid)
        public
        view
        returns (
            address lpToken,
            uint256 allocPoint,
            address rewarder,
            uint256 lastRewardBlock,
            uint256 accBananaPerShare,
            uint256 totalStaked,
            uint16 depositFeeBP
        )
    {
        return (
            address(poolInfo[_pid].stakeToken),
            poolInfo[_pid].allocPoint,
            address(poolInfo[_pid].rewarder),
            poolInfo[_pid].totalStaked,
            poolInfo[_pid].lastRewardTime,
            poolInfo[_pid].accBananaPerShare,
            poolInfo[_pid].depositFeeBP
        );
    }

    /// @notice Return reward multiplier over the given _from to _to block.
    /// @param _from from what timestamp
    /// @param _to to what timestamp
    /// @return uint256
    function getMultiplier(uint256 _from, uint256 _to) public pure returns (uint256) {
        return _to.sub(_from);
    }

    /// @dev Safe banana transfer function, just in case if rounding error causes pool to not have enough BANANAs.
    function _safeBananaTransfer(address _to, uint256 _amount) internal {
        uint256 bananaBal = banana.balanceOf(address(this));
        if (_amount > bananaBal) {
            harvestFromMasterApe();
        }
        bananaBal = banana.balanceOf(address(this));
        if (_amount > bananaBal) {
            banana.safeTransfer(_to, bananaBal);
        } else {
            banana.safeTransfer(_to, _amount);
        }
    }

    function _updateEmissionRate(uint256 _bananaPerSecond) internal {
        require(_bananaPerSecond <= MASTER_APE_BANANA_PER_SECOND_ESTIMATE, "More than maximum rate");
        bananaPerSecond = _bananaPerSecond;
        emit UpdateEmissionRate(msg.sender, _bananaPerSecond);
    }

    function _updateHardCap(uint256 _hardCap) internal {
        require(_hardCap > banana.totalSupply(), "Updated cap is less than total supply");
        hardCap = _hardCap;
        emit UpdateHardCap(msg.sender, _hardCap);
    }
}