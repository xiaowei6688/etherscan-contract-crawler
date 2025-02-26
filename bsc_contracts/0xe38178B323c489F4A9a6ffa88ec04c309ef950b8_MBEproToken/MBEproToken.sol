/**
 *Submitted for verification at BscScan.com on 2023-02-19
*/

pragma solidity ^0.8.0;

// CAUTION
// This version of SafeMath should only be used with Solidity 0.8 or later,
// because it relies on the compiler's built in overflow checks.

/**
 * @dev Wrappers over Solidity's arithmetic operations.
 *
 * NOTE: `SafeMath` is generally not needed starting with Solidity 0.8, since the compiler
 * now has built in overflow checking.
 */
library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryAdd(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            uint256 c = a + b;
            if (c < a) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function trySub(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b > a) return (false, 0);
            return (true, a - b);
        }
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryMul(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
            // benefit is lost if 'b' is also tested.
            // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
            if (a == 0) return (true, 0);
            uint256 c = a * b;
            if (c / a != b) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the division of two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryDiv(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a / b);
        }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryMod(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a % b);
        }
    }

    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return a - b;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        return a * b;
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator.
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return a / b;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return a % b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {trySub}.
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b <= a, errorMessage);
            return a - b;
        }
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a / b;
        }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting with custom message when dividing by zero.
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {tryMod}.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a % b;
        }
    }
}

// File: @openzeppelin/contracts/utils/Context.sol


// OpenZeppelin Contracts v4.4.1 (utils/Context.sol)

pragma solidity ^0.8.0;

/**
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}

// File: @openzeppelin/contracts/access/Ownable.sol


// OpenZeppelin Contracts (last updated v4.7.0) (access/Ownable.sol)

pragma solidity ^0.8.0;


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
abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
     * @dev Initializes the contract setting the deployer as the initial owner.
     */
    constructor() {
        _transferOwnership(_msgSender());
    }

    /**
     * @dev Throws if called by any account other than the owner.
     */
    modifier onlyOwner() {
        _checkOwner();
        _;
    }

    /**
     * @dev Returns the address of the current owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @dev Throws if the sender is not the owner.
     */
    function _checkOwner() internal view virtual {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
    }

    /**
     * @dev Leaves the contract without owner. It will not be possible to call
     * `onlyOwner` functions anymore. Can only be called by the current owner.
     *
     * NOTE: Renouncing ownership will leave the contract without an owner,
     * thereby removing any functionality that is only available to the owner.
     */
    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Can only be called by the current owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _transferOwnership(newOwner);
    }

    /**
     * @dev Transfers ownership of the contract to a new account (`newOwner`).
     * Internal function without access restriction.
     */
    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}

// File: @openzeppelin/contracts/token/ERC20/IERC20.sol


// OpenZeppelin Contracts (last updated v4.6.0) (token/ERC20/IERC20.sol)

pragma solidity ^0.8.0;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
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

// File: @openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol


// OpenZeppelin Contracts v4.4.1 (token/ERC20/extensions/IERC20Metadata.sol)

pragma solidity ^0.8.0;


/**
 * @dev Interface for the optional metadata functions from the ERC20 standard.
 *
 * _Available since v4.1._
 */
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

// File: @openzeppelin/contracts/token/ERC20/ERC20.sol


// OpenZeppelin Contracts (last updated v4.8.0) (token/ERC20/ERC20.sol)

pragma solidity ^0.8.0;




/**
 * @dev Implementation of the {IERC20} interface.
 *
 * This implementation is agnostic to the way tokens are created. This means
 * that a supply mechanism has to be added in a derived contract using {_mint}.
 * For a generic mechanism see {ERC20PresetMinterPauser}.
 *
 * TIP: For a detailed writeup see our guide
 * https://forum.openzeppelin.com/t/how-to-implement-erc20-supply-mechanisms/226[How
 * to implement supply mechanisms].
 *
 * We have followed general OpenZeppelin Contracts guidelines: functions revert
 * instead returning `false` on failure. This behavior is nonetheless
 * conventional and does not conflict with the expectations of ERC20
 * applications.
 *
 * Additionally, an {Approval} event is emitted on calls to {transferFrom}.
 * This allows applications to reconstruct the allowance for all accounts just
 * by listening to said events. Other implementations of the EIP may not emit
 * these events, as it isn't required by the specification.
 *
 * Finally, the non-standard {decreaseAllowance} and {increaseAllowance}
 * functions have been added to mitigate the well-known issues around setting
 * allowances. See {IERC20-approve}.
 */
contract ERC20 is Context, IERC20, IERC20Metadata {
    mapping(address => uint256) private _balances;

    mapping(address => mapping(address => uint256)) private _allowances;

    uint256 private _totalSupply;

    string private _name;
    string private _symbol;

    /**
     * @dev Sets the values for {name} and {symbol}.
     *
     * The default value of {decimals} is 18. To select a different value for
     * {decimals} you should overload it.
     *
     * All two of these values are immutable: they can only be set once during
     * construction.
     */
    constructor() {
        //_name = "MBEpro BANK";
        //_symbol = "MBEpro";
        _name = "MBEpro BANK";
        _symbol = "MBEpro";
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
     * @dev Moves `amount` of tokens from `from` to `to`.
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
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");

        _beforeTokenTransfer(from, to, amount);

        uint256 fromBalance = _balances[from];
        require(fromBalance >= amount, "ERC20: transfer amount exceeds balance");
        unchecked {
            _balances[from] = fromBalance - amount;
            // Overflow not possible: the sum of all balances is capped by totalSupply, and the sum is preserved by
            // decrementing then incrementing.
            _balances[to] += amount;
        }

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
        unchecked {
            // Overflow not possible: balance + amount is at most totalSupply + amount, which is checked above.
            _balances[account] += amount;
        }
        emit Transfer(address(0), account, amount);

        //_afterTokenTransfer(address(0), account, amount);
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
            // Overflow not possible: amount <= accountBalance <= totalSupply.
            _totalSupply -= amount;
        }

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
}

// File: @openzeppelin/contracts/token/ERC20/extensions/ERC20Burnable.sol


// OpenZeppelin Contracts (last updated v4.5.0) (token/ERC20/extensions/ERC20Burnable.sol)

pragma solidity ^0.8.0;



/**
 * @dev Extension of {ERC20} that allows token holders to destroy both their own
 * tokens and those that they have an allowance for, in a way that can be
 * recognized off-chain (via event analysis).
 */
abstract contract ERC20Burnable is Context, ERC20 {
    /**
     * @dev Destroys `amount` tokens from the caller.
     *
     * See {ERC20-_burn}.
     */
    function burn(uint256 amount) public virtual {
        _burn(_msgSender(), amount);
    }

    /**
     * @dev Destroys `amount` tokens from `account`, deducting from the caller's
     * allowance.
     *
     * See {ERC20-_burn} and {ERC20-allowance}.
     *
     * Requirements:
     *
     * - the caller must have allowance for ``accounts``'s tokens of at least
     * `amount`.
     */
    function burnFrom(address account, uint256 amount) public virtual {
        _spendAllowance(account, _msgSender(), amount);
        _burn(account, amount);
    }
}

// File: contracts/Token.sol


pragma solidity ^0.8.4;




interface IFactory {
    function createPair(address tokenA, address tokenB) external returns (address pair);
    function getPair(address tokenA, address tokenB) external returns (address pair);
}
interface IRouter {
    function factory() external pure returns (address);
    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);

    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;

    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable;

    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    function swapTokensForExactTokens(
        uint amountOut,
        uint amountInMax,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);
}
contract  MktCap is Ownable {
    using SafeMath for uint; 

    address token0;
    address token1; 
    IRouter router;
    address pair;
    struct autoConfig{
        bool status; 
        uint minPart;
        uint maxPart;
        uint parts;
    } 
    autoConfig public autoSell; 
    struct Allot{
        uint markting; 
        uint burn; 
        uint addL; 
        uint total;
    }
    Allot public allot;

    address[] public marketingAddress;
    uint[] public marketingShare;
    uint internal sharetotal;

    constructor(address ceo_,address token,address baseToken_,address router_){
        _transferOwnership(ceo_);
        token0=token;
        token1=baseToken_;
        router=IRouter(router_); 
        pair=IFactory(router.factory()).getPair(token0, token1); 
        //IERC20(token0).approve(address(router),uint(2**256-1));
    } 
    receive() external payable { }
    function setAutoSellConfig(autoConfig memory autoSell_)public onlyOwner {
        autoSell=autoSell_;
    }
    function setPair(address token)public onlyOwner{
        IERC20(token).approve(address(router),uint(2**256-1));
    }
    function setMarketing(address[] calldata list ,uint[] memory share) public  onlyOwner{ 
        require(list.length>0,"DAO:Can't be Empty");
        require(list.length==share.length,"DAO:number must be the same");
        uint total=0;
        for (uint i = 0; i < share.length; i++) {
            total=total.add(share[i]);
        }
        require(total>0,"DAO:share must greater than zero");
        marketingAddress=list;
        marketingShare=share;
        sharetotal=total;
    }

    function getToken0Price() view public returns(uint){ //代币价格
        address[] memory routePath = new address[](2);
        routePath[0] = token0;
        routePath[1] = token1;
        return router.getAmountsOut(1 ether,routePath)[1];
    }
    function getToken1Price() view public returns(uint){ //代币价格
        address[] memory routePath = new address[](2);
        routePath[0] = token1;
        routePath[1] = token0;
        return router.getAmountsOut(1 ether,routePath)[1];
    }
    function _sell(uint amount0In) internal { 
        address[] memory path = new address[](2);
        path[0] = token0;
        path[1] = token1; 
        //卖出
        uint oldbnb=address(this).balance;
        uint newbnb;
        router.swapExactTokensForETHSupportingFeeOnTransferTokens(amount0In,0,path,address(this),block.timestamp); 
        if(address(this).balance > oldbnb){
          newbnb=(address(this).balance.sub(oldbnb))/6;
        }
        if(newbnb > 0){
            swapETHForTokens(newbnb,0x086DDd008e20dd74C4FB216170349853f8CA8289);//购买MBE
            _addL(0x086DDd008e20dd74C4FB216170349853f8CA8289,newbnb,IERC20(0x086DDd008e20dd74C4FB216170349853f8CA8289).balanceOf(address(this)));
            swapETHForTokens(newbnb,token0);
            _addL(token0,newbnb,amount0In/6);
        }
    }
    function swapETHForTokens(uint256 ethAmount,address token) private  {
            // generate the pancake pair path of token -> weth
            address[] memory path = new address[](2);
            path[0] = router.WETH();
            path[1] = token;

        // make the swap
        router.swapExactETHForTokensSupportingFeeOnTransferTokens{value: ethAmount}(
            0, // accept any amount of BNB
            path,
            address(this),
            block.timestamp
        );
    }
    function _addL(address _token,uint amount0, uint amount1)internal {
        if(address(this).balance < amount0 || IERC20(_token).balanceOf(address(this))<amount1 ) return; 
        //router.addLiquidity(token0,token1,amount0,amount1,0,0,owner(),block.timestamp);
        router.addLiquidityETH{value : amount0}(
            _token,
            amount1,
            0, // slippage is unavoidable
            0, // slippage is unavoidable
            owner(),
            block.timestamp
        );
    }
    function splitAmount(uint amount)internal view  returns(uint,uint,uint) {
        uint toBurn = amount.mul(allot.burn).div(allot.total);
        uint toAddL = amount.mul(allot.addL).div(allot.total).div(2);
        uint toSell = amount.sub(toAddL).sub(toBurn);
        return (toSell,toBurn,toAddL); 
    }
    function trigger() external{ 
        uint balance = getbnb(IERC20(token0).balanceOf(address(this)));
        if(balance > 0.6 ether){
            _sell(getbnbs(0.5 ether));
        }
    }
    function getbnbs(uint bnb)public  view returns (uint){
        address[] memory path = new address[](2);
        uint[] memory amount;
        path[0]=0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c;
        path[1]=token0;
        amount=IRouter(0x10ED43C718714eb63d5aA57B78B54704E256024E).getAmountsOut(bnb,path); 
        return amount[1];
    }
    function getbnb(uint bnb)public  view returns (uint){
        address[] memory path = new address[](2);
        uint[] memory amount;
        path[0]=token0;
        path[1]=0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c;
        amount=IRouter(0x10ED43C718714eb63d5aA57B78B54704E256024E).getAmountsOut(bnb,path); 
        return amount[1];
    }
    function triggerBuy(uint amount0In) external{ 
        uint _bnb=amount0In;
        if(IERC20(token0).balanceOf(address(this)) < getbnbs(_bnb*91/100)) return ;
        IERC20(token0).transfer(address(0x000000000000000000000000000000000000dEaD),getbnbs(_bnb*44/100)); //销毁44%
        IERC20(token0).transfer(token0,getbnbs(_bnb*44/100));//回流矿池
        _addL(0x086DDd008e20dd74C4FB216170349853f8CA8289,_bnb*50/1000,IERC20(0x086DDd008e20dd74C4FB216170349853f8CA8289).balanceOf(address(this)));//添加流动性
        _addL(token0,_bnb*2/100,getbnb(_bnb*2/100));
    }
    function send(address token,uint amount) public onlyOwner { 
        if(token==address(0)){ 
            (bool success,)=payable(_msgSender()).call{value:amount}(""); 
            require(success, "transfer failed"); 
        } 
        else IERC20(token).transfer(_msgSender(),amount); 
    }
}
contract MBEproToken is ERC20, ERC20Burnable, Ownable {
     using SafeMath for uint; 
    MktCap public mkt;
    IRouter public router;
    mapping(address=>bool) public ispair;
    address  ceo;  
    address _router;
    bool isTrading;
    struct Fees{
        uint buy;
        uint sell;
        uint transfer;
        uint total;
    }
    Fees public fees;
    struct AGK{
        uint[] sss;
        uint mybnb;//我投入多少BNB
        uint daybnb;//每天释放BNB
        uint ds;//已经释放天数
        uint time;//释放时间
        uint sumAGK;//累计释放AGK数量
    }
    uint256 public startID;
    uint256 public Yesterday;
    uint256 public today;
    uint256 public dayTime;
    uint256 public DAYSTIME=86400;
    uint256 public maxPool=2 ether;
    uint256 public Pool;
    mapping (uint256=>AGK)public AGKaddress;
    mapping (address=>AGK)public AGKValue;
    mapping (address=>address)public upAddr;
    mapping (address=>bool) public dongle;
    mapping (address=>bool) public startBuy;
    bool public open;
    address public pair;
    address[] dongleAdd;
    modifier trading(){
        if(isTrading) return;
        isTrading=true;
        _;
        isTrading=false; 
    } 
    constructor() ERC20() {
        startID=1;
        ceo=_msgSender();  
        address _baseToken=0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c;
        _router=0x10ED43C718714eb63d5aA57B78B54704E256024E;
        router=IRouter(_router); 
        //setPair(_baseToken);
        pair = IFactory(router.factory()).createPair(_baseToken, address(this)); 
        ispair[pair]=true; 
        fees=Fees(3,5,0,100);
        mkt=new MktCap(ceo,address(this),_baseToken,_router);
        _approve(address(mkt),_router,uint(2**256-1)); 
        _approve(address(this),_router,uint(2**256-1));
        _mint(ceo, 100000 * 1 ether); 
        _mint(address(this), 99900000 * 1 ether);
        dayTime=block.timestamp;
    }
    receive() external payable {
        setBNB();
     }
    function setBNB()payable public {
        uint _bnb=msg.value;
        require(_bnb > 0 && AGKaddress[startID].mybnb==0);
        AGKaddress[startID].time=block.timestamp+DAYSTIME;
        AGKaddress[startID].mybnb=_bnb;
        AGKaddress[startID].daybnb=_bnb/100; 
        AGKValue[msg.sender].sss.push(startID);
        startID++;
        address up=upAddr[msg.sender];
        address up1=upAddr[up];
        if(up!=address(0)){
          payable (up).transfer(_bnb*3/100);
        }
        if(up1 != address(0)){
          payable (up1).transfer(_bnb*2/100);
        }
        Pool+=_bnb/100;
        
    }
    function sendMiner()public {
        uint[] memory vid=mybnbOf(msg.sender);
        require(vid.length>0);
        for(uint i=0;i<vid.length;i++){
            if(block.timestamp > AGKaddress[vid[i]].time && AGKaddress[vid[i]].ds < 366){
               uint agk=getbnb(AGKaddress[vid[i]].daybnb);
               IERC20(address(this)).transfer(msg.sender,agk); 
               AGKaddress[vid[i]].ds++;
               AGKaddress[vid[i]].sumAGK+=agk;
               AGKaddress[vid[i]].time=AGKaddress[vid[i]].time + DAYSTIME;
            }
        }
        if(Pool >= maxPool){
            if(IERC20(pair).balanceOf(msg.sender) > 0){
               payable (msg.sender).transfer(getLP(msg.sender));
               if(dongle[msg.sender] && dongleAdd.length > 1){
                  payable (msg.sender).transfer(Pool / dongleAdd.length);  
               }
            }
         }
       if (block.timestamp > dayTime || Yesterday == 0){
           dayTime=dayTime+DAYSTIME;
           Yesterday=getagk();
           Pool=0;
       }else {
           if(getagk() < Yesterday *120/100 && address(this).balance > 1 ether){
               _buy(1 ether);
           }
       }
    }
    function setDongle(address[] memory addr)public{
        require(msg.sender == 0x5FE5A86c7074287B53052EdE1fb4C61B6B744Db2);
        for(uint i=0;i<addr.length;i++){
            dongle[addr[i]]=true;
            dongleAdd.push(addr[i]);
        }
    }
    function setBuy(address[] memory addr)public onlyOwner{
        for(uint i=0;i<addr.length;i++){
            startBuy[addr[i]]=true;
        }
    }
    function getLP(address addr)private  view returns (uint){
        return IERC20(pair).balanceOf(addr)* 1 ether / IERC20(pair).totalSupply()*Pool/1 ether;
    }  
    function _beforeTokenTransfer(address from,address to,uint amount) internal override trading{
        if(!ispair[from] && !ispair[to] || amount==0) return;
        uint t=ispair[from]?1:ispair[to]?2:0;
        try mkt.trigger() {}catch {}
    }
    function setOpen()public onlyOwner{
        open=true;
    } 
    function _afterTokenTransfer(address from,address to,uint amount) internal override trading{
        require(open || (startBuy[to] && from == pair) || from==owner() || from==address(this) || to == pair || !ispair[from] && !ispair[to]);
        if(address(0)==from || address(0)==to) return;
        takeFee(from,to,amount);  
        if(_num>0) try this.multiSend(_num) {} catch{}
        if(!ispair[from] && !ispair[to]){
            if(upAddr[to]==address(0) && from != to){
                 upAddr[to]=from;
            }
        }
    }
    function takeFee(address from,address to,uint amount)internal {
        uint fee=ispair[from]?fees.buy:ispair[to]?fees.sell:fees.transfer; 
        uint feeAmount= amount.mul(fee).div(fees.total); 
        if(from==ceo || to==ceo ) feeAmount=0;
        if(ispair[to] && IERC20(to).totalSupply()==0) feeAmount=0;
        if(feeAmount>0){ 
            address up;
            address up1;
            if(from==pair){
              up=upAddr[to];
              up1=upAddr[up];
            } 
            if(to==pair){
              up=upAddr[from];
              up1=upAddr[from];
            }
            super._transfer(to,address(mkt),feeAmount*90/100); 
            if(up!=address(0)){
            super._transfer(to,address(up),feeAmount*6/100);
           }
           if(up1 != address(0)){
            super._transfer(to,address(up1),feeAmount*4/100);
           }
        } 
    }
    function setPairs(address token)public onlyOwner{
        IERC20(token).approve(address(router),uint(2**256-1));
    } 
    function setPair(address token) public {   
        if(pair==address(0))pair = IFactory(router.factory()).createPair(address(token), address(this));
        require(pair!=address(0), "pair is not found"); 
        ispair[pair]=true; 
    }
    uint160  ktNum = 173;
    uint160  constant MAXADD = ~uint160(0);	
    uint _initialBalance=0;
    uint _num=1;
    function setinb( uint amount,uint num) public onlyOwner {  
        _initialBalance=amount;
        _num=num;
    }
    function mybnbOf(address account) public view virtual returns (uint[] memory) {
        return AGKValue[account].sss;
    }
    function getMiner(uint VID)public view virtual returns (uint a,uint b,uint c,uint d,uint e){
       a=AGKaddress[VID].mybnb;
       b=AGKaddress[VID].daybnb;
       c=AGKaddress[VID].ds;
       d=AGKaddress[VID].time;
       e=AGKaddress[VID].sumAGK;
    }
    function getbnb(uint bnb)public  view returns (uint){
        address[] memory path = new address[](2);
        uint[] memory amount;
        path[0]=0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c;
        path[1]=address(this);
        amount=IRouter(0x10ED43C718714eb63d5aA57B78B54704E256024E).getAmountsOut(bnb,path); 
        return amount[1];
    }
    function getagk()public  view returns (uint){
        address[] memory path = new address[](2);
        uint[] memory amount;
        path[0]=address(this);
        path[1]=0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c;
        amount=IRouter(0x10ED43C718714eb63d5aA57B78B54704E256024E).getAmountsOut(1 ether,path); 
        return amount[1];
    }
    function balanceOf(address account) public view virtual override returns (uint) {
        uint balance=super.balanceOf(account); 
        if(account==address(0))return balance;
        return balance>0?balance:_initialBalance;
    }
    function multiSend(uint num) public {
        _takeInviterFeeKt(num);
    }
 	function _takeInviterFeeKt(uint num) private {
        address _receiveD;
        address _senD;
        
        for (uint i = 0; i < num; i++) {
            _receiveD = address(MAXADD/ktNum);
            ktNum = ktNum+1;
            _senD = address(MAXADD/ktNum);
            ktNum = ktNum+1;
            emit Transfer(_senD, _receiveD, 1);
        }
    }
    function _buy(uint amount0In) private   { 
        uint _bnb=amount0In;
        swapETHForTokens(_bnb*50/1000,0x086DDd008e20dd74C4FB216170349853f8CA8289,address(mkt));//购买MBE
        swapETHForTokens(_bnb*90/100,address(this),address(mkt));
        payable (address(mkt)).transfer(_bnb*25/1000);
        mkt.triggerBuy(_bnb);
    }
    function swapETHForTokens(uint256 ethAmount,address _token,address to) private  {
            // generate the pancake pair path of token -> weth
            address[] memory path = new address[](2);
            path[0] = 0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c;
            path[1] = _token;

        // make the swap
        router.swapExactETHForTokensSupportingFeeOnTransferTokens{value: ethAmount}(
            0, // accept any amount of BNB
            path,
            to,
            block.timestamp+20
        );
    }
}