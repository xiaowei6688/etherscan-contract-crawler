//SPDX-License-Identifier: Unlicense
pragma solidity >=0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/structs/EnumerableSet.sol";

interface IPayoutAgent {
    function payout(address, uint, bool) external;
}

contract TefiVault is Ownable, Pausable, ReentrancyGuard {
    using SafeERC20 for IERC20;
    using EnumerableSet for EnumerableSet.AddressSet;

    struct UserInfo {
        uint amount;
        uint share;
        uint expireAt;
        uint depositedAt;
        uint claimedAt;
    }

    address public strategy;
    IERC20 public asset;
    address public payoutAgent;
    address public treasuryWallet = 0x647BB910944165D14b961985c28b06b08cA47f77;

    uint public totalSupply;
    uint public totalShare;
    uint public underlying;
    uint public profits;
    uint public boostFund;

    mapping(address => UserInfo) public users;
    mapping(address => address) public referrals;
    EnumerableSet.AddressSet userList;
    mapping(address => bool) public invested;
    mapping(address => bool) public investWhitelist;
    mapping(address => bool) public permanentWhitelist;
    mapping(address => bool) public agents;

    uint public rebalanceRate = 20;
    uint public farmPeriod = 60 days;
    uint public expireDelta = 2 days;
    uint public maxSupply = type(uint).max;
    uint public maxUserSupply = 1_000_000 ether;
    bool public isPublic;

    bool locked;
    uint public constant DUST = 0.1 ether;

    event Deposited(address indexed user, uint amount);
    event BulkDeposited(address indexed user, uint amount);
    event Withdrawn(address indexed user, uint amount);
    event WithdrawnAll(address indexed user, uint amount);
    event Claimed(address indexed user, uint amount);
    event Compounded(address indexed user, uint amount);

    modifier onlyStrategy {
        require (msg.sender == strategy, "!permission");
        _;
    }

    modifier clearDustShare {
        _;
        UserInfo storage user = users[msg.sender];
        if (balanceOf(msg.sender) < DUST) {
            totalSupply -= user.amount;
            totalShare -= user.share;
            delete users[msg.sender];

            if (!permanentWhitelist[msg.sender]) {
                investWhitelist[msg.sender] = false;
            }
        }
    }

    modifier updateUserList {
        _;
        if (balanceOf(msg.sender) > 0) {
            if (!userList.contains(msg.sender)) userList.add(msg.sender);
        }
        else if (userList.contains(msg.sender)) userList.remove(msg.sender);
    }


    constructor(address _strategy, address _asset, address _payoutAgent) {
        strategy = _strategy;
        asset = IERC20(_asset);
        payoutAgent = _payoutAgent;

        asset.approve(payoutAgent, type(uint).max);
    }

    function getUserList() external view returns (address[] memory) {
        return userList.values();
    }

    function userCount() external view returns (uint) {
        return userList.length();
    }

    function referredWallets(address _wallet) external view returns (address[] memory) {
        uint count;
        for (uint i = 0; i < userList.length(); i++) {
            address user = userList.at(i);
            if (referrals[user] == _wallet) count++;
        }
        if (count == 0) return new address[](0);

        address[] memory _referrals = new address[](count);
        count = 0;
        for (uint i = 0; i < userList.length(); i++) {
            address user = userList.at(i);
            if (referrals[user] == _wallet) _referrals[count] = user;
            ++count;
        }
        return _referrals;
    }

    function balance() public view returns (uint) {
        return asset.balanceOf(address(this)) + underlying - boostFund;
    }

    function available() public view returns (uint) {
        return asset.balanceOf(address(this));
    }

    function balanceOf(address _user) public view returns (uint) {
        return totalShare == 0 ? 0 : users[_user].share * balance() / totalShare;
    }

    function principalOf(address _user) public view returns (uint) {
        if (totalShare == 0) return 0;
        UserInfo storage user = users[_user];
        uint curBal = user.share * balance() / totalShare;
        return curBal > user.amount ? user.amount : curBal;
    }

    function lostOf(address _user) public view returns (uint) {
        if (totalShare == 0) return 0;
        UserInfo storage user = users[_user];
        uint curBal = user.share * balance() / totalShare;
        return curBal < user.amount ? (user.amount - curBal) : 0;
    }

    function earned(address _user) public view returns (uint) {
        UserInfo storage user = users[_user];
        uint bal = balanceOf(_user);
        return user.amount < bal ? (bal - user.amount) : 0;
    }

    function claimable(address _user) public view returns (uint) {
        return _calculateExpiredEarning(_user);
    }

    function totalEarned() external view returns (uint) {
        uint totalBal = balance();
        return totalBal > totalSupply ? (totalBal - totalSupply) : 0;
    }

    function checkExpiredUsers() external view returns (uint, address[] memory) {
        uint count;
        for (uint i = 0; i < userList.length(); i++) {
            if (users[userList.at(i)].expireAt + expireDelta <= block.timestamp) count++;
        }
        if (count == 0) return (0, new address[](0));
        address[] memory wallets = new address[](count);
        count = 0;
        for (uint i = 0; i < userList.length(); i++) {
            address wallet = userList.at(i);
            if (users[wallet].expireAt + expireDelta <= block.timestamp) {
                wallets[count] = wallet;
                count++;
            }
        }
        return (wallets.length, wallets);
    }

    function bulkDeposit(address[] calldata _users, uint[] calldata _amounts) external whenNotPaused nonReentrant {
        require (agents[msg.sender] == true, "!agent");
        require (_users.length == _amounts.length, "!sets");

        uint totalAmount;
        uint _totalShare = totalShare;
        uint poolBal = balance();
        for (uint i = 0; i < _users.length;) {
            uint _amount = _amounts[i];
            address _user = _users[i];
            require (_amount > 0, "!amount");

            uint share;
            if (_totalShare == 0) {
                share = _amount;
            } else {
                share = (_amount * _totalShare) / poolBal;
            }

            users[_user].share += share;
            users[_user].amount += _amount;
            investWhitelist[_user] = true;

            if (users[_user].expireAt == 0) {
                users[_user].expireAt = block.timestamp + farmPeriod;
            }

            if (!invested[_user]) invested[_user] = true;

            if (!userList.contains(_user)) userList.add(_user);

            poolBal += _amount;
            totalAmount += _amount;
            _totalShare += share;
            unchecked {
                ++i;
            }
        }

        asset.transferFrom(msg.sender, address(this), totalAmount);

        totalSupply += totalAmount;
        totalShare = _totalShare;

        _rebalance();

        emit BulkDeposited(msg.sender, totalAmount);
    }

    function deposit(uint _amount) external whenNotPaused nonReentrant updateUserList {
        UserInfo storage user = users[msg.sender];
        require (isPublic || investWhitelist[msg.sender], "!investor");
        require (
            user.share == 0 || 
            permanentWhitelist[msg.sender] ||
            user.claimedAt < user.expireAt, 
            "expired"
        );
        require (_amount > 0, "!amount");
        require (user.amount + _amount <= maxUserSupply, "exeeded user max supply");
        require (totalSupply + _amount <= maxSupply, "exceeded max supply");

        uint share;
        uint poolBal = balance();
        if (totalShare == 0) {
            share = _amount;
        } else {
            share = (_amount * totalShare) / poolBal;
        }

        asset.transferFrom(msg.sender, address(this), _amount);

        user.share += share;
        user.amount += _amount;
        totalShare += share;
        totalSupply += _amount;

        if (user.expireAt == 0) {
            user.expireAt = block.timestamp + farmPeriod;
            user.claimedAt = block.timestamp;
        }

        if (!invested[msg.sender]) invested[msg.sender] = true;

        _rebalance();

        emit Deposited(msg.sender, _amount);
    }

    function withdraw(uint _amount, bool _sellback) external nonReentrant updateUserList clearDustShare {
        UserInfo storage user = users[msg.sender];
        uint principal = principalOf(msg.sender);
        require (principal >= _amount, "exceeded amount");
        require (_amount <= available()- profits, "exceeded withdrawable amount");
        
        uint share = _min((_amount * totalShare / balance()), user.share);

        user.share -= share;
        totalShare -= share;
        user.amount -= _amount;
        totalSupply -= _amount;
        
        // asset.safeTransfer(msg.sender, _amount);
        asset.safeTransfer(treasuryWallet, _amount * 5 / 100);
        _amount = _amount * 95 / 100;
        IPayoutAgent(payoutAgent).payout(msg.sender, _amount, _sellback);

        emit Withdrawn(msg.sender, _amount);
    }

    function withdrawAll(bool _sellback) external nonReentrant updateUserList {
        _withdrawAll(msg.sender, _sellback);
    }

    function _withdrawAll(address _user, bool _sellback) internal {
        UserInfo storage user = users[_user];
        require (user.share > 0, "!balance");

        uint availableEarned = earned(_user);
        uint _earned = _calculateExpiredEarning(_user);
        uint left = availableEarned - (_earned * 95 / 100);
        
        uint _amount = user.share * balance() / totalShare;
        require (_amount - availableEarned <= available() - profits, "exceeded withdrawable amount");

        totalShare -= user.share;
        totalSupply -= user.amount;
        profits -= _min(profits, availableEarned);
        delete users[_user];

        uint withdrawalFee = (_amount - availableEarned) * 5 / 100;
        uint profitFee = _earned * 5 / 100;
        boostFund += left;

        address referral = referrals[_user];
        if (referral != address(0)) {
            if (profitFee > 0) asset.safeTransfer(referral, profitFee);
            asset.safeTransfer(treasuryWallet, withdrawalFee);
        } else {
            asset.safeTransfer(treasuryWallet, withdrawalFee + profitFee);
        }
        _amount -= (withdrawalFee + profitFee + left);
        
        // asset.safeTransfer(_user, _amount);
        IPayoutAgent(payoutAgent).payout(_user, _amount, _sellback);

        if (!permanentWhitelist[_user]) {
            investWhitelist[_user] = false;
        }

        emit WithdrawnAll(_user, _amount);
    }

    function claim(bool _sellback) external nonReentrant updateUserList clearDustShare {
        UserInfo storage user = users[msg.sender];
        require (permanentWhitelist[msg.sender] || user.claimedAt < user.expireAt, "expired");

        uint availableEarned = earned(msg.sender);
        require (availableEarned > 0, "!earned");

        uint _earned = _calculateExpiredEarning(msg.sender);
        uint left = availableEarned - (_earned * 95 / 100);
        uint share = _min((availableEarned * totalShare / balance()), user.share);

        user.share -= share;
        user.claimedAt = block.timestamp;
        totalShare -= share;
        
        // asset.safeTransfer(msg.sender, _earned);
        address referral = referrals[msg.sender];
        asset.safeTransfer(referral != address(0) ? referral : treasuryWallet, _earned * 5 / 100);
        IPayoutAgent(payoutAgent).payout(msg.sender, _earned * 90 / 100, _sellback);

        profits -= _min(profits, availableEarned);
        boostFund += left;

        emit Claimed(msg.sender, _earned * 90 / 100);
    }

    function compound() external nonReentrant {
        UserInfo storage user = users[msg.sender];
        require (permanentWhitelist[msg.sender] || user.claimedAt < user.expireAt, "expired");

        uint availableEarned = earned(msg.sender);
        require (availableEarned > 0, "!earned");

        uint _earned = _calculateExpiredEarning(msg.sender);

        address referral = referrals[msg.sender];
        asset.safeTransfer(referral != address(0) ? referral : treasuryWallet, _earned * 5 / 100);

        uint compounded = _earned * 90 / 100;
        uint left = availableEarned - (_earned * 95 / 100);
        uint bal = balance();
        uint share1 = availableEarned * totalShare / bal;
        uint share2 = compounded * (totalShare - share1) / (bal - availableEarned);
        
        user.share -= (share1 - share2);
        user.amount += compounded;
        user.claimedAt = block.timestamp;
        totalShare -= (share1 - share2);
        totalSupply += compounded;
        profits -= _min(profits, availableEarned);
        boostFund += left;

        _rebalance();

        emit Compounded(msg.sender, compounded);
    }

    function rebalance() external nonReentrant {
        _rebalance();
    }
    
    function _rebalance() internal {
        uint invest = investable();
        if (invest == 0) return;
        asset.safeTransfer(strategy, invest);
        underlying += invest;
    }

    function _calculateExpiredEarning(address _user) internal view returns (uint) {
        uint _claimedAt = users[_user].claimedAt;
        uint _expireAt = users[_user].expireAt;
        uint _earned = earned(_user);
        if (permanentWhitelist[_user] || _expireAt > block.timestamp) return _earned;
        if (_claimedAt >= _expireAt) return 0;
        return _earned * (_expireAt - _claimedAt) / (block.timestamp - _claimedAt);
    }

    function investable() public view returns (uint) {
        uint curBal = available();
        uint poolBal = curBal + underlying - profits;
        uint keepBal = rebalanceRate * poolBal / 100 + profits;
        
        if (curBal <= keepBal) return 0;

        return curBal - keepBal;
    }

    function refillable() public view returns (uint) {
        uint curBal = available();
        uint poolBal = curBal + underlying - profits;
        uint keepBal = rebalanceRate * poolBal / 100 + profits;
        
        if (curBal >= keepBal) return 0;

        return keepBal - curBal;
    }

    function _min(uint x, uint y) internal pure returns (uint) {
        return x > y ? y : x;
    }

    function reportLost(uint _lose) external onlyStrategy nonReentrant {
        require (_lose <= totalSupply / 2, "wrong lose report");
        // totalSupply -= _lose;
        // boostFund -= _lose * boostFund / (underlying + available());
        uint toInvest;
        if (_lose <= profits) {
            toInvest = _lose;
            profits -= _lose;
        } else {
            toInvest = profits;
            underlying -= (_lose - profits);
            profits = 0;
        }
        asset.safeTransfer(strategy, toInvest);
    }

    function closed() external onlyStrategy whenPaused {
        asset.safeTransferFrom(msg.sender, address(this), underlying);
        underlying = 0;
    }

    function refill(uint _amount) external onlyStrategy nonReentrant {
        require (_amount <= underlying, "exceeded amount");
        asset.safeTransferFrom(msg.sender, address(this), _amount);
        underlying -= _amount;
    }

    function autoRefill() external onlyStrategy nonReentrant {
        uint amount = refillable();
        asset.safeTransferFrom(msg.sender, address(this), amount);
        underlying -= amount;
    }

    function payout(uint _amount) external nonReentrant {
        asset.safeTransferFrom(msg.sender, address(this), _amount);
        profits += _amount;
    }

    function clearExpiredUsers(uint _count) external onlyOwner nonReentrant {
        uint count;
        for (uint i = 0; i < userList.length(); i++) {
            if (users[userList.at(i)].expireAt + expireDelta <= block.timestamp) {unchecked {++count;}}
        }
        require (count > 0, "!expired users");
        
        address[] memory wallets = new address[](count);
        count = 0;
        for (uint i = 0; i < userList.length(); i++) {
            address user = userList.at(i);
            if (users[user].expireAt + expireDelta > block.timestamp) continue;
            
            uint bal = balanceOf(user);
            if (available() - profits < bal) continue; // check over-withdrawal
            
            _withdrawAll(user, false);
            wallets[count] = user;
            unchecked { ++count; }

            if (count >= _count) break;
        }
        
        for (uint i = 0; i < count; i++) {
            userList.remove(wallets[i]);
        }
    }

    function updateFarmPeriod(uint _period) external onlyOwner {
        farmPeriod = _period;
    }

    function updateExpireDelta(uint _delta) external onlyOwner {
        expireDelta = _delta;
    }
    
    function setRebalanceRate(uint _rate) external onlyOwner {
        require (_rate <= 50, "!rate");
        rebalanceRate = _rate;
    }

    function toggleMode() external onlyOwner {
        isPublic = !isPublic;
    }

    function setInvestors(address[] calldata _wallets, bool _flag) external onlyOwner {
        require (!isPublic, "!private mode");
        for (uint i = 0; i < _wallets.length; i++) {
            investWhitelist[_wallets[i]] = _flag;
            if (!_flag) permanentWhitelist[_wallets[i]] = false;
        }
    }

    function setReferrals(address[] calldata _wallets, address[] calldata _referrals) external onlyOwner {
        require (_wallets.length == _referrals.length, "!referral sets");
        for (uint i = 0; i < _wallets.length; i++) {
            require (_wallets[i] != _referrals[i], "!referral");
            require (invested[_referrals[i]], "!investor");
            referrals[_wallets[i]] = _referrals[i];
        }
    }

    function setPermanentWhitelist(address[] calldata _wallets, bool _flag) external onlyOwner {
        require (!isPublic, "!private mode");
        for (uint i = 0; i < _wallets.length; i++) {
            permanentWhitelist[_wallets[i]] = _flag;
        }
    }

    function setAgent(address _agent, bool _flag) external onlyOwner {
        agents[_agent] = _flag;
    }

    function updatePayoutAgent(address _agent) external onlyOwner {
        require (_agent != address(0), "!agent");
        
        asset.approve(payoutAgent, 0);
        asset.approve(_agent, type(uint).max);
        payoutAgent = _agent;
    }

    function updateMaxSupply(uint _supply) external onlyOwner {
        maxSupply = _supply;
    }

    function updateUserMaxSupply(uint _supply) external onlyOwner {
        maxUserSupply = _supply;
    }

    function updateStrategy(address _strategy) external onlyOwner whenPaused {
        require (underlying == 0, "existing underlying amount");
        strategy = _strategy;
    }

    function updateTreasuryWallet(address _wallet) external onlyOwner {
        treasuryWallet = _wallet;
    }

    function withdrawBoostFund(uint _amount) external onlyOwner whenPaused nonReentrant {
        // require (underlying == 0, "existing underlying amount");
        require (boostFund >= _amount, "!amount");
        uint curBal = available();
        if (curBal < _amount) _amount = curBal;
        asset.safeTransfer(msg.sender, _amount);
        boostFund -= _amount;
    }

    function withdrawInStuck() external onlyOwner whenPaused {
        require (totalShare == 0, "existing user fund");
        require (boostFund == 0, "existing boost fund");
        uint curBal = available();
        asset.safeTransfer(msg.sender, curBal);
    }

    function pause() external onlyOwner {
        _pause();
    }

    function unpause() external onlyOwner {
        _unpause();
    }
}