// SPDX-License-Identifier: MIT

pragma solidity ^0.8.15;

import "openzeppelin-contracts/contracts/utils/introspection/IERC165.sol";

/**
 * Implement this if you want your extension to approve a transfer
 */
interface IERC721CreatorExtensionApproveTransfer is IERC165 {
    /**
     * @dev Set whether or not the creator will check the extension for approval of token transfer
     */
    function setApproveTransfer(address creator, bool enabled) external;

    /**
     * @dev Called by creator contract to approve a transfer
     */
    function approveTransfer(
        address from,
        address to,
        uint256 tokenId
    ) external returns (bool);
}