/**
 *Submitted for verification at Etherscan.io on 2022-07-27
*/

// SPDX-License-Identifier: GPL-3.0-or-later
// Sources flattened with hardhat v2.6.1 https://hardhat.org

// File @openzeppelin/contracts/token/ERC20/[email protected]

// OpenZeppelin Contracts (last updated v4.5.0) (token/ERC20/IERC20.sol)

pragma solidity ^0.8.0;

/**
 * @dev Interface of the ERC20 standard as defined in the EIP.
 */
interface IERC20 {
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
}


// File @openzeppelin/contracts/utils/[email protected]

// OpenZeppelin Contracts (last updated v4.5.0) (utils/Address.sol)

pragma solidity ^0.8.1;

/**
 * @dev Collection of functions related to the address type
 */
library Address {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * [IMPORTANT]
     * ====
     * It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     *
     * Among others, `isContract` will return false for the following
     * types of addresses:
     *
     *  - an externally-owned account
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract lived, but was destroyed
     * ====
     *
     * [IMPORTANT]
     * ====
     * You shouldn't rely on `isContract` to protect against flash loan attacks!
     *
     * Preventing calls from contracts is highly discouraged. It breaks composability, breaks support for smart wallets
     * like Gnosis Safe, and does not provide security since it can be circumvented by calling from a contract
     * constructor.
     * ====
     */
    function isContract(address account) internal view returns (bool) {
        // This method relies on extcodesize/address.code.length, which returns 0
        // for contracts in construction, since the code is only stored at the end
        // of the constructor execution.

        return account.code.length > 0;
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        (bool success, ) = recipient.call{value: amount}("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }

    /**
     * @dev Performs a Solidity function call using a low level `call`. A
     * plain `call` is an unsafe replacement for a function call: use this
     * function instead.
     *
     * If `target` reverts with a revert reason, it is bubbled up by this
     * function (like regular Solidity function calls).
     *
     * Returns the raw returned data. To convert to the expected return value,
     * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
     *
     * Requirements:
     *
     * - `target` must be a contract.
     * - calling `target` with `data` must not revert.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionCall(target, data, "Address: low-level call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
     * `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but also transferring `value` wei to `target`.
     *
     * Requirements:
     *
     * - the calling contract must have an ETH balance of at least `value`.
     * - the called Solidity function must be `payable`.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }

    /**
     * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
     * with `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call");
        require(isContract(target), "Address: call to non-contract");

        (bool success, bytes memory returndata) = target.call{value: value}(data);
        return verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory) {
        return functionStaticCall(target, data, "Address: low-level static call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal view returns (bytes memory) {
        require(isContract(target), "Address: static call to non-contract");

        (bool success, bytes memory returndata) = target.staticcall(data);
        return verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a delegate call.
     *
     * _Available since v3.4._
     */
    function functionDelegateCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionDelegateCall(target, data, "Address: low-level delegate call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a delegate call.
     *
     * _Available since v3.4._
     */
    function functionDelegateCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(isContract(target), "Address: delegate call to non-contract");

        (bool success, bytes memory returndata) = target.delegatecall(data);
        return verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Tool to verifies that a low level call was successful, and revert if it wasn't, either by bubbling the
     * revert reason using the provided one.
     *
     * _Available since v4.3._
     */
    function verifyCallResult(
        bool success,
        bytes memory returndata,
        string memory errorMessage
    ) internal pure returns (bytes memory) {
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length > 0) {
                // The easiest way to bubble the revert reason is using memory via assembly

                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}


// File @openzeppelin/contracts/token/ERC20/utils/[email protected]

// OpenZeppelin Contracts v4.4.1 (token/ERC20/utils/SafeERC20.sol)

pragma solidity ^0.8.0;


/**
 * @title SafeERC20
 * @dev Wrappers around ERC20 operations that throw on failure (when the token
 * contract returns false). Tokens that return no value (and instead revert or
 * throw on failure) are also supported, non-reverting calls are assumed to be
 * successful.
 * To use this library you can add a `using SafeERC20 for IERC20;` statement to your contract,
 * which allows you to call the safe operations as `token.safeTransfer(...)`, etc.
 */
library SafeERC20 {
    using Address for address;

    function safeTransfer(
        IERC20 token,
        address to,
        uint256 value
    ) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transfer.selector, to, value));
    }

    function safeTransferFrom(
        IERC20 token,
        address from,
        address to,
        uint256 value
    ) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transferFrom.selector, from, to, value));
    }

    /**
     * @dev Deprecated. This function has issues similar to the ones found in
     * {IERC20-approve}, and its usage is discouraged.
     *
     * Whenever possible, use {safeIncreaseAllowance} and
     * {safeDecreaseAllowance} instead.
     */
    function safeApprove(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        // safeApprove should only be called when setting an initial allowance,
        // or when resetting it to zero. To increase and decrease it, use
        // 'safeIncreaseAllowance' and 'safeDecreaseAllowance'
        require(
            (value == 0) || (token.allowance(address(this), spender) == 0),
            "SafeERC20: approve from non-zero to non-zero allowance"
        );
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, value));
    }

    function safeIncreaseAllowance(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        uint256 newAllowance = token.allowance(address(this), spender) + value;
        _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
    }

    function safeDecreaseAllowance(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        unchecked {
            uint256 oldAllowance = token.allowance(address(this), spender);
            require(oldAllowance >= value, "SafeERC20: decreased allowance below zero");
            uint256 newAllowance = oldAllowance - value;
            _callOptionalReturn(token, abi.encodeWithSelector(token.approve.selector, spender, newAllowance));
        }
    }

    /**
     * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
     * on the return value: the return value is optional (but if data is returned, it must not be false).
     * @param token The token targeted by the call.
     * @param data The call data (encoded using abi.encode or one of its variants).
     */
    function _callOptionalReturn(IERC20 token, bytes memory data) private {
        // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since
        // we're implementing it ourselves. We use {Address.functionCall} to perform this call, which verifies that
        // the target address contains contract code and also asserts for success in the low-level call.

        bytes memory returndata = address(token).functionCall(data, "SafeERC20: low-level call failed");
        if (returndata.length > 0) {
            // Return data is optional
            require(abi.decode(returndata, (bool)), "SafeERC20: ERC20 operation did not succeed");
        }
    }
}


// File @openzeppelin/contracts-upgradeable/utils/[email protected]

// OpenZeppelin Contracts (last updated v4.5.0) (utils/Address.sol)

pragma solidity ^0.8.1;

/**
 * @dev Collection of functions related to the address type
 */
library AddressUpgradeable {
    /**
     * @dev Returns true if `account` is a contract.
     *
     * [IMPORTANT]
     * ====
     * It is unsafe to assume that an address for which this function returns
     * false is an externally-owned account (EOA) and not a contract.
     *
     * Among others, `isContract` will return false for the following
     * types of addresses:
     *
     *  - an externally-owned account
     *  - a contract in construction
     *  - an address where a contract will be created
     *  - an address where a contract lived, but was destroyed
     * ====
     *
     * [IMPORTANT]
     * ====
     * You shouldn't rely on `isContract` to protect against flash loan attacks!
     *
     * Preventing calls from contracts is highly discouraged. It breaks composability, breaks support for smart wallets
     * like Gnosis Safe, and does not provide security since it can be circumvented by calling from a contract
     * constructor.
     * ====
     */
    function isContract(address account) internal view returns (bool) {
        // This method relies on extcodesize/address.code.length, which returns 0
        // for contracts in construction, since the code is only stored at the end
        // of the constructor execution.

        return account.code.length > 0;
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `amount` wei to
     * `recipient`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] increases the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `recipient`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     */
    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        (bool success, ) = recipient.call{value: amount}("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }

    /**
     * @dev Performs a Solidity function call using a low level `call`. A
     * plain `call` is an unsafe replacement for a function call: use this
     * function instead.
     *
     * If `target` reverts with a revert reason, it is bubbled up by this
     * function (like regular Solidity function calls).
     *
     * Returns the raw returned data. To convert to the expected return value,
     * use https://solidity.readthedocs.io/en/latest/units-and-global-variables.html?highlight=abi.decode#abi-encoding-and-decoding-functions[`abi.decode`].
     *
     * Requirements:
     *
     * - `target` must be a contract.
     * - calling `target` with `data` must not revert.
     *
     * _Available since v3.1._
     */
    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionCall(target, data, "Address: low-level call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`], but with
     * `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but also transferring `value` wei to `target`.
     *
     * Requirements:
     *
     * - the calling contract must have an ETH balance of at least `value`.
     * - the called Solidity function must be `payable`.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }

    /**
     * @dev Same as {xref-Address-functionCallWithValue-address-bytes-uint256-}[`functionCallWithValue`], but
     * with `errorMessage` as a fallback revert reason when `target` reverts.
     *
     * _Available since v3.1._
     */
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call");
        require(isContract(target), "Address: call to non-contract");

        (bool success, bytes memory returndata) = target.call{value: value}(data);
        return verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory) {
        return functionStaticCall(target, data, "Address: low-level static call failed");
    }

    /**
     * @dev Same as {xref-Address-functionCall-address-bytes-string-}[`functionCall`],
     * but performing a static call.
     *
     * _Available since v3.3._
     */
    function functionStaticCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal view returns (bytes memory) {
        require(isContract(target), "Address: static call to non-contract");

        (bool success, bytes memory returndata) = target.staticcall(data);
        return verifyCallResult(success, returndata, errorMessage);
    }

    /**
     * @dev Tool to verifies that a low level call was successful, and revert if it wasn't, either by bubbling the
     * revert reason using the provided one.
     *
     * _Available since v4.3._
     */
    function verifyCallResult(
        bool success,
        bytes memory returndata,
        string memory errorMessage
    ) internal pure returns (bytes memory) {
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length > 0) {
                // The easiest way to bubble the revert reason is using memory via assembly

                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}


// File @openzeppelin/contracts-upgradeable/proxy/utils/[email protected]

// OpenZeppelin Contracts (last updated v4.5.0) (proxy/utils/Initializable.sol)

pragma solidity ^0.8.0;

/**
 * @dev This is a base contract to aid in writing upgradeable contracts, or any kind of contract that will be deployed
 * behind a proxy. Since proxied contracts do not make use of a constructor, it's common to move constructor logic to an
 * external initializer function, usually called `initialize`. It then becomes necessary to protect this initializer
 * function so it can only be called once. The {initializer} modifier provided by this contract will have this effect.
 *
 * TIP: To avoid leaving the proxy in an uninitialized state, the initializer function should be called as early as
 * possible by providing the encoded function call as the `_data` argument to {ERC1967Proxy-constructor}.
 *
 * CAUTION: When used with inheritance, manual care must be taken to not invoke a parent initializer twice, or to ensure
 * that all initializers are idempotent. This is not verified automatically as constructors are by Solidity.
 *
 * [CAUTION]
 * ====
 * Avoid leaving a contract uninitialized.
 *
 * An uninitialized contract can be taken over by an attacker. This applies to both a proxy and its implementation
 * contract, which may impact the proxy. To initialize the implementation contract, you can either invoke the
 * initializer manually, or you can include a constructor to automatically mark it as initialized when it is deployed:
 *
 * [.hljs-theme-light.nopadding]
 * ```
 * /// @custom:oz-upgrades-unsafe-allow constructor
 * constructor() initializer {}
 * ```
 * ====
 */
abstract contract Initializable {
    /**
     * @dev Indicates that the contract has been initialized.
     */
    bool private _initialized;

    /**
     * @dev Indicates that the contract is in the process of being initialized.
     */
    bool private _initializing;

    /**
     * @dev Modifier to protect an initializer function from being invoked twice.
     */
    modifier initializer() {
        // If the contract is initializing we ignore whether _initialized is set in order to support multiple
        // inheritance patterns, but we only do this in the context of a constructor, because in other contexts the
        // contract may have been reentered.
        require(_initializing ? _isConstructor() : !_initialized, "Initializable: contract is already initialized");

        bool isTopLevelCall = !_initializing;
        if (isTopLevelCall) {
            _initializing = true;
            _initialized = true;
        }

        _;

        if (isTopLevelCall) {
            _initializing = false;
        }
    }

    /**
     * @dev Modifier to protect an initialization function so that it can only be invoked by functions with the
     * {initializer} modifier, directly or indirectly.
     */
    modifier onlyInitializing() {
        require(_initializing, "Initializable: contract is not initializing");
        _;
    }

    function _isConstructor() private view returns (bool) {
        return !AddressUpgradeable.isContract(address(this));
    }
}


// File interfaces/strategies/IStrategy.sol

pragma solidity 0.8.10;

interface IStrategy {
    function deposit() external payable returns (bool);

    function withdraw(uint256 amount) external returns (bool);

    function withdrawAll() external returns (uint256);

    function harvest() external returns (uint256);

    function shutdown() external;

    function setCommunityReserve(address _communityReserve) external;

    function setStrategist(address strategist_) external;

    function name() external view returns (string memory);

    function balance() external view returns (uint256);

    function harvestable() external view returns (uint256);

    function strategist() external view returns (address);

    function hasPendingFunds() external view returns (bool);
}


// File interfaces/IVault.sol

pragma solidity 0.8.10;

/**
 * @title Interface for a Vault
 */

interface IVault {
    event StrategyActivated(address indexed strategy);

    event StrategyDeactivated(address indexed strategy);

    /**
     * @dev 'netProfit' is the profit after all fees have been deducted
     */
    event Harvest(uint256 indexed netProfit, uint256 indexed loss);

    function initialize(
        address _pool,
        uint256 _debtLimit,
        uint256 _targetAllocation,
        uint256 _bound
    ) external;

    function withdrawFromStrategyWaitingForRemoval(address strategy) external returns (uint256);

    function deposit() external payable;

    function withdraw(uint256 amount) external returns (bool);

    function withdrawAvailableToPool() external;

    function initializeStrategy(address strategy_) external;

    function shutdownStrategy() external;

    function withdrawFromReserve(uint256 amount) external;

    function updateStrategy(address newStrategy) external;

    function activateStrategy() external returns (bool);

    function deactivateStrategy() external returns (bool);

    function updatePerformanceFee(uint256 newPerformanceFee) external;

    function updateStrategistFee(uint256 newStrategistFee) external;

    function updateDebtLimit(uint256 newDebtLimit) external;

    function updateTargetAllocation(uint256 newTargetAllocation) external;

    function updateReserveFee(uint256 newReserveFee) external;

    function updateBound(uint256 newBound) external;

    function withdrawFromStrategy(uint256 amount) external returns (bool);

    function withdrawAllFromStrategy() external returns (bool);

    function harvest() external returns (bool);

    function getStrategiesWaitingForRemoval() external view returns (address[] memory);

    function getAllocatedToStrategyWaitingForRemoval(address strategy)
        external
        view
        returns (uint256);

    function getTotalUnderlying() external view returns (uint256);

    function getUnderlying() external view returns (address);

    function strategy() external view returns (IStrategy);
}


// File interfaces/IVaultReserve.sol

pragma solidity 0.8.10;

interface IVaultReserve {
    event Deposit(address indexed vault, address indexed token, uint256 amount);
    event Withdraw(address indexed vault, address indexed token, uint256 amount);
    event VaultListed(address indexed vault);

    function deposit(address token, uint256 amount) external payable;

    function withdraw(address token, uint256 amount) external;

    function getBalance(address vault, address token) external view returns (uint256);

    function canWithdraw(address vault) external view returns (bool);
}


// File interfaces/pool/ILiquidityPool.sol

pragma solidity 0.8.10;

interface ILiquidityPool {
    event Deposit(address indexed minter, uint256 depositAmount, uint256 mintedLpTokens);

    event DepositFor(
        address indexed minter,
        address indexed mintee,
        uint256 depositAmount,
        uint256 mintedLpTokens
    );

    event Redeem(address indexed redeemer, uint256 redeemAmount, uint256 redeemTokens);

    event LpTokenSet(address indexed lpToken);

    event StakerVaultSet(address indexed stakerVault);

    event Shutdown();

    function redeem(uint256 redeemTokens) external returns (uint256);

    function redeem(uint256 redeemTokens, uint256 minRedeemAmount) external returns (uint256);

    function calcRedeem(address account, uint256 underlyingAmount) external returns (uint256);

    function deposit(uint256 mintAmount) external payable returns (uint256);

    function deposit(uint256 mintAmount, uint256 minTokenAmount) external payable returns (uint256);

    function depositAndStake(uint256 depositAmount, uint256 minTokenAmount)
        external
        payable
        returns (uint256);

    function depositFor(address account, uint256 depositAmount) external payable returns (uint256);

    function depositFor(
        address account,
        uint256 depositAmount,
        uint256 minTokenAmount
    ) external payable returns (uint256);

    function unstakeAndRedeem(uint256 redeemLpTokens, uint256 minRedeemAmount)
        external
        returns (uint256);

    function handleLpTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) external;

    function updateVault(address _vault) external;

    function setLpToken(address _lpToken) external;

    function setStaker() external;

    function shutdownPool(bool shutdownStrategy) external;

    function shutdownStrategy() external;

    function updateRequiredReserves(uint256 _newRatio) external;

    function updateReserveDeviation(uint256 newRatio) external;

    function updateMinWithdrawalFee(uint256 newFee) external;

    function updateMaxWithdrawalFee(uint256 newFee) external;

    function updateWithdrawalFeeDecreasePeriod(uint256 newPeriod) external;

    function rebalanceVault() external;

    function getNewCurrentFees(
        uint256 timeToWait,
        uint256 lastActionTimestamp,
        uint256 feeRatio
    ) external view returns (uint256);

    function vault() external view returns (IVault);

    function getUnderlying() external view returns (address);

    function getLpToken() external view returns (address);

    function getWithdrawalFee(address account, uint256 amount) external view returns (uint256);

    function exchangeRate() external view returns (uint256);

    function totalUnderlying() external view returns (uint256);

    function name() external view returns (string memory);

    function isShutdown() external view returns (bool);
}


// File interfaces/IGasBank.sol

pragma solidity 0.8.10;

interface IGasBank {
    event Deposit(address indexed account, uint256 value);
    event Withdraw(address indexed account, address indexed receiver, uint256 value);

    function depositFor(address account) external payable;

    function withdrawUnused(address account) external;

    function withdrawFrom(address account, uint256 amount) external;

    function withdrawFrom(
        address account,
        address payable to,
        uint256 amount
    ) external;

    function balanceOf(address account) external view returns (uint256);
}


// File interfaces/oracles/IOracleProvider.sol

pragma solidity 0.8.10;

interface IOracleProvider {
    /// @notice Checks whether the asset is supported
    /// @param baseAsset the asset of which the price is to be quoted
    /// @return true if the asset is supported
    function isAssetSupported(address baseAsset) external view returns (bool);

    /// @notice Quotes the USD price of `baseAsset`
    /// @param baseAsset the asset of which the price is to be quoted
    /// @return the USD price of the asset
    function getPriceUSD(address baseAsset) external view returns (uint256);

    /// @notice Quotes the ETH price of `baseAsset`
    /// @param baseAsset the asset of which the price is to be quoted
    /// @return the ETH price of the asset
    function getPriceETH(address baseAsset) external view returns (uint256);
}


// File libraries/AddressProviderMeta.sol

pragma solidity 0.8.10;

library AddressProviderMeta {
    struct Meta {
        bool freezable;
        bool frozen;
    }

    function fromUInt(uint256 value) internal pure returns (Meta memory) {
        Meta memory meta;
        meta.freezable = (value & 1) == 1;
        meta.frozen = ((value >> 1) & 1) == 1;
        return meta;
    }

    function toUInt(Meta memory meta) internal pure returns (uint256) {
        uint256 value;
        value |= meta.freezable ? 1 : 0;
        value |= meta.frozen ? 1 << 1 : 0;
        return value;
    }
}


// File interfaces/IAddressProvider.sol

pragma solidity 0.8.10;




// solhint-disable ordering

interface IAddressProvider {
    event KnownAddressKeyAdded(bytes32 indexed key);
    event StakerVaultListed(address indexed stakerVault);
    event StakerVaultDelisted(address indexed stakerVault);
    event ActionListed(address indexed action);
    event PoolListed(address indexed pool);
    event VaultUpdated(address indexed previousVault, address indexed newVault);
    event FeeHandlerAdded(address feeHandler);
    event FeeHandlerRemoved(address feeHandler);

    /** Key functions */
    function getKnownAddressKeys() external view returns (bytes32[] memory);

    function freezeAddress(bytes32 key) external;

    /** Pool functions */

    function allPools() external view returns (address[] memory);

    function addPool(address pool) external;

    function poolsCount() external view returns (uint256);

    function getPoolAtIndex(uint256 index) external view returns (address);

    function isPool(address pool) external view returns (bool);

    function getPoolForToken(address token) external view returns (ILiquidityPool);

    function safeGetPoolForToken(address token) external view returns (address);

    /** Vault functions  */

    function updateVault(address previousVault, address newVault) external;

    function allVaults() external view returns (address[] memory);

    function vaultsCount() external view returns (uint256);

    function getVaultAtIndex(uint256 index) external view returns (address);

    function isVault(address vault) external view returns (bool);

    /** Action functions */

    function allActions() external view returns (address[] memory);

    function addAction(address action) external returns (bool);

    function isAction(address action) external view returns (bool);

    /** Address functions */
    function initializeAddress(bytes32 key, address initialAddress) external;

    function initializeAddress(
        bytes32 key,
        address initialAddress,
        bool frezable
    ) external;

    function initializeAndFreezeAddress(bytes32 key, address initialAddress) external;

    function getAddress(bytes32 key) external view returns (address);

    function getAddress(bytes32 key, bool checkExists) external view returns (address);

    function getAddressMeta(bytes32 key) external view returns (AddressProviderMeta.Meta memory);

    function updateAddress(bytes32 key, address newAddress) external;

    /** Staker vault functions */
    function allStakerVaults() external view returns (address[] memory);

    function tryGetStakerVault(address token) external view returns (bool, address);

    function getStakerVault(address token) external view returns (address);

    function addStakerVault(address stakerVault) external;

    function isStakerVault(address stakerVault, address token) external view returns (bool);

    function isStakerVaultRegistered(address stakerVault) external view returns (bool);

    function isWhiteListedFeeHandler(address feeHandler) external view returns (bool);

    /** Fee Handler function */
    function addFeeHandler(address feeHandler) external;

    function removeFeeHandler(address feeHandler) external;
}


// File interfaces/tokenomics/IInflationManager.sol

pragma solidity 0.8.10;

interface IInflationManager {
    event KeeperGaugeListed(address indexed pool, address indexed keeperGauge);
    event AmmGaugeListed(address indexed token, address indexed ammGauge);
    event KeeperGaugeDelisted(address indexed pool, address indexed keeperGauge);
    event AmmGaugeDelisted(address indexed token, address indexed ammGauge);

    /** Pool functions */

    function setKeeperGauge(address pool, address _keeperGauge) external returns (bool);

    function setAmmGauge(address token, address _ammGauge) external returns (bool);

    function setMinter(address _minter) external;

    function advanceKeeperGaugeEpoch(address pool) external;

    function whitelistGauge(address gauge) external;

    function removeStakerVaultFromInflation(address lpToken) external;

    function removeAmmGauge(address token) external returns (bool);

    function addGaugeForVault(address lpToken) external;

    function checkpointAllGauges() external;

    function mintRewards(address beneficiary, uint256 amount) external;

    function getAllAmmGauges() external view returns (address[] memory);

    function getLpRateForStakerVault(address stakerVault) external view returns (uint256);

    function getKeeperRateForPool(address pool) external view returns (uint256);

    function getAmmRateForToken(address token) external view returns (uint256);

    function getLpPoolWeight(address pool) external view returns (uint256);

    function getKeeperGaugeForPool(address pool) external view returns (address);

    function getAmmGaugeForToken(address token) external view returns (address);

    /** Weight setter functions **/

    function updateLpPoolWeight(address lpToken, uint256 newPoolWeight) external;

    function updateAmmTokenWeight(address token, uint256 newTokenWeight) external;

    function updateKeeperPoolWeight(address pool, uint256 newPoolWeight) external;

    function batchUpdateLpPoolWeights(address[] calldata lpTokens, uint256[] calldata weights)
        external;

    function batchUpdateAmmTokenWeights(address[] calldata tokens, uint256[] calldata weights)
        external;

    function batchUpdateKeeperPoolWeights(address[] calldata pools, uint256[] calldata weights)
        external;

    function deactivateWeightBasedKeeperDistribution() external;
}


// File interfaces/IController.sol

pragma solidity 0.8.10;




// solhint-disable ordering

interface IController {
    function addressProvider() external view returns (IAddressProvider);

    function inflationManager() external view returns (IInflationManager);

    function addStakerVault(address stakerVault) external;

    function shutdownPool(ILiquidityPool pool, bool shutdownStrategy) external returns (bool);

    /** Keeper functions */
    function updateKeeperRequiredStakedMERO(uint256 amount) external;

    function canKeeperExecuteAction(address keeper) external view returns (bool);

    /** Miscellaneous functions */

    function getTotalEthRequiredForGas(address payer) external view returns (uint256);
}


// File libraries/ScaledMath.sol

pragma solidity 0.8.10;

/*
 * @dev To use functions of this contract, at least one of the numbers must
 * be scaled to `DECIMAL_SCALE`. The result will scaled to `DECIMAL_SCALE`
 * if both numbers are scaled to `DECIMAL_SCALE`, otherwise to the scale
 * of the number not scaled by `DECIMAL_SCALE`
 */
library ScaledMath {
    // solhint-disable-next-line private-vars-leading-underscore
    uint256 internal constant DECIMAL_SCALE = 1e18;
    // solhint-disable-next-line private-vars-leading-underscore
    uint256 internal constant ONE = 1e18;

    /**
     * @notice Performs a multiplication between two scaled numbers
     */
    function scaledMul(uint256 a, uint256 b) internal pure returns (uint256) {
        return (a * b) / DECIMAL_SCALE;
    }

    /**
     * @notice Performs a division between two scaled numbers
     */
    function scaledDiv(uint256 a, uint256 b) internal pure returns (uint256) {
        return (a * DECIMAL_SCALE) / b;
    }

    /**
     * @notice Performs a division between two numbers, rounding up the result
     */
    function scaledDivRoundUp(uint256 a, uint256 b) internal pure returns (uint256) {
        return (a * DECIMAL_SCALE + b - 1) / b;
    }

    /**
     * @notice Performs a division between two numbers, ignoring any scaling and rounding up the result
     */
    function divRoundUp(uint256 a, uint256 b) internal pure returns (uint256) {
        return (a + b - 1) / b;
    }
}


// File libraries/Errors.sol

pragma solidity 0.8.10;

// solhint-disable private-vars-leading-underscore

library Error {
    string internal constant ADDRESS_WHITELISTED = "address already whitelisted";
    string internal constant ADMIN_ALREADY_SET = "admin has already been set once";
    string internal constant ADDRESS_NOT_WHITELISTED = "address not whitelisted";
    string internal constant ADDRESS_NOT_FOUND = "address not found";
    string internal constant CONTRACT_INITIALIZED = "contract can only be initialized once";
    string internal constant CONTRACT_PAUSED = "contract is paused";
    string internal constant UNAUTHORIZED_PAUSE = "not authorized to pause";
    string internal constant INVALID_AMOUNT = "invalid amount";
    string internal constant INVALID_INDEX = "invalid index";
    string internal constant INVALID_VALUE = "invalid msg.value";
    string internal constant INVALID_SENDER = "invalid msg.sender";
    string internal constant INVALID_TOKEN = "token address does not match pool's LP token address";
    string internal constant INVALID_DECIMALS = "incorrect number of decimals";
    string internal constant INVALID_ARGUMENT = "invalid argument";
    string internal constant INVALID_PARAMETER_VALUE = "invalid parameter value attempted";
    string internal constant INVALID_IMPLEMENTATION = "invalid pool implementation for given coin";
    string internal constant INVALID_POOL_IMPLEMENTATION =
        "invalid pool implementation for given coin";
    string internal constant INVALID_LP_TOKEN_IMPLEMENTATION =
        "invalid LP Token implementation for given coin";
    string internal constant INVALID_VAULT_IMPLEMENTATION =
        "invalid vault implementation for given coin";
    string internal constant INVALID_STAKER_VAULT_IMPLEMENTATION =
        "invalid stakerVault implementation for given coin";
    string internal constant INSUFFICIENT_ALLOWANCE = "insufficient allowance";
    string internal constant INSUFFICIENT_BALANCE = "insufficient balance";
    string internal constant INSUFFICIENT_AMOUNT_OUT = "Amount received less than min amount";
    string internal constant INSUFFICIENT_AMOUNT_IN = "Amount spent more than max amount";
    string internal constant ADDRESS_ALREADY_SET = "Address is already set";
    string internal constant INSUFFICIENT_STRATEGY_BALANCE = "insufficient strategy balance";
    string internal constant INSUFFICIENT_FUNDS_RECEIVED = "insufficient funds received";
    string internal constant ADDRESS_DOES_NOT_EXIST = "address does not exist";
    string internal constant ADDRESS_FROZEN = "address is frozen";
    string internal constant ROLE_EXISTS = "role already exists";
    string internal constant CANNOT_REVOKE_ROLE = "cannot revoke role";
    string internal constant UNAUTHORIZED_ACCESS = "unauthorized access";
    string internal constant SAME_ADDRESS_NOT_ALLOWED = "same address not allowed";
    string internal constant SELF_TRANSFER_NOT_ALLOWED = "self-transfer not allowed";
    string internal constant ZERO_ADDRESS_NOT_ALLOWED = "zero address not allowed";
    string internal constant ZERO_TRANSFER_NOT_ALLOWED = "zero transfer not allowed";
    string internal constant THRESHOLD_TOO_HIGH = "threshold is too high, must be under 10";
    string internal constant INSUFFICIENT_THRESHOLD = "insufficient threshold";
    string internal constant NO_POSITION_EXISTS = "no position exists";
    string internal constant POSITION_ALREADY_EXISTS = "position already exists";
    string internal constant CANNOT_EXECUTE_IN_SAME_BLOCK = "cannot execute action in same block";
    string internal constant PROTOCOL_NOT_FOUND = "protocol not found";
    string internal constant TOP_UP_FAILED = "top up failed";
    string internal constant SWAP_PATH_NOT_FOUND = "swap path not found";
    string internal constant UNDERLYING_NOT_SUPPORTED = "underlying token not supported";
    string internal constant NOT_ENOUGH_FUNDS_WITHDRAWN =
        "not enough funds were withdrawn from the pool";
    string internal constant FAILED_TRANSFER = "transfer failed";
    string internal constant FAILED_MINT = "mint failed";
    string internal constant FAILED_REPAY_BORROW = "repay borrow failed";
    string internal constant FAILED_METHOD_CALL = "method call failed";
    string internal constant NOTHING_TO_CLAIM = "there is no claimable balance";
    string internal constant ERC20_BALANCE_EXCEEDED = "ERC20: transfer amount exceeds balance";
    string internal constant INVALID_MINTER =
        "the minter address of the LP token and the pool address do not match";
    string internal constant STAKER_VAULT_EXISTS = "a staker vault already exists for the token";
    string internal constant DEADLINE_NOT_ZERO = "deadline must be 0";
    string internal constant NOTHING_PENDING = "no pending change to reset";
    string internal constant DEADLINE_NOT_SET = "deadline is 0";
    string internal constant DEADLINE_NOT_REACHED = "deadline has not been reached yet";
    string internal constant DELAY_TOO_SHORT = "delay must be at least 3 days";
    string internal constant INSUFFICIENT_UPDATE_BALANCE =
        "insufficient funds for updating the position";
    string internal constant SAME_AS_CURRENT = "value must be different to existing value";
    string internal constant NOT_CAPPED = "the pool is not currently capped";
    string internal constant ALREADY_CAPPED = "the pool is already capped";
    string internal constant ALREADY_SHUTDOWN = "the pool is already shutdown";
    string internal constant EXCEEDS_DEPOSIT_CAP = "deposit exceeds deposit cap";
    string internal constant VALUE_TOO_LOW_FOR_GAS = "value too low to cover gas";
    string internal constant NOT_ENOUGH_FUNDS = "not enough funds to withdraw";
    string internal constant ESTIMATED_GAS_TOO_HIGH = "too much ETH will be used for gas";
    string internal constant GAUGE_KILLED = "gauge killed";
    string internal constant INVALID_TARGET = "Invalid Target";
    string internal constant DEPOSIT_FAILED = "deposit failed";
    string internal constant GAS_TOO_HIGH = "too much ETH used for gas";
    string internal constant GAS_BANK_BALANCE_TOO_LOW = "not enough ETH in gas bank to cover gas";
    string internal constant INVALID_TOKEN_TO_ADD = "Invalid token to add";
    string internal constant INVALID_TOKEN_TO_REMOVE = "token can not be removed";
    string internal constant TIME_DELAY_NOT_EXPIRED = "time delay not expired yet";
    string internal constant UNDERLYING_NOT_WITHDRAWABLE =
        "pool does not support additional underlying coins to be withdrawn";
    string internal constant STRATEGY_SHUTDOWN = "Strategy is shutdown";
    string internal constant POOL_SHUTDOWN = "Pool is shutdown";
    string internal constant STRATEGY_DOES_NOT_EXIST = "Strategy does not exist";
    string internal constant GAUGE_STILL_ACTIVE = "Gauge still active";
    string internal constant UNSUPPORTED_UNDERLYING = "Underlying not supported";
    string internal constant NO_DEX_SET = "no dex has been set for token";
    string internal constant INVALID_TOKEN_PAIR = "invalid token pair";
    string internal constant TOKEN_NOT_USABLE = "token not usable for the specific action";
    string internal constant ADDRESS_NOT_ACTION = "address is not registered action";
    string internal constant INVALID_SLIPPAGE_TOLERANCE = "Invalid slippage tolerance";
    string internal constant INVALID_MAX_FEE = "invalid max fee";
    string internal constant POOL_NOT_PAUSED = "Pool must be paused to withdraw from reserve";
    string internal constant INTERACTION_LIMIT = "Max of one deposit and withdraw per block";
    string internal constant GAUGE_EXISTS = "Gauge already exists";
    string internal constant GAUGE_DOES_NOT_EXIST = "Gauge does not exist";
    string internal constant EXCEEDS_MAX_BOOST = "Not allowed to exceed maximum boost on Convex";
    string internal constant PREPARED_WITHDRAWAL =
        "Cannot relock funds when withdrawal is being prepared";
    string internal constant ASSET_NOT_SUPPORTED = "Asset not supported";
    string internal constant STALE_PRICE = "Price is stale";
    string internal constant NEGATIVE_PRICE = "Price is negative";
    string internal constant ROUND_NOT_COMPLETE = "Round not complete";
    string internal constant NOT_ENOUGH_MERO_STAKED = "Not enough MERO tokens staked";
    string internal constant RESERVE_ACCESS_EXCEEDED = "Reserve access exceeded";
}


// File @openzeppelin/contracts/utils/structs/[email protected]

// OpenZeppelin Contracts v4.4.1 (utils/structs/EnumerableSet.sol)

pragma solidity ^0.8.0;

/**
 * @dev Library for managing
 * https://en.wikipedia.org/wiki/Set_(abstract_data_type)[sets] of primitive
 * types.
 *
 * Sets have the following properties:
 *
 * - Elements are added, removed, and checked for existence in constant time
 * (O(1)).
 * - Elements are enumerated in O(n). No guarantees are made on the ordering.
 *
 * ```
 * contract Example {
 *     // Add the library methods
 *     using EnumerableSet for EnumerableSet.AddressSet;
 *
 *     // Declare a set state variable
 *     EnumerableSet.AddressSet private mySet;
 * }
 * ```
 *
 * As of v3.3.0, sets of type `bytes32` (`Bytes32Set`), `address` (`AddressSet`)
 * and `uint256` (`UintSet`) are supported.
 */
library EnumerableSet {
    // To implement this library for multiple types with as little code
    // repetition as possible, we write it in terms of a generic Set type with
    // bytes32 values.
    // The Set implementation uses private functions, and user-facing
    // implementations (such as AddressSet) are just wrappers around the
    // underlying Set.
    // This means that we can only create new EnumerableSets for types that fit
    // in bytes32.

    struct Set {
        // Storage of set values
        bytes32[] _values;
        // Position of the value in the `values` array, plus 1 because index 0
        // means a value is not in the set.
        mapping(bytes32 => uint256) _indexes;
    }

    /**
     * @dev Add a value to a set. O(1).
     *
     * Returns true if the value was added to the set, that is if it was not
     * already present.
     */
    function _add(Set storage set, bytes32 value) private returns (bool) {
        if (!_contains(set, value)) {
            set._values.push(value);
            // The value is stored at length-1, but we add 1 to all indexes
            // and use 0 as a sentinel value
            set._indexes[value] = set._values.length;
            return true;
        } else {
            return false;
        }
    }

    /**
     * @dev Removes a value from a set. O(1).
     *
     * Returns true if the value was removed from the set, that is if it was
     * present.
     */
    function _remove(Set storage set, bytes32 value) private returns (bool) {
        // We read and store the value's index to prevent multiple reads from the same storage slot
        uint256 valueIndex = set._indexes[value];

        if (valueIndex != 0) {
            // Equivalent to contains(set, value)
            // To delete an element from the _values array in O(1), we swap the element to delete with the last one in
            // the array, and then remove the last element (sometimes called as 'swap and pop').
            // This modifies the order of the array, as noted in {at}.

            uint256 toDeleteIndex = valueIndex - 1;
            uint256 lastIndex = set._values.length - 1;

            if (lastIndex != toDeleteIndex) {
                bytes32 lastvalue = set._values[lastIndex];

                // Move the last value to the index where the value to delete is
                set._values[toDeleteIndex] = lastvalue;
                // Update the index for the moved value
                set._indexes[lastvalue] = valueIndex; // Replace lastvalue's index to valueIndex
            }

            // Delete the slot where the moved value was stored
            set._values.pop();

            // Delete the index for the deleted slot
            delete set._indexes[value];

            return true;
        } else {
            return false;
        }
    }

    /**
     * @dev Returns true if the value is in the set. O(1).
     */
    function _contains(Set storage set, bytes32 value) private view returns (bool) {
        return set._indexes[value] != 0;
    }

    /**
     * @dev Returns the number of values on the set. O(1).
     */
    function _length(Set storage set) private view returns (uint256) {
        return set._values.length;
    }

    /**
     * @dev Returns the value stored at position `index` in the set. O(1).
     *
     * Note that there are no guarantees on the ordering of values inside the
     * array, and it may change when more values are added or removed.
     *
     * Requirements:
     *
     * - `index` must be strictly less than {length}.
     */
    function _at(Set storage set, uint256 index) private view returns (bytes32) {
        return set._values[index];
    }

    /**
     * @dev Return the entire set in an array
     *
     * WARNING: This operation will copy the entire storage to memory, which can be quite expensive. This is designed
     * to mostly be used by view accessors that are queried without any gas fees. Developers should keep in mind that
     * this function has an unbounded cost, and using it as part of a state-changing function may render the function
     * uncallable if the set grows to a point where copying to memory consumes too much gas to fit in a block.
     */
    function _values(Set storage set) private view returns (bytes32[] memory) {
        return set._values;
    }

    // Bytes32Set

    struct Bytes32Set {
        Set _inner;
    }

    /**
     * @dev Add a value to a set. O(1).
     *
     * Returns true if the value was added to the set, that is if it was not
     * already present.
     */
    function add(Bytes32Set storage set, bytes32 value) internal returns (bool) {
        return _add(set._inner, value);
    }

    /**
     * @dev Removes a value from a set. O(1).
     *
     * Returns true if the value was removed from the set, that is if it was
     * present.
     */
    function remove(Bytes32Set storage set, bytes32 value) internal returns (bool) {
        return _remove(set._inner, value);
    }

    /**
     * @dev Returns true if the value is in the set. O(1).
     */
    function contains(Bytes32Set storage set, bytes32 value) internal view returns (bool) {
        return _contains(set._inner, value);
    }

    /**
     * @dev Returns the number of values in the set. O(1).
     */
    function length(Bytes32Set storage set) internal view returns (uint256) {
        return _length(set._inner);
    }

    /**
     * @dev Returns the value stored at position `index` in the set. O(1).
     *
     * Note that there are no guarantees on the ordering of values inside the
     * array, and it may change when more values are added or removed.
     *
     * Requirements:
     *
     * - `index` must be strictly less than {length}.
     */
    function at(Bytes32Set storage set, uint256 index) internal view returns (bytes32) {
        return _at(set._inner, index);
    }

    /**
     * @dev Return the entire set in an array
     *
     * WARNING: This operation will copy the entire storage to memory, which can be quite expensive. This is designed
     * to mostly be used by view accessors that are queried without any gas fees. Developers should keep in mind that
     * this function has an unbounded cost, and using it as part of a state-changing function may render the function
     * uncallable if the set grows to a point where copying to memory consumes too much gas to fit in a block.
     */
    function values(Bytes32Set storage set) internal view returns (bytes32[] memory) {
        return _values(set._inner);
    }

    // AddressSet

    struct AddressSet {
        Set _inner;
    }

    /**
     * @dev Add a value to a set. O(1).
     *
     * Returns true if the value was added to the set, that is if it was not
     * already present.
     */
    function add(AddressSet storage set, address value) internal returns (bool) {
        return _add(set._inner, bytes32(uint256(uint160(value))));
    }

    /**
     * @dev Removes a value from a set. O(1).
     *
     * Returns true if the value was removed from the set, that is if it was
     * present.
     */
    function remove(AddressSet storage set, address value) internal returns (bool) {
        return _remove(set._inner, bytes32(uint256(uint160(value))));
    }

    /**
     * @dev Returns true if the value is in the set. O(1).
     */
    function contains(AddressSet storage set, address value) internal view returns (bool) {
        return _contains(set._inner, bytes32(uint256(uint160(value))));
    }

    /**
     * @dev Returns the number of values in the set. O(1).
     */
    function length(AddressSet storage set) internal view returns (uint256) {
        return _length(set._inner);
    }

    /**
     * @dev Returns the value stored at position `index` in the set. O(1).
     *
     * Note that there are no guarantees on the ordering of values inside the
     * array, and it may change when more values are added or removed.
     *
     * Requirements:
     *
     * - `index` must be strictly less than {length}.
     */
    function at(AddressSet storage set, uint256 index) internal view returns (address) {
        return address(uint160(uint256(_at(set._inner, index))));
    }

    /**
     * @dev Return the entire set in an array
     *
     * WARNING: This operation will copy the entire storage to memory, which can be quite expensive. This is designed
     * to mostly be used by view accessors that are queried without any gas fees. Developers should keep in mind that
     * this function has an unbounded cost, and using it as part of a state-changing function may render the function
     * uncallable if the set grows to a point where copying to memory consumes too much gas to fit in a block.
     */
    function values(AddressSet storage set) internal view returns (address[] memory) {
        bytes32[] memory store = _values(set._inner);
        address[] memory result;

        assembly {
            result := store
        }

        return result;
    }

    // UintSet

    struct UintSet {
        Set _inner;
    }

    /**
     * @dev Add a value to a set. O(1).
     *
     * Returns true if the value was added to the set, that is if it was not
     * already present.
     */
    function add(UintSet storage set, uint256 value) internal returns (bool) {
        return _add(set._inner, bytes32(value));
    }

    /**
     * @dev Removes a value from a set. O(1).
     *
     * Returns true if the value was removed from the set, that is if it was
     * present.
     */
    function remove(UintSet storage set, uint256 value) internal returns (bool) {
        return _remove(set._inner, bytes32(value));
    }

    /**
     * @dev Returns true if the value is in the set. O(1).
     */
    function contains(UintSet storage set, uint256 value) internal view returns (bool) {
        return _contains(set._inner, bytes32(value));
    }

    /**
     * @dev Returns the number of values on the set. O(1).
     */
    function length(UintSet storage set) internal view returns (uint256) {
        return _length(set._inner);
    }

    /**
     * @dev Returns the value stored at position `index` in the set. O(1).
     *
     * Note that there are no guarantees on the ordering of values inside the
     * array, and it may change when more values are added or removed.
     *
     * Requirements:
     *
     * - `index` must be strictly less than {length}.
     */
    function at(UintSet storage set, uint256 index) internal view returns (uint256) {
        return uint256(_at(set._inner, index));
    }

    /**
     * @dev Return the entire set in an array
     *
     * WARNING: This operation will copy the entire storage to memory, which can be quite expensive. This is designed
     * to mostly be used by view accessors that are queried without any gas fees. Developers should keep in mind that
     * this function has an unbounded cost, and using it as part of a state-changing function may render the function
     * uncallable if the set grows to a point where copying to memory consumes too much gas to fit in a block.
     */
    function values(UintSet storage set) internal view returns (uint256[] memory) {
        bytes32[] memory store = _values(set._inner);
        uint256[] memory result;

        assembly {
            result := store
        }

        return result;
    }
}


// File libraries/EnumerableMapping.sol

pragma solidity 0.8.10;

library EnumerableMapping {
    using EnumerableSet for EnumerableSet.Bytes32Set;

    // Code take from contracts/utils/structs/EnumerableMap.sol
    // because the helper functions are private

    // To implement this library for multiple types with as little code
    // repetition as possible, we write it in terms of a generic Map type with
    // bytes32 keys and values.
    // The Map implementation uses private functions, and user-facing
    // implementations (such as Uint256ToAddressMap) are just wrappers around
    // the underlying Map.
    // This means that we can only create new EnumerableMaps for types that fit
    // in bytes32.

    struct Map {
        // Storage of keys
        EnumerableSet.Bytes32Set _keys;
        mapping(bytes32 => bytes32) _values;
    }

    /**
     * @dev Adds a key-value pair to a map, or updates the value for an existing
     * key. O(1).
     *
     * Returns true if the key was added to the map, that is if it was not
     * already present.
     */
    function _set(
        Map storage map,
        bytes32 key,
        bytes32 value
    ) private returns (bool) {
        map._values[key] = value;
        return map._keys.add(key);
    }

    /**
     * @dev Removes a key-value pair from a map. O(1).
     *
     * Returns true if the key was removed from the map, that is if it was present.
     */
    function _remove(Map storage map, bytes32 key) private returns (bool) {
        delete map._values[key];
        return map._keys.remove(key);
    }

    /**
     * @dev Returns true if the key is in the map. O(1).
     */
    function _contains(Map storage map, bytes32 key) private view returns (bool) {
        return map._keys.contains(key);
    }

    /**
     * @dev Returns the number of key-value pairs in the map. O(1).
     */
    function _length(Map storage map) private view returns (uint256) {
        return map._keys.length();
    }

    /**
     * @dev Returns the key-value pair stored at position `index` in the map. O(1).
     *
     * Note that there are no guarantees on the ordering of entries inside the
     * array, and it may change when more entries are added or removed.
     *
     * Requirements:
     *
     * - `index` must be strictly less than {length}.
     */
    function _at(Map storage map, uint256 index) private view returns (bytes32, bytes32) {
        bytes32 key = map._keys.at(index);
        return (key, map._values[key]);
    }

    /**
     * @dev Tries to returns the value associated with `key`.  O(1).
     * Does not revert if `key` is not in the map.
     */
    function _tryGet(Map storage map, bytes32 key) private view returns (bool, bytes32) {
        bytes32 value = map._values[key];
        if (value == bytes32(0)) {
            return (_contains(map, key), bytes32(0));
        } else {
            return (true, value);
        }
    }

    /**
     * @dev Returns the value associated with `key`.  O(1).
     *
     * Requirements:
     *
     * - `key` must be in the map.
     */
    function _get(Map storage map, bytes32 key) private view returns (bytes32) {
        bytes32 value = map._values[key];
        require(value != 0 || _contains(map, key), "EnumerableMap: nonexistent key");
        return value;
    }

    // AddressToAddressMap

    struct AddressToAddressMap {
        Map _inner;
    }

    /**
     * @dev Adds a key-value pair to a map, or updates the value for an existing
     * key. O(1).
     *
     * Returns true if the key was added to the map, that is if it was not
     * already present.
     */
    function set(
        AddressToAddressMap storage map,
        address key,
        address value
    ) internal returns (bool) {
        return _set(map._inner, bytes32(uint256(uint160(key))), bytes32(uint256(uint160(value))));
    }

    /**
     * @dev Removes a value from a set. O(1).
     *
     * Returns true if the key was removed from the map, that is if it was present.
     */
    function remove(AddressToAddressMap storage map, address key) internal returns (bool) {
        return _remove(map._inner, bytes32(uint256(uint160(key))));
    }

    /**
     * @dev Returns true if the key is in the map. O(1).
     */
    function contains(AddressToAddressMap storage map, address key) internal view returns (bool) {
        return _contains(map._inner, bytes32(uint256(uint160(key))));
    }

    /**
     * @dev Returns the number of elements in the map. O(1).
     */
    function length(AddressToAddressMap storage map) internal view returns (uint256) {
        return _length(map._inner);
    }

    /**
     * @dev Returns the element stored at position `index` in the set. O(1).
     * Note that there are no guarantees on the ordering of values inside the
     * array, and it may change when more values are added or removed.
     *
     * Requirements:
     *
     * - `index` must be strictly less than {length}.
     */
    function at(AddressToAddressMap storage map, uint256 index)
        internal
        view
        returns (address, address)
    {
        (bytes32 key, bytes32 value) = _at(map._inner, index);
        return (address(uint160(uint256(key))), address(uint160(uint256(value))));
    }

    /**
     * @dev Tries to returns the value associated with `key`.  O(1).
     * Does not revert if `key` is not in the map.
     *
     * _Available since v3.4._
     */
    function tryGet(AddressToAddressMap storage map, address key)
        internal
        view
        returns (bool, address)
    {
        (bool success, bytes32 value) = _tryGet(map._inner, bytes32(uint256(uint160(key))));
        return (success, address(uint160(uint256(value))));
    }

    /**
     * @dev Returns the value associated with `key`.  O(1).
     *
     * Requirements:
     *
     * - `key` must be in the map.
     */
    function get(AddressToAddressMap storage map, address key) internal view returns (address) {
        return address(uint160(uint256(_get(map._inner, bytes32(uint256(uint160(key)))))));
    }

    // AddressToUintMap

    struct AddressToUintMap {
        Map _inner;
    }

    /**
     * @dev Adds a key-value pair to a map, or updates the value for an existing
     * key. O(1).
     *
     * Returns true if the key was added to the map, that is if it was not
     * already present.
     */
    function set(
        AddressToUintMap storage map,
        address key,
        uint256 value
    ) internal returns (bool) {
        return _set(map._inner, bytes32(uint256(uint160(key))), bytes32(value));
    }

    /**
     * @dev Removes a value from a set. O(1).
     *
     * Returns true if the key was removed from the map, that is if it was present.
     */
    function remove(AddressToUintMap storage map, address key) internal returns (bool) {
        return _remove(map._inner, bytes32(uint256(uint160(key))));
    }

    /**
     * @dev Returns true if the key is in the map. O(1).
     */
    function contains(AddressToUintMap storage map, address key) internal view returns (bool) {
        return _contains(map._inner, bytes32(uint256(uint160(key))));
    }

    /**
     * @dev Returns the number of elements in the map. O(1).
     */
    function length(AddressToUintMap storage map) internal view returns (uint256) {
        return _length(map._inner);
    }

    /**
     * @dev Returns the element stored at position `index` in the set. O(1).
     * Note that there are no guarantees on the ordering of values inside the
     * array, and it may change when more values are added or removed.
     *
     * Requirements:
     *
     * - `index` must be strictly less than {length}.
     */
    function at(AddressToUintMap storage map, uint256 index)
        internal
        view
        returns (address, uint256)
    {
        (bytes32 key, bytes32 value) = _at(map._inner, index);
        return (address(uint160(uint256(key))), uint256(value));
    }

    /**
     * @dev Tries to returns the value associated with `key`.  O(1).
     * Does not revert if `key` is not in the map.
     *
     * _Available since v3.4._
     */
    function tryGet(AddressToUintMap storage map, address key)
        internal
        view
        returns (bool, uint256)
    {
        (bool success, bytes32 value) = _tryGet(map._inner, bytes32(uint256(uint160(key))));
        return (success, uint256(value));
    }

    /**
     * @dev Returns the value associated with `key`.  O(1).
     *
     * Requirements:
     *
     * - `key` must be in the map.
     */
    function get(AddressToUintMap storage map, address key) internal view returns (uint256) {
        return uint256(_get(map._inner, bytes32(uint256(uint160(key)))));
    }

    // Bytes32ToUIntMap

    struct Bytes32ToUIntMap {
        Map _inner;
    }

    /**
     * @dev Adds a key-value pair to a map, or updates the value for an existing
     * key. O(1).
     *
     * Returns true if the key was added to the map, that is if it was not
     * already present.
     */
    function set(
        Bytes32ToUIntMap storage map,
        bytes32 key,
        uint256 value
    ) internal returns (bool) {
        return _set(map._inner, key, bytes32(value));
    }

    /**
     * @dev Removes a value from a set. O(1).
     *
     * Returns true if the key was removed from the map, that is if it was present.
     */
    function remove(Bytes32ToUIntMap storage map, bytes32 key) internal returns (bool) {
        return _remove(map._inner, key);
    }

    /**
     * @dev Returns true if the key is in the map. O(1).
     */
    function contains(Bytes32ToUIntMap storage map, bytes32 key) internal view returns (bool) {
        return _contains(map._inner, key);
    }

    /**
     * @dev Returns the number of elements in the map. O(1).
     */
    function length(Bytes32ToUIntMap storage map) internal view returns (uint256) {
        return _length(map._inner);
    }

    /**
     * @dev Returns the element stored at position `index` in the set. O(1).
     * Note that there are no guarantees on the ordering of values inside the
     * array, and it may change when more values are added or removed.
     *
     * Requirements:
     *
     * - `index` must be strictly less than {length}.
     */
    function at(Bytes32ToUIntMap storage map, uint256 index)
        internal
        view
        returns (bytes32, uint256)
    {
        (bytes32 key, bytes32 value) = _at(map._inner, index);
        return (key, uint256(value));
    }

    /**
     * @dev Tries to returns the value associated with `key`.  O(1).
     * Does not revert if `key` is not in the map.
     *
     * _Available since v3.4._
     */
    function tryGet(Bytes32ToUIntMap storage map, bytes32 key)
        internal
        view
        returns (bool, uint256)
    {
        (bool success, bytes32 value) = _tryGet(map._inner, key);
        return (success, uint256(value));
    }

    /**
     * @dev Returns the value associated with `key`.  O(1).
     *
     * Requirements:
     *
     * - `key` must be in the map.
     */
    function get(Bytes32ToUIntMap storage map, bytes32 key) internal view returns (uint256) {
        return uint256(_get(map._inner, key));
    }
}


// File libraries/EnumerableExtensions.sol

pragma solidity 0.8.10;


library EnumerableExtensions {
    using EnumerableSet for EnumerableSet.AddressSet;
    using EnumerableSet for EnumerableSet.Bytes32Set;
    using EnumerableMapping for EnumerableMapping.AddressToAddressMap;
    using EnumerableMapping for EnumerableMapping.AddressToUintMap;
    using EnumerableMapping for EnumerableMapping.Bytes32ToUIntMap;

    function toArray(EnumerableSet.AddressSet storage addresses)
        internal
        view
        returns (address[] memory)
    {
        uint256 len = addresses.length();
        address[] memory result = new address[](len);
        for (uint256 i; i < len; ) {
            result[i] = addresses.at(i);
            unchecked {
                ++i;
            }
        }
        return result;
    }

    function toArray(EnumerableSet.Bytes32Set storage values)
        internal
        view
        returns (bytes32[] memory)
    {
        uint256 len = values.length();
        bytes32[] memory result = new bytes32[](len);
        for (uint256 i; i < len; ) {
            result[i] = values.at(i);
            unchecked {
                ++i;
            }
        }
        return result;
    }

    function keyAt(EnumerableMapping.AddressToAddressMap storage map, uint256 index)
        internal
        view
        returns (address)
    {
        (address key, ) = map.at(index);
        return key;
    }

    function valueAt(EnumerableMapping.AddressToAddressMap storage map, uint256 index)
        internal
        view
        returns (address)
    {
        (, address value) = map.at(index);
        return value;
    }

    function keyAt(EnumerableMapping.AddressToUintMap storage map, uint256 index)
        internal
        view
        returns (address)
    {
        (address key, ) = map.at(index);
        return key;
    }

    function keyAt(EnumerableMapping.Bytes32ToUIntMap storage map, uint256 index)
        internal
        view
        returns (bytes32)
    {
        (bytes32 key, ) = map.at(index);
        return key;
    }

    function valueAt(EnumerableMapping.AddressToUintMap storage map, uint256 index)
        internal
        view
        returns (uint256)
    {
        (, uint256 value) = map.at(index);
        return value;
    }

    function keysArray(EnumerableMapping.AddressToAddressMap storage map)
        internal
        view
        returns (address[] memory)
    {
        uint256 len = map.length();
        address[] memory result = new address[](len);
        for (uint256 i; i < len; ) {
            result[i] = keyAt(map, i);
            unchecked {
                ++i;
            }
        }
        return result;
    }

    function valuesArray(EnumerableMapping.AddressToAddressMap storage map)
        internal
        view
        returns (address[] memory)
    {
        uint256 len = map.length();
        address[] memory result = new address[](len);
        for (uint256 i; i < len; ) {
            result[i] = valueAt(map, i);
            unchecked {
                ++i;
            }
        }
        return result;
    }

    function keysArray(EnumerableMapping.AddressToUintMap storage map)
        internal
        view
        returns (address[] memory)
    {
        uint256 len = map.length();
        address[] memory result = new address[](len);
        for (uint256 i; i < len; ) {
            result[i] = keyAt(map, i);
            unchecked {
                ++i;
            }
        }
        return result;
    }

    function keysArray(EnumerableMapping.Bytes32ToUIntMap storage map)
        internal
        view
        returns (bytes32[] memory)
    {
        uint256 len = map.length();
        bytes32[] memory result = new bytes32[](len);
        for (uint256 i; i < len; ) {
            result[i] = keyAt(map, i);
            unchecked {
                ++i;
            }
        }
        return result;
    }
}


// File interfaces/IRoleManager.sol

pragma solidity 0.8.10;

interface IRoleManager {
    event RoleGranted(bytes32 indexed role, address indexed account, address indexed sender);

    event RoleRevoked(bytes32 indexed role, address indexed account, address indexed sender);

    function grantRole(bytes32 role, address account) external;

    function addGovernor(address newGovernor) external;

    function renounceGovernance() external;

    function addGaugeZap(address zap) external;

    function removeGaugeZap(address zap) external;

    function revokeRole(bytes32 role, address account) external;

    function hasRole(bytes32 role, address account) external view returns (bool);

    function hasAnyRole(bytes32[] memory roles, address account) external view returns (bool);

    function hasAnyRole(
        bytes32 role1,
        bytes32 role2,
        address account
    ) external view returns (bool);

    function hasAnyRole(
        bytes32 role1,
        bytes32 role2,
        bytes32 role3,
        address account
    ) external view returns (bool);

    function getRoleMemberCount(bytes32 role) external view returns (uint256);

    function getRoleMember(bytes32 role, uint256 index) external view returns (address);
}


// File interfaces/IFeeBurner.sol

pragma solidity 0.8.10;

interface IFeeBurner {
    function burnToTarget(address[] memory tokens, address targetLpToken)
        external
        payable
        returns (uint256);
}


// File interfaces/tokenomics/IMeroToken.sol

pragma solidity 0.8.10;

interface IMeroToken is IERC20 {
    function mint(address account, uint256 amount) external;

    function cap() external view returns (uint256);
}


// File interfaces/ISwapperRouter.sol

pragma solidity 0.8.10;

interface ISwapperRouter {
    function swapAll(address fromToken, address toToken) external payable returns (uint256);

    function setSlippageTolerance(uint256 slippageTolerance_) external;

    function setCurvePool(address token_, address curvePool_) external;

    function swap(
        address fromToken,
        address toToken,
        uint256 amountIn
    ) external payable returns (uint256);

    function getAmountOut(
        address fromToken,
        address toToken,
        uint256 amountIn
    ) external view returns (uint256 amountOut);
}


// File libraries/AddressProviderKeys.sol

pragma solidity 0.8.10;

library AddressProviderKeys {
    bytes32 internal constant _TREASURY_KEY = "treasury";
    bytes32 internal constant _REWARD_HANDLER_KEY = "rewardHandler";
    bytes32 internal constant _GAS_BANK_KEY = "gasBank";
    bytes32 internal constant _VAULT_RESERVE_KEY = "vaultReserve";
    bytes32 internal constant _ORACLE_PROVIDER_KEY = "oracleProvider";
    bytes32 internal constant _POOL_FACTORY_KEY = "poolFactory";
    bytes32 internal constant _CONTROLLER_KEY = "controller";
    bytes32 internal constant _MERO_LOCKER_KEY = "meroLocker";
    bytes32 internal constant _FEE_BURNER_KEY = "feeBurner";
    bytes32 internal constant _ROLE_MANAGER_KEY = "roleManager";
    bytes32 internal constant _SWAPPER_ROUTER_KEY = "swapperRouter";
}


// File libraries/AddressProviderHelpers.sol

pragma solidity 0.8.10;









library AddressProviderHelpers {
    /**
     * @return The address of the treasury.
     */
    function getTreasury(IAddressProvider provider) internal view returns (address) {
        return provider.getAddress(AddressProviderKeys._TREASURY_KEY);
    }

    /**
     * @return The address of the reward handler.
     */
    function getRewardHandler(IAddressProvider provider) internal view returns (address) {
        return provider.getAddress(AddressProviderKeys._REWARD_HANDLER_KEY);
    }

    /**
     * @dev Returns zero address if no reward handler is set.
     * @return The address of the reward handler.
     */
    function getSafeRewardHandler(IAddressProvider provider) internal view returns (address) {
        return provider.getAddress(AddressProviderKeys._REWARD_HANDLER_KEY, false);
    }

    /**
     * @return The address of the fee burner.
     */
    function getFeeBurner(IAddressProvider provider) internal view returns (IFeeBurner) {
        return IFeeBurner(provider.getAddress(AddressProviderKeys._FEE_BURNER_KEY));
    }

    /**
     * @return The gas bank.
     */
    function getGasBank(IAddressProvider provider) internal view returns (IGasBank) {
        return IGasBank(provider.getAddress(AddressProviderKeys._GAS_BANK_KEY));
    }

    /**
     * @return The address of the vault reserve.
     */
    function getVaultReserve(IAddressProvider provider) internal view returns (IVaultReserve) {
        return IVaultReserve(provider.getAddress(AddressProviderKeys._VAULT_RESERVE_KEY));
    }

    /**
     * @return The oracleProvider.
     */
    function getOracleProvider(IAddressProvider provider) internal view returns (IOracleProvider) {
        return IOracleProvider(provider.getAddress(AddressProviderKeys._ORACLE_PROVIDER_KEY));
    }

    /**
     * @return the address of the MERO locker
     */
    function getMEROLocker(IAddressProvider provider) internal view returns (address) {
        return provider.getAddress(AddressProviderKeys._MERO_LOCKER_KEY);
    }

    /**
     * @return the address of the MERO locker
     */
    function getRoleManager(IAddressProvider provider) internal view returns (IRoleManager) {
        return IRoleManager(provider.getAddress(AddressProviderKeys._ROLE_MANAGER_KEY));
    }

    /**
     * @return the controller
     */
    function getController(IAddressProvider provider) internal view returns (IController) {
        return IController(provider.getAddress(AddressProviderKeys._CONTROLLER_KEY));
    }

    /**
     * @return the swapper router
     */
    function getSwapperRouter(IAddressProvider provider) internal view returns (ISwapperRouter) {
        return ISwapperRouter(provider.getAddress(AddressProviderKeys._SWAPPER_ROUTER_KEY));
    }
}


// File libraries/UncheckedMath.sol

pragma solidity 0.8.10;

library UncheckedMath {
    function uncheckedInc(uint256 a) internal pure returns (uint256) {
        unchecked {
            return a + 1;
        }
    }

    function uncheckedAdd(uint256 a, uint256 b) internal pure returns (uint256) {
        unchecked {
            return a + b;
        }
    }

    function uncheckedSub(uint256 a, uint256 b) internal pure returns (uint256) {
        unchecked {
            return a - b;
        }
    }

    function uncheckedDiv(uint256 a, uint256 b) internal pure returns (uint256) {
        unchecked {
            return a / b;
        }
    }
}


// File contracts/vault/VaultStorage.sol

pragma solidity 0.8.10;



contract VaultStorage {
    uint256 public currentAllocated;
    uint256 public waitingForRemovalAllocated;
    address public pool;

    uint256 public totalDebt;
    bool public strategyActive;

    EnumerableMapping.AddressToUintMap internal _strategiesWaitingForRemoval;
}

contract VaultStorageV1 is VaultStorage {
    /**
     * @dev This is to avoid breaking contracts inheriting from `VaultStorage`
     * such as `Erc20Vault`, especially if they have storage variables
     * See https://docs.openzeppelin.com/contracts/4.x/upgradeable#storage_gaps
     * for more details
     *
     * A new field can be added using a new contract such as
     *
     * ```solidity
     * contract VaultStorageV2 is VaultStorage {
     *   uint256 someNewField;
     *   uint256[49] private __gap;
     * }
     */
    uint256[50] private __gap;
}


// File contracts/utils/IPausable.sol

pragma solidity 0.8.10;

interface IPausable {
    function pause() external returns (bool);

    function unpause() external returns (bool);

    function isPaused() external view returns (bool);

    function isAuthorizedToPause(address account) external view returns (bool);
}


// File libraries/Roles.sol

pragma solidity 0.8.10;

// solhint-disable private-vars-leading-underscore

library Roles {
    bytes32 internal constant GOVERNANCE = "governance";
    bytes32 internal constant ADDRESS_PROVIDER = "address_provider";
    bytes32 internal constant POOL_FACTORY = "pool_factory";
    bytes32 internal constant CONTROLLER = "controller";
    bytes32 internal constant GAUGE_ZAP = "gauge_zap";
    bytes32 internal constant MAINTENANCE = "maintenance";
    bytes32 internal constant INFLATION_MANAGER = "inflation_manager";
    bytes32 internal constant POOL = "pool";
    bytes32 internal constant VAULT = "vault";
}


// File contracts/access/AuthorizationBase.sol

pragma solidity 0.8.10;


/**
 * @notice Provides modifiers for authorization
 */
abstract contract AuthorizationBase {
    /**
     * @notice Only allows a sender with `role` to perform the given action
     */
    modifier onlyRole(bytes32 role) {
        require(_roleManager().hasRole(role, msg.sender), Error.UNAUTHORIZED_ACCESS);
        _;
    }

    /**
     * @notice Only allows a sender with GOVERNANCE role to perform the given action
     */
    modifier onlyGovernance() {
        require(_roleManager().hasRole(Roles.GOVERNANCE, msg.sender), Error.UNAUTHORIZED_ACCESS);
        _;
    }

    /**
     * @notice Only allows a sender with any of `roles` to perform the given action
     */
    modifier onlyRoles2(bytes32 role1, bytes32 role2) {
        require(_roleManager().hasAnyRole(role1, role2, msg.sender), Error.UNAUTHORIZED_ACCESS);
        _;
    }

    /**
     * @notice Only allows a sender with any of `roles` to perform the given action
     */
    modifier onlyRoles3(
        bytes32 role1,
        bytes32 role2,
        bytes32 role3
    ) {
        require(
            _roleManager().hasAnyRole(role1, role2, role3, msg.sender),
            Error.UNAUTHORIZED_ACCESS
        );
        _;
    }

    function roleManager() external view virtual returns (IRoleManager) {
        return _roleManager();
    }

    function _roleManager() internal view virtual returns (IRoleManager);
}


// File contracts/access/Authorization.sol

pragma solidity 0.8.10;

contract Authorization is AuthorizationBase {
    IRoleManager internal immutable __roleManager;

    constructor(IRoleManager roleManager) {
        __roleManager = roleManager;
    }

    function _roleManager() internal view override returns (IRoleManager) {
        return __roleManager;
    }
}


// File contracts/vault/Vault.sol

pragma solidity 0.8.10;












abstract contract Vault is IVault, Authorization, VaultStorageV1, Initializable {
    using ScaledMath for uint256;
    using UncheckedMath for uint256;
    using SafeERC20 for IERC20;
    using EnumerableSet for EnumerableSet.AddressSet;
    using EnumerableExtensions for EnumerableSet.AddressSet;
    using EnumerableMapping for EnumerableMapping.AddressToUintMap;
    using EnumerableExtensions for EnumerableMapping.AddressToUintMap;
    using AddressProviderHelpers for IAddressProvider;

    IStrategy public strategy;
    uint256 public performanceFee;
    uint256 public strategistFee = 0.1e18;
    uint256 public debtLimit;
    uint256 public targetAllocation;
    uint256 public reserveFee = 0.01e18;
    uint256 public bound;

    uint256 public constant MAX_PERFORMANCE_FEE = 0.5e18;
    uint256 public constant MAX_DEVIATION_BOUND = 0.5e18;
    uint256 public constant STRATEGY_DELAY = 5 days;

    IController public immutable controller;
    IAddressProvider public immutable addressProvider;
    IVaultReserve public immutable reserve;

    event StrategyUpdated(address newStrategy);
    event PerformanceFeeUpdated(uint256 performanceFee);
    event StrategistFeeUpdated(uint256 strategistFee);
    event DebtLimitUpdated(uint256 debtLimit);
    event TargetAllocationUpdated(uint256 targetAllocation);
    event ReserveFeeUpdated(uint256 reserveFee);
    event BoundUpdated(uint256 bound);
    event AllFundsWithdrawn();

    modifier onlyPool() {
        require(msg.sender == pool, Error.UNAUTHORIZED_ACCESS);
        _;
    }

    modifier onlyPoolOrGovernance() {
        require(
            msg.sender == pool || _roleManager().hasRole(Roles.GOVERNANCE, msg.sender),
            Error.UNAUTHORIZED_ACCESS
        );
        _;
    }

    modifier onlyPoolOrMaintenance() {
        require(
            msg.sender == pool || _roleManager().hasRole(Roles.MAINTENANCE, msg.sender),
            Error.UNAUTHORIZED_ACCESS
        );
        _;
    }

    constructor(IController _controller)
        Authorization(_controller.addressProvider().getRoleManager())
    {
        controller = _controller;
        IAddressProvider addressProvider_ = _controller.addressProvider();
        addressProvider = addressProvider_;
        reserve = IVaultReserve(addressProvider_.getVaultReserve());
    }

    function _initialize(
        address pool_,
        uint256 debtLimit_,
        uint256 targetAllocation_,
        uint256 bound_
    ) internal {
        require(debtLimit_ <= ScaledMath.ONE, Error.INVALID_AMOUNT);
        require(targetAllocation_ <= ScaledMath.ONE, Error.INVALID_AMOUNT);
        require(bound_ <= MAX_DEVIATION_BOUND, Error.INVALID_AMOUNT);

        pool = pool_;
        debtLimit = debtLimit_;
        targetAllocation = targetAllocation_;
        bound = bound_;
    }

    /**
     * @notice Handles deposits from the liquidity pool
     */
    function deposit() external payable override onlyPoolOrMaintenance {
        // solhint-disable-previous-line ordering
        _deposit();
    }

    /**
     * @notice Withdraws specified amount of underlying from vault.
     * @dev If the specified amount exceeds idle funds, an amount of funds is withdrawn
     *      from the strategy such that it will achieve a target allocation for after the
     *      amount has been withdrawn.
     * @param amount Amount to withdraw.
     * @return `true` if successful.
     */
    function withdraw(uint256 amount) external override onlyPoolOrGovernance returns (bool) {
        IStrategy strategy_ = strategy;
        uint256 availableUnderlying_ = _availableUnderlying();

        if (availableUnderlying_ < amount) {
            if (address(strategy_) == address(0)) return false;
            uint256 allocated = strategy_.balance();
            uint256 requiredWithdrawal = amount.uncheckedSub(availableUnderlying_);

            if (requiredWithdrawal > allocated) return false;

            // compute withdrawal amount to sustain target allocation
            uint256 newTarget = allocated.uncheckedSub(requiredWithdrawal).scaledMul(
                targetAllocation
            );
            uint256 excessAmount = allocated - newTarget;
            strategy_.withdraw(excessAmount);
            currentAllocated = _computeNewAllocated(currentAllocated, excessAmount);
        } else {
            uint256 allocatedUnderlying;
            if (address(strategy_) != address(0))
                allocatedUnderlying = IStrategy(strategy_).balance();
            uint256 totalUnderlying = availableUnderlying_ +
                allocatedUnderlying +
                waitingForRemovalAllocated;
            uint256 totalUnderlyingAfterWithdraw = totalUnderlying.uncheckedSub(amount);
            _rebalance(totalUnderlyingAfterWithdraw, allocatedUnderlying);
        }

        _transfer(pool, amount);
        return true;
    }

    /**
     * @notice Shuts down the strategy, withdraws all funds from vault and
     * strategy and transfer them to the pool.
     */
    function shutdownStrategy() external override onlyPool {
        _withdrawAllFromStrategy();
        _transfer(pool, _availableUnderlying());
    }

    /**
     * @notice Transfers all the available funds to the pool
     */
    function withdrawAvailableToPool() external onlyPoolOrGovernance {
        _transfer(pool, _availableUnderlying());
    }

    /**
     * @notice Withdraws specified amount of underlying from reserve to vault.
     * @dev Withdraws from reserve will cause a spike in pool exchange rate.
     *  Pool deposits should be paused during this to prevent front running
     * @param amount Amount to withdraw.
     */
    function withdrawFromReserve(uint256 amount) external override onlyGovernance {
        require(amount > 0, Error.INVALID_AMOUNT);
        require(IPausable(pool).isPaused(), Error.POOL_NOT_PAUSED);
        uint256 reserveBalance_ = reserve.getBalance(address(this), getUnderlying());
        require(amount <= reserveBalance_, Error.INSUFFICIENT_BALANCE);
        reserve.withdraw(getUnderlying(), amount);
    }

    /**
     * @notice Activate the current strategy set for the vault.
     * @return `true` if strategy has been activated
     */
    function activateStrategy() external override onlyGovernance returns (bool) {
        return _activateStrategy();
    }

    /**
     * @notice Deactivates a strategy.
     * @return `true` if strategy has been deactivated
     */
    function deactivateStrategy() external override onlyGovernance returns (bool) {
        return _deactivateStrategy();
    }

    /**
     * @notice Initializes the vault's strategy.
     * @dev Bypasses the time delay, but can only be called if strategy is not set already.
     * @param strategy_ Address of the strategy.
     */
    function initializeStrategy(address strategy_) external override onlyGovernance {
        require(address(strategy) == address(0), Error.ADDRESS_ALREADY_SET);
        require(strategy_ != address(0), Error.ZERO_ADDRESS_NOT_ALLOWED);
        strategy = IStrategy(strategy_);
        _activateStrategy();
        require(IStrategy(strategy_).strategist() != address(0), Error.ZERO_ADDRESS_NOT_ALLOWED);
    }

    /**
     * @notice Update the vault's strategy (with time delay enforced).
     * @param newStrategy_ Address of the new strategy.
     */
    function updateStrategy(address newStrategy_) external override onlyGovernance {
        IStrategy strategy_ = strategy;
        if (address(strategy_) != address(0)) {
            _harvest();
            strategy_.shutdown();
            strategy_.withdrawAll();

            // there might still be some balance left if the strategy did not
            // manage to withdraw all funds (e.g. due to locking)
            uint256 remainingStrategyBalance = strategy_.balance();
            if (remainingStrategyBalance > 0) {
                _strategiesWaitingForRemoval.set(address(strategy_), remainingStrategyBalance);
                waitingForRemovalAllocated += remainingStrategyBalance;
            }
        }
        _deactivateStrategy();
        currentAllocated = 0;
        totalDebt = 0;
        strategy = IStrategy(newStrategy_);

        if (newStrategy_ != address(0)) _activateStrategy();
        emit StrategyUpdated(newStrategy_);
    }

    /**
     * @notice Update performance fee.
     * @param performanceFee_ New performance fee value.
     */
    function updatePerformanceFee(uint256 performanceFee_) external override onlyGovernance {
        require(performanceFee_ <= MAX_PERFORMANCE_FEE, Error.INVALID_AMOUNT);
        performanceFee = performanceFee_;
        emit PerformanceFeeUpdated(performanceFee_);
    }

    /**
     * @notice Update strategist fee (with time delay enforced).
     * @param strategistFee_ New strategist fee value.
     */
    function updateStrategistFee(uint256 strategistFee_) external override onlyGovernance {
        _checkFeesInvariant(reserveFee, strategistFee_);
        strategistFee = strategistFee_;
        emit StrategistFeeUpdated(strategistFee_);
    }

    /**
     * @notice Update debt limit.
     * @param debtLimit_ New debt limit.
     */
    function updateDebtLimit(uint256 debtLimit_) external override onlyGovernance {
        debtLimit = debtLimit_;
        if (totalDebt >= currentAllocated.scaledMul(debtLimit_)) _handleExcessDebt();
        emit DebtLimitUpdated(debtLimit_);
    }

    /**
     * @notice Update target allocation.
     * @param targetAllocation_ New target allocation.
     */
    function updateTargetAllocation(uint256 targetAllocation_) external override onlyGovernance {
        targetAllocation = targetAllocation_;
        _deposit();
        emit TargetAllocationUpdated(targetAllocation_);
    }

    /**
     * @notice Update reserve fee.
     * @param reserveFee_ New reserve fee.
     */
    function updateReserveFee(uint256 reserveFee_) external override onlyGovernance {
        _checkFeesInvariant(reserveFee_, strategistFee);
        reserveFee = reserveFee_;
        emit ReserveFeeUpdated(reserveFee_);
    }

    /**
     * @notice Update deviation bound for strategy allocation.
     * @param bound_ New deviation bound for target allocation.
     */
    function updateBound(uint256 bound_) external override onlyGovernance {
        require(bound_ <= MAX_DEVIATION_BOUND, Error.INVALID_AMOUNT);
        bound = bound_;
        _deposit();
        emit BoundUpdated(bound_);
    }

    /**
     * @notice Withdraws an amount of underlying from the strategy to the vault.
     * @param amount Amount of underlying to withdraw.
     * @return True if successful withdrawal.
     */
    function withdrawFromStrategy(uint256 amount) external override onlyGovernance returns (bool) {
        IStrategy strategy_ = strategy;
        if (address(strategy_) == address(0)) return false;
        if (strategy_.balance() < amount) return false;
        uint256 oldBalance = _availableUnderlying();
        strategy_.withdraw(amount);
        uint256 newBalance = _availableUnderlying();
        currentAllocated -= newBalance - oldBalance;
        return true;
    }

    function withdrawFromStrategyWaitingForRemoval(address strategy_)
        external
        override
        returns (uint256)
    {
        (bool exists, uint256 allocated) = _strategiesWaitingForRemoval.tryGet(strategy_);
        require(exists, Error.STRATEGY_DOES_NOT_EXIST);

        IStrategy(strategy_).harvest();
        uint256 withdrawn = IStrategy(strategy_).withdrawAll();

        uint256 _waitingForRemovalAllocated = waitingForRemovalAllocated;
        if (withdrawn >= _waitingForRemovalAllocated) {
            waitingForRemovalAllocated = 0;
        } else {
            waitingForRemovalAllocated = _waitingForRemovalAllocated.uncheckedSub(withdrawn);
        }

        if (withdrawn > allocated) {
            uint256 profit = withdrawn.uncheckedSub(allocated);
            uint256 strategistShare = _shareFees(profit.scaledMul(performanceFee));
            if (strategistShare > 0) {
                _payStrategist(strategistShare, IStrategy(strategy_).strategist());
            }
            allocated = 0;
            emit Harvest(profit, 0);
        } else {
            allocated = allocated.uncheckedSub(withdrawn);
        }

        if (IStrategy(strategy_).balance() == 0) {
            _strategiesWaitingForRemoval.remove(strategy_);
        } else {
            _strategiesWaitingForRemoval.set(strategy_, allocated);
        }

        return withdrawn;
    }

    function getStrategiesWaitingForRemoval() external view override returns (address[] memory) {
        return _strategiesWaitingForRemoval.keysArray();
    }

    /**
     * @notice Computes the total underlying of the vault: idle funds + allocated funds
     * @return Total amount of underlying.
     */
    function getTotalUnderlying() external view override returns (uint256) {
        if (address(strategy) == address(0)) {
            return _availableUnderlying();
        }

        return _availableUnderlying() + currentAllocated + waitingForRemovalAllocated;
    }

    function getAllocatedToStrategyWaitingForRemoval(address strategy_)
        external
        view
        override
        returns (uint256)
    {
        return _strategiesWaitingForRemoval.get(strategy_);
    }

    /**
     * @notice Withdraws all funds from strategy to vault.
     * @dev Harvests profits before withdrawing. Deactivates strategy after withdrawing.
     * @return `true` if successful.
     */
    function withdrawAllFromStrategy() public override onlyPoolOrGovernance returns (bool) {
        return _withdrawAllFromStrategy();
    }

    /**
     * @notice Harvest profits from the vault's strategy.
     * @dev Harvesting adds profits to the vault's balance and deducts fees.
     *  No performance fees are charged on profit used to repay debt.
     * @return `true` if successful.
     */
    function harvest() public override onlyPoolOrMaintenance returns (bool) {
        return _harvest();
    }

    function getUnderlying() public view virtual override returns (address);

    function _activateStrategy() internal returns (bool) {
        IStrategy strategy_ = strategy;
        if (address(strategy_) == address(0)) return false;

        strategyActive = true;
        emit StrategyActivated(address(strategy_));
        _deposit();
        return true;
    }

    function _harvest() internal returns (bool) {
        IStrategy strategy_ = strategy;
        if (address(strategy_) == address(0)) {
            return false;
        }

        strategy_.harvest();

        uint256 strategistShare;

        uint256 allocatedUnderlying = strategy_.balance();
        uint256 amountAllocated = currentAllocated;
        uint256 currentDebt = totalDebt;

        if (allocatedUnderlying > amountAllocated) {
            // we made profits
            uint256 profit = allocatedUnderlying.uncheckedSub(amountAllocated);

            if (profit > currentDebt) {
                if (currentDebt > 0) {
                    profit = profit.uncheckedSub(currentDebt);
                    currentDebt = 0;
                }
                (profit, strategistShare) = _shareProfit(profit);
            } else {
                currentDebt = currentDebt.uncheckedSub(profit);
            }
            emit Harvest(profit, 0);
        } else if (allocatedUnderlying < amountAllocated) {
            // we made a loss
            uint256 loss = amountAllocated.uncheckedSub(allocatedUnderlying);
            currentDebt += loss;

            // check debt limit and withdraw funds if exceeded
            uint256 debtLimitAllocated = amountAllocated.scaledMul(debtLimit);
            if (currentDebt > debtLimitAllocated) {
                currentDebt = _handleExcessDebt(currentDebt);
            }
            emit Harvest(0, loss);
        } else {
            // nothing to declare
            return true;
        }

        totalDebt = currentDebt;
        currentAllocated = strategy_.balance();

        if (strategistShare > 0) {
            _payStrategist(strategistShare);
        }

        return true;
    }

    function _withdrawAllFromStrategy() internal returns (bool) {
        IStrategy strategy_ = strategy;
        if (address(strategy_) == address(0)) return false;
        _harvest();
        strategy_.withdrawAll();
        currentAllocated = 0;
        totalDebt = 0;
        _deactivateStrategy();
        emit AllFundsWithdrawn();
        return true;
    }

    function _handleExcessDebt(uint256 currentDebt) internal returns (uint256) {
        IVaultReserve reserve_ = reserve;
        uint256 underlyingReserves = reserve_.getBalance(address(this), getUnderlying());
        if (currentDebt > underlyingReserves) {
            _emergencyStop(underlyingReserves);
        } else if (reserve_.canWithdraw(address(this))) {
            reserve_.withdraw(getUnderlying(), currentDebt);
            currentDebt = 0;
            _deposit();
        }
        return currentDebt;
    }

    function _handleExcessDebt() internal {
        uint256 currentDebt = totalDebt;
        uint256 newDebt = _handleExcessDebt(currentDebt);
        if (currentDebt != newDebt) {
            totalDebt = newDebt;
        }
    }

    /**
     * @notice Invest the underlying money in the vault after a deposit from the pool is made.
     * @dev After each deposit, the vault checks whether it needs to rebalance underlying funds allocated to strategy.
     * If no strategy is set then all deposited funds will be idle.
     */
    function _deposit() internal {
        if (!strategyActive) return;

        uint256 allocatedUnderlying = strategy.balance();
        uint256 totalUnderlying = _availableUnderlying() +
            allocatedUnderlying +
            waitingForRemovalAllocated;

        if (totalUnderlying == 0) return;
        _rebalance(totalUnderlying, allocatedUnderlying);
    }

    function _shareProfit(uint256 profit) internal returns (uint256, uint256) {
        uint256 totalFeeAmount = profit.scaledMul(performanceFee);
        if (_availableUnderlying() < totalFeeAmount) {
            strategy.withdraw(totalFeeAmount);
        }
        uint256 strategistShare = _shareFees(totalFeeAmount);

        return ((profit - totalFeeAmount), strategistShare);
    }

    function _shareFees(uint256 totalFeeAmount) internal returns (uint256) {
        uint256 strategistShare = totalFeeAmount.scaledMul(strategistFee);

        uint256 reserveShare = totalFeeAmount.scaledMul(reserveFee);
        uint256 govShare = totalFeeAmount - strategistShare - reserveShare;

        _depositToReserve(reserveShare);
        if (govShare > 0) {
            _depositToRewardHandler(govShare);
        }
        return strategistShare;
    }

    function _emergencyStop(uint256 underlyingReserves) internal {
        // debt limit exceeded: withdraw funds from strategy
        uint256 withdrawn = strategy.withdrawAll();

        uint256 actualDebt = _computeNewAllocated(currentAllocated, withdrawn);

        if (reserve.canWithdraw(address(this))) {
            // check if debt can be covered with reserve funds
            if (underlyingReserves >= actualDebt) {
                reserve.withdraw(getUnderlying(), actualDebt);
            } else if (underlyingReserves > 0) {
                // debt can not be covered with reserves
                reserve.withdraw(getUnderlying(), underlyingReserves);
            }
        }

        // too much money lost, stop the strategy
        _deactivateStrategy();
    }

    /**
     * @notice Deactivates a strategy. All positions of the strategy are exited.
     * @return `true` if strategy has been deactivated
     */
    function _deactivateStrategy() internal returns (bool) {
        if (!strategyActive) return false;

        strategyActive = false;
        emit StrategyDeactivated(address(strategy));
        return true;
    }

    function _payStrategist(uint256 amount) internal {
        _payStrategist(amount, strategy.strategist());
    }

    function _payStrategist(uint256 amount, address strategist) internal virtual;

    function _transfer(address to, uint256 amount) internal virtual;

    function _depositToReserve(uint256 amount) internal virtual;

    function _depositToRewardHandler(uint256 amount) internal virtual;

    function _availableUnderlying() internal view virtual returns (uint256);

    function _computeNewAllocated(uint256 allocated, uint256 withdrawn)
        internal
        pure
        returns (uint256)
    {
        if (allocated > withdrawn) {
            return allocated - withdrawn;
        }
        return 0;
    }

    function _checkFeesInvariant(uint256 reserveFee_, uint256 strategistFee_) internal pure {
        require(
            reserveFee_ + strategistFee_ <= ScaledMath.ONE,
            "sum of strategist fee and reserve fee should be below 1"
        );
    }

    function _rebalance(uint256 totalUnderlying, uint256 allocatedUnderlying)
        private
        returns (bool)
    {
        if (!strategyActive) return false;
        uint256 targetAllocation_ = targetAllocation;

        uint256 bound_ = bound;

        uint256 target = totalUnderlying.scaledMul(targetAllocation_);
        uint256 upperBound = targetAllocation_ == 0 ? 0 : targetAllocation_ + bound_;
        upperBound = upperBound > ScaledMath.ONE ? ScaledMath.ONE : upperBound;
        uint256 lowerBound = bound_ > targetAllocation_ ? 0 : targetAllocation_ - bound_;
        if (allocatedUnderlying > totalUnderlying.scaledMul(upperBound)) {
            // withdraw funds from strategy
            uint256 withdrawAmount = allocatedUnderlying - target;
            strategy.withdraw(withdrawAmount);

            currentAllocated = _computeNewAllocated(currentAllocated, withdrawAmount);
        } else if (allocatedUnderlying < totalUnderlying.scaledMul(lowerBound)) {
            // allocate more funds to strategy
            uint256 depositAmount = target - allocatedUnderlying;
            _transfer(address(strategy), depositAmount);
            currentAllocated += depositAmount;
            strategy.deposit();
        }
        return true;
    }
}


// File contracts/vault/EthVault.sol

pragma solidity 0.8.10;

contract EthVault is Vault {
    using AddressProviderHelpers for IAddressProvider;

    address private constant _UNDERLYING = address(0);

    constructor(IController controller) Vault(controller) {}

    receive() external payable {}

    function initialize(
        address _pool,
        uint256 _debtLimit,
        uint256 _targetAllocation,
        uint256 _bound
    ) external virtual override initializer {
        _initialize(_pool, _debtLimit, _targetAllocation, _bound);
    }

    function getUnderlying() public pure override returns (address) {
        return _UNDERLYING;
    }

    function _transfer(address to, uint256 amount) internal override {
        // solhint-disable-next-line avoid-low-level-calls
        (bool success, ) = payable(to).call{value: amount}("");
        require(success, Error.FAILED_TRANSFER);
    }

    function _depositToReserve(uint256 amount) internal override {
        reserve.deposit{value: amount}(_UNDERLYING, amount);
    }

    function _depositToRewardHandler(uint256 amount) internal override {
        address handler = addressProvider.getSafeRewardHandler();
        if (handler == address(0)) {
            handler = addressProvider.getTreasury();
        }
        // solhint-disable-next-line avoid-low-level-calls
        (bool success, ) = payable(handler).call{value: amount}("");
        require(success, Error.FAILED_TRANSFER);
    }

    function _payStrategist(uint256 amount, address strategist) internal override {
        if (strategist == address(0)) return;
        ILiquidityPool(pool).depositFor{value: amount}(strategist, amount);
    }

    function _availableUnderlying() internal view override returns (uint256) {
        return address(this).balance;
    }
}