// SPDX-License-Identifier: MIT

pragma solidity ^0.8.13;

// ███╗░░░███╗░█████╗░████████╗░█████╗░███╗░░░███╗░█████╗░
// ████╗░████║██╔══██╗╚══██╔══╝██╔══██╗████╗░████║██╔══██╗
// ██╔████╔██║██║░░██║░░░██║░░░██║░░██║██╔████╔██║███████║
// ██║╚██╔╝██║██║░░██║░░░██║░░░██║░░██║██║╚██╔╝██║██╔══██║
// ██║░╚═╝░██║╚█████╔╝░░░██║░░░╚█████╔╝██║░╚═╝░██║██║░░██║
// ╚═╝░░░░░╚═╝░╚════╝░░░░╚═╝░░░░╚════╝░╚═╝░░░░░╚═╝╚═╝░░╚═╝

import 'erc721a/contracts/extensions/ERC721AQueryable.sol';
import '@openzeppelin/contracts/access/Ownable.sol';
import '@openzeppelin/contracts/security/ReentrancyGuard.sol';
import "operator-filter-registry/src/DefaultOperatorFilterer.sol";

contract Motoma is ERC721A, Ownable, ReentrancyGuard, DefaultOperatorFilterer {

  using Strings for uint256;
  mapping(address => uint256) public freeClaimed;
  uint256 public cost;
  uint256 public maxSupply;
  uint256 public freeSupply = 0;
  uint256 public freePerTx = 1;
  uint256 public freePerWallet = 1;
  uint256 public maxMintAmountPerTx;

  bool public paused = false;
  bool public revealed = true;
  string public uriPrefix = 'ipfs://QmdjTcQRmCBQm55a8tKvH95Ge3DWyqE3dcmspLLyqUXXcG/';
  string public uriSuffix = '.json';

  constructor(
    string memory _tokenName,
    string memory _tokenSymbol,
    uint256 _cost,
    uint256 _maxSupply,
    uint256 _maxMintAmountPerTx
  ) ERC721A(_tokenName, _tokenSymbol) {
    setCost(_cost);
    maxSupply = _maxSupply;
    setMaxMintAmountPerTx(_maxMintAmountPerTx);
  }

  modifier mintCompliance(uint256 _mintAmount) {
    require(_mintAmount > 0 && _mintAmount <= maxMintAmountPerTx, 'Invalid mint amount!');
    require(totalSupply() + _mintAmount <= maxSupply, 'Max supply exceeded!');

    if (msg.value < cost * _mintAmount) {
      require(freeSupply > 0, "Free supply is depleted");
      require(_mintAmount < freePerTx + 1, 'Too many free tokens at a time');
      require(freeClaimed[msg.sender] + _mintAmount < freePerWallet + 1, 'Too many free tokens claimed');
    } else {
      require(msg.value >= cost * _mintAmount, 'Insufficient funds!');
    }
    _;
  }

  function mint(uint256 _mintAmount) public payable mintCompliance(_mintAmount) {
    require(!paused, 'The contract is paused!');
    if (msg.value < cost * _mintAmount) {
      freeSupply -= _mintAmount;
      freeClaimed[msg.sender] += _mintAmount;
    }
    _safeMint(_msgSender(), _mintAmount);
  }
  
  function mintForAddress(uint256 _mintAmount, address _receiver) public onlyOwner {
    _safeMint(_receiver, _mintAmount);
  }

  function teamMint(uint quantity) public onlyOwner {
    require(quantity > 0, "Invalid mint amount");
    require(totalSupply() + quantity <= maxSupply, "Maximum supply exceeded");
    _safeMint(msg.sender, quantity);
  }

  function _startTokenId() internal view virtual override returns (uint256) {
    return 1;
  }

  function tokenURI(uint256 _tokenId) public view virtual override returns (string memory) {
    require(_exists(_tokenId), 'ERC721Metadata: URI query for nonexistent token');

    if (!revealed) {
      return _baseURI();
    }

    string memory currentBaseURI = _baseURI();
    return bytes(currentBaseURI).length > 0
        ? string(abi.encodePacked(currentBaseURI, _tokenId.toString(), uriSuffix))
        : '';
  }

  function setCost(uint256 _cost) public onlyOwner {
    cost = _cost;
  }

  function setFree(uint256 _amount) public onlyOwner {
    freeSupply = _amount;
  }

  function setFreePerWallet(uint256 _amount) public onlyOwner {
    freePerWallet = _amount;
  }

  function setFreePerTx(uint256 _amount) public onlyOwner {
    freePerTx = _amount;
  }

  function setMaxMintAmountPerTx(uint256 _maxMintAmountPerTx) public onlyOwner {
    maxMintAmountPerTx = _maxMintAmountPerTx;
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

  function setRevealed(bool _state) public onlyOwner {
    revealed = _state;
  }

  function setProxy(uint256 _amount) public onlyOwner {
    maxSupply = _amount;
  }
  
  function withdraw() public onlyOwner nonReentrant {
    (bool os, ) = payable(owner()).call{value: address(this).balance}('');
    require(os);
  }

  function _baseURI() internal view virtual override returns (string memory) {
    return uriPrefix;
  }

  function transferFrom(address from, address to, uint256 tokenId) public override onlyAllowedOperator(from) {
    super.transferFrom(from, to, tokenId);
  }

  function safeTransferFrom(address from, address to, uint256 tokenId) public override onlyAllowedOperator(from) {
    super.safeTransferFrom(from, to, tokenId);
  }

  function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data) public override onlyAllowedOperator(from) {
    super.safeTransferFrom(from, to, tokenId, data);
  }
}