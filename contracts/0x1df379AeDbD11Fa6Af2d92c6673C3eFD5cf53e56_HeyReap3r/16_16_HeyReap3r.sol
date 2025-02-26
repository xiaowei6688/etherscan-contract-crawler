// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC721/extensions/IERC721Enumerable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/cryptography/MerkleProof.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

import "./ERC721A.sol";

contract HeyReap3r is Ownable, ReentrancyGuard, ERC721A {
    using SafeMath for uint256;

    enum Status {
        Pending,
        ReapMint,
        AllowMint,
        PublicMint,
        TeamMint,
        Finished
    }

    Status public status;

    bytes32 public reapRoot;
    bytes32 public allowRoot;

    address private vault;

    mapping(address => uint256) public mintedReapAddress;
    mapping(address => uint256) public mintedAllowAddress;
    mapping(address => uint256) public mintedPublicAddress;

    string private _baseTokenURI;

    uint256 public _teamReservedAmount = 0;
    uint256 public _mintedReapAmount = 0;
    uint256 public _mintedAllowAmount = 0;

    uint256 public immutable MAX_REAP_MINT_AMOUNT = 1;
    uint256 public immutable MAX_ALLOW_MINT_AMOUNT = 2;
    uint256 public immutable MAX_PUBLIC_MINT_AMOUNT = 2;

    uint256 public immutable MAX_REAP_AMOUNT = 1111;
    uint256 public immutable MAX_ALLOW_AMOUNT = 5555;

    uint256 public allowListSalePrice = 0.025 ether;
    uint256 public publicSalePrice = 0.03 ether;

    uint256 public immutable MAX_TOTAL_SUPPLY = 7000;

    uint256 public immutable MAX_TEAM_HOLD = 334;

    modifier eoaOnly() {
        require(tx.origin == msg.sender, "EOA Only.");
        _;
    }

    constructor(string memory baseTokenURI, address _vault) ERC721A("Hey! Reap3r", "REAP3R", 100) {
        _baseTokenURI = baseTokenURI;
        vault = _vault;
    }

    function _baseURI() internal view override(ERC721A) returns (string memory) {
        return _baseTokenURI;
    }

    function setURI(string memory baseTokenURI) public virtual onlyOwner {
        _baseTokenURI = baseTokenURI;
    }

    function teamAirdrop(address to, uint256 num) public virtual onlyOwner {

        require(MAX_TOTAL_SUPPLY - totalSupply() >= num, "Max supply reached.");

        require(MAX_TEAM_HOLD - _teamReservedAmount >= num, "Airdrop max supply reached.");

        _safeMint(to, num);

        _teamReservedAmount += num;
    }

    function _allowListVerify(bytes32[] memory proof)
    internal
    view
    returns (bool)
    {
        if (status == Status.ReapMint) {
            return
            MerkleProof.verify(
                proof,
                reapRoot,
                keccak256(abi.encodePacked(msg.sender))
            );
        }
        return
        MerkleProof.verify(
            proof,
            allowRoot,
            keccak256(abi.encodePacked(msg.sender))
        );
    }

    function makeChange(uint256 price) private {
        require(msg.value >= price, "Insufficient ether amount.");
        if (msg.value > price) {
            payable(msg.sender).transfer(msg.value - price);
        }
    }

    function _preMint(bytes32[] memory proof, uint256 num) internal {
        require(status == Status.ReapMint || status == Status.AllowMint, "AllowList not avalible for now.");

        require(_allowListVerify(proof), "Invalid merkle proof.");

        if (status == Status.ReapMint) {

            require(MAX_REAP_AMOUNT - _mintedReapAmount >= num, "Max supply reached.");

            require(mintedReapAddress[msg.sender] + num <= MAX_REAP_MINT_AMOUNT, "Minting more than the max supply for a single address.");

            mintedReapAddress[msg.sender] = mintedReapAddress[msg.sender] + num;

            _mintedReapAmount += num;

            makeChange(0);
        } else {

            require(MAX_ALLOW_AMOUNT - _mintedAllowAmount >= num, "Max supply reached.");

            require(mintedAllowAddress[msg.sender] + num <= MAX_ALLOW_MINT_AMOUNT, "Minting more than the max supply for a single address.");

            mintedAllowAddress[msg.sender] = mintedAllowAddress[msg.sender] + num;

            _mintedAllowAmount += num;

            makeChange(allowListSalePrice.mul(num));
        }

        _safeMint(msg.sender, num);
    }

    function preMint(bytes32[] memory proof, uint256 num)
    public
    payable
    nonReentrant
    eoaOnly
    {
        _preMint(proof, num);
    }

    function _publicMint(uint256 num) internal
    {
        require(status == Status.PublicMint, "PublicSale not avalible for now.");

        require(MAX_TOTAL_SUPPLY - totalSupply() - num >= MAX_TEAM_HOLD - _teamReservedAmount, "Max supply reached.");

        require(mintedPublicAddress[msg.sender] + num <= MAX_PUBLIC_MINT_AMOUNT, "Minting more than the max supply for a single address.");

        _safeMint(msg.sender, num);

        makeChange(publicSalePrice.mul(num));

        mintedPublicAddress[msg.sender] = mintedPublicAddress[msg.sender] + num;
    }

    function publicMint(uint256 num)
    public
    payable
    nonReentrant
    eoaOnly
    {
        _publicMint(num);
    }

    function setStatus(Status _status) public onlyOwner {
        status = _status;
    }

    function setRoot(bytes32 _reapRoot, bytes32 _allowRoot) public onlyOwner {
        reapRoot = _reapRoot;
        allowRoot = _allowRoot;
    }

    function setVault(address _vault) public onlyOwner {
        vault = _vault;
    }

    function withdraw() public onlyOwner {
        uint256 balance = address(this).balance;
        payable(vault).transfer(balance);
    }

}