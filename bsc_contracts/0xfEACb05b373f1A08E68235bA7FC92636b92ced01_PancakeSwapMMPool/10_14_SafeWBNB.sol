// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import {IWBNB} from "../interfaces/IWBNB.sol";
import {Address} from "@openzeppelin-4.7.3/contracts/utils/Address.sol";

library SafeWBNB {
    using Address for address;

    function safeDeposit(IWBNB token, uint256 value) internal {
        _callWithValueOptionalReturn(token, abi.encodeWithSelector(token.deposit.selector), value);
    }

    function safeWithdraw(IWBNB token, uint256 value) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.withdraw.selector, value));
    }

    function safeTransfer(
        IWBNB token,
        address to,
        uint256 value
    ) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transfer.selector, to, value));
    }

    function safeTransferFrom(
        IWBNB token,
        address from,
        address to,
        uint256 value
    ) internal {
        _callOptionalReturn(token, abi.encodeWithSelector(token.transferFrom.selector, from, to, value));
    }

    /**
     * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
     * on the return value: the return value is optional (but if data is returned, it must not be false).
     * @param token The token targeted by the call.
     * @param data The call data (encoded using abi.encode or one of its variants).
     */
    function _callOptionalReturn(IWBNB token, bytes memory data) private {
        // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since
        // we're implementing it ourselves. We use {Address.functionCall} to perform this call, which verifies that
        // the target address contains contract code and also asserts for success in the low-level call.

        bytes memory returndata = address(token).functionCall(data, "SafeWBNB: low-level call failed");
        if (returndata.length > 0) {
            // Return data is optional
            require(abi.decode(returndata, (bool)), "SafeWBNB: WBNB operation did not succeed");
        }
    }

    /**
     * @dev Imitates a Solidity high-level call (i.e. a regular function call to a contract), relaxing the requirement
     * on the return value: the return value is optional (but if data is returned, it must not be false).
     * @param token The token targeted by the call.
     * @param data The call data (encoded using abi.encode or one of its variants).
     * @param value The amount of native toke send with the function.
     */
    function _callWithValueOptionalReturn(
        IWBNB token,
        bytes memory data,
        uint256 value
    ) private {
        // We need to perform a low level call here, to bypass Solidity's return data size checking mechanism, since
        // we're implementing it ourselves. We use {Address.functionCall} to perform this call, which verifies that
        // the target address contains contract code and also asserts for success in the low-level call.

        bytes memory returndata = address(token).functionCallWithValue(data, value, "SafeWBNB: low-level call failed");
        if (returndata.length > 0) {
            // Return data is optional
            require(abi.decode(returndata, (bool)), "SafeWBNB: WBNB operation did not succeed");
        }
    }
}