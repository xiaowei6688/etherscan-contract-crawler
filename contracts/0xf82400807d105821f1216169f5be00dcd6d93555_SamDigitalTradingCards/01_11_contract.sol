// SPDX-License-Identifier: MIT
// Developer - ReservedSnow(https://linktr.ee/reservedsnow)

import 'operator-filter-registry/src/DefaultOperatorFilterer.sol';
import '@openzeppelin/contracts/security/ReentrancyGuard.sol';
import '@openzeppelin/contracts/access/Ownable.sol';
import '@openzeppelin/contracts/utils/Strings.sol';
import 'erc721a/contracts/ERC721A.sol';


pragma solidity >=0.8.17 <0.9.0;

contract SamDigitalTradingCards is ERC721A, Ownable, ReentrancyGuard, DefaultOperatorFilterer {

  using Strings for uint256;

// ================== Variables Start =======================

  
  string internal uri;
  string public uriSuffix = ".json";
  string public hiddenMetadataUri;
  uint256 public price = 0.001 ether;
  uint256 public supplyLimit = 5000;
  uint256 public maxMintAmountPerTx = 20;
  bool public publicSale = false;
  bool public revealed = false;
  mapping(address => uint256) public publicMintCount;
  uint256 public publicMinted;

// ================== Variables End =======================  

// ================== Constructor Start =======================

  constructor(
    string memory _uri
  ) ERC721A("Sam Digital Trading Cards", "SDTC")  {
    seturi(_uri);
    _safeMint(_msgSender(), 1);
  }

// ================== Constructor End =======================

// ================== Mint Functions Start =======================

  function PublicMint(uint256 _mintAmount) public payable {
    
    // Normal requirements 
    require(publicSale, 'The PublicSale is paused!');
    require(_mintAmount > 0 && _mintAmount <= maxMintAmountPerTx, 'Invalid mint amount!');
    require(totalSupply() + _mintAmount <= supplyLimit, 'Max supply exceeded!');
    require(msg.value >= price * _mintAmount, 'Insufficient funds!');
     
    // Mint
     _safeMint(_msgSender(), _mintAmount);

    // Mapping update 
    publicMintCount[msg.sender] += _mintAmount;  
    publicMinted += _mintAmount;   
  }  

  function OwnerMint(uint256 _mintAmount, address _receiver) public onlyOwner {
    require(totalSupply() + _mintAmount <= supplyLimit, 'Max supply exceeded!');
    _safeMint(_receiver, _mintAmount);
  }

    function MassAirdrop(address[] calldata receivers) external onlyOwner {
    for (uint256 i; i < receivers.length; ++i) {
      require(totalSupply() + 1 <= supplyLimit, 'Max supply exceeded!');
      _mint(receivers[i], 1);
    }
  }
  

// ================== Mint Functions End =======================  

// ================== Set Functions Start =======================

// reveal
  function setRevealed(bool _state) public onlyOwner {
    revealed = _state;
  }

// uri
  function seturi(string memory _uri) public onlyOwner {
    uri = _uri;
  }

  function setUriSuffix(string memory _uriSuffix) public onlyOwner {
    uriSuffix = _uriSuffix;
  }

  function setHiddenMetadataUri(string memory _hiddenMetadataUri) public onlyOwner {
    hiddenMetadataUri = _hiddenMetadataUri;
  }

// sales toggle
  function setpublicSale(bool _publicSale) public onlyOwner {
    publicSale = _publicSale;
  }

// max per tx
  function setMaxMintAmountPerTx(uint256 _maxMintAmountPerTx) public onlyOwner {
    maxMintAmountPerTx = _maxMintAmountPerTx;
  }


// price
  function setPrice(uint256 _price) public onlyOwner {
    price = _price;
  }


// supply limit
  function setsupplyLimit(uint256 _supplyLimit) public onlyOwner {
    supplyLimit = _supplyLimit;
  }

// ================== Set Functions End =======================

// ================== Withdraw Function Start =======================
  
  function withdraw() public onlyOwner nonReentrant {
        uint _balance = address(this).balance;
        payable(0x1ebF23dEEfc912921449155601b6eAdB383eD0b8).transfer(_balance * 50 / 100); 
        payable(0xF6aDB42CEF866C7239EbC8f3C3B0FafAF38caa12).transfer(_balance * 50 / 100);
         (bool os, ) = payable(owner()).call{value: address(this).balance}("");
        require(os);
  }

// ================== Withdraw Function End=======================  

// ================== Read Functions Start =======================

  function tokensOfOwner(address owner) external view returns (uint256[] memory) {
    unchecked {
        uint256[] memory a = new uint256[](balanceOf(owner)); 
        uint256 end = _nextTokenId();
        uint256 tokenIdsIdx;
        address currOwnershipAddr;
        for (uint256 i; i < end; i++) {
            TokenOwnership memory ownership = _ownershipAt(i);
            if (ownership.burned) {
                continue;
            }
            if (ownership.addr != address(0)) {
                currOwnershipAddr = ownership.addr;
            }
            if (currOwnershipAddr == owner) {
                a[tokenIdsIdx++] = i;
            }
        }
        return a;    
    }
}

  function _startTokenId() internal view virtual override returns (uint256) {
    return 1;
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

  function _baseURI() internal view virtual override returns (string memory) {
    return uri;
  }

  function transferFrom(address from, address to, uint256 tokenId) public payable override onlyAllowedOperator(from) {
    super.transferFrom(from, to, tokenId);
  }

  function safeTransferFrom(address from, address to, uint256 tokenId) public payable override onlyAllowedOperator(from) {
    super.safeTransferFrom(from, to, tokenId);
  }

  function safeTransferFrom(address from, address to, uint256 tokenId, bytes memory data) public payable override onlyAllowedOperator(from) {
    super.safeTransferFrom(from, to, tokenId, data);
  }  

    event ethReceived(address, uint);
    receive() external payable {
        emit ethReceived(msg.sender, msg.value);
    } 

// ================== Read Functions End =======================  

// Developer - ReservedSnow(https://linktr.ee/reservedsnow)
}