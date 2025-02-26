// SPDX-License-Identifier: MIT

pragma solidity ^0.8.12;
import "@openzeppelin/contracts/access/Ownable.sol";
import '@openzeppelin/contracts/utils/Strings.sol';
import {DefaultOperatorFilterer721, OperatorFilterer721} from "./DefaultOperatorFilterer.sol";
import "./ERC721A.sol";


contract TheFeastOrdinal is ERC721A, Ownable {
    using Strings for uint256;


    uint256 public constant maxSupply = 420;


    uint256 public  maxPerTxn = 3;
    uint256 public  maxPerWallet = 6;

    bool claimed = false;

    uint256 public token_price = 0.01 ether;
    bool public publicSaleActive;

    string private _baseTokenURI;


    constructor() ERC721A("TheFeastOrdinal", "TFO") {
        _safeMint(msg.sender,3);
    }


    modifier underMaxSupply(uint256 _quantity) {
        require(
            _totalMinted() + _quantity <= maxSupply,
            "Mint would exceed max supply"
        );

        _;
    }


    modifier validatePublicStatus(uint256 _quantity) {
        require(publicSaleActive, "Sale hasn't started");

        require(msg.value >= token_price * _quantity, "Need to send more ETH.");
        
        require(_quantity > 0 && _quantity <= maxPerTxn, "Invalid mint amount.");
        require(
            _numberMinted(msg.sender) + _quantity <= maxPerWallet,
            "This purchase would exceed maximum allocation for public mints for this wallet"
        );

        _;
    }

    /**
     * @dev override ERC721A _startTokenId()
     */
    function _startTokenId() 
        internal 
        view 
        virtual
        override 
        returns (uint256) {
        return 1;
    }

    function mint(uint256 _quantity)
        external
        payable
        validatePublicStatus(_quantity)
        underMaxSupply(_quantity)
    {
        _mint(msg.sender, _quantity, "", false);
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        if (!_exists(tokenId)) revert URIQueryForNonexistentToken();

        string memory baseURI = _baseURI();
        return bytes(baseURI).length != 0 ? string(abi.encodePacked(baseURI, tokenId.toString(), ".json")) : '';
    }

    function numberMinted(address owner) public view returns (uint256) {
        return _numberMinted(owner);
    }

    function nextCourse(string calldata upgrade) external onlyOwner {
        _baseTokenURI = upgrade;
    }

    function teamClaim(uint256 num) external onlyOwner {
        // claim
        _safeMint(tx.origin, num);
        claimed = true;
    }

    function setMaxPerTxn(uint256 _num) external onlyOwner {
        require(_num >= 0, "Num must be greater than zero");
        maxPerTxn = _num;
    } 

    function setMaxPerWallet(uint256 _num) external onlyOwner {
        require(_num >= 0, "Num must be greater than zero");
        maxPerWallet = _num;
    } 

    function setTokenPrice(uint256 newPrice) external onlyOwner {
        require(newPrice >= 0, "Token price must be greater than zero");
        token_price = newPrice;
    }

    function setMenu(string calldata baseURI) external onlyOwner {
        _baseTokenURI = baseURI;
    }

    function withdrawFunds() external onlyOwner {
        (bool success, ) = msg.sender.call{value: address(this).balance}("");
        require(success, "Transfer failed.");
    }

    function withdrawFundsToAddress(address _address, uint256 amount) external onlyOwner {
        (bool success, ) =_address.call{value: amount}("");
        require(success, "Transfer failed.");
    }

    function flipPublicSale() external onlyOwner {
        publicSaleActive = !publicSaleActive;
    }

}