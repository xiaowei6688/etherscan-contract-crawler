/**
 * SPDX-License-Identifier: Apache-2.0
 */
pragma solidity ^0.8.14;

import "@openzeppelin/contracts/access/AccessControl.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/**
 * @title MultiTxProcessor
 * @author Zeropoint Labs.
 *
 * Intermediary contract to perform ChainB swaps while moving funds from ChainA to ChainB.
 * @notice access controlled with previlages functions. Entirely to be processed by Zeropoint Labs Keepers.
 */
contract MultiTxProcessor is AccessControl {
    /* ================ Constants =================== */
    bytes32 public constant SWAPPER_ROLE = keccak256("SWAPPER_ROLE");

    /**
     * @notice bridge id is mapped to its execution address.
     * @dev maps all the bridges to their address.
     */
    mapping(uint8 => address) public bridgeAddress;

    /* ================ Events =================== */
    event SetBridgeAddress(uint256 bridgeId, address bridgeAddress);

    /* ================ Constructor =================== */
    /**
     * @dev caller would be assigned as the admin of the contract.
     */
    constructor() {
        _setupRole(DEFAULT_ADMIN_ROLE, _msgSender());
    }

    /* ================ External Functions =================== */
    /**
     * @notice receive enables processing native token transfers into the smart contract.
     * @dev socket.tech fails without a native receive function.
     */
    receive() external payable {}

    /**
     * PREVILAGED admin ONLY FUNCTION.
     * @dev allows admin to set the bridge address for an bridge id.
     * @param _bridgeId         represents the bridge unqiue identifier.
     * @param _bridgeAddress    represents the bridge address.
     *
     * note: should be moved to registry post beta.
     */
    function setBridgeAddress(
        uint8[] memory _bridgeId,
        address[] memory _bridgeAddress
    ) external onlyRole(DEFAULT_ADMIN_ROLE) {
        for (uint256 i = 0; i < _bridgeId.length; i++) {
            address x = _bridgeAddress[i];
            uint8 y = _bridgeId[i];
            require(x != address(0), "Router: Zero Bridge Address");

            bridgeAddress[y] = x;
            emit SetBridgeAddress(y, x);
        }
    }

    /**
     * PREVILAGED SWAPPER ONLY FUNCTION
     *
     * @dev would interact with socket contract to process multi-tx transactions and move the funds into destination contract.
     * @param bridgeId          represents the unique propreitory id of the bridge used.
     * @param txData            represents the transaction data generated by socket API.
     * @param approvalToken     represents the tokens to be swapped.
     * @param allowanceTarget   represents the socket registry contract.
     * @param amount            represents the amounts to be swapped.
     */
    function processTx(
        uint8 bridgeId,
        bytes memory txData,
        address approvalToken,
        address allowanceTarget,
        uint256 amount
    ) external onlyRole(SWAPPER_ROLE) {
        address to = bridgeAddress[bridgeId];
        if (allowanceTarget != address(0)) {
            IERC20(approvalToken).approve(allowanceTarget, amount);
            (bool success, ) = payable(to).call(txData);
            require(success, "Socket Error: Invalid Tx data (1)");
        } else {
            (bool success, ) = payable(to).call{value: amount}(txData);
            require(success, "Socket Error: Invalid Tx Data (2)");
        }
    }

    /* ================ Development Only Functions =================== */

    /**
     * PREVILAGED admin ONLY FUNCTION.
     * @notice should be removed after end-to-end testing.
     * @dev allows admin to withdraw lost tokens in the smart contract.
     */
    function withdrawToken(address _tokenContract, uint256 _amount)
        external
        onlyRole(DEFAULT_ADMIN_ROLE)
    {
        IERC20 tokenContract = IERC20(_tokenContract);

        // transfer the token from address of this contract
        // to address of the user (executing the withdrawToken() function)
        tokenContract.transfer(msg.sender, _amount);
    }

    /**
     * PREVILAGED admin ONLY FUNCTION.
     * @dev allows admin to withdraw lost native tokens in the smart contract.
     */
    function withdrawNativeToken(uint256 _amount)
        external
        onlyRole(DEFAULT_ADMIN_ROLE)
    {
        payable(msg.sender).transfer(_amount);
    }
}