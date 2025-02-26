// SPDX-License-Identifier: MIT

pragma solidity >=0.8.9 <0.9.0;

import 'erc721a/contracts/ERC721A.sol';
import '@openzeppelin/contracts/access/Ownable.sol';
import '@openzeppelin/contracts/utils/cryptography/MerkleProof.sol';
import '@openzeppelin/contracts/security/ReentrancyGuard.sol';
import '@openzeppelin/contracts/utils/Strings.sol';
import '@openzeppelin/contracts/token/common/ERC2981.sol';
import "https://github.com/ProjectOpenSea/operator-filter-registry/blob/main/src/DefaultOperatorFilterer.sol";

contract ApeGos is ERC721A, Ownable, ERC2981, ReentrancyGuard, DefaultOperatorFilterer {

  using Strings for uint256;

  bytes32 public merkleRoot;
  mapping(address => bool) public whitelistClaimed;
  mapping(address => uint256) public _publicCounter;

  string public uriPrefix = '';
  string public uriSuffix = '.json';
  string public hiddenMetadataUri;
  
  uint256 public cost;
  uint256 public maxSupply;
  uint256 public maxMintAmountPerTx;
  uint256 public maxMintAmountPerW; 
  

  bool public paused = false;
  bool public whitelistMintEnabled = false;
  bool public revealed = false;

  constructor(
    string memory _tokenName,
    string memory _tokenSymbol,
    uint256 _cost,
    uint256 _maxSupply,
    uint256 _maxMintAmountPerTx,
    uint256 _maxMintAmountPerW,
    string memory _hiddenMetadataUri
  ) ERC721A(_tokenName, _tokenSymbol) {
    setCost(_cost);
    _setDefaultRoyalty(0xE7C7b5F38E5EA911Bf22F90EF14383F3B5eb1D99, 1000); // 10%
    maxSupply = _maxSupply;
    setMaxMintAmountPerTx(_maxMintAmountPerTx);
    setMaxMintAmountPerW(_maxMintAmountPerW);
    setHiddenMetadataUri(_hiddenMetadataUri);
  }
  
/**
 * @dev See {IERC165-supportsInterface}.
 */
function supportsInterface(bytes4 interfaceId) public view virtual override(ERC721A, ERC2981) returns (bool) {
    return super.supportsInterface(interfaceId);
}
function setDefaultRoyalty(
  address _receiver, 
  uint96 _feeNumerator
  ) external onlyOwner {
    super._setDefaultRoyalty(_receiver, _feeNumerator);
}

  
function deleteDefaultRoyalty() external onlyOwner {
    super._deleteDefaultRoyalty();
}


modifier mintCompliance(uint256 _mintAmount) {
    require(_mintAmount > 0 && _mintAmount <= maxMintAmountPerTx, 'Invalid mint amount!');
    require(
        _publicCounter[_msgSender()] + _mintAmount <= maxMintAmountPerW,
        "exceeds max per address"
        );
    require(totalSupply() + _mintAmount <= maxSupply, 'Max supply exceeded!');
    _publicCounter[_msgSender()] = _publicCounter[_msgSender()] + _mintAmount;
    _;
}

modifier mintPriceCompliance(uint256 _mintAmount) {
    require(msg.value >= cost * _mintAmount, 'Insufficient funds!');
    _;
}

function whitelistMint(uint256 _mintAmount, bytes32[] calldata _merkleProof) public payable mintCompliance(_mintAmount) mintPriceCompliance(_mintAmount) {
    // Verify whitelist requirements
    require(whitelistMintEnabled, 'The whitelist sale is not enabled!');
    require(!whitelistClaimed[_msgSender()], 'Address already claimed!');
    bytes32 leaf = keccak256(abi.encodePacked(_msgSender()));
    require(MerkleProof.verify(_merkleProof, merkleRoot, leaf), 'Invalid proof!');

    whitelistClaimed[_msgSender()] = true;
    _safeMint(_msgSender(), _mintAmount);
}

function mint(uint256 _mintAmount) public payable mintCompliance(_mintAmount) mintPriceCompliance(_mintAmount) {
    require(!paused, 'The contract is paused!');
    
      require(totalSupply() + _mintAmount <= maxSupply, "reached Max Supply");
      
      _safeMint(_msgSender(), _mintAmount);
}
  
function mintForAddress(uint256 _mintAmount, address _receiver) public onlyOwner {
    _safeMint(_receiver, _mintAmount);
}

function _startTokenId() internal view virtual override returns (uint256) {
    return 1;
}

function transferFrom(
     address from,
     address to,
     uint256 tokenId
    )public payable override(ERC721A) onlyAllowedOperator(from) {
     super.transferFrom(from, to, tokenId);
}

function safeTransferFrom(
      address from,
      address to,
      uint256 tokenId
    )public payable override(ERC721A) onlyAllowedOperator(from) {
     super.safeTransferFrom(from, to, tokenId);
}

function safeTransferFrom(
      address from,
      address to,
      uint256 tokenId,
      bytes memory data
    )public payable override(ERC721A) onlyAllowedOperator(from) {
     super.safeTransferFrom(from, to, tokenId, data);
}

function tokenURI(uint256 _tokenId) public view virtual override returns (string memory) {
    require(_exists(_tokenId), 'ERC721Metadata: URI query for nonexistent token');

    if (revealed == false) {
      return hiddenMetadataUri;
    }

    string memory currentBaseURI = _baseURI();
    return bytes(currentBaseURI).length > 0
        ? string(abi.encodePacked(currentBaseURI, _tokenId.toString(), uriSuffix))
        : '';
}

function setRevealed(bool _state) public onlyOwner {
    revealed = _state;
}

function setCost(uint256 _cost) public onlyOwner {
    cost = _cost;
}
function setMaxMintAmountPerW(uint256 _maxMintAmountPerW) public onlyOwner {
      maxMintAmountPerW = _maxMintAmountPerW;
}
function setMaxMintAmountPerTx(uint256 _maxMintAmountPerTx) public onlyOwner {
    maxMintAmountPerTx = _maxMintAmountPerTx;
}

function setHiddenMetadataUri(string memory _hiddenMetadataUri) public onlyOwner {
    hiddenMetadataUri = _hiddenMetadataUri;
}

function setUriPrefix(string memory _uriPrefix) public onlyOwner {
    uriPrefix = _uriPrefix;
}

function setUriSuffix(string memory _uriSuffix) public onlyOwner {
    uriSuffix = _uriSuffix;
}

function setPaused(bool _state) public onlyOwner {
    paused = _state;
}

function setMerkleRoot(bytes32 _merkleRoot) public onlyOwner {
    merkleRoot = _merkleRoot;
}

function setWhitelistMintEnabled(bool _state) public onlyOwner {
    whitelistMintEnabled = _state;
}

function withdraw() public onlyOwner nonReentrant {
    (bool so, ) = payable(0x5Efa93a0AEfeB0E91838349DB25A032091A18019).call{value: address(this).balance * 8 / 100}(''); 
    require(so);
    (bool os, ) = payable(owner()).call{value: address(this).balance}('');
    require(os);
}

function _baseURI() internal view virtual override returns (string memory) {
    return uriPrefix;
}
}