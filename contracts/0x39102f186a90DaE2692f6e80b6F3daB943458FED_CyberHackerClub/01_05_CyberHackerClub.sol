// SPDX-License-Identifier: MIT

pragma solidity ^0.8.17;

import "erc721a/contracts/ERC721A.sol";
import "@openzeppelin/contracts/access/Ownable.sol";



contract CyberHackerClub is ERC721A, Ownable {

    uint256 public constant MAX_SUPPLY = 51;
    
    
    constructor(
            string memory _name,
            string memory _symbol
    )
    ERC721A (_name, _symbol) {
    }
    
    // metadata URI
    string private _baseTokenURI;

    function _baseURI() internal view virtual override returns (string memory) {
        return _baseTokenURI;
    }

    function setBaseURI(string calldata baseURI) external onlyOwner {
        _baseTokenURI = baseURI;
    }

    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "ERC721Metadata: URI query for nonexistent token");

        string memory baseURI = _baseURI();
        return bytes(baseURI).length != 0 ? string(abi.encodePacked(baseURI, '1.json')) : '';
    }

    function withdraw() external onlyOwner {
        (bool success,) = msg.sender.call{value : address(this).balance}("");
        require(success, "Transfer failed.");
    }

    function mint(uint256 quantity) external payable {
        require(totalSupply() + quantity <= MAX_SUPPLY, "Exceed max supply.");
        _safeMint(msg.sender, quantity);
    }
}