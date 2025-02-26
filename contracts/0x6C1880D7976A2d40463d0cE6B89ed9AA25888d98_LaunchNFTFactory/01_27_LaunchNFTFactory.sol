// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/utils/Counters.sol";
import "@openzeppelin/contracts/interfaces/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/utils/ERC721Holder.sol";
import "@openzeppelin/contracts/token/ERC1155/utils/ERC1155Holder.sol";
import "./LaunchNftI.sol";
import "@openzeppelin/contracts/token/ERC1155/IERC1155.sol";
import "./ILaunchSettings.sol";


contract LaunchNFTFactory is Ownable, Pausable, ERC1155Holder, ERC721Holder {
    using Counters for Counters.Counter;
    Counters.Counter private _vaultTracker;

    mapping(uint256 => address) public vaults;
    address public immutable launchSettings;

    event Mint(
        address indexed token,
        uint256 id,
        uint256 priceOfToken,
        address vault,
        uint256 vaultId,
        address indexed user
    );
    
    constructor(address _launchSettings) {
        launchSettings = _launchSettings;
    }

    function createVault(
        string memory _name,
        string memory _symbol,
        uint256 _supply,
        uint256 priceOfNft,
        address nft,
        uint256 nftId,
        uint96 curatorFee
    ) external whenNotPaused returns (uint256) {
        address newVault = address(
            new LaunchNftI(_name,_symbol,msg.sender,_supply,launchSettings,nft,nftId,priceOfNft,curatorFee));
        emit Mint(
            nft,
            nftId,
            priceOfNft,
            newVault,
            _vaultTracker.current(),
            msg.sender
        );
         if(ILaunchSettings(launchSettings).isERC721(nft)){
        IERC721(nft).safeTransferFrom(msg.sender, newVault, nftId);
        }
        if(ILaunchSettings(launchSettings).isERC1155(nft)){
        IERC1155(nft).safeTransferFrom(msg.sender,newVault,nftId,1,"");
        }
        vaults[_vaultTracker.current()] = newVault;
        _vaultTracker.increment();
        return _vaultTracker.current() - 1;
        
    }
  
    function pause() external onlyOwner {
        _pause();
    }

    function unpause() external onlyOwner {
        _unpause();
    }

}