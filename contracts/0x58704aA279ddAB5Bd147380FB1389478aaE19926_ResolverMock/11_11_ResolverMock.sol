// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

import "../interfaces/IResolver.sol";
import "../libraries/TokensAndAmounts.sol";
import "@1inch/solidity-utils/contracts/libraries/SafeERC20.sol";

contract ResolverMock is IResolver {
    error OnlyOwner();
    error OnlySettlement();
    error FailedExternalCall(uint256 index, bytes reason);

    using TokensAndAmounts for bytes;
    using SafeERC20 for IERC20;
    using AddressLib for Address;

    address private immutable _settlement;
    address private immutable _owner;
    bytes1 private constant _INDICES_MASK = 0xff;

    constructor(address settlement) {
        _settlement = settlement;
        _owner = msg.sender;
    }

    function resolveOrders(
        address resolver,
        bytes calldata tokensAndAmounts,
        bytes calldata data
    ) external {
        if (msg.sender != _settlement) revert OnlySettlement();
        if (resolver != _owner) revert OnlyOwner();

        bytes32 tokenIndices = bytes32(data);
        if (data.length > 32) {
            (Address[] memory targets, bytes[] memory calldatas) = abi.decode(data[32:], (Address[],bytes[]));
            for (uint256 i = 0; i < targets.length; ++i) {
                // solhint-disable-next-line avoid-low-level-calls
                (bool success, bytes memory reason) = targets[i].get().call(calldatas[i]);
                if (!success) revert FailedExternalCall(i, reason);
            }
        }

        unchecked {
            TokensAndAmounts.Data[] calldata items = tokensAndAmounts.decode();
            for (uint256 i = 0; i < items.length; ++i) {
                uint256 totalAmount;
                uint256 j = i;
                uint256 next = uint8(tokenIndices[i]);
                if (next != 0xff) {
                    do {
                        totalAmount += items[j].amount;
                        tokenIndices |= bytes32(_INDICES_MASK) >> (j << 3);
                        j = next;
                        next = uint8(tokenIndices[next]);
                    } while (j != 0);

                    IERC20(items[i].token.get()).safeTransfer(msg.sender, totalAmount);
                }
            }
        }
    }
}