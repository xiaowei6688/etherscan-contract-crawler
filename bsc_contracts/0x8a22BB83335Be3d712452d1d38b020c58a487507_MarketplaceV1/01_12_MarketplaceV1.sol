// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";

import "@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "./ERC20RecoverableUpgradeable.sol";

contract MarketplaceV1 is Initializable, OwnableUpgradeable, ReentrancyGuardUpgradeable, ERC20RecoverableUpgradeable {
  /**
   * @notice Indicates whether a detail id has already been used or not.
   */
  mapping(bytes32 => bool) private _alreadyUsed;

  mapping(address => bool) public isNFTSupported;

  struct Pair {
    address tokenAddress;
    uint256 tokenId;
  }

  struct Price {
    address tokenAddress;
    uint256 amount;
  }

  struct Detail {
    bytes32 id;
    address seller;
    string title;
    string description;
    Pair[] bundle;
    Price price;
  }

  struct Fee {
    uint128 numerator;
    uint128 denominator;
  }

  Fee public fee;

  bool public enabled;

  address private master;

  /**
   * @notice Initializes the upgradable contract.
   */
  function initialize() public virtual initializer {
    __Ownable_init();
    fee = Fee(50, 1000);
    enabled = true;
  }

  /**
   * @notice Checks if a signature is valid or not using ECDSA.
   * @param signature Signature bytes to validate.
   * @param hash Hash to recover from it the signer address.
   * @return isSignatureValid Boolean value indicating if the signature is valid or not.
   */
  function isSignatureValid(
    bytes memory signature,
    bytes32 hash,
    address signer
  ) internal pure returns (bool) {
    return ECDSA.recover(ECDSA.toEthSignedMessageHash(hash), signature) == signer;
  }

  /**
   * @notice Executes a buy which is validated by a signature signed by the seller.
   * @param detail Detail object to use for the buy execution by the buyer.
   * @param signature Detail signature.
   */
  function buy(
    Detail calldata detail,
    bytes calldata signature,
    uint256 expiredAt,
    bytes calldata masterSignature
  ) external nonReentrant {
    require(enabled == true, "buy is disabled");
    require(block.timestamp <= expiredAt, "signature is expired");
    require(alreadyUsed(detail.id) == false, "id already used");
    require(isSignatureValid(signature, keccak256(abi.encode(detail)), detail.seller), "invalid detail signature");
    require(isSignatureValid(masterSignature, keccak256(abi.encode(signature, expiredAt)), master), "invalid master signature");

    /**
     * @notice Transfers taxed bundle price from buyer to seller.
     */
    Price memory price = detail.price;
    uint256 feeAmount = (price.amount * fee.numerator) / fee.denominator;
    IERC20(price.tokenAddress).transferFrom(msg.sender, detail.seller, price.amount - feeAmount);
    IERC20(price.tokenAddress).transferFrom(msg.sender, address(this), feeAmount);

    /**
     * @notice Transfers bundle from seller to buyer.
     */
    for (uint256 i = 0; i < detail.bundle.length; i++) {
      require(isNFTSupported[detail.bundle[i].tokenAddress], "nft address not supported");
      IERC721(detail.bundle[i].tokenAddress).safeTransferFrom(detail.seller, msg.sender, detail.bundle[i].tokenId);
    }

    _alreadyUsed[detail.id] = true;

    emit Buy(msg.sender, detail, signature);
  }

  /**
   * @notice Checks id detail id has already been used.
   * @param id Detail id.
   * @return alreadyUsed Boolean value indicating if the id has already been used.
   */
  function alreadyUsed(bytes32 id) public view returns (bool) {
    return _alreadyUsed[id];
  }

  /**
   * @notice Adds or removes NFT address from marketplace support.
   * @param nft NFT address to update support.
   * @param value Boolean value of whether to add or remove the NFT address.
   */
  function supportNFT(address nft, bool value) public onlyOwner {
    isNFTSupported[nft] = value;

    emit SupportNFTUpdated(nft, value);
  }

  /**
   * @notice Adds or removes NFTs addresses from marketplace support.
   * @param nfts NFT address array to update support.
   * @param values Boolean value array of whether to add or remove the NFT address.
   */
  function supportNFTs(address[] calldata nfts, bool[] calldata values) external onlyOwner {
    require(nfts.length == values.length, "nfts and values have different length");

    for (uint256 i = 0; i < nfts.length; i++) {
      supportNFT(nfts[i], values[i]);
    }
  }

  function batchTransfer(
    IERC721[] calldata nfts,
    address to,
    uint256[] calldata tokenIds
  ) external {
    require(nfts.length == tokenIds.length, "nfts and tokenIds have different length");

    for (uint256 i = 0; i < nfts.length; i++) {
      nfts[i].safeTransferFrom(msg.sender, to, tokenIds[i]);
    }
  }

  /**
   * @notice Update the marketplace trade fee.
   * @param numerator Fee numerator.
   * @param denominator Fee denominator.
   */
  function setFee(uint128 numerator, uint128 denominator) external onlyOwner {
    require(denominator != 0, "denominator isn't valid");

    fee = Fee(numerator, denominator);
    emit FeeSet(numerator, denominator);
  }

  function setEnabled(bool value) external onlyOwner {
    enabled = value;
    emit EnabledSet(value);
  }

  function setMaster(address value) external onlyOwner {
    master = value;

    emit MasterSet(value);
  }

  event Buy(address indexed buyer, Detail detail, bytes signature);
  event SupportNFTUpdated(address nft, bool value);
  event FeeSet(uint128 numerator, uint128 denominator);
  event EnabledSet(bool value);
  event MasterSet(address master);
}