//SPDX-License-Identifier: MIT

pragma solidity 0.8.9;

import '@openzeppelin/contracts-upgradeable/token/ERC20/IERC20Upgradeable.sol';
import '@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol';
import '@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol';
import '@openzeppelin/contracts-upgradeable/utils/ContextUpgradeable.sol';
import '@openzeppelin/contracts-upgradeable/security/PausableUpgradeable.sol';
import '@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol';
import '@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol';

interface Aggregator {
  function latestRoundData() external view returns (uint80 roundId, int256 answer, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound);
}

contract PresaleV4 is Initializable, ReentrancyGuardUpgradeable, OwnableUpgradeable, PausableUpgradeable {
  uint256 public totalTokensSold;
  uint256 public startTime;
  uint256 public endTime;
  uint256 public claimStart;
  address public saleToken;
  uint256 public baseDecimals;
  uint256 public maxTokensToBuy;
  uint256 public currentStep;

  IERC20Upgradeable public USDTInterface;
  Aggregator public aggregatorInterface;

  uint256[4] public token_amount;
  uint256[4] public token_price;

  mapping(address => uint256) public userDeposits;
  mapping(address => bool) public hasClaimed;
  uint256[][3] public rounds;
  uint256 public checkPoint;
  bool reinit;
  uint256 public usdRaised;
  mapping(address => bool) public isBlacklisted;
  mapping(address => bool) public isWhitelisted;
  bool public whitelistClaimOnly;

  event SaleTimeSet(uint256 _start, uint256 _end, uint256 timestamp);

  event SaleTimeUpdated(bytes32 indexed key, uint256 prevValue, uint256 newValue, uint256 timestamp);

  event TokensBought(address indexed user, uint256 indexed tokensBought, address indexed purchaseToken, uint256 amountPaid, uint256 usdEq, uint256 timestamp);

  event TokensAdded(address indexed token, uint256 noOfTokens, uint256 timestamp);
  event TokensClaimed(address indexed user, uint256 amount, uint256 timestamp);

  event ClaimStartUpdated(uint256 prevValue, uint256 newValue, uint256 timestamp);
  event MaxTokensUpdated(uint256 prevValue, uint256 newValue, uint256 timestamp);

  /// @custom:oz-upgrades-unsafe-allow constructor
  constructor() initializer {}

  function initializeV2(uint256[][3] memory _rounds, uint256 _maxTokensToBuy) external {
    require(!reinit, 'Already Executed');
    reinit = true;
    maxTokensToBuy = _maxTokensToBuy;
    rounds = _rounds;
  }

  function changeMaxTokensToBuy(uint256 _maxTokensToBuy) external onlyOwner {
    require(_maxTokensToBuy > 0, 'Zero max tokens to buy value');
    uint256 prevValue = maxTokensToBuy;
    maxTokensToBuy = _maxTokensToBuy;
    emit MaxTokensUpdated(prevValue, _maxTokensToBuy, block.timestamp);
  }

  function changeRoundsData(uint256[][3] memory _rounds) external onlyOwner {
    rounds = _rounds;
  }

  /**
   * @dev To pause the presale
   */
  function pause() external onlyOwner {
    _pause();
  }

  /**
   * @dev To unpause the presale
   */
  function unpause() external onlyOwner {
    _unpause();
  }

  /**
   * @dev To calculate the price in USD for given amount of tokens.
   * @param _amount No of tokens
   */
  function calculatePrice(uint256 _amount) public view returns (uint256) {
    uint256 USDTAmount;
    uint256 total = checkPoint == 0 ? totalTokensSold : checkPoint;
    require(_amount <= maxTokensToBuy, 'Amount exceeds max tokens to buy');
    if (_amount + total > rounds[0][currentStep] || block.timestamp >= rounds[2][currentStep]) {
      require(currentStep < (rounds[0].length - 1), 'Wrong params');

      if (block.timestamp >= rounds[2][currentStep]) {
        require(rounds[0][currentStep] + _amount <= rounds[0][currentStep + 1], '');
        USDTAmount = _amount * rounds[1][currentStep + 1];
      } else {
        uint256 tokenAmountForCurrentPrice = rounds[0][currentStep] - total;
        USDTAmount = tokenAmountForCurrentPrice * rounds[1][currentStep] + (_amount - tokenAmountForCurrentPrice) * rounds[1][currentStep + 1];
      }
    } else USDTAmount = _amount * rounds[1][currentStep];
    return USDTAmount;
  }

  /**
   * @dev To update the sale times
   * @param _startTime New start time
   * @param _endTime New end time
   */
  function changeSaleTimes(uint256 _startTime, uint256 _endTime) external onlyOwner {
    require(_startTime > 0 || _endTime > 0, 'Invalid parameters');
    if (_startTime > 0) {
      // require(block.timestamp < startTime, "Sale already started");
      // require(block.timestamp < _startTime, "Sale time in past");
      uint256 prevValue = startTime;
      startTime = _startTime;
      emit SaleTimeUpdated(bytes32('START'), prevValue, _startTime, block.timestamp);
    }

    if (_endTime > 0) {
      require(block.timestamp < endTime, 'Sale already ended');
      require(_endTime > startTime, 'Invalid endTime');
      uint256 prevValue = endTime;
      endTime = _endTime;
      emit SaleTimeUpdated(bytes32('END'), prevValue, _endTime, block.timestamp);
    }
  }

  /**
   * @dev To get latest BNB price in 10**18 format
   */
  function getLatestPrice() public view returns (uint256) {
    (, int256 price, , , ) = aggregatorInterface.latestRoundData();
    price = (price * (10 ** 10));
    return uint256(price);
  }

  modifier checkSaleState(uint256 amount) {
    require(block.timestamp >= startTime && block.timestamp <= endTime, 'Invalid time for buying');
    require(amount > 0, 'Invalid sale amount');
    _;
  }

  /**
   * @dev To buy into a presale using USDT
   * @param amount No of tokens to buy
   */
  function buyWithUSDT(uint256 amount) external checkSaleState(amount) whenNotPaused returns (bool) {
    uint256 usdPrice = calculatePrice(amount);
    totalTokensSold += amount;
    if (checkPoint != 0) checkPoint += amount;
    uint256 total = totalTokensSold > checkPoint ? totalTokensSold : checkPoint;
    if (total > rounds[0][currentStep] || block.timestamp >= rounds[2][currentStep]) {
      if (block.timestamp >= rounds[2][currentStep]) {
        checkPoint = rounds[0][currentStep] + amount;
      }
      currentStep += 1;
    }
    userDeposits[_msgSender()] += (amount * baseDecimals);
    usdRaised += usdPrice;
    uint256 ourAllowance = USDTInterface.allowance(_msgSender(), address(this));
    require(usdPrice <= ourAllowance, 'Make sure to add enough allowance');
    (bool success, ) = address(USDTInterface).call(abi.encodeWithSignature('transferFrom(address,address,uint256)', _msgSender(), owner(), usdPrice));
    require(success, 'Token payment failed');
    emit TokensBought(_msgSender(), amount, address(USDTInterface), usdPrice, usdPrice, block.timestamp);
    return true;
  }

  /**
   * @dev To buy into a presale using BNB
   * @param amount No of tokens to buy
   */
  function buyWithBnb(uint256 amount) external payable checkSaleState(amount) whenNotPaused nonReentrant returns (bool) {
    uint256 usdPrice = calculatePrice(amount);
    uint256 bnbAmount = (usdPrice * baseDecimals) / getLatestPrice();
    require(msg.value >= bnbAmount, 'Less payment');
    uint256 excess = msg.value - bnbAmount;
    totalTokensSold += amount;
    if (checkPoint != 0) checkPoint += amount;
    uint256 total = totalTokensSold > checkPoint ? totalTokensSold : checkPoint;
    if (total > rounds[0][currentStep] || block.timestamp >= rounds[2][currentStep]) {
      if (block.timestamp >= rounds[2][currentStep]) {
        checkPoint = rounds[0][currentStep] + amount;
      }
      currentStep += 1;
    }
    userDeposits[_msgSender()] += (amount * baseDecimals);
    usdRaised += usdPrice;
    sendValue(payable(owner()), bnbAmount);
    if (excess > 0) sendValue(payable(_msgSender()), excess);
    emit TokensBought(_msgSender(), amount, address(0), bnbAmount, usdPrice, block.timestamp);
    return true;
  }

  /**
   * @dev Helper funtion to get BNB price for given amount
   * @param amount No of tokens to buy
   */
  function bnbBuyHelper(uint256 amount) external view returns (uint256 bnbAmount) {
    uint256 usdPrice = calculatePrice(amount);
    bnbAmount = (usdPrice * baseDecimals) / getLatestPrice();
  }

  /**
   * @dev Helper funtion to get USDT price for given amount
   * @param amount No of tokens to buy
   */
  function usdtBuyHelper(uint256 amount) external view returns (uint256 usdPrice) {
    usdPrice = calculatePrice(amount);
  }

  function sendValue(address payable recipient, uint256 amount) internal {
    require(address(this).balance >= amount, 'Low balance');
    (bool success, ) = recipient.call{value: amount}('');
    require(success, 'BNB Payment failed');
  }

  /**
   * @dev To set the claim start time and sale token address by the owner
   * @param _claimStart claim start time
   * @param noOfTokens no of tokens to add to the contract
   * @param _saleToken sale toke address
   */
  function startClaim(uint256 _claimStart, uint256 noOfTokens, address _saleToken) external onlyOwner returns (bool) {
    require(_claimStart > endTime && _claimStart > block.timestamp, 'Invalid claim start time');
    require(noOfTokens >= (totalTokensSold * baseDecimals), 'Tokens less than sold');
    require(_saleToken != address(0), 'Zero token address');
    require(claimStart == 0, 'Claim already set');
    claimStart = _claimStart;
    saleToken = _saleToken;
    bool success = IERC20Upgradeable(_saleToken).transferFrom(_msgSender(), address(this), noOfTokens);
    require(success, 'Token transfer failed');
    emit TokensAdded(saleToken, noOfTokens, block.timestamp);
    return true;
  }

  /**
   * @dev To change the claim start time by the owner
   * @param _claimStart new claim start time
   */
  function changeClaimStart(uint256 _claimStart) external onlyOwner returns (bool) {
    require(claimStart > 0, 'Initial claim data not set');
    require(_claimStart > endTime, 'Sale in progress');
    require(_claimStart > block.timestamp, 'Claim start in past');
    uint256 prevValue = claimStart;
    claimStart = _claimStart;
    emit ClaimStartUpdated(prevValue, _claimStart, block.timestamp);
    return true;
  }

  /**
   * @dev To claim tokens after claiming starts
   */
  function claim() external whenNotPaused returns (bool) {
    require(saleToken != address(0), 'Sale token not added');
    require(!isBlacklisted[_msgSender()], 'This Address is Blacklisted');
    if (whitelistClaimOnly) {
      require(isWhitelisted[_msgSender()], 'User not whitelisted for claim');
    }
    require(block.timestamp >= claimStart, 'Claim has not started yet');
    require(!hasClaimed[_msgSender()], 'Already claimed');
    hasClaimed[_msgSender()] = true;
    uint256 amount = userDeposits[_msgSender()];
    require(amount > 0, 'Nothing to claim');
    delete userDeposits[_msgSender()];
    bool success = IERC20Upgradeable(saleToken).transfer(_msgSender(), amount);
    require(success, 'Token transfer failed');
    emit TokensClaimed(_msgSender(), amount, block.timestamp);
    return true;
  }

  /**
   * @dev to update userDeposits for purchases made on BSC
   * @param users array of users
   * @param _userDeposits array of userDeposits associated with users
   */
  function updateFromETH(address[] calldata users, uint256[] calldata _userDeposits) external onlyOwner {
    require(users.length == _userDeposits.length, 'Length mismatch');
    for (uint256 i = 0; i < users.length; i++) {
      userDeposits[users[i]] += _userDeposits[i];
    }
  }

  /**
   * @dev To add users to blacklist which restricts blacklisted users from claiming
   * @param _usersToBlacklist addresses of the users
   */
  function blacklistUsers(address[] calldata _usersToBlacklist) external onlyOwner {
    for (uint256 i = 0; i < _usersToBlacklist.length; i++) {
      isBlacklisted[_usersToBlacklist[i]] = true;
    }
  }

  /**
   * @dev To remove users from blacklist which restricts blacklisted users from claiming
   * @param _userToRemoveFromBlacklist addresses of the users
   */
  function removeFromBlacklist(address[] calldata _userToRemoveFromBlacklist) external onlyOwner {
    for (uint256 i = 0; i < _userToRemoveFromBlacklist.length; i++) {
      isBlacklisted[_userToRemoveFromBlacklist[i]] = false;
    }
  }

  /**
   * @dev To add users to whitelist which restricts users from claiming if claimWhitelistStatus is true
   * @param _usersToWhitelist addresses of the users
   */
  function whitelistUsers(address[] calldata _usersToWhitelist) external onlyOwner {
    for (uint256 i = 0; i < _usersToWhitelist.length; i++) {
      isWhitelisted[_usersToWhitelist[i]] = true;
    }
  }

  /**
   * @dev To remove users from whitelist which restricts users from claiming if claimWhitelistStatus is true
   * @param _userToRemoveFromWhitelist addresses of the users
   */
  function removeFromWhitelist(address[] calldata _userToRemoveFromWhitelist) external onlyOwner {
    for (uint256 i = 0; i < _userToRemoveFromWhitelist.length; i++) {
      isWhitelisted[_userToRemoveFromWhitelist[i]] = false;
    }
  }

  /**
   * @dev To set status for claim whitelisting
   * @param _status bool value
   */
  function setClaimWhitelistStatus(bool _status) external onlyOwner {
    whitelistClaimOnly = _status;
  }
}