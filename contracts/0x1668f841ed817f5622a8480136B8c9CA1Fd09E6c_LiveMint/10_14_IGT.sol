// SPDX-License-Identifier: MIT
/**
 * @dev @brougkr
 */
pragma solidity 0.8.17;
interface IGT 
{ 
    /**
     * @dev { Golden Token Burn }
     */
    function _LiveMintBurn(uint TicketID) external returns (address Recipient); 
}