/* 
  _____                     _ _              _     ___              
  \_   \_ __  ___  ___ _ __(_) |__   ___  __| |   /___\_ __ ___ ___ 
   / /\/ '_ \/ __|/ __| '__| | '_ \ / _ \/ _` |  //  // '__/ __/ __|
/\/ /_ | | | \__ \ (__| |  | | |_) |  __/ (_| | / \_//| | | (__\__ \
\____/ |_| |_|___/\___|_|  |_|_.__/ \___|\__,_| \___/ |_|  \___|___/
                                                               */      
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "./ERC721A.sol";
import "./Ownable.sol";

contract InscribedOrcs is ERC721A, Ownable {
    using Strings for uint256;
    uint256 public maxSupply = 400;
    uint256 public cost = 0.0069 ether;
    uint256 public maxPerWallet = 5;
    uint256 public maxFreePerWallet = 0;
    uint256 public maxMintAmountPerTx = 5;
    string public baseURI;
    bool public paused = true;
    
    constructor(
        string memory _tokenName,
        string memory _tokenSymbol
    ) ERC721A(_tokenName, _tokenSymbol) {}

    modifier mintCompliance(uint256 quantity) {
        require(quantity > 0 && quantity <= maxMintAmountPerTx, "Invalid mint amount!");
        require(_numberMinted(msg.sender) + quantity <= maxPerWallet, "Max per wallet mint exceeded");
        require(totalSupply() + quantity < maxSupply + 1, "Max supply exceeded");
        _;
    }

    modifier mintPriceCompliance(uint256 quantity) {
        uint256 realCost = 0;
        if (_numberMinted(msg.sender) < maxFreePerWallet) {
            uint256 freeMintsLeft = maxFreePerWallet - _numberMinted(msg.sender);
            // 0 or 1
            realCost = cost * freeMintsLeft;
        }
        require(msg.value >= cost * quantity - realCost, "Please send the exact amount.");
        _;
    }

    function publicMint(uint256 quantity) external payable mintCompliance(quantity) mintPriceCompliance(quantity) {
        require(!paused, "The contract is paused!");
        _safeMint(msg.sender, quantity);
    }

    function ownerMint(uint256 quantity)
        public
        payable
        mintCompliance(quantity)
        onlyOwner
    {
        _safeMint(_msgSender(), quantity);
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return baseURI;
    }

    function tokenURI(uint256 tokenId)
        public
        view
        virtual
        override
        returns (string memory)
    {
        require(
            _exists(tokenId),
            "ERC721Metadata: URI query for nonexistent token"
        );
        return string(abi.encodePacked(baseURI, tokenId.toString(), ".json"));
    }

    function setBaseURI(string memory uri) public onlyOwner {
        baseURI = uri;
    }

    function setMaxFreePerWallet(uint256 _amount) external onlyOwner {
        maxFreePerWallet = _amount;
    }

    function setMaxSupply(uint256 _maxSupply) public onlyOwner {
        maxSupply = _maxSupply;
    }

    function setPaused(bool _state) public onlyOwner {
        paused = _state;
    }

    function withdraw() external onlyOwner {
        (bool success, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(success, "Transfer failed.");
    }
}