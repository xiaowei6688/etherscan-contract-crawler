/**
 *Submitted for verification at Etherscan.io on 2022-12-23
*/

// SPDX-License-Identifier: GPL-3.0-or-later
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

// File @mimic-fi/v2-registry/contracts/implementations/[email protected]


pragma solidity >=0.8.0;

// solhint-disable func-name-mixedcase

/**
 * @title IImplementation
 * @dev Implementation interface that must be followed for implementations to be registered in the Mimic Registry
 */
interface IImplementation {
    /**
     * @dev Tells the namespace under which the implementation is registered in the Mimic Registry
     */
    function NAMESPACE() external view returns (bytes32);

    /**
     * @dev Tells the address of the Mimic Registry
     */
    function registry() external view returns (address);
}


// File @mimic-fi/v2-helpers/contracts/auth/[email protected]


pragma solidity >=0.8.0;

/**
 * @title IAuthorizer
 */
interface IAuthorizer {
    /**
     * @dev Emitted when an account is authorized to call a function
     */
    event Authorized(address indexed who, bytes4 what);

    /**
     * @dev Emitted when an account is unauthorized to call a function
     */
    event Unauthorized(address indexed who, bytes4 what);

    /**
     * @dev Authorizes someone to call a function. Sender must be authorize to do so.
     * @param who Address to be authorized
     * @param what Function selector to be granted
     */
    function authorize(address who, bytes4 what) external;

    /**
     * @dev Unauthorizes someone to call a function. Sender must be authorize to do so.
     * @param who Address to be unauthorized
     * @param what Function selector to be revoked
     */
    function unauthorize(address who, bytes4 what) external;

    /**
     * @dev Tells whether someone is allowed to call a function or not. It returns true if it's allowed to anyone.
     * @param who Address asking permission for
     * @param what Function selector asking permission for
     */
    function isAuthorized(address who, bytes4 what) external view returns (bool);
}


// File @mimic-fi/v2-price-oracle/contracts/feeds/[email protected]


pragma solidity >=0.8.0;

/**
 * @title IPriceFeedProvider
 * @dev Contract providing price feed references for (base, quote) token pairs
 */
interface IPriceFeedProvider {
    /**
     * @dev Emitted every time a price feed is set for (base, quote) pair
     */
    event PriceFeedSet(address indexed base, address indexed quote, address feed);

    /**
     * @dev Tells the price feed address for (base, quote) pair. It returns the zero address if there is no one set.
     * @param base Token to be rated
     * @param quote Token used for the price rate
     */
    function getPriceFeed(address base, address quote) external view returns (address);

    /**
     * @dev Sets a of price feed
     * @param base Token base to be set
     * @param quote Token quote to be set
     * @param feed Price feed to be set
     */
    function setPriceFeed(address base, address quote, address feed) external;

    /**
     * @dev Sets a list of price feeds
     * @param bases List of token bases to be set
     * @param quotes List of token quotes to be set
     * @param feeds List of price feeds to be set
     */
    function setPriceFeeds(address[] memory bases, address[] memory quotes, address[] memory feeds) external;
}


// File contracts/ISmartVault.sol


pragma solidity ^0.8.0;



/**
 * @title ISmartVault
 * @dev Mimic Smart Vault interface to manage assets. It must support also `IImplementation` and `IAuthorizer`
 */
interface ISmartVault is IPriceFeedProvider, IImplementation, IAuthorizer {
    enum SwapLimit {
        Slippage,
        MinAmountOut
    }

    /**
     * @dev Emitted every time a new strategy is set for the Smart Vault
     */
    event StrategySet(address indexed strategy, bool allowed);

    /**
     * @dev Emitted every time a new price oracle is set for the Smart Vault
     */
    event PriceOracleSet(address indexed priceOracle);

    /**
     * @dev Emitted every time a new swap connector is set for the Smart Vault
     */
    event SwapConnectorSet(address indexed swapConnector);

    /**
     * @dev Emitted every time a new fee collector is set
     */
    event FeeCollectorSet(address indexed feeCollector);

    /**
     * @dev Emitted every time the withdraw fee percentage is set
     */
    event WithdrawFeeSet(uint256 pct, uint256 cap, address token, uint256 period);

    /**
     * @dev Emitted every time the performance fee percentage is set
     */
    event PerformanceFeeSet(uint256 pct, uint256 cap, address token, uint256 period);

    /**
     * @dev Emitted every time the swap fee percentage is set
     */
    event SwapFeeSet(uint256 pct, uint256 cap, address token, uint256 period);

    /**
     * @dev Emitted every time `call` is called
     */
    event Call(address indexed target, bytes callData, uint256 value, bytes result, bytes data);

    /**
     * @dev Emitted every time `collect` is called
     */
    event Collect(address indexed token, address indexed from, uint256 collected, bytes data);

    /**
     * @dev Emitted every time `withdraw` is called
     */
    event Withdraw(address indexed token, address indexed recipient, uint256 withdrawn, uint256 fee, bytes data);

    /**
     * @dev Emitted every time `wrap` is called
     */
    event Wrap(uint256 amount, uint256 wrapped, bytes data);

    /**
     * @dev Emitted every time `unwrap` is called
     */
    event Unwrap(uint256 amount, uint256 unwrapped, bytes data);

    /**
     * @dev Emitted every time `claim` is called
     */
    event Claim(address indexed strategy, address[] tokens, uint256[] amounts, bytes data);

    /**
     * @dev Emitted every time `join` is called
     */
    event Join(
        address indexed strategy,
        address[] tokensIn,
        uint256[] amountsIn,
        address[] tokensOut,
        uint256[] amountsOut,
        uint256 value,
        uint256 slippage,
        bytes data
    );

    /**
     * @dev Emitted every time `exit` is called
     */
    event Exit(
        address indexed strategy,
        address[] tokensIn,
        uint256[] amountsIn,
        address[] tokensOut,
        uint256[] amountsOut,
        uint256 value,
        uint256[] fees,
        uint256 slippage,
        bytes data
    );

    /**
     * @dev Emitted every time `swap` is called
     */
    event Swap(
        uint8 indexed source,
        address indexed tokenIn,
        address indexed tokenOut,
        uint256 amountIn,
        uint256 amountOut,
        uint256 minAmountOut,
        uint256 fee,
        bytes data
    );

    /**
     * @dev Tells a strategy is allowed or not
     * @param strategy Address of the strategy being queried
     */
    function isStrategyAllowed(address strategy) external view returns (bool);

    /**
     * @dev Tells the invested value for a strategy
     * @param strategy Address of the strategy querying the invested value of
     */
    function investedValue(address strategy) external view returns (uint256);

    /**
     * @dev Tells the last value accrued for a strategy. Note this value can be outdated.
     * @param strategy Address of the strategy querying the last value of
     */
    function lastValue(address strategy) external view returns (uint256);

    /**
     * @dev Tells the price oracle associated to a Smart Vault
     */
    function priceOracle() external view returns (address);

    /**
     * @dev Tells the swap connector associated to a Smart Vault
     */
    function swapConnector() external view returns (address);

    /**
     * @dev Tells the address where fees will be deposited
     */
    function feeCollector() external view returns (address);

    /**
     * @dev Tells the withdraw fee configuration
     */
    function withdrawFee()
        external
        view
        returns (uint256 pct, uint256 cap, address token, uint256 period, uint256 totalCharged, uint256 nextResetTime);

    /**
     * @dev Tells the performance fee configuration
     */
    function performanceFee()
        external
        view
        returns (uint256 pct, uint256 cap, address token, uint256 period, uint256 totalCharged, uint256 nextResetTime);

    /**
     * @dev Tells the swap fee configuration
     */
    function swapFee()
        external
        view
        returns (uint256 pct, uint256 cap, address token, uint256 period, uint256 totalCharged, uint256 nextResetTime);

    /**
     * @dev Tells the address of the wrapped native token
     */
    function wrappedNativeToken() external view returns (address);

    /**
     * @dev Sets a new strategy as allowed or not for a Smart Vault
     * @param strategy Address of the strategy to be set
     * @param allowed Whether the strategy is allowed or not
     */
    function setStrategy(address strategy, bool allowed) external;

    /**
     * @dev Sets a new price oracle to a Smart Vault
     * @param newPriceOracle Address of the new price oracle to be set
     */
    function setPriceOracle(address newPriceOracle) external;

    /**
     * @dev Sets a new swap connector to a Smart Vault
     * @param newSwapConnector Address of the new swap connector to be set
     */
    function setSwapConnector(address newSwapConnector) external;

    /**
     * @dev Sets a new fee collector
     * @param newFeeCollector Address of the new fee collector to be set
     */
    function setFeeCollector(address newFeeCollector) external;

    /**
     * @dev Sets a new withdraw fee configuration
     * @param pct Withdraw fee percentage to be set
     * @param cap New maximum amount of withdraw fees to be charged per period
     * @param token Address of the token cap to be set
     * @param period New cap period length in seconds for the withdraw fee
     */
    function setWithdrawFee(uint256 pct, uint256 cap, address token, uint256 period) external;

    /**
     * @dev Sets a new performance fee configuration
     * @param pct Performance fee percentage to be set
     * @param cap New maximum amount of performance fees to be charged per period
     * @param token Address of the token cap to be set
     * @param period New cap period length in seconds for the performance fee
     */
    function setPerformanceFee(uint256 pct, uint256 cap, address token, uint256 period) external;

    /**
     * @dev Sets a new swap fee configuration
     * @param pct Swap fee percentage to be set
     * @param cap New maximum amount of swap fees to be charged per period
     * @param token Address of the token cap to be set
     * @param period New cap period length in seconds for the swap fee
     */
    function setSwapFee(uint256 pct, uint256 cap, address token, uint256 period) external;

    /**
     * @dev Tells the price of a token (base) in a given quote
     * @param base Token to rate
     * @param quote Token used for the price rate
     */
    function getPrice(address base, address quote) external view returns (uint256);

    /**
     * @dev Execute an arbitrary call from a Smart Vault
     * @param target Address where the call will be sent
     * @param callData Calldata to be used for the call
     * @param value Value in wei that will be attached to the call
     * @param data Extra data that may enable or not different behaviors depending on the implementation
     * @return result Call response if it was successful, otherwise it reverts
     */
    function call(address target, bytes memory callData, uint256 value, bytes memory data)
        external
        returns (bytes memory result);

    /**
     * @dev Collect tokens from a sender to a Smart Vault
     * @param token Address of the token to be collected
     * @param from Address where the tokens will be transfer from
     * @param amount Amount of tokens to be transferred
     * @param data Extra data that may enable or not different behaviors depending on the implementation
     * @return collected Amount of tokens assigned to the Smart Vault
     */
    function collect(address token, address from, uint256 amount, bytes memory data)
        external
        returns (uint256 collected);

    /**
     * @dev Withdraw tokens to an external account
     * @param token Address of the token to be withdrawn
     * @param amount Amount of tokens to withdraw
     * @param recipient Address where the tokens will be transferred to
     * @param data Extra data that may enable or not different behaviors depending on the implementation
     * @return withdrawn Amount of tokens transferred to the recipient address
     */
    function withdraw(address token, uint256 amount, address recipient, bytes memory data)
        external
        returns (uint256 withdrawn);

    /**
     * @dev Wrap an amount of native tokens to the wrapped ERC20 version of it
     * @param amount Amount of native tokens to be wrapped
     * @param data Extra data that may enable or not different behaviors depending on the implementation
     * @return wrapped Amount of tokens wrapped
     */
    function wrap(uint256 amount, bytes memory data) external returns (uint256 wrapped);

    /**
     * @dev Unwrap an amount of wrapped native tokens
     * @param amount Amount of wrapped native tokens to unwrapped
     * @param data Extra data that may enable or not different behaviors depending on the implementation
     * @return unwrapped Amount of tokens unwrapped
     */
    function unwrap(uint256 amount, bytes memory data) external returns (uint256 unwrapped);

    /**
     * @dev Claim strategy rewards
     * @param strategy Address of the strategy to claim rewards
     * @param data Extra data that may enable or not different behaviors depending on the implementation
     * @return tokens Addresses of the tokens received as rewards
     * @return amounts Amounts of the tokens received as rewards
     */
    function claim(address strategy, bytes memory data)
        external
        returns (address[] memory tokens, uint256[] memory amounts);

    /**
     * @dev Join a strategy with an amount of tokens
     * @param strategy Address of the strategy to join
     * @param tokensIn List of token addresses to join with
     * @param amountsIn List of token amounts to join with
     * @param slippage Slippage that will be used to compute the join
     * @param data Extra data that may enable or not different behaviors depending on the implementation
     * @return tokensOut List of token addresses received after the join
     * @return amountsOut List of token amounts received after the join
     */
    function join(
        address strategy,
        address[] memory tokensIn,
        uint256[] memory amountsIn,
        uint256 slippage,
        bytes memory data
    ) external returns (address[] memory tokensOut, uint256[] memory amountsOut);

    /**
     * @dev Exit a strategy
     * @param strategy Address of the strategy to exit
     * @param tokensIn List of token addresses to exit with
     * @param amountsIn List of token amounts to exit with
     * @param slippage Slippage that will be used to compute the exit
     * @param data Extra data that may enable or not different behaviors depending on the implementation
     * @return tokensOut List of token addresses received after the exit
     * @return amountsOut List of token amounts received after the exit
     */
    function exit(
        address strategy,
        address[] memory tokensIn,
        uint256[] memory amountsIn,
        uint256 slippage,
        bytes memory data
    ) external returns (address[] memory tokensOut, uint256[] memory amountsOut);

    /**
     * @dev Swaps two tokens
     * @param source Source to request the swap. It depends on the Swap Connector attached to a Smart Vault.
     * @param tokenIn Token being sent
     * @param tokenOut Token being received
     * @param amountIn Amount of tokenIn being swapped
     * @param limitType Swap limit to be applied: slippage or min amount out
     * @param limitAmount Amount of the swap limit to be applied depending on limitType
     * @param data Extra data that may enable or not different behaviors depending on the implementation
     * @return amountOut Received amount of tokens out
     */
    function swap(
        uint8 source,
        address tokenIn,
        address tokenOut,
        uint256 amountIn,
        SwapLimit limitType,
        uint256 limitAmount,
        bytes memory data
    ) external returns (uint256 amountOut);
}


// File @openzeppelin/contracts/token/ERC20/[email protected]


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


// File contracts/IWrappedNativeToken.sol


pragma solidity ^0.8.0;

/**
 * @title IWrappedNativeToken
 */
interface IWrappedNativeToken is IERC20 {
    /**
     * @dev Wraps msg.value into the wrapped-native token
     */
    function deposit() external payable;

    /**
     * @dev Unwraps requested amount to the native token
     */
    function withdraw(uint256 amount) external;
}


// File @mimic-fi/v2-strategies/contracts/[email protected]


pragma solidity ^0.8.0;

/**
 * @title IStrategy
 * @dev Strategy interface required by Mimic Smart Vaults. It must follow the IImplementation interface.
 */
interface IStrategy is IImplementation {
    /**
     * @dev Tokens accepted to join the strategy
     */
    function joinTokens() external view returns (address[] memory);

    /**
     * @dev Tokens accepted to exit the strategy
     */
    function exitTokens() external view returns (address[] memory);

    /**
     * @dev Tells how much a value unit means expressed in the asset token.
     * For example, if a strategy has a value of 100 in T0, and then it has a value of 120 in T1,
     * and the value rate is 1.5, it means the strategy has earned 30 strategy tokens between T0 and T1.
     */
    function valueRate() external view returns (uint256);

    /**
     * @dev Tells the last value an account has over time. Note this value can be outdated: there could be rewards to
     * be claimed that will affect the accrued value. For example, if an account has a value of 100 in T0, and then it
     * has a value of 120 in T1, it means it gained a 20% between T0 and T1.
     * @param account Address of the account querying the last value of
     */
    function lastValue(address account) external view returns (uint256);

    /**
     * @dev Claim any existing rewards
     * @param data Arbitrary extra data
     * @return tokens Addresses of the tokens received as rewards
     * @return amounts Amounts of the tokens received as rewards
     */
    function claim(bytes memory data) external returns (address[] memory tokens, uint256[] memory amounts);

    /**
     * @dev Join the interfaced DeFi protocol
     * @param tokensIn List of token addresses to join with
     * @param amountsIn List of token amounts to join with
     * @param slippage Slippage value to join with
     * @param data Arbitrary extra data
     * @return tokensOut List of token addresses received after the join
     * @return amountsOut List of token amounts received after the join
     * @return value Value represented by the joined amount
     */
    function join(address[] memory tokensIn, uint256[] memory amountsIn, uint256 slippage, bytes memory data)
        external
        returns (address[] memory tokensOut, uint256[] memory amountsOut, uint256 value);

    /**
     * @dev Exit the interfaced DeFi protocol
     * @param tokensIn List of token addresses to exit with
     * @param amountsIn List of token amounts to exit with
     * @param slippage Slippage value to exit with
     * @param data Arbitrary extra data
     * @return tokensOut List of token addresses received after the exit
     * @return amountsOut List of token amounts received after the exit
     * @return value Value represented by the exited amount
     */
    function exit(address[] memory tokensIn, uint256[] memory amountsIn, uint256 slippage, bytes memory data)
        external
        returns (address[] memory tokensOut, uint256[] memory amountsOut, uint256 value);
}


// File @openzeppelin/contracts/utils/[email protected]


// OpenZeppelin Contracts (last updated v4.7.0) (utils/Address.sol)

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
                /// @solidity memory-safe-assembly
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


// File contracts/helpers/StrategyLib.sol


pragma solidity ^0.8.0;

/**
 * @title StrategyLib
 * @dev Library used to delegate-call to strategy and decode return data correctly
 */
library StrategyLib {
    /**
     * @dev Delegate-calls a claim to a strategy and decodes de expected data
     * IMPORTANT! This helper method does not check any of the given params, these should be checked beforehand.
     */
    function claim(address strategy, bytes memory data) internal returns (address[] memory, uint256[] memory) {
        bytes memory claimData = abi.encodeWithSelector(IStrategy.claim.selector, data);

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = strategy.delegatecall(claimData);
        Address.verifyCallResult(success, returndata, 'CLAIM_CALL_REVERTED');
        return abi.decode(returndata, (address[], uint256[]));
    }

    /**
     * @dev Delegate-calls a join to a strategy and decodes de expected data
     * IMPORTANT! This helper method does not check any of the given params, these should be checked beforehand.
     */
    function join(
        address strategy,
        address[] memory tokensIn,
        uint256[] memory amountsIn,
        uint256 slippage,
        bytes memory data
    ) internal returns (address[] memory tokensOut, uint256[] memory amountsOut, uint256 value) {
        bytes memory joinData = abi.encodeWithSelector(IStrategy.join.selector, tokensIn, amountsIn, slippage, data);

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = strategy.delegatecall(joinData);
        Address.verifyCallResult(success, returndata, 'JOIN_CALL_REVERTED');
        return abi.decode(returndata, (address[], uint256[], uint256));
    }

    /**
     * @dev Delegate-calls a exit to a strategy and decodes de expected data
     * IMPORTANT! This helper method does not check any of the given params, these should be checked beforehand.
     */
    function exit(
        address strategy,
        address[] memory tokensIn,
        uint256[] memory amountsIn,
        uint256 slippage,
        bytes memory data
    ) internal returns (address[] memory tokensOut, uint256[] memory amountsOut, uint256 value) {
        bytes memory exitData = abi.encodeWithSelector(IStrategy.exit.selector, tokensIn, amountsIn, slippage, data);

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = strategy.delegatecall(exitData);
        Address.verifyCallResult(success, returndata, 'EXIT_CALL_REVERTED');
        return abi.decode(returndata, (address[], uint256[], uint256));
    }
}


// File @mimic-fi/v2-swap-connector/contracts/[email protected]


pragma solidity >=0.8.0;

/**
 * @title ISwapConnector
 * @dev Swap Connector interface to perform token swaps. It must follow the IImplementation interface.
 */
interface ISwapConnector is IImplementation {
    /**
     * @dev Enum identifying the sources proposed: Uniswap V2, Uniswap V3, Balancer V2, Paraswap V5, and 1inch V5.
     */
    enum Source {
        UniswapV2,
        UniswapV3,
        BalancerV2,
        ParaswapV5,
        OneInchV5
    }

    /**
     * @dev Swaps two tokens
     * @param source Source to execute the requested swap
     * @param tokenIn Token being sent
     * @param tokenOut Token being received
     * @param amountIn Amount of tokenIn being swapped
     * @param minAmountOut Minimum amount of tokenOut willing to receive
     * @param data Encoded data to specify different swap parameters depending on the source picked
     */
    function swap(
        uint8 source,
        address tokenIn,
        address tokenOut,
        uint256 amountIn,
        uint256 minAmountOut,
        bytes memory data
    ) external returns (uint256 amountOut);
}


// File contracts/helpers/SwapConnectorLib.sol


pragma solidity ^0.8.0;

/**
 * @title SwapConnectorLib
 * @dev Library used to delegate-call swaps and decode return data correctly
 */
library SwapConnectorLib {
    /**
     * @dev Delegate-calls a swap to the swap connector and decodes de expected data
     * IMPORTANT! This helper method does not check any of the given params, these should be checked beforehand.
     */
    function swap(
        address connector,
        uint8 source,
        address tokenIn,
        address tokenOut,
        uint256 amountIn,
        uint256 minAmountOut,
        bytes memory data
    ) internal returns (uint256 amountOut) {
        bytes memory swapData = abi.encodeWithSelector(
            ISwapConnector.swap.selector,
            source,
            tokenIn,
            tokenOut,
            amountIn,
            minAmountOut,
            data
        );

        // solhint-disable-next-line avoid-low-level-calls
        (bool success, bytes memory returndata) = connector.delegatecall(swapData);
        Address.verifyCallResult(success, returndata, 'SWAP_CALL_REVERTED');
        return abi.decode(returndata, (uint256));
    }
}


// File @openzeppelin/contracts/utils/math/[email protected]


// OpenZeppelin Contracts (last updated v4.7.0) (utils/math/Math.sol)

pragma solidity ^0.8.0;

/**
 * @dev Standard math utilities missing in the Solidity language.
 */
library Math {
    enum Rounding {
        Down, // Toward negative infinity
        Up, // Toward infinity
        Zero // Toward zero
    }

    /**
     * @dev Returns the largest of two numbers.
     */
    function max(uint256 a, uint256 b) internal pure returns (uint256) {
        return a >= b ? a : b;
    }

    /**
     * @dev Returns the smallest of two numbers.
     */
    function min(uint256 a, uint256 b) internal pure returns (uint256) {
        return a < b ? a : b;
    }

    /**
     * @dev Returns the average of two numbers. The result is rounded towards
     * zero.
     */
    function average(uint256 a, uint256 b) internal pure returns (uint256) {
        // (a + b) / 2 can overflow.
        return (a & b) + (a ^ b) / 2;
    }

    /**
     * @dev Returns the ceiling of the division of two numbers.
     *
     * This differs from standard division with `/` in that it rounds up instead
     * of rounding down.
     */
    function ceilDiv(uint256 a, uint256 b) internal pure returns (uint256) {
        // (a + b - 1) / b can overflow on addition, so we distribute.
        return a == 0 ? 0 : (a - 1) / b + 1;
    }

    /**
     * @notice Calculates floor(x * y / denominator) with full precision. Throws if result overflows a uint256 or denominator == 0
     * @dev Original credit to Remco Bloemen under MIT license (https://xn--2-umb.com/21/muldiv)
     * with further edits by Uniswap Labs also under MIT license.
     */
    function mulDiv(
        uint256 x,
        uint256 y,
        uint256 denominator
    ) internal pure returns (uint256 result) {
        unchecked {
            // 512-bit multiply [prod1 prod0] = x * y. Compute the product mod 2^256 and mod 2^256 - 1, then use
            // use the Chinese Remainder Theorem to reconstruct the 512 bit result. The result is stored in two 256
            // variables such that product = prod1 * 2^256 + prod0.
            uint256 prod0; // Least significant 256 bits of the product
            uint256 prod1; // Most significant 256 bits of the product
            assembly {
                let mm := mulmod(x, y, not(0))
                prod0 := mul(x, y)
                prod1 := sub(sub(mm, prod0), lt(mm, prod0))
            }

            // Handle non-overflow cases, 256 by 256 division.
            if (prod1 == 0) {
                return prod0 / denominator;
            }

            // Make sure the result is less than 2^256. Also prevents denominator == 0.
            require(denominator > prod1);

            ///////////////////////////////////////////////
            // 512 by 256 division.
            ///////////////////////////////////////////////

            // Make division exact by subtracting the remainder from [prod1 prod0].
            uint256 remainder;
            assembly {
                // Compute remainder using mulmod.
                remainder := mulmod(x, y, denominator)

                // Subtract 256 bit number from 512 bit number.
                prod1 := sub(prod1, gt(remainder, prod0))
                prod0 := sub(prod0, remainder)
            }

            // Factor powers of two out of denominator and compute largest power of two divisor of denominator. Always >= 1.
            // See https://cs.stackexchange.com/q/138556/92363.

            // Does not overflow because the denominator cannot be zero at this stage in the function.
            uint256 twos = denominator & (~denominator + 1);
            assembly {
                // Divide denominator by twos.
                denominator := div(denominator, twos)

                // Divide [prod1 prod0] by twos.
                prod0 := div(prod0, twos)

                // Flip twos such that it is 2^256 / twos. If twos is zero, then it becomes one.
                twos := add(div(sub(0, twos), twos), 1)
            }

            // Shift in bits from prod1 into prod0.
            prod0 |= prod1 * twos;

            // Invert denominator mod 2^256. Now that denominator is an odd number, it has an inverse modulo 2^256 such
            // that denominator * inv = 1 mod 2^256. Compute the inverse by starting with a seed that is correct for
            // four bits. That is, denominator * inv = 1 mod 2^4.
            uint256 inverse = (3 * denominator) ^ 2;

            // Use the Newton-Raphson iteration to improve the precision. Thanks to Hensel's lifting lemma, this also works
            // in modular arithmetic, doubling the correct bits in each step.
            inverse *= 2 - denominator * inverse; // inverse mod 2^8
            inverse *= 2 - denominator * inverse; // inverse mod 2^16
            inverse *= 2 - denominator * inverse; // inverse mod 2^32
            inverse *= 2 - denominator * inverse; // inverse mod 2^64
            inverse *= 2 - denominator * inverse; // inverse mod 2^128
            inverse *= 2 - denominator * inverse; // inverse mod 2^256

            // Because the division is now exact we can divide by multiplying with the modular inverse of denominator.
            // This will give us the correct result modulo 2^256. Since the preconditions guarantee that the outcome is
            // less than 2^256, this is the final result. We don't need to compute the high bits of the result and prod1
            // is no longer required.
            result = prod0 * inverse;
            return result;
        }
    }

    /**
     * @notice Calculates x * y / denominator with full precision, following the selected rounding direction.
     */
    function mulDiv(
        uint256 x,
        uint256 y,
        uint256 denominator,
        Rounding rounding
    ) internal pure returns (uint256) {
        uint256 result = mulDiv(x, y, denominator);
        if (rounding == Rounding.Up && mulmod(x, y, denominator) > 0) {
            result += 1;
        }
        return result;
    }

    /**
     * @dev Returns the square root of a number. It the number is not a perfect square, the value is rounded down.
     *
     * Inspired by Henry S. Warren, Jr.'s "Hacker's Delight" (Chapter 11).
     */
    function sqrt(uint256 a) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }

        // For our first guess, we get the biggest power of 2 which is smaller than the square root of the target.
        // We know that the "msb" (most significant bit) of our target number `a` is a power of 2 such that we have
        // `msb(a) <= a < 2*msb(a)`.
        // We also know that `k`, the position of the most significant bit, is such that `msb(a) = 2**k`.
        // This gives `2**k < a <= 2**(k+1)` → `2**(k/2) <= sqrt(a) < 2 ** (k/2+1)`.
        // Using an algorithm similar to the msb conmputation, we are able to compute `result = 2**(k/2)` which is a
        // good first aproximation of `sqrt(a)` with at least 1 correct bit.
        uint256 result = 1;
        uint256 x = a;
        if (x >> 128 > 0) {
            x >>= 128;
            result <<= 64;
        }
        if (x >> 64 > 0) {
            x >>= 64;
            result <<= 32;
        }
        if (x >> 32 > 0) {
            x >>= 32;
            result <<= 16;
        }
        if (x >> 16 > 0) {
            x >>= 16;
            result <<= 8;
        }
        if (x >> 8 > 0) {
            x >>= 8;
            result <<= 4;
        }
        if (x >> 4 > 0) {
            x >>= 4;
            result <<= 2;
        }
        if (x >> 2 > 0) {
            result <<= 1;
        }

        // At this point `result` is an estimation with one bit of precision. We know the true value is a uint128,
        // since it is the square root of a uint256. Newton's method converges quadratically (precision doubles at
        // every iteration). We thus need at most 7 iteration to turn our partial result with one bit of precision
        // into the expected uint128 result.
        unchecked {
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            result = (result + a / result) >> 1;
            return min(result, a / result);
        }
    }

    /**
     * @notice Calculates sqrt(a), following the selected rounding direction.
     */
    function sqrt(uint256 a, Rounding rounding) internal pure returns (uint256) {
        uint256 result = sqrt(a);
        if (rounding == Rounding.Up && result * result < a) {
            result += 1;
        }
        return result;
    }
}


// File @mimic-fi/v2-helpers/contracts/math/[email protected]


pragma solidity ^0.8.0;

/**
 * @title FixedPoint
 * @dev Math library to operate with fixed point values with 18 decimals
 */
library FixedPoint {
    // 1 in fixed point value: 18 decimal places
    uint256 internal constant ONE = 1e18;

    /**
     * @dev Multiplies two fixed point numbers rounding down
     */
    function mulDown(uint256 a, uint256 b) internal pure returns (uint256) {
        unchecked {
            uint256 product = a * b;
            require(a == 0 || product / a == b, 'MUL_OVERFLOW');
            return product / ONE;
        }
    }

    /**
     * @dev Multiplies two fixed point numbers rounding up
     */
    function mulUp(uint256 a, uint256 b) internal pure returns (uint256) {
        unchecked {
            uint256 product = a * b;
            require(a == 0 || product / a == b, 'MUL_OVERFLOW');
            return product == 0 ? 0 : (((product - 1) / ONE) + 1);
        }
    }

    /**
     * @dev Divides two fixed point numbers rounding down
     */
    function divDown(uint256 a, uint256 b) internal pure returns (uint256) {
        unchecked {
            require(b != 0, 'ZERO_DIVISION');
            if (a == 0) return 0;
            uint256 aInflated = a * ONE;
            require(aInflated / a == ONE, 'DIV_INTERNAL');
            return aInflated / b;
        }
    }

    /**
     * @dev Divides two fixed point numbers rounding up
     */
    function divUp(uint256 a, uint256 b) internal pure returns (uint256) {
        unchecked {
            require(b != 0, 'ZERO_DIVISION');
            if (a == 0) return 0;
            uint256 aInflated = a * ONE;
            require(aInflated / a == ONE, 'DIV_INTERNAL');
            return ((aInflated - 1) / b) + 1;
        }
    }
}


// File @mimic-fi/v2-helpers/contracts/math/[email protected]


pragma solidity ^0.8.0;

/**
 * @title UncheckedMath
 * @dev Math library to perform unchecked operations
 */
library UncheckedMath {
    /**
     * @dev Unsafely adds two unsigned integers
     */
    function uncheckedAdd(uint256 a, uint256 b) internal pure returns (uint256) {
        unchecked {
            return a + b;
        }
    }

    /**
     * @dev Unsafely subtracts two unsigned integers
     */
    function uncheckedSub(uint256 a, uint256 b) internal pure returns (uint256) {
        unchecked {
            return a - b;
        }
    }

    /**
     * @dev Unsafely multiplies two unsigned integers
     */
    function uncheckedMul(uint256 a, uint256 b) internal pure returns (uint256) {
        unchecked {
            return a * b;
        }
    }

    /**
     * @dev Unsafely multiplies two signed integers
     */
    function uncheckedMul(int256 a, int256 b) internal pure returns (int256) {
        unchecked {
            return a * b;
        }
    }

    /**
     * @dev Unsafely divides two unsigned integers
     */
    function uncheckedDiv(uint256 a, uint256 b) internal pure returns (uint256) {
        unchecked {
            return a / b;
        }
    }
}


// File @mimic-fi/v2-price-oracle/contracts/feeds/[email protected]


pragma solidity ^0.8.0;

/**
 * @title IPriceFeedProvider
 * @dev Contract providing price feed references for (base, quote) token pairs
 */
contract PriceFeedProvider is IPriceFeedProvider {
    using UncheckedMath for uint256;

    // Mapping of price feeds from "token A" to "token B"
    mapping (address => mapping (address => address)) private _priceFeeds;

    /**
     * @dev Tells the price feed address for (base, quote) pair. It returns the zero address if there is no one set.
     * @param base Token to be rated
     * @param quote Token used for the price rate
     */
    function getPriceFeed(address base, address quote) external view override returns (address) {
        return _priceFeeds[base][quote];
    }

    /**
     * @dev Sets a of price feed
     * @param base Token base to be set
     * @param quote Token quote to be set
     * @param feed Price feed to be set
     */
    function setPriceFeed(address base, address quote, address feed) public virtual override {
        _priceFeeds[base][quote] = feed;
        emit PriceFeedSet(base, quote, feed);
    }

    /**
     * @dev Sets a list of price feeds. Sender must be authorized.
     * @param bases List of token bases to be set
     * @param quotes List of token quotes to be set
     * @param feeds List of price feeds to be set
     */
    function setPriceFeeds(address[] memory bases, address[] memory quotes, address[] memory feeds)
        public
        virtual
        override
    {
        require(bases.length == quotes.length, 'SET_FEEDS_INVALID_QUOTES_LENGTH');
        require(bases.length == feeds.length, 'SET_FEEDS_INVALID_FEEDS_LENGTH');
        for (uint256 i = 0; i < bases.length; i = i.uncheckedAdd(1)) setPriceFeed(bases[i], quotes[i], feeds[i]);
    }
}


// File @mimic-fi/v2-price-oracle/contracts/oracle/[email protected]


pragma solidity >=0.8.0;

/**
 * @title IPriceOracle
 * @dev Oracle that interfaces with external feeds to provide quotes for tokens based on any other token.
 * It must support also `IImplementation`.
 */
interface IPriceOracle is IImplementation {
    /**
     * @dev Tells the price of a token (base) in a given quote. The response is expressed using the corresponding
     * number of decimals so that when performing a fixed point product of it by a `base` amount it results in
     * a value expressed in `quote` decimals. For example, if `base` is ETH and `quote` is USDC, then the returned
     * value is expected to be expressed using 6 decimals:
     *
     * FixedPoint.mul(X[ETH], price[USDC/ETH]) = FixedPoint.mul(X[18], price[6]) = X * price [6]
     *
     * @param provider Contract providing the price feeds to use by the oracle
     * @param base Token to rate
     * @param quote Token used for the price rate
     */
    function getPrice(address provider, address base, address quote) external view returns (uint256);
}


// File @openzeppelin/contracts/token/ERC20/extensions/[email protected]


// OpenZeppelin Contracts v4.4.1 (token/ERC20/extensions/draft-IERC20Permit.sol)

pragma solidity ^0.8.0;

/**
 * @dev Interface of the ERC20 Permit extension allowing approvals to be made via signatures, as defined in
 * https://eips.ethereum.org/EIPS/eip-2612[EIP-2612].
 *
 * Adds the {permit} method, which can be used to change an account's ERC20 allowance (see {IERC20-allowance}) by
 * presenting a message signed by the account. By not relying on {IERC20-approve}, the token holder account doesn't
 * need to send a transaction, and thus is not required to hold Ether at all.
 */
interface IERC20Permit {
    /**
     * @dev Sets `value` as the allowance of `spender` over ``owner``'s tokens,
     * given ``owner``'s signed approval.
     *
     * IMPORTANT: The same issues {IERC20-approve} has related to transaction
     * ordering also apply here.
     *
     * Emits an {Approval} event.
     *
     * Requirements:
     *
     * - `spender` cannot be the zero address.
     * - `deadline` must be a timestamp in the future.
     * - `v`, `r` and `s` must be a valid `secp256k1` signature from `owner`
     * over the EIP712-formatted function arguments.
     * - the signature must use ``owner``'s current nonce (see {nonces}).
     *
     * For more information on the signature format, see the
     * https://eips.ethereum.org/EIPS/eip-2612#specification[relevant EIP
     * section].
     */
    function permit(
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external;

    /**
     * @dev Returns the current nonce for `owner`. This value must be
     * included whenever a signature is generated for {permit}.
     *
     * Every successful call to {permit} increases ``owner``'s nonce by one. This
     * prevents a signature from being used multiple times.
     */
    function nonces(address owner) external view returns (uint256);

    /**
     * @dev Returns the domain separator used in the encoding of the signature for {permit}, as defined by {EIP712}.
     */
    // solhint-disable-next-line func-name-mixedcase
    function DOMAIN_SEPARATOR() external view returns (bytes32);
}


// File @openzeppelin/contracts/token/ERC20/utils/[email protected]


// OpenZeppelin Contracts (last updated v4.7.0) (token/ERC20/utils/SafeERC20.sol)

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

    function safePermit(
        IERC20Permit token,
        address owner,
        address spender,
        uint256 value,
        uint256 deadline,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) internal {
        uint256 nonceBefore = token.nonces(owner);
        token.permit(owner, spender, value, deadline, v, r, s);
        uint256 nonceAfter = token.nonces(owner);
        require(nonceAfter == nonceBefore + 1, "SafeERC20: permit did not succeed");
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


// File @mimic-fi/v2-helpers/contracts/utils/[email protected]


pragma solidity ^0.8.0;

/**
 * @title Denominations
 * @dev Provides a list of ground denominations for those tokens that cannot be represented by an ERC20.
 * For now, the only needed is the native token that could be ETH, MATIC, or other depending on the layer being operated.
 */
library Denominations {
    address internal constant NATIVE_TOKEN = 0xEeeeeEeeeEeEeeEeEeEeeEEEeeeeEeeeeeeeEEeE;

    function isNativeToken(address token) internal pure returns (bool) {
        return token == NATIVE_TOKEN;
    }
}


// File @openzeppelin/contracts/proxy/utils/[email protected]


// OpenZeppelin Contracts (last updated v4.7.0) (proxy/utils/Initializable.sol)

pragma solidity ^0.8.2;

/**
 * @dev This is a base contract to aid in writing upgradeable contracts, or any kind of contract that will be deployed
 * behind a proxy. Since proxied contracts do not make use of a constructor, it's common to move constructor logic to an
 * external initializer function, usually called `initialize`. It then becomes necessary to protect this initializer
 * function so it can only be called once. The {initializer} modifier provided by this contract will have this effect.
 *
 * The initialization functions use a version number. Once a version number is used, it is consumed and cannot be
 * reused. This mechanism prevents re-execution of each "step" but allows the creation of new initialization steps in
 * case an upgrade adds a module that needs to be initialized.
 *
 * For example:
 *
 * [.hljs-theme-light.nopadding]
 * ```
 * contract MyToken is ERC20Upgradeable {
 *     function initialize() initializer public {
 *         __ERC20_init("MyToken", "MTK");
 *     }
 * }
 * contract MyTokenV2 is MyToken, ERC20PermitUpgradeable {
 *     function initializeV2() reinitializer(2) public {
 *         __ERC20Permit_init("MyToken");
 *     }
 * }
 * ```
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
 * contract, which may impact the proxy. To prevent the implementation contract from being used, you should invoke
 * the {_disableInitializers} function in the constructor to automatically lock it when it is deployed:
 *
 * [.hljs-theme-light.nopadding]
 * ```
 * /// @custom:oz-upgrades-unsafe-allow constructor
 * constructor() {
 *     _disableInitializers();
 * }
 * ```
 * ====
 */
abstract contract Initializable {
    /**
     * @dev Indicates that the contract has been initialized.
     * @custom:oz-retyped-from bool
     */
    uint8 private _initialized;

    /**
     * @dev Indicates that the contract is in the process of being initialized.
     */
    bool private _initializing;

    /**
     * @dev Triggered when the contract has been initialized or reinitialized.
     */
    event Initialized(uint8 version);

    /**
     * @dev A modifier that defines a protected initializer function that can be invoked at most once. In its scope,
     * `onlyInitializing` functions can be used to initialize parent contracts. Equivalent to `reinitializer(1)`.
     */
    modifier initializer() {
        bool isTopLevelCall = !_initializing;
        require(
            (isTopLevelCall && _initialized < 1) || (!Address.isContract(address(this)) && _initialized == 1),
            "Initializable: contract is already initialized"
        );
        _initialized = 1;
        if (isTopLevelCall) {
            _initializing = true;
        }
        _;
        if (isTopLevelCall) {
            _initializing = false;
            emit Initialized(1);
        }
    }

    /**
     * @dev A modifier that defines a protected reinitializer function that can be invoked at most once, and only if the
     * contract hasn't been initialized to a greater version before. In its scope, `onlyInitializing` functions can be
     * used to initialize parent contracts.
     *
     * `initializer` is equivalent to `reinitializer(1)`, so a reinitializer may be used after the original
     * initialization step. This is essential to configure modules that are added through upgrades and that require
     * initialization.
     *
     * Note that versions can jump in increments greater than 1; this implies that if multiple reinitializers coexist in
     * a contract, executing them in the right order is up to the developer or operator.
     */
    modifier reinitializer(uint8 version) {
        require(!_initializing && _initialized < version, "Initializable: contract is already initialized");
        _initialized = version;
        _initializing = true;
        _;
        _initializing = false;
        emit Initialized(version);
    }

    /**
     * @dev Modifier to protect an initialization function so that it can only be invoked by functions with the
     * {initializer} and {reinitializer} modifiers, directly or indirectly.
     */
    modifier onlyInitializing() {
        require(_initializing, "Initializable: contract is not initializing");
        _;
    }

    /**
     * @dev Locks the contract, preventing any future reinitialization. This cannot be part of an initializer call.
     * Calling this in the constructor of a contract will prevent that contract from being initialized or reinitialized
     * to any version. It is recommended to use this to lock implementation contracts that are designed to be called
     * through proxies.
     */
    function _disableInitializers() internal virtual {
        require(!_initializing, "Initializable: contract is initializing");
        if (_initialized < type(uint8).max) {
            _initialized = type(uint8).max;
            emit Initialized(type(uint8).max);
        }
    }
}


// File @mimic-fi/v2-registry/contracts/registry/[email protected]


pragma solidity >=0.8.0;

/**
 * @title IRegistry
 * @dev Registry interface, it must follow the IAuthorizer interface.
 */
interface IRegistry is IAuthorizer {
    /**
     * @dev Emitted every time a new implementation is registered
     */
    event Registered(bytes32 indexed namespace, address indexed implementation, bool stateless);

    /**
     * @dev Emitted every time an implementation is deprecated
     */
    event Deprecated(bytes32 indexed namespace, address indexed implementation);

    /**
     * @dev Emitted every time an implementation is cloned
     */
    event Cloned(bytes32 indexed namespace, address indexed implementation, address instance, bytes initResult);

    /**
     * @dev Tells the implementation associated to a contract instance
     * @param instance Address of the instance to request it's implementation
     */
    function implementationOf(address instance) external view returns (address);

    /**
     * @dev Tells the data of an implementation:
     * @param implementation Address of the implementation to request it's data
     */
    function implementationData(address implementation)
        external
        view
        returns (bool stateless, bool deprecated, bytes32 namespace);

    /**
     * @dev Tells if a specific implementation is registered under a certain namespace and it's not deprecated
     * @param namespace Namespace asking for
     * @param implementation Address of the implementation to be checked
     */
    function isActive(bytes32 namespace, address implementation) external view returns (bool);

    /**
     * @dev Registers a new implementation for a given namespace
     * @param namespace Namespace to be used for the implementation
     * @param implementation Address of the implementation to be registered
     * @param stateless Whether the implementation is stateless or not
     */
    function register(bytes32 namespace, address implementation, bool stateless) external;

    /**
     * @dev Deprecates a registered implementation
     * @param implementation Address of the implementation to be deprecated
     */
    function deprecate(address implementation) external;

    /**
     * @dev Clones a registered implementation
     * @param implementation Address of the implementation to be cloned
     * @param initializeData Arbitrary data to be sent after deployment
     * @return instance Address of the new instance created
     */
    function clone(address implementation, bytes memory initializeData) external returns (address);
}


// File @mimic-fi/v2-registry/contracts/implementations/[email protected]


pragma solidity ^0.8.0;


/**
 * @title BaseImplementation
 * @dev This implementation contract comes with an immutable reference to an implementations registry where it should
 * be registered as well (checked during initialization). It allows requesting new instances of other registered
 * implementations to as another safety check to make sure valid instances are referenced in case it's needed.
 */
abstract contract BaseImplementation is IImplementation {
    // Immutable implementations registry reference
    address public immutable override registry;

    /**
     * @dev Creates a new BaseImplementation
     * @param _registry Address of the Mimic Registry where dependencies will be validated against
     */
    constructor(address _registry) {
        registry = _registry;
    }

    /**
     * @dev Internal function to validate a new dependency that must be registered as stateless.
     * It checks the new dependency is registered, not deprecated, and stateless.
     * @param dependency New stateless dependency to be set
     */
    function _validateStatelessDependency(address dependency) internal view {
        require(_validateDependency(dependency), 'DEPENDENCY_NOT_STATELESS');
    }

    /**
     * @dev Internal function to validate a new dependency that cannot be registered as stateless.
     * It checks the new dependency is registered, not deprecated, and not stateful.
     * @param dependency New stateful dependency to be set
     */
    function _validateStatefulDependency(address dependency) internal view {
        require(!_validateDependency(dependency), 'DEPENDENCY_NOT_STATEFUL');
    }

    /**
     * @dev Internal function to validate a new dependency. It checks the dependency is registered and not deprecated.
     * @param dependency New dependency to be set
     * @return Whether the dependency is stateless or not
     */
    function _validateDependency(address dependency) private view returns (bool) {
        // If there is an implementation registered for the dependency, check the dependency as an instance.
        // Otherwise, treat the dependency as an implementation.
        address dependencyImplementation = IRegistry(registry).implementationOf(dependency);
        address implementation = dependencyImplementation != address(0) ? dependencyImplementation : dependency;

        (bool stateless, bool deprecated, bytes32 namespace) = IRegistry(registry).implementationData(implementation);
        require(namespace != bytes32(0), 'DEPENDENCY_NOT_REGISTERED');
        require(!deprecated, 'DEPENDENCY_DEPRECATED');
        return stateless;
    }
}


// File @mimic-fi/v2-registry/contracts/implementations/[email protected]


pragma solidity ^0.8.0;

/**
 * @title InitializableImplementation
 * @dev Implementation contract to be used through proxies. Inheriting contracts are meant to be initialized through
 * initialization functions instead of constructor functions. It allows re-using the same logic contract while making
 * deployments cheaper.
 */
abstract contract InitializableImplementation is BaseImplementation, Initializable {
    /**
     * @dev Creates a new BaseImplementation. Note that initializers are disabled at creation time.
     */
    constructor(address registry) BaseImplementation(registry) {
        _disableInitializers();
    }

    /**
     * @dev Initialization function to check a new instance is properly set up in the registry.
     * Note this function can only be called from a function marked with the `initializer` modifier.
     */
    function _initialize() internal view onlyInitializing {
        address implementation = IRegistry(registry).implementationOf(address(this));
        require(implementation != address(0), 'IMPLEMENTATION_NOT_REGISTERED');

        (, bool deprecated, bytes32 namespace) = IRegistry(registry).implementationData(implementation);
        require(!deprecated, 'IMPLEMENTATION_DEPRECATED');
        require(this.NAMESPACE() == namespace, 'INVALID_IMPLEMENTATION_NAMESPACE');
    }
}


// File @mimic-fi/v2-helpers/contracts/auth/[email protected]


pragma solidity ^0.8.0;

/**
 * @title Authorizer
 * @dev Authorization module to be used by contracts that need to implement permissions for their methods.
 * It provides a permissions model to list who is allowed to call what function in a contract. And only accounts
 * authorized to manage those permissions are the ones that are allowed to authorize or unauthorize accounts.
 */
contract Authorizer is IAuthorizer {
    // Constant used to denote that a permission is open to anyone
    address public constant ANY_ADDRESS = address(0xFFfFfFffFFfffFFfFFfFFFFFffFFFffffFfFFFfF);

    // Internal mapping to tell who is allowed to do what indexed by (account, function selector)
    mapping (address => mapping (bytes4 => bool)) private authorized;

    /**
     * @dev Modifier that should be used to tag protected functions
     */
    modifier auth() {
        _authenticate(msg.sender, msg.sig);
        _;
    }

    /**
     * @dev Tells whether someone is allowed to call a function or not. It returns true if it's allowed to anyone.
     * @param who Address asking permission for
     * @param what Function selector asking permission for
     */
    function isAuthorized(address who, bytes4 what) public view override returns (bool) {
        return authorized[ANY_ADDRESS][what] || authorized[who][what];
    }

    /**
     * @dev Authorizes someone to call a function. Sender must be authorize to do so.
     * @param who Address to be authorized
     * @param what Function selector to be granted
     */
    function authorize(address who, bytes4 what) external override auth {
        _authorize(who, what);
    }

    /**
     * @dev Unauthorizes someone to call a function. Sender must be authorize to do so.
     * @param who Address to be unauthorized
     * @param what Function selector to be revoked
     */
    function unauthorize(address who, bytes4 what) external override auth {
        _unauthorize(who, what);
    }

    /**
     * @dev Internal function to authenticate someone over a function.
     * It reverts if the given account is not authorized to call the requested function.
     * @param who Address to be authenticated
     * @param what Function selector to be authenticated
     */
    function _authenticate(address who, bytes4 what) internal view {
        require(isAuthorized(who, what), 'AUTH_SENDER_NOT_ALLOWED');
    }

    /**
     * @dev Internal function to authorize someone to call a function
     * @param who Address to be authorized
     * @param what Function selector to be granted
     */
    function _authorize(address who, bytes4 what) internal {
        authorized[who][what] = true;
        emit Authorized(who, what);
    }

    /**
     * @dev Internal function to unauthorize someone to call a function
     * @param who Address to be unauthorized
     * @param what Function selector to be revoked
     */
    function _unauthorize(address who, bytes4 what) internal {
        authorized[who][what] = false;
        emit Unauthorized(who, what);
    }
}


// File @mimic-fi/v2-registry/contracts/implementations/[email protected]


pragma solidity ^0.8.0;

/**
 * @title InitializableAuthorizedImplementation
 * @dev InitializableImplementation using the Authorizer mixin. Initializable implementations that want to use the
 * Authorizer permissions mechanism should inherit from this contract instead.
 */
abstract contract InitializableAuthorizedImplementation is InitializableImplementation, Authorizer {
    /**
     * @dev Creates a new InitializableAuthorizedImplementation
     * @param registry Address of the Mimic Registry
     */
    constructor(address registry) InitializableImplementation(registry) {
        // solhint-disable-previous-line no-empty-blocks
    }

    /**
     * @dev Initialization function that authorizes an admin account to authorize and unauthorize accounts.
     * Note this function can only be called from a function marked with the `initializer` modifier.
     * @param admin Address to be granted authorize and unauthorize permissions
     */
    function _initialize(address admin) internal onlyInitializing {
        _initialize();
        _authorize(admin, Authorizer.authorize.selector);
        _authorize(admin, Authorizer.unauthorize.selector);
    }
}


// File contracts/SmartVault.sol


pragma solidity ^0.8.0;














/**
 * @title Smart Vault
 * @dev Smart Vault contract where funds are being held offering a bunch of primitives to allow users model any
 * type of action to manage them, these are: collector, withdraw, swap, join, exit, bridge, wrap, and unwrap.
 *
 * It inherits from InitializableAuthorizedImplementation which means it's implementation can be cloned
 * from the Mimic Registry and should be initialized depending on each case.
 */
contract SmartVault is ISmartVault, PriceFeedProvider, InitializableAuthorizedImplementation {
    using SafeERC20 for IERC20;
    using FixedPoint for uint256;
    using UncheckedMath for uint256;
    using StrategyLib for address;
    using SwapConnectorLib for address;

    // Namespace under which the Smart Vault is registered in the Mimic Registry
    bytes32 public constant override NAMESPACE = keccak256('SMART_VAULT');

    /**
     * @dev Fee configuration parameters
     * @param pct Percentage expressed using 16 decimals (1e18 = 100%)
     * @param cap Maximum amount of fees to be charged per period
     * @param token Address of the token to express the cap amount
     * @param period Period length in seconds
     * @param totalCharged Total amount of fees charged in the current period
     * @param nextResetTime Current cap period end date
     */
    struct Fee {
        uint256 pct;
        uint256 cap;
        address token;
        uint256 period;
        uint256 totalCharged;
        uint256 nextResetTime;
    }

    // Price oracle reference
    address public override priceOracle;

    // Swap connector reference
    address public override swapConnector;

    // List of allowed strategies indexed by strategy address
    mapping (address => bool) public override isStrategyAllowed;

    // List of invested values indexed by strategy address
    mapping (address => uint256) public override investedValue;

    // Fee collector address where fees will be deposited
    address public override feeCollector;

    // Withdraw fee configuration
    Fee public override withdrawFee;

    // Performance fee configuration
    Fee public override performanceFee;

    // Swap fee configuration
    Fee public override swapFee;

    // Wrapped native token reference
    address public immutable override wrappedNativeToken;

    /**
     * @dev Creates a new Smart Vault implementation with references that should be shared among all implementations
     * @param _wrappedNativeToken Address of the wrapped native token to be used
     * @param _registry Address of the Mimic Registry to be referenced
     */
    constructor(address _wrappedNativeToken, address _registry) InitializableAuthorizedImplementation(_registry) {
        wrappedNativeToken = _wrappedNativeToken;
    }

    /**
     * @dev Initializes the Smart Vault instance
     * @param admin Address that will be granted with admin rights
     */
    function initialize(address admin) external initializer {
        _initialize(admin);
    }

    /**
     * @dev It allows receiving native token transfers
     */
    receive() external payable {
        // solhint-disable-previous-line no-empty-blocks
    }

    /**
     * @dev Sets a new strategy as allowed or not for a Smart Vault. Sender must be authorized.
     * @param strategy Address of the strategy to be set
     * @param allowed Whether the strategy is allowed or not
     */
    function setStrategy(address strategy, bool allowed) external override auth {
        _setStrategy(strategy, allowed);
    }

    /**
     * @dev Sets a new price oracle to a Smart Vault. Sender must be authorized.
     * @param newPriceOracle Address of the new price oracle to be set
     */
    function setPriceOracle(address newPriceOracle) external override auth {
        _setPriceOracle(newPriceOracle);
    }

    /**
     * @dev Sets a new swap connector to a Smart Vault. Sender must be authorized.
     * @param newSwapConnector Address of the new swap connector to be set
     */
    function setSwapConnector(address newSwapConnector) external override auth {
        _setSwapConnector(newSwapConnector);
    }

    /**
     * @dev Sets a new fee collector. Sender must be authorized.
     * @param newFeeCollector Address of the new fee collector to be set
     */
    function setFeeCollector(address newFeeCollector) external override auth {
        _setFeeCollector(newFeeCollector);
    }

    /**
     * @dev Sets a new withdraw fee. Sender must be authorized.
     * @param pct Withdraw fee percentage to be set
     * @param cap New maximum amount of withdraw fees to be charged per period
     * @param token Address of the token cap to be set
     * @param period New cap period length in seconds for the withdraw fee
     */
    function setWithdrawFee(uint256 pct, uint256 cap, address token, uint256 period) external override auth {
        _setFeeConfiguration(withdrawFee, pct, cap, token, period);
        emit WithdrawFeeSet(pct, cap, token, period);
    }

    /**
     * @dev Sets a new performance fee. Sender must be authorized.
     * @param pct Performance fee percentage to be set
     * @param cap New maximum amount of performance fees to be charged per period
     * @param token Address of the token cap to be set
     * @param period New cap period length in seconds for the performance fee
     */
    function setPerformanceFee(uint256 pct, uint256 cap, address token, uint256 period) external override auth {
        _setFeeConfiguration(performanceFee, pct, cap, token, period);
        emit PerformanceFeeSet(pct, cap, token, period);
    }

    /**
     * @dev Sets a new swap fee. Sender must be authorized.
     * @param pct New swap fee percentage to be set
     * @param cap New maximum amount of swap fees to be charged per period
     * @param token Address of the token cap to be set
     * @param period New cap period length in seconds for the swap fee
     */
    function setSwapFee(uint256 pct, uint256 cap, address token, uint256 period) external override auth {
        _setFeeConfiguration(swapFee, pct, cap, token, period);
        emit SwapFeeSet(pct, cap, token, period);
    }

    /**
     * @dev Sets a of price feed
     * @param base Token base to be set
     * @param quote Token quote to be set
     * @param feed Price feed to be set
     */
    function setPriceFeed(address base, address quote, address feed)
        public
        override(IPriceFeedProvider, PriceFeedProvider)
        auth
    {
        super.setPriceFeed(base, quote, feed);
    }

    /**
     * @dev Tells the price of a token (base) in a given quote
     * @param base Token to rate
     * @param quote Token used for the price rate
     */
    function getPrice(address base, address quote) public view override returns (uint256) {
        return IPriceOracle(priceOracle).getPrice(address(this), base, quote);
    }

    /**
     * @dev Tells the last value accrued for a strategy. Note this value can be outdated.
     * @param strategy Address of the strategy querying the last value of
     */
    function lastValue(address strategy) public view override returns (uint256) {
        return IStrategy(strategy).lastValue(address(this));
    }

    /**
     * @dev Execute an arbitrary call from a Smart Vault. Sender must be authorized.
     * @param target Address where the call will be sent
     * @param data Calldata to be used for the call
     * @param value Value in wei that will be attached to the call
     * @return result Call response if it was successful, otherwise it reverts
     */
    function call(address target, bytes memory callData, uint256 value, bytes memory data)
        external
        override
        auth
        returns (bytes memory result)
    {
        result = Address.functionCallWithValue(target, callData, value, 'SMART_VAULT_ARBITRARY_CALL_FAIL');
        emit Call(target, callData, value, result, data);
    }

    /**
     * @dev Collect tokens from an external account to a Smart Vault. Sender must be authorized.
     * @param token Address of the token to be collected
     * @param from Address where the tokens will be transfer from
     * @param amount Amount of tokens to be transferred
     * @param data Extra data only logged
     * @return collected Amount of tokens collected
     */
    function collect(address token, address from, uint256 amount, bytes memory data)
        external
        override
        auth
        returns (uint256 collected)
    {
        require(amount > 0, 'COLLECT_AMOUNT_ZERO');

        uint256 previousBalance = IERC20(token).balanceOf(address(this));
        IERC20(token).safeTransferFrom(from, address(this), amount);
        uint256 currentBalance = IERC20(token).balanceOf(address(this));

        collected = currentBalance - previousBalance;
        emit Collect(token, from, collected, data);
    }

    /**
     * @dev Withdraw tokens to an external account. Sender must be authorized.
     * @param token Address of the token to be withdrawn
     * @param amount Amount of tokens to withdraw
     * @param recipient Address where the tokens will be transferred to
     * @param data Extra data only logged
     * @return withdrawn Amount of tokens transferred to the recipient address
     */
    function withdraw(address token, uint256 amount, address recipient, bytes memory data)
        external
        override
        auth
        returns (uint256 withdrawn)
    {
        require(amount > 0, 'WITHDRAW_AMOUNT_ZERO');
        require(recipient != address(0), 'RECIPIENT_ZERO');

        uint256 withdrawFeeAmount = recipient == feeCollector ? 0 : _payFee(token, amount, withdrawFee);
        withdrawn = amount - withdrawFeeAmount;
        _safeTransfer(token, recipient, withdrawn);
        emit Withdraw(token, recipient, withdrawn, withdrawFeeAmount, data);
    }

    /**
     * @dev Wrap an amount of native tokens to the wrapped ERC20 version of it. Sender must be authorized.
     * @param amount Amount of native tokens to be wrapped
     * @param data Extra data only logged
     * @return wrapped Amount of tokens wrapped
     */
    function wrap(uint256 amount, bytes memory data) external override auth returns (uint256 wrapped) {
        require(amount > 0, 'WRAP_AMOUNT_ZERO');
        require(address(this).balance >= amount, 'WRAP_INSUFFICIENT_AMOUNT');

        IWrappedNativeToken wrappedToken = IWrappedNativeToken(wrappedNativeToken);
        uint256 previousBalance = wrappedToken.balanceOf(address(this));
        wrappedToken.deposit{ value: amount }();
        uint256 currentBalance = wrappedToken.balanceOf(address(this));

        wrapped = currentBalance - previousBalance;
        emit Wrap(amount, wrapped, data);
    }

    /**
     * @dev Unwrap an amount of wrapped native tokens. Sender must be authorized.
     * @param amount Amount of wrapped native tokens to unwrapped
     * @param data Extra data only logged
     * @return unwrapped Amount of tokens unwrapped
     */
    function unwrap(uint256 amount, bytes memory data) external override auth returns (uint256 unwrapped) {
        require(amount > 0, 'UNWRAP_AMOUNT_ZERO');

        uint256 previousBalance = address(this).balance;
        IWrappedNativeToken(wrappedNativeToken).withdraw(amount);
        uint256 currentBalance = address(this).balance;

        unwrapped = currentBalance - previousBalance;
        emit Unwrap(amount, unwrapped, data);
    }

    /**
     * @dev Claim strategy rewards. Sender must be authorized.
     * @param strategy Address of the strategy to claim rewards
     * @param data Extra data passed to the strategy and logged
     * @return tokens Addresses of the tokens received as rewards
     * @return amounts Amounts of the tokens received as rewards
     */
    function claim(address strategy, bytes memory data)
        external
        override
        auth
        returns (address[] memory tokens, uint256[] memory amounts)
    {
        require(isStrategyAllowed[strategy], 'STRATEGY_NOT_ALLOWED');
        (tokens, amounts) = strategy.claim(data);
        emit Claim(strategy, tokens, amounts, data);
    }

    /**
     * @dev Join a strategy with an amount of tokens. Sender must be authorized.
     * @param strategy Address of the strategy to join
     * @param tokensIn List of token addresses to join with
     * @param amountsIn List of token amounts to join with
     * @param slippage Slippage that will be used to compute the join
     * @param data Extra data passed to the strategy and logged
     * @return tokensOut List of token addresses received after the join
     * @return amountsOut List of token amounts received after the join
     */
    function join(
        address strategy,
        address[] memory tokensIn,
        uint256[] memory amountsIn,
        uint256 slippage,
        bytes memory data
    ) external override auth returns (address[] memory tokensOut, uint256[] memory amountsOut) {
        require(isStrategyAllowed[strategy], 'STRATEGY_NOT_ALLOWED');
        require(slippage <= FixedPoint.ONE, 'JOIN_SLIPPAGE_ABOVE_ONE');
        require(tokensIn.length == amountsIn.length, 'JOIN_INPUT_INVALID_LENGTH');

        uint256 value;
        (tokensOut, amountsOut, value) = strategy.join(tokensIn, amountsIn, slippage, data);
        require(tokensOut.length == amountsOut.length, 'JOIN_OUTPUT_INVALID_LENGTH');

        investedValue[strategy] = investedValue[strategy] + value;
        emit Join(strategy, tokensIn, amountsIn, tokensOut, amountsOut, value, slippage, data);
    }

    /**
     * @dev Exit a strategy. Sender must be authorized.
     * @param strategy Address of the strategy to exit
     * @param tokensIn List of token addresses to exit with
     * @param amountsIn List of token amounts to exit with
     * @param slippage Slippage that will be used to compute the exit
     * @param data Extra data passed to the strategy and logged
     * @return tokensOut List of token addresses received after the exit
     * @return amountsOut List of token amounts received after the exit
     */
    function exit(
        address strategy,
        address[] memory tokensIn,
        uint256[] memory amountsIn,
        uint256 slippage,
        bytes memory data
    ) external override auth returns (address[] memory tokensOut, uint256[] memory amountsOut) {
        require(isStrategyAllowed[strategy], 'STRATEGY_NOT_ALLOWED');
        require(investedValue[strategy] > 0, 'EXIT_NO_INVESTED_VALUE');
        require(slippage <= FixedPoint.ONE, 'EXIT_SLIPPAGE_ABOVE_ONE');
        require(tokensIn.length == amountsIn.length, 'EXIT_INPUT_INVALID_LENGTH');

        uint256 value;
        (tokensOut, amountsOut, value) = strategy.exit(tokensIn, amountsIn, slippage, data);
        require(tokensOut.length == amountsOut.length, 'EXIT_OUTPUT_INVALID_LENGTH');
        uint256[] memory performanceFeeAmounts = new uint256[](amountsOut.length);

        // It can rely on the last updated value since we have just exited, no need to compute current value
        uint256 valueBeforeExit = lastValue(strategy) + value;
        if (valueBeforeExit <= investedValue[strategy]) {
            // There were losses, invested value is simply reduced using the exited ratio compared to the value
            // before exit. Invested value is round up to avoid interpreting losses due to rounding errors
            investedValue[strategy] -= investedValue[strategy].mulUp(value).divUp(valueBeforeExit);
        } else {
            // If value gains are greater than the exit value, it means only gains are being withdrawn. In that case
            // the taxable amount is the entire exited amount, otherwise it should be the equivalent gains ratio of it.
            uint256 valueGains = valueBeforeExit.uncheckedSub(investedValue[strategy]);
            bool onlyGains = valueGains >= value;

            // If the exit value is greater than the value gains, the invested value should be reduced by the portion
            // of the invested value being exited. Otherwise, it's still the same, only gains are being withdrawn.
            // No need for checked math as we are checking it manually beforehand
            uint256 decrement = onlyGains ? 0 : value.uncheckedSub(valueGains);
            investedValue[strategy] = investedValue[strategy] - decrement;

            // Compute performance fees per token out
            for (uint256 i = 0; i < tokensOut.length; i = i.uncheckedAdd(1)) {
                address token = tokensOut[i];
                uint256 amount = amountsOut[i];
                uint256 taxableAmount = onlyGains ? amount : ((amount * valueGains) / value);
                uint256 feeAmount = _payFee(token, taxableAmount, performanceFee);
                amountsOut[i] = amount - feeAmount;
                performanceFeeAmounts[i] = feeAmount;
            }
        }

        emit Exit(strategy, tokensIn, amountsIn, tokensOut, amountsOut, value, performanceFeeAmounts, slippage, data);
    }

    /**
     * @dev Swaps two tokens. Sender must be authorized.
     * @param source Source to request the swap: Uniswap V2, Uniswap V3, Balancer V2, or Paraswap V5.
     * @param tokenIn Token being sent
     * @param tokenOut Token being received
     * @param amountIn Amount of tokenIn being swapped
     * @param limitType Swap limit to be applied: slippage or min amount out
     * @param limitAmount Amount of the swap limit to be applied depending on limitType
     * @param data Encoded data to specify different swap parameters depending on the source picked
     * @return amountOut Received amount of tokens out
     */
    function swap(
        uint8 source,
        address tokenIn,
        address tokenOut,
        uint256 amountIn,
        SwapLimit limitType,
        uint256 limitAmount,
        bytes memory data
    ) external override auth returns (uint256 amountOut) {
        require(tokenIn != tokenOut, 'SWAP_SAME_TOKEN');
        require(swapConnector != address(0), 'SWAP_CONNECTOR_NOT_SET');

        uint256 minAmountOut;
        if (limitType == SwapLimit.MinAmountOut) {
            minAmountOut = limitAmount;
        } else if (limitType == SwapLimit.Slippage) {
            require(limitAmount <= FixedPoint.ONE, 'SWAP_SLIPPAGE_ABOVE_ONE');
            uint256 price = getPrice(tokenIn, tokenOut);
            // No need for checked math as we are checking it manually beforehand
            // Always round up the expected min amount out. Limit amount is slippage.
            minAmountOut = amountIn.mulUp(price).mulUp(FixedPoint.ONE.uncheckedSub(limitAmount));
        } else {
            revert('SWAP_INVALID_LIMIT_TYPE');
        }

        uint256 preBalanceOut = IERC20(tokenOut).balanceOf(address(this));
        swapConnector.swap(source, tokenIn, tokenOut, amountIn, minAmountOut, data);
        uint256 postBalanceOut = IERC20(tokenOut).balanceOf(address(this));
        uint256 amountOutBeforeFees = postBalanceOut - preBalanceOut;
        require(amountOutBeforeFees >= minAmountOut, 'SWAP_MIN_AMOUNT');

        uint256 swapFeeAmount = _payFee(tokenOut, amountOutBeforeFees, swapFee);
        amountOut = amountOutBeforeFees - swapFeeAmount;
        emit Swap(source, tokenIn, tokenOut, amountIn, amountOut, minAmountOut, swapFeeAmount, data);
    }

    /**
     * @dev Internal function to pay the amount of fees to be charged based on a fee configuration to the fee collector
     * @param token Token being charged
     * @param amount Token amount to be taxed with fees
     * @param fee Fee configuration to be applied
     * @return paidAmount Amount of fees paid to the fee collector
     */
    function _payFee(address token, uint256 amount, Fee storage fee) internal returns (uint256 paidAmount) {
        // Fee amounts are always rounded down
        uint256 feeAmount = amount.mulDown(fee.pct);

        // If cap amount or cap period are not set, charge the entire amount
        if (fee.token == address(0) || fee.cap == 0 || fee.period == 0) {
            _safeTransfer(token, feeCollector, feeAmount);
            return feeAmount;
        }

        // Reset cap totalizator if necessary
        if (block.timestamp >= fee.nextResetTime) {
            fee.totalCharged = 0;
            fee.nextResetTime = block.timestamp + fee.period;
        }

        // Calc fee amount in the fee token used for the cap
        uint256 feeTokenPrice = getPrice(token, fee.token);
        uint256 feeAmountInFeeToken = feeAmount.mulDown(feeTokenPrice);

        // Compute fee amount picking the minimum between the chargeable amount and the remaining part for the cap
        if (fee.totalCharged + feeAmountInFeeToken <= fee.cap) {
            paidAmount = feeAmount;
            fee.totalCharged += feeAmountInFeeToken;
        } else if (fee.totalCharged < fee.cap) {
            paidAmount = (fee.cap.uncheckedSub(fee.totalCharged) * feeAmount) / feeAmountInFeeToken;
            fee.totalCharged = fee.cap;
        } else {
            // This case is when the total charged amount is already greater than the cap amount. It could happen if
            // the cap amounts is decreased or if the cap token is changed. In this case the total charged amount is
            // not updated, and the amount to paid is zero.
            paidAmount = 0;
        }

        // Pay fee amount to the fee collector
        _safeTransfer(token, feeCollector, paidAmount);
    }

    /**
     * @dev Internal method to transfer ERC20 or native tokens from a Smart Vault
     * @param token Address of the ERC20 token to transfer
     * @param to Address transferring the tokens to
     * @param amount Amount of tokens to transfer
     */
    function _safeTransfer(address token, address to, uint256 amount) internal {
        if (amount == 0) return;
        if (Denominations.isNativeToken(token)) Address.sendValue(payable(to), amount);
        else IERC20(token).safeTransfer(to, amount);
    }

    /**
     * @dev Sets a new strategy as allowed or not
     * @param strategy Address of the strategy to be set
     * @param allowed Whether the strategy is allowed or not
     */
    function _setStrategy(address strategy, bool allowed) internal {
        if (allowed) _validateStatelessDependency(strategy);
        isStrategyAllowed[strategy] = allowed;
        emit StrategySet(strategy, allowed);
    }

    /**
     * @dev Sets a new price oracle
     * @param newPriceOracle New price oracle to be set
     */
    function _setPriceOracle(address newPriceOracle) internal {
        _validateStatelessDependency(newPriceOracle);
        priceOracle = newPriceOracle;
        emit PriceOracleSet(newPriceOracle);
    }

    /**
     * @dev Sets a new swap connector
     * @param newSwapConnector New swap connector to be set
     */
    function _setSwapConnector(address newSwapConnector) internal {
        _validateStatelessDependency(newSwapConnector);
        swapConnector = newSwapConnector;
        emit SwapConnectorSet(newSwapConnector);
    }

    /**
     * @dev Internal method to set the fee collector
     * @param newFeeCollector New fee collector to be set
     */
    function _setFeeCollector(address newFeeCollector) internal {
        require(newFeeCollector != address(0), 'FEE_COLLECTOR_ZERO');
        feeCollector = newFeeCollector;
        emit FeeCollectorSet(newFeeCollector);
    }

    /**
     * @dev Internal method to set a new fee cap configuration
     * @param fee Fee configuration to be updated
     * @param pct Fee percentage to be set
     * @param cap New maximum amount of fees to be charged per period
     * @param token Address of the token cap to be set
     * @param period New cap period length in seconds
     */
    function _setFeeConfiguration(Fee storage fee, uint256 pct, uint256 cap, address token, uint256 period) internal {
        require(pct <= FixedPoint.ONE, 'FEE_PCT_ABOVE_ONE');

        // If there is no fee percentage, there must not be a fee cap
        bool isZeroCap = token == address(0) && cap == 0 && period == 0;
        require(pct != 0 || isZeroCap, 'INVALID_CAP_WITH_FEE_ZERO');

        // If there is a cap, all values must be non-zero
        bool isNonZeroCap = token != address(0) && cap != 0 && period != 0;
        require(isZeroCap || isNonZeroCap, 'INCONSISTENT_CAP_VALUES');

        // Changing the fee percentage does not affect the totalizator at all, it only affects future fee charges
        fee.pct = pct;

        // Changing the fee cap amount does not affect the totalizator, it only applies when changing the for the total
        // charged amount. Note that it can happen that the cap amount is lower than the total charged amount if the
        // cap amount is lowered. However, there shouldn't be any accounting issues with that.
        fee.cap = cap;

        // Changing the cap period only affects the end time of the next period, but not the end date of the current one
        fee.period = period;

        // Therefore, only clean the totalizators if the cap is being removed
        if (isZeroCap) {
            fee.totalCharged = 0;
            fee.nextResetTime = 0;
        } else {
            // If cap values are not zero, set the next reset time if it wasn't set already
            // Otherwise, if the cap token is being changed the total charged amount must be updated accordingly
            if (fee.nextResetTime == 0) {
                fee.nextResetTime = block.timestamp + period;
            } else if (fee.token != token) {
                uint256 newTokenPrice = getPrice(fee.token, token);
                fee.totalCharged = fee.totalCharged.mulDown(newTokenPrice);
            }
        }

        // Finally simply set the new requested token
        fee.token = token;
    }
}