// SPDX-License-Identifier: MIT

pragma solidity ^0.8.4;

import "../roles/OperatorRole.sol";
import "./IERC20TransferProxy.sol";

contract ERC20TransferProxy is
    IERC20TransferProxy,
    Initializable,
    OperatorRole
{
    function __ERC20TransferProxy_init() external initializer {
        __Ownable_init();
    }

    function erc20safeTransferFrom(
        IERC20Upgradeable token,
        address from,
        address to,
        uint256 value
    ) external override onlyOperator {
        require(
            token.transferFrom(from, to, value),
            "failure while transferring"
        );
    }
}