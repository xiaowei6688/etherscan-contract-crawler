// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/token/ERC721/ERC721.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";

contract NiftyHeroes is ERC721URIStorage, Ownable {

    using SafeMath for uint256;

    uint256 public maxNft = 8000;
    uint256 public totalSupply = 0;
    uint256[] private _iqdaxPrice = [0.1 ether, 0.2 ether, 0.5 ether];
    bool public saleIsActive = true;
    bool public whitelistStatus = true;
    address public devAddress = 0xbC9316F0a53Cc817C8AAb51eaAbC477836B9C854;
    constructor() ERC721("Nifty Heroes: Mission Moon", "NHMM") {}


    function newDevAddress(address _new) external onlyOwner {
        devAddress = _new;
    }

    function newMax(uint256 _max) external onlyOwner {
        maxNft = _max;
    }
    function updateWhitelistStatus() external onlyOwner {
        whitelistStatus = !whitelistStatus;
    }

    function addToWhitelist(address _address) external onlyOwner {
            whitelist[_address] = true;
    }

    function removeToWhitelist(address _address) external onlyOwner {
        whitelist[_address] = false;
    }

    mapping(address => bool) public whitelist;

    function setPrice(uint256[] memory _newPrice) external onlyOwner() {
        _iqdaxPrice = _newPrice;
    }

    function getPrice(uint256 tokenId) public view returns (uint256) {
        if(tokenId < 8000) {
            return _iqdaxPrice[0];
        } else if(tokenId > 8000 && tokenId < 16000) {
            return _iqdaxPrice[1];
        } else if(tokenId > 16000 && tokenId < 20000) {
            return _iqdaxPrice[2];
        }
        return _iqdaxPrice[2];
    }

    function mint(uint tokenId) external payable {
        require(saleIsActive, "Sale must be active");
        require(totalSupply + 1 <= maxNft, "Max supply");
        require(getPrice(tokenId) <= msg.value, "Ether value sent is not correct");
        if(whitelistStatus) {
            require(whitelist[msg.sender], "NotIiWhiteList");
        }

        string memory url = string(abi.encodePacked(
                "https://web3bot.iqdax.io/images/",
                Strings.toString(tokenId),
                ".json"
            ));
        _safeMint(msg.sender, tokenId);
        _setTokenURI(tokenId, url);
        totalSupply += 1;
        payable(devAddress).transfer(msg.value);
    }

    function saleState() external onlyOwner {
        saleIsActive = !saleIsActive;
    }
}