// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";


contract Recoverable is Ownable, ReentrancyGuard {
    using SafeERC20 for IERC20;

    // Recover NFT tokens sent by accident
    event NonFungibleTokenRecovery(address indexed token, uint256 indexed tokenId, address indexed receiver);

    // Recover ERC20 tokens sent by accident
    event TokenRecovery(address indexed token, uint256 amount, address indexed receiver);
    
   
    /**
     * @notice Allows the owner to recover tokens sent to the contract by mistake
     * @param _token: token address
     * @dev Callable by owner
     */
    function recoverFungibleTokens(address _token, uint256 _amount, address _receiver) external onlyOwner {
        if (_amount == 0) _amount = IERC20(_token).balanceOf(address(this));
        require(_amount != 0, "Operations: No token to recover");

        IERC20(_token).safeTransfer(_receiver, _amount);

        emit TokenRecovery(_token, _amount, _receiver);
    }

    /**
     * @notice Allows the owner to recover NFTs sent to the contract by mistake
     * @param _token: NFT token address
     * @param _tokenId: tokenId
     * @dev Callable by owner
     */
    function recoverNonFungibleToken(address _token, uint256 _tokenId, address _receiver) external onlyOwner nonReentrant {
        IERC721(_token).safeTransferFrom(address(this), _receiver, _tokenId);

        emit NonFungibleTokenRecovery(_token, _tokenId, _receiver);
    }
}