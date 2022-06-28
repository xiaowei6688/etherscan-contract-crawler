//SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.0;

import "erc721a/contracts/ERC721A.sol";
import "erc721a/contracts/extensions/ERC721AQueryable.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";

contract EthGamesEntry is ERC721A, ERC721AQueryable, Ownable {
    using SafeMath for uint256;
    using Strings for uint256;

    struct Drop {
        address to;
        uint256 amount;
    }

    address public constant DEV_ADDRESS = 0xC61d067E2239496996ADa99Ea878f7b8c5f383Db;

    uint256 public maxTokenSupply;
    string public baseTokenURI;
    bytes32 public merkleRoot;
    bool public saleEnabled;
    bool public whitelistEnabled;
    uint256 public currentPrice;
    uint256 public currentMaxSale;
    uint256 public maxMintPerTx;
    uint256 public maxMintPerWallet;
    mapping(address => uint256) public mintCount;
    mapping(address => bool) private presaleListClaimed;

    constructor(string memory baseURI) ERC721A("EthGames Season 0", "EGXS0") {
        setBaseURI(baseURI);
        saleEnabled = false;
        whitelistEnabled = true;
        currentPrice = 0.015 ether;
        currentMaxSale = 1500;
        maxTokenSupply = 1500;
        maxMintPerTx = 3;
        maxMintPerWallet = 3;
    }

    function _startTokenId() internal view virtual override returns (uint256) {
        return 1;
    }

    modifier saleIsOpen() {
        require(totalSupply() <= maxTokenSupply, "EthGamesEntry: Sale ended");
        _;
    }

    function mint(
        uint256 _count,
        uint256 _presaleMaxAmount,
        bytes32[] calldata _merkleProof
    ) public payable saleIsOpen {
        uint256 total = totalSupply();
        require(total <= maxTokenSupply, "EthGamesEntry: Max limit");
        require(total + _count <= maxTokenSupply, "EthGamesEntry: Max limit");
        require(total + _count <= currentMaxSale, "EthGamesEntry: Max sale limit");
        require(mintCount[msg.sender] + _count <= maxMintPerWallet, "EthGamesEntry: Max wallet limit");
        require(_count <= maxMintPerTx, "EthGamesEntry: Max mint for tx limit");
        require(saleEnabled, "EthGamesEntry: Sale is not active");
        require(msg.value >= getPrice(_count), "EthGamesEntry: Value below price");

        if (whitelistEnabled == true) {
            require(merkleRoot != 0x0, "EthGamesEntry: merkle root not set");

            // Verify if the account has already claimed
            require(
                !isPresaleListClaimed(msg.sender),
                "EthGamesEntry: account already claimed"
            );

            // Verify we cannot claim more than the max amount
            require(
                _count <= _presaleMaxAmount,
                "EthGamesEntry: can only claim less than or equal to the max amount"
            );

            // Verify the merkle proof.
            require(
                validClaim(msg.sender, _presaleMaxAmount, _merkleProof),
                "EthGamesEntry: invalid proof"
            );

            presaleListClaimed[msg.sender] = true;
        }

        _mintElements(msg.sender, _count, true);
    }

    // @dev start of public/external views
    function isPresaleListClaimed(address account) public view returns (bool) {
        return presaleListClaimed[account];
    }

    function validClaim(
        address claimer,
        uint256 maxAmount,
        bytes32[] calldata merkleProof
    ) public view returns (bool) {
        bytes32 node = keccak256(abi.encodePacked(claimer, maxAmount.toString()));
        return MerkleProof.verify(merkleProof, merkleRoot, node);
    }

    function getPrice(uint256 _count) public view returns (uint256) {
        return currentPrice.mul(_count);
    }

    function saleActive() external view returns (bool) {
        return saleEnabled;
    }
    // @dev end of public/external views

    // @dev start of internal/private functions
    function _mintElements(address _to, uint256 _amount, bool increaseCount) private {
        if(increaseCount) {
            mintCount[_to] = mintCount[_to] + _amount;
        }
        _safeMint(_to, _amount);
        require(totalSupply() <= maxTokenSupply, "EthGamesEntry: Limit reached");
    }

    function _baseURI() internal view virtual override returns (string memory) {
        return baseTokenURI;
    }

    function _payout(address _address, uint256 _amount) private {
        (bool success, ) = _address.call{value: _amount}("");
        require(success, "EthGamesEntry: Transfer failed");
    }
    // @dev end of internal/private functions

    // @dev start of airdrop functions
    function airdrop(Drop[] calldata drops) public onlyOwner {
        for (uint i = 0; i < drops.length; i++) {
            Drop calldata drop = drops[i];
            _mintElements(drop.to, drop.amount, false);
        }
    }
    // @dev end of airdrop functions

    // @dev start of only owner functions
    function mintReserve(uint256 _count, address _to) public onlyOwner {
        uint256 total = totalSupply();
        require(total <= maxTokenSupply, "EthGamesEntry: Sale ended");
        require(total + _count <= maxTokenSupply, "EthGamesEntry: Max limit");
        _mintElements(_to, _count, false);
    }

    function setMaxSale(uint256 currentMaxSale_) external onlyOwner {
        currentMaxSale = currentMaxSale_;
    }

    function setMaxTokenSupply(uint256 maxTokenSupply_) external onlyOwner {
        maxTokenSupply = maxTokenSupply_;
    }

    function setPrice(uint256 priceInWei) external onlyOwner {
        currentPrice = priceInWei;
    }

    function setMaxMintPerWallet(uint256 maxMintPerWallet_) external onlyOwner {
        maxMintPerWallet = maxMintPerWallet_;
    }

    function setMaxMintPerTx(uint256 maxMintPerTx_) external onlyOwner {
        maxMintPerTx = maxMintPerTx_;
    }

    function setBaseURI(string memory baseURI) public onlyOwner {
        baseTokenURI = baseURI;
    }

    function setMerkleRoot(bytes32 _merkleRoot) public onlyOwner {
        merkleRoot = _merkleRoot;
    }

    function toggleSale() public onlyOwner {
        saleEnabled = !saleEnabled;
    }

    function toggleWhitelist() public onlyOwner {
        whitelistEnabled = !whitelistEnabled;
    }

    function withdrawAll() public payable onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "EthGamesEntry: Balance should be above 0");
        _payout(DEV_ADDRESS, address(this).balance);
    }
    // @dev end of only owner functions
}