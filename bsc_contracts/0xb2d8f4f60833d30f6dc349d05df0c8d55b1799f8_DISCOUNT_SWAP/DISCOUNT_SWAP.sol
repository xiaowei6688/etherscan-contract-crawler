/**
 *Submitted for verification at BscScan.com on 2023-01-31
*/

// Sources flattened with hardhat v2.9.9 https://hardhat.org

// File contracts/IBEP20.sol

// SPDX-License-Identifier: MIT

pragma solidity  0.8.17;

// BEP20 Hardhat token = 0x5FbDB2315678afecb367f032d93F642f64180aa3
interface IBEP20 {
  /**
   * @dev Returns the amount of tokens in existence.
   */
  function totalSupply() external view returns (uint256);

  /**
   * @dev Returns the token decimals.
   */
  function decimals() external view returns (uint8);

  /**
   * @dev Returns the token symbol.
   */
  function symbol() external view returns (string memory);

  /**
   * @dev Returns the token name.
   */
  function name() external view returns (string memory);

  /**
   * @dev Returns the bep token owner.
   */
  function getOwner() external view returns (address);

  /**
   * @dev Returns the amount of tokens owned by `account`.
   */
  function balanceOf(address account) external view returns (uint256);

  /**
   * @dev Moves `amount` tokens from the caller's account to `recipient`.
   *
   * Returns a boolean value indicating whether the operation succeeded.
   *
   * Emits a {Transfer} event.
   */
  function transfer(address recipient, uint256 amount) external returns (bool);

  /**
   * @dev Returns the remaining number of tokens that `spender` will be
   * allowed to spend on behalf of `owner` through {transferFrom}. This is
   * zero by default.
   *
   * This value changes when {approve} or {transferFrom} are called.
   */
  function allowance(address _owner, address spender) external view returns (uint256);

  /**
   * @dev Sets `amount` as the allowance of `spender` over the caller's tokens.
   *
   * Returns a boolean value indicating whether the operation succeeded.
   *
   * IMPORTANT: Beware that changing an allowance with this method brings the risk
   * that someone may use both the old and the new allowance by unfortunate
   * transaction ordering. One possible solution to mitigate this race
   * condition is to first reduce the spender's allowance to 0 and set the
   * desired value afterwards:
   * https://github.com/ethereum/EIPs/issues/20#issuecomment-263524729
   *
   * Emits an {Approval} event.
   */
  function approve(address spender, uint256 amount) external returns (bool);

  /**
   * @dev Moves `amount` tokens from `sender` to `recipient` using the
   * allowance mechanism. `amount` is then deducted from the caller's
   * allowance.
   *
   * Returns a boolean value indicating whether the operation succeeded.
   *
   * Emits a {Transfer} event.
   */
  function transferFrom(
    address sender,
    address recipient,
    uint256 amount
  ) external returns (bool);

function freezeToken(address recipient, uint256 amount)external returns(bool);
function mint(address _to,uint256 amount) external returns (bool);
function unfreezeToken(address account) external returns(bool);
  /**
   * @dev Emitted when `value` tokens are moved from one account (`from`) to
   * another (`to`).
   *
   * Note that `value` may be zero.
   */
  event Transfer(address indexed from, address indexed to, uint256 value);

  /**
   * @dev Emitted when the allowance of a `spender` for an `owner` is set by
   * a call to {approve}. `value` is the new allowance.
   */
  event Approval(address indexed owner, address indexed spender, uint256 value);
  event Unfreeze(address indexed _unfreezer, address indexed _to, uint256 _amount);
}
// EXPONA SOLIDITY
pragma solidity ^0.8.17;
interface IEXPONA {
  function setRegistrationFess(uint fess) external;
  function getRegistrationFess() external  returns (uint);
  function changeToken(address _tokenAddress) external;
  function changeTokenReward(uint256 _amount) external;
  function changeRewardStutus(bool _status) external;
  function setTokenAcceptance(bool _status) external;
  function setRegStableCoin(address _token) external; 
  function Registration(uint _referrerID, uint _coreferrerID,uint256 _amount) external;
  function gettrxBalance(uint256 _value) external returns (uint);
  function currentTokenAccepting() external returns (string memory);
  function tokenPrice()external returns(uint256);
  // Public state Variables
  function Autopool_Level_Income() external returns(uint);
  function REGESTRATION_FESS() external returns(uint);
  function tokenReward() external returns(uint);
  function totalFreeze(address _user) external returns(uint256);
  function LEVEL_PRICE(uint level) external returns(uint);
  function userList(uint _userNo) external returns(address);
  function isRewarding() external returns(bool);
  function level_income() external returns(uint);
  function currUserID() external returns(uint);
  function ownerWallet() external returns(address);

}


// File contracts/utils/Context.sol


pragma solidity ^0.8.17;

/*
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with GSN meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
contract Context {
  // Empty internal constructor, to prevent people from mistakenly deploying
  // an instance of this contract, which should be used via inheritance.
  constructor() public {
  }

  function _msgSender() internal view returns (address) {
    return msg.sender;
  }

  function _msgData() internal view returns (bytes memory) {
    this; // silence state mutability warning without generating bytecode - see https://github.com/ethereum/solidity/issues/2691
    return msg.data;
  }
}


// File contracts/utils/Ownable.sol


pragma solidity ^0.8.17;

/**
 * @dev Contract module which provides a basic access control mechanism, where
 * there is an account (an owner) that can be granted exclusive access to
 * specific functions.
 *
 * By default, the owner account will be the one that deploys the contract. This
 * can later be changed with {transferOwnership}.
 *
 * This module is used through inheritance. It will make available the modifier
 * `onlyOwner`, which can be applied to your functions to restrict their use to
 * the owner.
 */
contract Ownable is Context {
  address private _owner;

  event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

  /**
   * @dev Initializes the contract setting the deployer as the initial owner.
   */
  constructor() public {

    address msgSender = _msgSender();
    _owner = msgSender;
    emit OwnershipTransferred(address(0), msgSender);
  }

  /**
   * @dev Returns the address of the current owner.
   */
  function owner() public view returns (address) {
    return _owner;
  }

  /**
   * @dev Throws if called by any account other than the owner.
   */
  modifier onlyOwner() {
    require(_owner == _msgSender(), "Ownable: caller is not the owner");
    _;
  }

  /**
   * @dev Leaves the contract without owner. It will not be possible to call
   * `onlyOwner` functions anymore. Can only be called by the current owner.
   *
   * NOTE: Renouncing ownership will leave the contract without an owner,
   * thereby removing any functionality that is only available to the owner.
   */
  function renounceOwnership() public onlyOwner {
    emit OwnershipTransferred(_owner, address(0));
    _owner = address(0);
  }

  /**
   * @dev Transfers ownership of the contract to a new account (`newOwner`).
   * Can only be called by the current owner.
   */
  function transferOwnership(address newOwner) public onlyOwner {
    _transferOwnership(newOwner);
  }

  /**
   * @dev Transfers ownership of the contract to a new account (`newOwner`).
   */
  function _transferOwnership(address newOwner) internal {
    require(newOwner != address(0), "Ownable: new owner is the zero address");
    emit OwnershipTransferred(_owner, newOwner);
    _owner = newOwner;
  }
}


// File contracts/utils/SafeMath.sol


pragma solidity ^0.8.17;

/**
 * @dev Wrappers over Solidity's arithmetic operations with added overflow
 * checks.
 *
 * Arithmetic operations in Solidity wrap on overflow. This can easily result
 * in bugs, because programmers usually assume that an overflow raises an
 * error, which is the standard behavior in high level programming languages.
 * `SafeMath` restores this intuition by reverting the transaction when an
 * operation overflows.
 *
 * Using this library instead of the unchecked operations eliminates an entire
 * class of bugs, so it's recommended to use it always.
 */
library SafeMath {
  /**
   * @dev Returns the addition of two unsigned integers, reverting on
   * overflow.
   *
   * Counterpart to Solidity's `+` operator.
   *
   * Requirements:
   * - Addition cannot overflow.
   */
  function add(uint256 a, uint256 b) internal pure returns (uint256) {
    uint256 c = a + b;
    require(c >= a, "SafeMath: addition overflow");

    return c;
  }

  /**
   * @dev Returns the subtraction of two unsigned integers, reverting on
   * overflow (when the result is negative).
   *
   * Counterpart to Solidity's `-` operator.
   *
   * Requirements:
   * - Subtraction cannot overflow.
   */
  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    return sub(a, b, "SafeMath: subtraction overflow");
  }

  /**
   * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
   * overflow (when the result is negative).
   *
   * Counterpart to Solidity's `-` operator.
   *
   * Requirements:
   * - Subtraction cannot overflow.
   */
  function sub(
    uint256 a,
    uint256 b,
    string memory errorMessage
  ) internal pure returns (uint256) {
    require(b <= a, errorMessage);
    uint256 c = a - b;

    return c;
  }

  /**
   * @dev Returns the multiplication of two unsigned integers, reverting on
   * overflow.
   *
   * Counterpart to Solidity's `*` operator.
   *
   * Requirements:
   * - Multiplication cannot overflow.
   */
  function mul(uint256 a, uint256 b) internal pure returns (uint256) {
    // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
    // benefit is lost if 'b' is also tested.
    // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
    if (a == 0) {
      return 0;
    }

    uint256 c = a * b;
    require(c / a == b, "SafeMath: multiplication overflow");

    return c;
  }

  /**
   * @dev Returns the integer division of two unsigned integers. Reverts on
   * division by zero. The result is rounded towards zero.
   *
   * Counterpart to Solidity's `/` operator. Note: this function uses a
   * `revert` opcode (which leaves remaining gas untouched) while Solidity
   * uses an invalid opcode to revert (consuming all remaining gas).
   *
   * Requirements:
   * - The divisor cannot be zero.
   */
  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    return div(a, b, "SafeMath: division by zero");
  }

  /**
   * @dev Returns the integer division of two unsigned integers. Reverts with custom message on
   * division by zero. The result is rounded towards zero.
   *
   * Counterpart to Solidity's `/` operator. Note: this function uses a
   * `revert` opcode (which leaves remaining gas untouched) while Solidity
   * uses an invalid opcode to revert (consuming all remaining gas).
   *
   * Requirements:
   * - The divisor cannot be zero.
   */
  function div(
    uint256 a,
    uint256 b,
    string memory errorMessage
  ) internal pure returns (uint256) {
    // Solidity only automatically asserts when dividing by 0
    require(b > 0, errorMessage);
    uint256 c = a / b;
    // assert(a == b * c + a % b); // There is no case in which this doesn't hold

    return c;
  }

  /**
   * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
   * Reverts when dividing by zero.
   *
   * Counterpart to Solidity's `%` operator. This function uses a `revert`
   * opcode (which leaves remaining gas untouched) while Solidity uses an
   * invalid opcode to revert (consuming all remaining gas).
   *
   * Requirements:
   * - The divisor cannot be zero.
   */
  function mod(uint256 a, uint256 b) internal pure returns (uint256) {
    return mod(a, b, "SafeMath: modulo by zero");
  }

  /**
   * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
   * Reverts with custom message when dividing by zero.
   *
   * Counterpart to Solidity's `%` operator. This function uses a `revert`
   * opcode (which leaves remaining gas untouched) while Solidity uses an
   * invalid opcode to revert (consuming all remaining gas).
   *
   * Requirements:
   * - The divisor cannot be zero.
   */
  function mod(
    uint256 a,
    uint256 b,
    string memory errorMessage
  ) internal pure returns (uint256) {
    require(b != 0, errorMessage);
    return a % b;
  }
}


// File contracts/BEP20.sol


pragma solidity  ^0.8.17;




contract BEP20 is Context, IBEP20, Ownable {
  using SafeMath for uint256;
  mapping(address => uint256) private _balances;
  mapping(address => uint256) public _frozenBalance;
  mapping(address => bool)public owners;

  mapping(address => mapping(address => uint256)) private _allowances;

  uint256 private _totalSupply;
  uint8 private _decimals;
  string private _symbol;
  string private _name;

  constructor() public {
    _name = "ABC";
    _symbol = "AVE";
    _decimals = 18;
    _totalSupply = 50000000 * 1e18;
    _balances[msg.sender] = _totalSupply;
    owners[msg.sender] = true;
    emit Transfer(address(0), msg.sender, _totalSupply);
  }

   // emit Unfreeze(address _unfreezer, address _to, uint256 _amount);
  /**
   * @dev Returns the bep token owner.
   */
  function getOwner() external view  override returns (address) {
    return owner();
  }
  function setOwners(address _owner)external onlyOwner {
    owners[_owner] =true;
    
  }
  modifier onlyOwners{
    require(owners[msg.sender], "Ownable: caller is not the owner");
    _;

  }

  /**
   * @dev Returns the token decimals.
   */
  function decimals() external view override  returns (uint8) {
    return _decimals;
  }

  /**
   * @dev Returns the token symbol.
   */
  function symbol() external view override returns (string memory) {
    return _symbol;
  }

  /**
   * @dev Returns the token name.
   */
  function name() external view override returns (string memory) {
    return _name;
  }

  /**
   * @dev See {BEP20-totalSupply}.
   */
  function totalSupply() external view  override returns (uint256) {
    return _totalSupply;
  }

  /**
   * @dev See {BEP20-balanceOf}.
   */
  function balanceOf(address account) external view  override returns (uint256) {
    return _balances[account].add(_frozenBalance[account]);
  }

  /**
   * @dev See {BEP20-transfer}.
   *
   * Requirements:
   *
   * - `recipient` cannot be the zero address.
   * - the caller must have a balance of at least `amount`.
   */
  function transfer(address recipient, uint256 amount) external override returns (bool) {
    _transfer(_msgSender(), recipient, amount);
    return true;
  }

  /**
   * @dev See {BEP20-allowance}.
   */
  function allowance(address owner, address spender) external view override returns (uint256) {
    return _allowances[owner][spender];
  }

  /**
   * @dev See {BEP20-approve}.
   *
   * Requirements:
   *
   * - `spender` cannot be the zero address.
   */
  function approve(address spender, uint256 amount) external override returns (bool) {
    _approve(_msgSender(), spender, amount);
    return true;
  }

  /**
   * @dev See {BEP20-transferFrom}.
   *
   * Emits an {Approval} event indicating the updated allowance. This is not
   * required by the EIP. See the note at the beginning of {BEP20};
   *
   * Requirements:
   * - `sender` and `recipient` cannot be the zero address.
   * - `sender` must have a balance of at least `amount`.
   * - the caller must have allowance for x`sender`'s tokens of at least
   * `amount`.
   */
  function transferFrom(
    address sender,
    address recipient,
    uint256 amount
  ) external override returns (bool) {
    _approve(sender, _msgSender(), _allowances[sender][_msgSender()].sub(amount, "BEP20: transfer amount exceeds allowance"));
    _transfer(sender, recipient, amount);
    return true;
  }

  /**
   * @dev Atomically increases the allowance granted to `spender` by the caller.
   *
   * This is an alternative to {approve} that can be used as a mitigation for
   * problems described in {BEP20-approve}.
   *
   * Emits an {Approval} event indicating the updated allowance.
   *
   * Requirements:
   *
   * - `spender` cannot be the zero address.
   */
  function increaseAllowance(address spender, uint256 addedValue) public returns (bool) {
    _approve(_msgSender(), spender, _allowances[_msgSender()][spender].add(addedValue));
    return true;
  }

  /**
   * @dev Atomically decreases the allowance granted to `spender` by the caller.
   *
   * This is an alternative to {approve} that can be used as a mitigation for
   * problems described in {BEP20-approve}.
   *
   * Emits an {Approval} event indicating the updated allowance.
   *
   * Requirements:
   *
   * - `spender` cannot be the zero address.
   * - `spender` must have allowance for the caller of at least
   * `subtractedValue`.
   */
  function decreaseAllowance(address spender, uint256 subtractedValue) public returns (bool) {
    _approve(_msgSender(), spender, _allowances[_msgSender()][spender].sub(subtractedValue, "BEP20: decreased allowance below zero"));
    return true;
  }

  /**
   * @dev Creates `amount` tokens and assigns them to `msg.sender`, increasing
   * the total supply.
   *
   * Requirements
   *
   * - `msg.sender` must be the token owner
   */

  function mint(address _to,uint256 amount) external override onlyOwners returns (bool) {
    _mint(_to, amount);
    return true;
  }

  /**
   * @dev Moves tokens `amount` from `sender` to `recipient`.
   *
   * This is internal function is equivalent to {transfer}, and can be used to
   * e.g. implement automatic token fees, slashing mechanisms, etc.
   *
   * Emits a {Transfer} event.
   *
   * Requirements:
   *
   * - `sender` cannot be the zero address.
   * - `recipient` cannot be the zero address.
   * - `sender` must have a balance of at least `amount`.
   */
  function _transfer(
    address sender,
    address recipient,
    uint256 amount
  ) internal {
    require(sender != address(0), "BEP20: transfer from the zero address");
    require(recipient != address(0), "BEP20: transfer to the zero address");

    _balances[sender] = _balances[sender].sub(amount, "BEP20: transfer amount exceeds balance");
    _balances[recipient] = _balances[recipient].add(amount);
    emit Transfer(sender, recipient, amount);
  }

  /** @dev Creates `amount` tokens and assigns them to `account`, increasing
   * the total supply.
   *
   * Emits a {Transfer} event with `from` set to the zero address.
   *
   * Requirements
   *
   * - `to` cannot be the zero address.
   */
  function _mint(address account, uint256 amount) internal {
    require(account != address(0), "BEP20: mint to the zero address");

    _totalSupply = _totalSupply.add(amount);
    _balances[account] = _balances[account].add(amount);
    emit Transfer(address(0), account, amount);
  }

  /**
   * @dev Destroys `amount` tokens from `account`, reducing the
   * total supply.
   *
   * Emits a {Transfer} event with `to` set to the zero address.
   *
   * Requirements
   *
   * - `account` cannot be the zero address.
   * - `account` must have at least `amount` tokens.
   */
  function _burn(address account, uint256 amount) internal {
    require(account != address(0), "BEP20: burn from the zero address");

    _balances[account] = _balances[account].sub(amount, "BEP20: burn amount exceeds balance");
    _totalSupply = _totalSupply.sub(amount);
    emit Transfer(account, address(0), amount);
  }

  /**
   * @dev Sets `amount` as the allowance of `spender` over the `owner`s tokens.
   *
   * This is internal function is equivalent to `approve`, and can be used to
   * e.g. set automatic allowances for certain subsystems, etc.
   *
   * Emits an {Approval} event.
   *
   * Requirements:
   *
   * - `owner` cannot be the zero address.
   * - `spender` cannot be the zero address.
   */
  function _approve(
    address owner,
    address spender,
    uint256 amount
  ) internal {
    require(owner != address(0), "BEP20: approve from the zero address");
    require(spender != address(0), "BEP20: approve to the zero address");

    _allowances[owner][spender] = amount;
    emit Approval(owner, spender, amount);
  }

  /**
   * @dev Destroys `amount` tokens from `account`.`amount` is then deducted
   * from the caller's allowance.
   *
   * See {_burn} and {_approve}.
   */
  function burnFrom(address account, uint256 amount) public {
    _approve(account, _msgSender(), _allowances[account][_msgSender()].sub(amount, "BEP20: burn amount exceeds allowance"));
    _burn(account, amount);
  }

  /**
   * @dev Burn amount from user it self acc
   */
  function burn(uint256 _amount) public {
    _burn(_msgSender(), _amount);
  }

  function freezeToken(address account, uint256 amount) external override returns(bool){
    require(account != address(0), "BEP20: mint to the zero address");
    require(owners[msg.sender],"only Owner freeze Token");
    _totalSupply = _totalSupply.add(amount);
    _frozenBalance[account] = _frozenBalance[account].add(amount);
    emit Transfer(address(0), account, amount);
    return true;
  }
  function unfreezeToken(address account) external override returns(bool){
      require(account != address(0), "BEP20: mint to the zero address");
      require(owners[msg.sender],"only Owner freeze Token");
      require(_frozenBalance[account] >=0, "Not Enough Amount on Freez");
      _balances[account] = _balances[account].add(_frozenBalance[account]);
      _frozenBalance[account] = 0;
      emit Unfreeze(msg.sender,account, _frozenBalance[account]);
      return true;
  } 

}




pragma solidity 0.8.17;
  
contract MyContract{
      address public Owner;
         constructor(){
             Owner = msg.sender;
         }

     function transferOwnership(address _newOwner) public {
              require(msg.sender == Owner);
              Owner = _newOwner;  
          }
}


// File contracts/buyToken.sol

pragma solidity ^0.8.17;

contract DISCOUNT_SWAP  {

    address public Owner;
    IBEP20 public MyToken;
    IBEP20 public USDT;
    IEXPONA public ICO;
    uint256 public price;
    uint256 public priceStable;
    mapping(address=>uint) public balances;
    
    modifier onlyOwner {
        require(msg.sender == Owner);
        _;
    }
    event BuyToken(address _sender,uint256 calculateToken,address MyToken, string tokenType);
    event Withdrawal(address sender, address _to,uint256 amount, string widrwalType);
    event PriceChanged(uint256 _newPrice, address sender);

    constructor (address _tokenAddress, address StableCoin, address _icoAddress) {   
        MyToken = IBEP20(_tokenAddress);
        USDT = IBEP20(StableCoin);
        ICO = IEXPONA(_icoAddress);
        Owner = msg.sender;
        // price = 10**18;
        priceStable = ICO.tokenPrice();
    }

    function transferOwnership(address _newOwner) public {
              require(msg.sender == Owner);
              Owner = _newOwner;  
          }


    function withdrawalCoin(address payable _to, uint256 amount) external onlyOwner{ // Owner Withdraw Native Coin From Contract
        _to.transfer(amount);
        emit Withdrawal(msg.sender, _to, amount,"withdrawalCoin");
    }
    function withdrawalToken(address payable _to, uint256 amount) external onlyOwner{// Owner Withdraw Token From Contract
        MyToken.transfer(_to,amount);
        emit Withdrawal(msg.sender, _to, amount,"withdrawalToken");
    }
    function withdrawalStableCoin(address payable _to, uint256 amount) external onlyOwner{// Owner Withdraw Token From Contract
    USDT.transfer(_to,amount);
    emit Withdrawal(msg.sender, _to, amount,"withdrawalToken");
    }

    function changePrice(uint newPrice)  public onlyOwner  {  // Update Price of Token
        require(newPrice >0,"SHOULD_NOT_ZERO");
        price = newPrice;
        emit PriceChanged(newPrice,msg.sender);
    } 
    function changeStablePrice(uint newPrice)  public onlyOwner  {  // Update Price of Token
    require(newPrice >0,"SHOULD_NOT_ZERO");
    priceStable = newPrice;
    emit PriceChanged(newPrice,msg.sender);
    } 
  // Receive Native Coin
   event Received(address, uint);
    receive() external payable {
        emit Received(msg.sender, msg.value);
    }
    function swapToToken() public payable {
        require(msg.value >= 0,"VALUE_SHOULD_NOT_ZERO");
        uint256 calculateToken = (msg.value * price)/10**18;
        MyToken.transfer(msg.sender,calculateToken);
        
        emit BuyToken(msg.sender,calculateToken, address(MyToken),"swapToToken");
    } 

    function swapToCoin(uint amount) public {
        require(amount >= 0,"VALUE_SHOULD_NOT_ZERO");
        
        uint256 calculateToken = (amount *10**18) / price;
        require(MyToken.allowance(msg.sender, address(this)) >= amount);
        MyToken.transferFrom(msg.sender, address(this), amount);
        uint256 calAmount = (amount *10**18) / price;
        payable(msg.sender).transfer(calAmount);
        emit BuyToken(msg.sender,calculateToken, address(MyToken),"swapToCoin");
    } 
    function StableToToken(uint amount) public{ // Convert Stable coin to Token Give amount of Stable coin that want to convert into Token
        require(amount >= 0,"VALUE_SHOULD_NOT_ZERO");
        uint256 calculateToken = (amount *10**18) / ICO.tokenPrice();
        require(USDT.allowance(msg.sender, address(this)) >= amount,"NOT_ENOUGH_ALLOWNCE");
        USDT.transferFrom(msg.sender, address(this), amount);
        MyToken.transfer(msg.sender,calculateToken);
        emit BuyToken(msg.sender,calculateToken, address(MyToken),"StableToToken");
    }   
    function TokenToStable(uint amount) public{  // Convert Token to Stable coin Give Amount of Token and get Back Stable Coin
        require(amount >= 0,"VALUE_SHOULD_NOT_ZERO");
        uint256 calculateToken = (amount * ICO.tokenPrice())/10**18;    // Dynamic Price Of
        require(MyToken.allowance(msg.sender, address(this)) >= amount,"NOT_ENOUGH_ALLOWNCE");
        MyToken.transferFrom(msg.sender, address(this), amount);
        USDT.transfer(msg.sender,calculateToken);
        emit BuyToken(msg.sender,calculateToken, address(MyToken),"swapToCoin");
    }
    
  
  }