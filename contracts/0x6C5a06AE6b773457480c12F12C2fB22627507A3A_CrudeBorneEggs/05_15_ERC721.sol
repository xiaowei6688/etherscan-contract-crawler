// SPDX-License-Identifier: Unlicense
// Creator: U dont need 2 know dat u farkers
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/IERC721Metadata.sol";
import "@openzeppelin/contracts/token/ERC721/extensions/IERC721Enumerable.sol";
import "@openzeppelin/contracts/utils/Address.sol";
import "@openzeppelin/contracts/utils/Context.sol";
import "@openzeppelin/contracts/utils/Strings.sol";
import "@openzeppelin/contracts/utils/introspection/ERC165.sol";

/**
 * @dev Implementation of https://eips.ethereum.org/EIPS/eip-721[ERC721] Non-Fungible Token Standard, including
 * the Metadata and Enumerable extension. Built to optimize for lower gas during batch mints.
 *
 * Assumes serials are sequentially minted starting at 0 (e.g. 0, 1, 2, 3..).
 *
 * Does not support burning tokens to address(0).
 */
contract ERC721 is Context, ERC165, IERC721, IERC721Metadata, IERC721Enumerable {
    using Address for address;
    using Strings for uint256;

    struct TokenOwnership {
        address addr;
        uint64 startTimestamp;
    }

    struct AddressData {
        uint128 balance;
        uint128 numberMinted;
    }

    uint256 private currentIndex = 0;

    uint256 internal immutable maxBatchSize;
    uint256 internal immutable maxOwnerBatchSize;

    // Token name
    string private _name;

    // Token symbol
    string private _symbol;

    // Base URI
    string private _baseURI;
    string private _preRevealURI;

    // Mapping from token ID to ownership details
    // An empty struct value does not necessarily mean the token is unowned. See ownershipOf implementation for details.
    mapping(uint256 => TokenOwnership) private _ownerships;

    // Mapping owner address to address data
    mapping(address => AddressData) private _addressData;

//    // Mapping from tokens to burn status
//    mapping(uint256 )
    address public immutable burnAddress = 0x000000000000000000000000000000000000dEaD;
    uint256 private numTokensBurned;

    // Mapping from token ID to approved address
    mapping(uint256 => address) private _tokenApprovals;

    // Mapping from owner to operator approvals
    mapping(address => mapping(address => bool)) private _operatorApprovals;

    /**
     * @dev
     * `maxBatchSize` refers to how much a minter can mint at a time.
     */
    constructor(
        string memory name_,
        string memory symbol_,
        uint256 maxBatchSize_,
        uint256 maxOwnerBatchSize_
    ) {
        require(maxBatchSize_ > 0, "b");
        _name = name_;
        _symbol = symbol_;
        maxBatchSize = maxBatchSize_;
        maxOwnerBatchSize = maxOwnerBatchSize_;
    }

    /**
     * @dev See {IERC721Enumerable-totalSupply}.
     */
    function totalSupply() public view override returns (uint256) {
        return (currentIndex - numTokensBurned);
    }

    /**
     * @dev See {IERC721Enumerable-tokenByIndex}.
     */
    function tokenByIndex(uint256 index) public view override returns (uint256) {
        require(index < totalSupply(), "g");
        require(ownerOf(index) != burnAddress, "b");
        return index;
    }

    /**
     * @dev See {IERC721Enumerable-tokenOfOwnerByIndex}.
     * This read function is O(totalSupply). If calling from a separate contract, be sure to test gas first.
     * It may also degrade with extremely large collection sizes (e.g >> 10000), test for your use case.
     */
    function tokenOfOwnerByIndex(address owner, uint256 index) public view override returns (uint256) {
        require(index < balanceOf(owner), "b");
        uint256 numMintedSoFar = totalSupply();
        uint256 tokenIdsIdx = 0;
        address currOwnershipAddr = address(0);
        for (uint256 i = 0; i < numMintedSoFar; i++) {
            TokenOwnership memory ownership = _ownerships[i];
            if (ownership.addr != address(0)) {
                currOwnershipAddr = ownership.addr;
            }
            if (currOwnershipAddr == owner) {
                if (tokenIdsIdx == index) {
                    return i;
                }
                tokenIdsIdx++;
            }
        }
        revert("u");
    }

    /**
     * @dev See {IERC165-supportsInterface}.
     */
    function supportsInterface(bytes4 interfaceId) public view virtual override(ERC165, IERC165) returns (bool) {
        return
        interfaceId == type(IERC721).interfaceId ||
        interfaceId == type(IERC721Metadata).interfaceId ||
        interfaceId == type(IERC721Enumerable).interfaceId ||
        super.supportsInterface(interfaceId);
    }

    /**
     * @dev See {IERC721-balanceOf}.
     */
    function balanceOf(address owner) public view override returns (uint256) {
        require(owner != address(0), "0");
        return uint256(_addressData[owner].balance);
    }

//    function numberMinted(address owner) external view returns (uint256) {
//        require(owner != address(0), "0");
//        return uint256(_addressData[owner].numberMinted);
//    }

    function ownershipOf(uint256 tokenId) internal view returns (TokenOwnership memory) {
        require(tokenId < currentIndex, "t");

        uint256 lowestTokenToCheck;
//        if (tokenId >= maxBatchSize) {
//            lowestTokenToCheck = tokenId - maxBatchSize + 1;
//        }
        if (tokenId >= maxOwnerBatchSize) {
            lowestTokenToCheck = tokenId - maxOwnerBatchSize + 1;
        }

        for (uint256 curr = tokenId; curr >= lowestTokenToCheck; curr--) {
            TokenOwnership memory ownership = _ownerships[curr];
            if (ownership.addr != address(0)) {
                return ownership;
            }
        }

        revert("o");
    }

    /**
     * @dev See {IERC721-ownerOf}.
     */
    function ownerOf(uint256 tokenId) public view override returns (address) {
        return ownershipOf(tokenId).addr;
    }

    /**
     * @dev See {IERC721Metadata-name}.
     */
    function name() public view virtual override returns (string memory) {
        return _name;
    }

    /**
     * @dev See {IERC721Metadata-symbol}.
     */
    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }

    /**
     * @dev See {IERC721Metadata-tokenURI}.
     */
    function tokenURI(uint256 tokenId) public view virtual override returns (string memory) {
        require(_exists(tokenId), "z");

//        return bytes(_baseURI).length > 0 ? string(abi.encodePacked(_baseURI, tokenId.toString())) : _preRevealURI;

        require(_exists(tokenId), "z");

//        if (revealed) {
//            return bytes(_baseURI).length > 0 ? string(abi.encodePacked(_baseURI, "/", tokenId.toString(), ".json")) : "";
//        }
//        else {
//            return _baseURI;
//        }
        if (bytes(_baseURI).length > 0) {
            return string(abi.encodePacked(_baseURI, "/", tokenId.toString(), ".json"));
        }
        else {
            return _preRevealURI;
        }
    }

    /**
     * @dev Base URI for computing {tokenURI}. If set, the resulting URI for each
     * token will be the concatenation of the `baseURI` and the `tokenId`. Empty
     * by default, can be overridden in child contracts.
     */
    function baseURI() public view virtual returns (string memory) {
        return _baseURI;
    }

    /**
     * @dev Internal function to set the base URI for all token IDs. It is
     * automatically added as a prefix to the value returned in {tokenURI},
     * or to the token ID if {tokenURI} is empty.
     */
    function _setBaseURI(string memory baseURI_) internal virtual {
        _baseURI = baseURI_;
    }

    function preRevealURI() public view virtual returns (string memory) {
        return _preRevealURI;
    }

    function _setPreRevealURI(string memory preRevealURI_) internal virtual {
        _preRevealURI = preRevealURI_;
    }



    /**
     * @dev See {IERC721-approve}.
     */
    function approve(address to, uint256 tokenId) public override {
        address owner = ERC721.ownerOf(tokenId);
        require(to != owner, "o");

        require(
            _msgSender() == owner || isApprovedForAll(owner, _msgSender()),
            "a"
        );

        _approve(to, tokenId, owner);
    }

    /**
     * @dev See {IERC721-getApproved}.
     */
    function getApproved(uint256 tokenId) public view override returns (address) {
        require(_exists(tokenId), "a");

        return _tokenApprovals[tokenId];
    }

    /**
     * @dev See {IERC721-setApprovalForAll}.
     */
    function setApprovalForAll(address operator, bool approved) public override {
        require(operator != _msgSender(), "a");

        _operatorApprovals[_msgSender()][operator] = approved;
        emit ApprovalForAll(_msgSender(), operator, approved);
    }

    /**
     * @dev See {IERC721-isApprovedForAll}.
     */
    function isApprovedForAll(address owner, address operator) public view virtual override returns (bool) {
        return _operatorApprovals[owner][operator];
    }

    /**
     * @dev See {IERC721-transferFrom}.
     */
    function transferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public override {
        _transfer(from, to, tokenId);
    }

    /**
     * @dev See {IERC721-safeTransferFrom}.
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId
    ) public override {
        safeTransferFrom(from, to, tokenId, "");
    }

    /**
     * @dev See {IERC721-safeTransferFrom}.
     */
    function safeTransferFrom(
        address from,
        address to,
        uint256 tokenId,
        bytes memory _data
    ) public override {
        _transfer(from, to, tokenId);
        require(
            _checkOnERC721Received(from, to, tokenId, _data),
            "z"
        );
    }

    function burnToken(uint256 tokenId) public {
        _transfer(ownerOf(tokenId), burnAddress, tokenId);
        numTokensBurned++;
    }

    /**
     * @dev Returns whether `tokenId` exists.
     *
     * Tokens can be managed by their owner or approved accounts via {approve} or {setApprovalForAll}.
     *
     * Tokens start existing when they are minted (`_mint`),
     */
    function _exists(uint256 tokenId) internal view returns (bool) {
        return (tokenId < currentIndex && ownerOf(tokenId) != burnAddress);
    }

//    function _safeMint(address to, uint256 quantity) internal {
//        _safeMint(to, quantity, "");
//    }
    function _safeMint(bool isPreMint, address from, address to, uint256 quantity) internal {
        _safeMint(isPreMint, from, to, quantity, "");
    }

    /**
     * @dev Mints `quantity` tokens and transfers them to `to`.
     *
     * Requirements:
     *
     * - `to` cannot be the zero address.
     * - `quantity` cannot be larger than the max batch size.
     *
     * Emits a {Transfer} event.
     */
//    function _safeMint(
//        address to,
//        uint256 quantity,
//        bytes memory _data
//    ) internal {
//        uint256 startTokenId = currentIndex;
//        require(to != address(0), "0");
//        // We know if the first token in the batch doesn't exist, the other ones don't as well, because of serial ordering.
//        require(!_exists(startTokenId), "a");
//        require(quantity <= maxBatchSize, "m");
//
//        _beforeTokenTransfers(address(0), to, startTokenId, quantity);
//
//        AddressData memory addressData = _addressData[to];
//        _addressData[to] = AddressData(
//            addressData.balance + uint128(quantity),
//            addressData.numberMinted + uint128(quantity)
//        );
//        _ownerships[startTokenId] = TokenOwnership(to, uint64(block.timestamp));
//
//        uint256 updatedIndex = startTokenId;
//
//        for (uint256 i = 0; i < quantity; i++) {
//            emit Transfer(address(0), to, updatedIndex);
//            require(
//                _checkOnERC721Received(address(0), to, updatedIndex, _data),
//                "z"
//            );
//            updatedIndex++;
//        }
//
//        currentIndex = updatedIndex;
//        _afterTokenTransfers(address(0), to, startTokenId, quantity);
//    }
    function _safeMint(
        bool isPreMint,
        address from,
        address to,
        uint256 quantity,
        bytes memory _data
    ) internal {
        uint256 startTokenId = currentIndex;
        require(to != address(0), "0");
        // We know if the first token in the batch doesn't exist, the other ones don't as well, because of serial ordering.
        require(!_exists(startTokenId), "a");
        if (isPreMint) {
            require(quantity <= maxOwnerBatchSize, "m");
        }
        else {
            require(quantity <= maxBatchSize, "m");
        }

        if (from != address(0)) {
            _beforeTokenTransfers(address(0), from, startTokenId, quantity);
        }
        if (from != to) {
            _beforeTokenTransfers(from, to, startTokenId, quantity);
        }

        AddressData memory addressData = _addressData[to];
        _addressData[to] = AddressData(
            addressData.balance + uint128(quantity),
            addressData.numberMinted + uint128(quantity)
        );
        _ownerships[startTokenId] = TokenOwnership(to, uint64(block.timestamp));

        uint256 updatedIndex = startTokenId;

        for (uint256 i = 0; i < quantity; i++) {
            if (from != address(0)) {
                emit Transfer(address(0), from, updatedIndex);
            }
            if (from != to) {
                emit Transfer(from, to, updatedIndex);
            }
            require(
                _checkOnERC721Received(address(0), from, updatedIndex, _data) && _checkOnERC721Received(from, to, updatedIndex, _data),
                "z"
            );
            updatedIndex++;
        }

        currentIndex = updatedIndex;
        if (from != address(0)) {
            _afterTokenTransfers(address(0), from, startTokenId, quantity);
        }
        if (from != to) {
            _afterTokenTransfers(from, to, startTokenId, quantity);
        }
    }

    /**
     * @dev Transfers `tokenId` from `from` to `to`.
     *
     * Requirements:
     *
     * - `to` cannot be the zero address.
     * - `tokenId` token must be owned by `from`.
     *
     * Emits a {Transfer} event.
     */
    function _transfer(
        address from,
        address to,
        uint256 tokenId
    ) private {
        TokenOwnership memory prevOwnership = ownershipOf(tokenId);

        bool isApprovedOrOwner = (_msgSender() == prevOwnership.addr ||
        getApproved(tokenId) == _msgSender() ||
        isApprovedForAll(prevOwnership.addr, _msgSender()));

        require(isApprovedOrOwner, "a");

        require(prevOwnership.addr == from, "o");
        require(to != address(0), "0");

        _beforeTokenTransfers(from, to, tokenId, 1);

        // Clear approvals from the previous owner
        _approve(address(0), tokenId, prevOwnership.addr);

        _addressData[from].balance -= 1;
        _addressData[to].balance += 1;
        _ownerships[tokenId] = TokenOwnership(to, uint64(block.timestamp));

        // If the ownership slot of tokenId+1 is not explicitly set, that means the transfer initiator owns it.
        // Set the slot of tokenId+1 explicitly in storage to maintain correctness for ownerOf(tokenId+1) calls.
        uint256 nextTokenId = tokenId + 1;
        if (_ownerships[nextTokenId].addr == address(0)) {
            if (_exists(nextTokenId)) {
                _ownerships[nextTokenId] = TokenOwnership(prevOwnership.addr, prevOwnership.startTimestamp);
            }
        }

        emit Transfer(from, to, tokenId);
        _afterTokenTransfers(from, to, tokenId, 1);
    }

    /**
     * @dev Approve `to` to operate on `tokenId`
     *
     * Emits a {Approval} event.
     */
    function _approve(
        address to,
        uint256 tokenId,
        address owner
    ) private {
        _tokenApprovals[tokenId] = to;
        emit Approval(owner, to, tokenId);
    }

//    uint256 public nextOwnerToExplicitlySet = 0;
//
//    /**
//     * @dev Explicitly set `owners` to eliminate loops in future calls of ownerOf().
//     */
//    function _setOwnersExplicit(uint256 quantity) internal {
//        uint256 oldNextOwnerToSet = nextOwnerToExplicitlySet;
//        require(quantity > 0, "q");
//        uint256 endIndex = oldNextOwnerToSet + quantity - 1;
//        if (endIndex > currentIndex - 1) {
//            endIndex = currentIndex - 1;
//        }
//        // We know if the last one in the group exists, all in the group exist, due to serial ordering.
//        require(_exists(endIndex), "n");
//        for (uint256 i = oldNextOwnerToSet; i <= endIndex; i++) {
//            if (_ownerships[i].addr == address(0)) {
//                TokenOwnership memory ownership = ownershipOf(i);
//                _ownerships[i] = TokenOwnership(ownership.addr, ownership.startTimestamp);
//            }
//        }
//        nextOwnerToExplicitlySet = endIndex + 1;
//    }

    /**
     * @dev Internal function to invoke {IERC721Receiver-onERC721Received} on a target address.
     * The call is not executed if the target address is not a contract.
     *
     * @param from address representing the previous owner of the given token ID
     * @param to target address that will receive the tokens
     * @param tokenId uint256 ID of the token to be transferred
     * @param _data bytes optional data to send along with the call
     * @return bool whether the call correctly returned the expected magic value
     */
    function _checkOnERC721Received(
        address from,
        address to,
        uint256 tokenId,
        bytes memory _data
    ) private returns (bool) {
        if (to.isContract()) {
            try IERC721Receiver(to).onERC721Received(_msgSender(), from, tokenId, _data) returns (bytes4 retval) {
                return retval == IERC721Receiver(to).onERC721Received.selector;
            } catch (bytes memory reason) {
                if (reason.length == 0) {
                    revert("z");
                } else {
                    assembly {
                        revert(add(32, reason), mload(reason))
                    }
                }
            }
        } else {
            return true;
        }
    }

    /**
     * @dev Hook that is called before a set of serially-ordered token ids are about to be transferred. This includes minting.
     *
     * startTokenId - the first token id to be transferred
     * quantity - the amount to be transferred
     *
     * Calling conditions:
     *
     * - When `from` and `to` are both non-zero, ``from``'s `tokenId` will be
     * transferred to `to`.
     * - When `from` is zero, `tokenId` will be minted for `to`.
     */
    function _beforeTokenTransfers(
        address from,
        address to,
        uint256 startTokenId,
        uint256 quantity
    ) internal virtual {}

    /**
     * @dev Hook that is called after a set of serially-ordered token ids have been transferred. This includes
     * minting.
     *
     * startTokenId - the first token id to be transferred
     * quantity - the amount to be transferred
     *
     * Calling conditions:
     *
     * - when `from` and `to` are both non-zero.
     * - `from` and `to` are never both zero.
     */
    function _afterTokenTransfers(
        address from,
        address to,
        uint256 startTokenId,
        uint256 quantity
    ) internal virtual {}
}

////////////////////////////////////////