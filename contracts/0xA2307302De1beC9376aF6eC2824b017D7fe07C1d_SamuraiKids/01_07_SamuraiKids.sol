// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "erc721a/contracts/ERC721A.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract SamuraiKids is ERC721A, Ownable {
    using Strings for uint256;

    uint256 public MAX_SUPPLY = 333;
    uint256 public SALE_PRICE = .0069 ether;
    uint256 public MAX_MINT = 2;
    bool public mintStarted = false;
    string public baseURI = "ipfs://QmT3smAz6jkJzfbBpwKJ5pN2bDSan2adBCJwfNMcKnySqa/";
    mapping(address => uint256) public walletMintCount;
    address reserveWallet = 0x40e078dAd9259e864E79AfB64b55eE54143118b8;

    constructor() ERC721A("Samurai Kids by Roselia", "SK") {}

    function mint(uint256 _quantity) external payable {
        require(mintStarted, "Mint hasn't started yet.");
        require(
            (totalSupply() + _quantity) <= MAX_SUPPLY,
            "Max supply exceeded."
        );
        require(
            (walletMintCount[msg.sender] + _quantity) <= MAX_MINT,
            "Max mint exceeded"
        );
        require(
            msg.value >= (SALE_PRICE * _quantity),
            "Wrong mint price."
        );

        walletMintCount[msg.sender] += _quantity;
        _safeMint(msg.sender, _quantity);
    }

    function reserveMint(uint256 mintAmount) external onlyOwner {
        _safeMint(reserveWallet, mintAmount);
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

    function _baseURI() internal view virtual override returns (string memory) {
        return baseURI;
    }

    function _startTokenId() internal view virtual override returns (uint256) {
        return 1;
    }

    function setBaseURI(string memory uri) public onlyOwner {
        baseURI = uri;
    }

    function startSale() external onlyOwner {
        mintStarted = !mintStarted;
    }

    function setPrice(uint256 _newPrice) external onlyOwner {
        SALE_PRICE = _newPrice;
    }

    function withdraw() external onlyOwner {
        (bool success, ) = payable(msg.sender).call{
            value: address(this).balance
        }("");
        require(success, "Transfer failed.");
    }
}