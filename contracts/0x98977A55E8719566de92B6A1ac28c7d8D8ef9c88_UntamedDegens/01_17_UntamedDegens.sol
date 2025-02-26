// SPDX-License-Identifier: BSD-3
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "operator-filter-registry/src/OperatorFilterer.sol";

import "../Common/ERC721/ERC721FQueryable.sol";
import "../Common/Royalties.sol";
import "../Common/Delegated.sol";

contract UntamedDegens is ERC721FQueryable, Royalties, OperatorFilterer, Delegated {
  using Strings for uint256;

  struct CollabConfig{
    uint64 ethPrice;
    uint8 maxFree;
    uint8 maxSupply;
    bool isEnabled;
    bool useTokenId;
  }

  bool public isBurnEnabled = false;
  uint256 public burnToMintQty = 0;
  string public tokenURIPrefix;
  string public tokenURISuffix;

  bool public IS_OS_ENABLED = true;
  bool public IS_PAUSED = true;
  uint16 public MAX_SUPPLY = 10000;

  mapping(address => CollabConfig) public collabs;


  modifier onlyAllowedOperator(address from) override {
    if (IS_OS_ENABLED && from != msg.sender) {
      _checkFilterOperator(msg.sender);
    }
    _;
  }

  modifier onlyAllowedOperatorApproval(address operator) override {
    if(IS_OS_ENABLED){
      _checkFilterOperator(operator);
    }
    _;
  }


  constructor()
    OperatorFilterer(0x3cc6CddA760b79bAfa08dF41ECFA224f810dCeB6, true)
    Royalties(msg.sender, 5, 100)
    ERC721F("Untamed Degens", "UDEGENS")
  {
    // GA
    collabs[address(0)] = CollabConfig(
      0.019 ether,
      0,
      1,
      true,
      false
    );
  }

  receive() external payable {}

  function withdraw() external onlyOwner {
    uint256 totalBalance = address(this).balance;
    require(totalBalance > 0, "No funds available");
    Address.sendValue(payable(owner()), totalBalance);
  }


  // payable - payable
  function collabMint(address collection, uint16 quantity, uint256 checkTokenId) external payable {
    require(!IS_PAUSED, "Sale is paused");
    require(totalSupply() + quantity < MAX_SUPPLY, "Mint/Order exceeds supply");
    
    CollabConfig memory collab = collabs[collection];
    require(collab.isEnabled, "Community mint is disabled");
    require(collab.maxSupply >= _numberMinted(msg.sender) + quantity, "Mint limit reached");

    bool isAllowed = collab.useTokenId ?
      IERC721(collection).ownerOf(checkTokenId) == msg.sender :
      IERC721(collection).balanceOf(msg.sender) > 0;
    require(isAllowed, "Wallet not authorized");

    ( , , uint256 totalValue) = calculateQuantities(collection, msg.sender, quantity);
    require(msg.value == totalValue, "Ether sent is not correct");

    _mint(msg.sender, quantity);
  }

  function mint(uint256 quantity) external payable {
    require(!IS_PAUSED, "Sale is paused");
    require(totalSupply() + quantity < MAX_SUPPLY, "Mint/Order exceeds supply");

    CollabConfig memory collab = collabs[address(0)];
    require(collab.isEnabled, "Public sale is closed");
    require(collab.maxSupply >= _numberMinted(msg.sender) + quantity, "Mint limit reached");

    ( , , uint256 totalValue) = calculateQuantities(address(0), msg.sender, uint16(quantity));
    require(msg.value == totalValue, "Ether sent is not correct");

    _mint(msg.sender, quantity);
  }

  function burn(uint256[] calldata tokenIds) external {
    require(isBurnEnabled, "burn is disabled");

    for(uint256 i = 0; i < tokenIds.length; ++i){
      _burn(tokenIds[i], true);
    }
  }

  function burnToMint(uint256[] calldata tokenIds) external {
    require(burnToMintQty > 0, "burnToMint is disabled");
    require(tokenIds.length > 0 && tokenIds.length % burnToMintQty == 0, "not a multiple");

    uint256 mintQty = tokenIds.length / burnToMintQty;
    require(totalSupply() + mintQty < MAX_SUPPLY, "mint/Order exceeds supply");

    for(uint256 i = 0; i < tokenIds.length; ++i){
      _burn(tokenIds[i], true);
    }

    _mint(msg.sender, mintQty);
  }


  // payable - onlyDelegates
  function burnFrom(uint16[] calldata tokenIds, address account) external payable onlyDelegates{
    if(!isApprovedForAll(account, address(this)))
      revert TransferCallerNotOwnerNorApproved();

    for(uint256 i = 0; i < tokenIds.length; ++i){
      require(ownerOf(tokenIds[i]) == account, "Owner mismatch");
      _burn(tokenIds[i]);
    }
  }

  function mintTo(uint16[] calldata quantities, address[] calldata recipients) external payable onlyDelegates{
    require(quantities.length == recipients.length, "Uneven request");

    uint16 quantity;
    address recipient;
    uint256 supply = totalSupply();
    for(uint256 i = 0; i < quantities.length; ++i){
      quantity = quantities[i];
      require(supply + quantity < MAX_SUPPLY, "Mint/Order exceeds supply");

      recipient = recipients[i];
      _mint(recipient, quantity);
      _packedAddressData[recipient].numberMinted -= quantity;
    }
  }


  // nonpayable - onlyDelegates
  function setBurnConfig(bool isBurnEnabled_, uint256 burnToMintQty_) external onlyDelegates {
    isBurnEnabled = isBurnEnabled_;
    burnToMintQty = burnToMintQty_;
  }

  function setCollab(address collection, CollabConfig calldata config) public onlyDelegates {
    collabs[collection] = config;
  }

  function setCollabs(address[] calldata collections, CollabConfig[] calldata configs) external onlyDelegates{
    for(uint256 i = 0; i < collections.length; ++i){
      setCollab(collections[i], configs[i]);
    }
  }

  function setMaxSupply(uint16 maxSupply) external onlyDelegates{
    MAX_SUPPLY = maxSupply;
  }

  function setOsStatus(bool isEnabled) external onlyDelegates{
    IS_OS_ENABLED = isEnabled;
  }

  function setPaused(bool isPaused) external onlyDelegates{
    IS_PAUSED = isPaused;
  }

  function setTokenURI( string calldata prefix, string calldata suffix ) external onlyDelegates{
    tokenURIPrefix = prefix;
    tokenURISuffix = suffix;
  }


  //nonpayable - onlyOwner
  function setDefaultRoyalty( address receiver, uint16 feeNumerator, uint16 feeDenominator ) external onlyOwner {
    _setDefaultRoyalty( receiver, feeNumerator, feeDenominator );
  }


  // view
  function calculateQuantities(address collection, address account, uint16 quantity) public view returns(uint16, uint16, uint256){
    CollabConfig memory collab = collabs[collection];

    uint16 free = 0;
    uint16 paid = quantity;
    uint16 minted = uint16(_numberMinted(account));
    if(collab.maxFree >= minted){
      free = collab.maxFree - minted;
      if(quantity > free){
        paid = quantity - free;
      }
      else{
        free = quantity;
        paid = 0;
      }
    }

    uint256 totalValue = collab.ethPrice * paid;
    return (free, paid, totalValue);
  }


  //view - IERC721Metadata
  function tokenURI( uint256 tokenId ) public view override(IERC721F, ERC721F) returns( string memory ){
    require(_exists(tokenId), "Genesis: query for nonexistent token");
    return string(abi.encodePacked(tokenURIPrefix, tokenId.toString(), tokenURISuffix));
  }


  // view - override
  function supportsInterface(bytes4 interfaceId) public view override(IERC721F, ERC721F, Royalties) returns(bool) {
    return ERC721F.supportsInterface(interfaceId)
      || Royalties.supportsInterface(interfaceId);
  }


  //OS overrides
  function approve(address operator, uint256 tokenId)
    public
    payable
    override(IERC721F, ERC721F)
    onlyAllowedOperatorApproval(operator)
  {
    super.approve(operator, tokenId);
  }

  function setApprovalForAll(address operator, bool approved)
    public
    override(IERC721F, ERC721F)
    onlyAllowedOperatorApproval(operator)
  {
    super.setApprovalForAll(operator, approved);
  }

  function safeTransferFrom(address from, address to, uint256 tokenId)
    public
    payable
    override(IERC721F, ERC721F) onlyAllowedOperator(from)
  {
    super.safeTransferFrom(from, to, tokenId);
  }

  function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data)
    public
    payable
    override(IERC721F, ERC721F)
    onlyAllowedOperator(from)
  {
    super.safeTransferFrom(from, to, tokenId, data);
  }

  function transferFrom(address from, address to, uint256 tokenId)
    public
    payable
    override(IERC721F, ERC721F)
    onlyAllowedOperator(from)
  {
    super.transferFrom(from, to, tokenId);
  }
}