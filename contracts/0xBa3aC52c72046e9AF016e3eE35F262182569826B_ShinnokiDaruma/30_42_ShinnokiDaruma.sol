// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "erc721a-upgradeable/contracts/extensions/ERC721ABurnableUpgradeable.sol";
import "@chocolate-factory/contracts/token/ERC721/presets/TwoStage.sol";
import "./interfaces/IShinnoki.sol";

contract ShinnokiDaruma is TwoStage, ERC721ABurnableUpgradeable {
  bool public openActive;
  IShinnoki public shinnoki;

  function initialize(
    bytes32 whitelistMerkleTreeRoot_,
    address royaltiesRecipient_,
    uint256 royaltiesValue_,
    address[] memory shareholders_,
    uint256[] memory shares_
  ) public initializerERC721A initializer {
    __ERC721A_init("Shinnoki Darumas", "SD");
    __Ownable_init();
    __AdminManager_init_unchained();
    __Supply_init_unchained(5959);
    __AdminMint_init_unchained();
    __Whitelist_init_unchained();
    __BalanceLimit_init_unchained();
    __UriManager_init_unchained("https://ipfs.io/ipfs/QmUaDz69Nn8yNpdZR5LxqgEZiJRkwDLykikpu9HmB67GqJ/", ".json");
    __Royalties_init_unchained(royaltiesRecipient_, royaltiesValue_);
    __ERC721ABurnable_init();
    __DefaultOperatorFilterer_init();
    __CustomPaymentSplitter_init(shareholders_, shares_);
    updateMerkleTreeRoot(uint8(Stage.Whitelist), whitelistMerkleTreeRoot_);    
    updateBalanceLimit(uint8(Stage.Whitelist), 2);
    updateBalanceLimit(uint8(Stage.Public), 2);
    setPrice(uint8(Stage.Whitelist), 0.069 ether);
    setPrice(uint8(Stage.Public), 0.075 ether);
  }

  function openCase(uint256[] calldata ids) external {
    require(openActive, "Opening case is not active");
    uint256 total = ids.length;
    for(uint256 i = 0; i < total; ++i) {
      uint256 id = ids[i];
      require(ownerOf(id) == msg.sender, "Not Owner");
      burn(id);
    }
    shinnoki.mint(msg.sender, total);
  }

  function toggleOpenActive(bool _openActive) external onlyAdmin {
    openActive = _openActive;
  }

  function setShinnoki(IShinnoki _shinnoki) external onlyAdmin {
    shinnoki = _shinnoki;
  }

  function _startTokenId() internal pure override(ERC721AUpgradeable) returns (uint256) {
    return 1;
  }

  function tokenURI(uint256 tokenId) public view override(ERC721AUpgradeable, IERC721AUpgradeable, TwoStage) returns (string memory) {
    return super.tokenURI(tokenId);
  }

  function supportsInterface(bytes4 interfaceId) public view override(ERC721AUpgradeable, IERC721AUpgradeable, TwoStage) returns (bool) {
    return super.supportsInterface(interfaceId);
  }
}