// SPDX-License-Identifier: MIT
pragma solidity 0.8.13;

/**
    ███    ██ ██ ███    ██ ███████  █████  
    ████   ██ ██ ████   ██ ██      ██   ██ 
    ██ ██  ██ ██ ██ ██  ██ █████   ███████ 
    ██  ██ ██ ██ ██  ██ ██ ██      ██   ██ 
    ██   ████ ██ ██   ████ ██      ██   ██                                                 
 */

import "./token/ERC1155/utils/ERC1155Holder.sol";
import "./utils/Counters.sol";
import "./utils/RoyaltyEngineV1.sol";
import "./access/Ownable.sol";

/**
 * @custom:security-contact [email protected]
 */
contract NinfaEnglishAuction is Ownable, RoyaltyEngineV1, ERC1155Holder {
    using Counters for Counters.Counter;
    Counters.Counter private _auctionId;
    /**
     * @notice auctions ids mapped to NFT auction data.
     * @dev This is deleted when an auction is finalized or canceled.
     * @dev Visibility needs to be public so that it can be called by a frontend as the auction creation event only emits auction id.
     */
    mapping(uint256 => _Auction) public auctions;
    /**
     * @notice stores collections that are considered valid vor primary sales, such as NinfaMarketplaceV1 and V2, used in order to efficiently check whether a collection's tokens are considered to be primary market.
     * @dev The contracts in this list need to implement `_marketInfo`
     * @dev Has a setter function callable by admin multisig.
     */
    mapping(address => bool) private _isPrimaryMarket;
    mapping(address => bool) private _isWhitelisted;
    mapping(address => bool) private _isLazyMintContract;
    /**
     * @notice _marketInfo maps collection address and tokenId to boolean
     * @dev Set `_marketInfo` boolean to `true` after each primary sale on this contract.
     * @dev this is a nested mapping in order to allow more than one collection to be sold on primary market
     */
    mapping(address => mapping(uint256 => bool)) private _marketInfo;
    /**
     * @notice _feeAccount multisig for receiving trading fees
     */
    address payable private _feeAccount;
    /**
     * @notice used to check for access control, i.e. whether a collection is whitelisted. Should contain any erc721 or erc1155 factory contract and the marketplace contract.
     */
    address[] private _marketplacesWhitelist;
    /**
     * @notice How long an auction lasts for once the first bid has been received.
     */
    uint256 private _DURATION = 1 days;
    /**
     * @notice The window for auction extensions, any bid placed in the final 15 minutes of an auction will reset the time remaining to 15 minutes.
     */
    uint256 private _EXTENSION_DURATION = 15 minutes;
    /**
     * @notice the last highest bid is divided by this number in order to obtain the minimum bid increment. E.g. _MIN_BID_RAISE = 10 is 10% increment, 20 is 5%, 2 is 50%. I.e. 100 / _MIN_BID_RAISE. OpenSea uses a fixed 5% increment while SuperRare between 5-10%
     */
    uint256 private constant _MIN_BID_RAISE = 20;
    /**
     * @notice 5% fee on all secondary sales paid to Ninfa (seller receives the remainder after paying 10% royalties to artist/gallery and 5% Ninfa, i.e. 85%)
     */
    uint256 private constant _MARKETPLACE_FEE = 500;

    /**
     * @notice Stores the auction configuration for a specific NFT.
     * @param owner since the order creator may be a gallery, i.e. the commission receiver itself, they would not be able to cancel or update the order as there would be no way to know if the order creator was the seller or the commissionReceiver,
     * @dev therefore an additional parameter is needed to store the address of `msg.sender`
     */
    struct _Auction {
        uint256 auctionId;
        address collection;
        uint256 tokenId;
        address payable seller; // auction beneficiary, needs to be payable in order to receive funds from the auction sale
        address payable bidder; // highest bidder, needs to be payable in order to receive refund in case of being outbid
        uint256 bidPrice; // reserve price, highest bid, and all bids in between
        uint256 erc1155Amount; // 0 for erc721, 1> for erc1155
        uint256 end; // The time at which this auction will not accept any new bids. This is `0` until the first bid is placed.
        address payable commissionReceiver;
        uint256 commissionBps;
        address owner;
    }

    /**
     * @notice Emitted when an NFT is listed for auction.
     * @param auctionId The id of the auction that was created.
     * @dev the only parameter needed is auctionId, the emitted event must trigger the backend to retrieve all auction data from a getter function and store it in DB.
     */
    event AuctionCreated(uint256 auctionId);

    /**
     * @notice Emitted when an auction is cancelled.
     * @dev This is only possible if the auction has not received any bids.
     * @param auctionId The id of the auction that was cancelled.
     */
    event AuctionCanceled(uint256 auctionId);

    /**
     * @notice Emitted when a bid is placed.
     * @param auctionId The id of the auction this bid was for.
     */
    event Bid(uint256 auctionId);

    /**
     * @notice Emitted when the auction's reserve price is updated.
     * @dev This is only possible if the auction has not received any bids.
     * @param auctionId The id of the auction that was updated.
     */
    event AuctionUpdated(uint256 auctionId);

    /**
     * @notice Emitted when an auction that has already ended is finalized,
     * indicating that the NFT has been transferred and revenue from the sale distributed.
     */
    event AuctionFinalized(
        uint256 auctionId,
        uint256 royaltyAmount // royalty set by the deployer of the contract (0% if primary sale?)
    );

    /**
     * @notice emitted for transparency whenever the Auction contract's fees receiver account changes
     */
    event FeeAccount(address _feeAccount);

    /**
     * @dev ERC721 and ERC1155 collections must be whitelisted.
     */
    modifier isWhitelisted(address _collection) {
        if (_isWhitelisted[_collection] == false) {
            uint256 i = _marketplacesWhitelist.length;

            do {
                // ++i costs less gas compared to i++ or i += 1
                // decrement first because the `length` property is the array elements count, whereas index starts at 0, i.e. index = length - 1
                --i;

                if (
                    // boolean returned by hasRole, if `true` break the loop and continue, i.e. the collection is whitelisted
                    _staticcallUnchecked(
                        abi.encodeWithSelector(0xf6a3d24e, _collection), // function selector: 0xf6a3d24e or bytes4(keccak256("exists(address)"));
                        _marketplacesWhitelist[i]
                    )
                ) break;
                // if `i` equals the last index in the array AND the loop hasn't hit the break statement yet (the collection is not whitelisetd) revert (before incrementing `i` in order to save some gas).
                if (i == 0) revert Unauthorized();
            } while (i > 0);
        }

        _;
    }

    /**
     * @notice Creates an auction for the given NFT. The NFT is held in escrow until the auction is finalized or canceled.
     * @param _collection The address of the NFT contract.
     * @param _tokenId The id of the NFT.
     * @param _reservePrice The initial reserve price for the auction.
     * @dev reserve price may also be 0, clearly a mistake but not strictly required, only done in order to save gas by removing the need for a condition such as `if (_price == 0) revert InvalidAmount(_price)`
     * @param _erc1155Amount 0 for ERC-721, >1 for ERC-1155.
     * @param _commissionReceiver address of sale commissions receiver
     * @dev if `msg.sender` is also the `_commissionReceiver`, e.g. if `msg.sender` is a gallery, they must put their own address as the `_commissionReceiver`, and set the `_seller` parameter with the artist's/collector's address.
     * @dev if there is no commission receiver, it must be set to address(0)
     * @dev it is not required for `_commissionReceiver` and `_seller` addresses to be different (in order to save gas), although it would likely be a mistake, it cannot be exploited as the total amount paid out will never exceed the price set for the order. I.e. in the worst case the same address will receive both principal sale profit and commissions.
     */
    function createAuction(
        address _collection,
        uint256 _tokenId,
        uint256 _reservePrice,
        uint256 _erc1155Amount,
        address _commissionReceiver,
        uint256 _commissionBps,
        address _seller
    ) external isWhitelisted(_collection) {
        _auctionId.increment(); // start counter at 1

        uint256 auctionId_ = _auctionId.current();

        auctions[auctionId_] = _Auction(
            auctionId_,
            _collection,
            _tokenId,
            payable(_seller), // auction beneficiary, needs to be payable in order to receive funds from the auction sale
            payable(0), // bidder is only known once a bid has been placed. // highest bidder, needs to be payable in order to receive refund in case of being outbid
            _reservePrice,
            _erc1155Amount,
            0,
            payable(_commissionReceiver),
            _commissionBps,
            msg.sender
        );

        _transferNFT(
            _collection, // collection,
            msg.sender, // from
            address(this), // to
            _tokenId, // tokenId
            _erc1155Amount // amount
        );

        emit AuctionCreated(auctionId_);
    }

    function firstBid(uint256 auctionId_) external payable {
        _Auction storage _auction = auctions[auctionId_];

        // hardcoded 0x0 address in order to avoid reading from storage.
        // there is no need to check whether the auction exists already, because even if someone managed to set end, price and bidder for a (yet) non-existing auction, they would be reser when an auction with the same id gets created
        // the important thing is that no one can reset these variables for auctions that have already started, and can't happen because _auction.bidder would be set after the first bid is placed by calling this function.
        if (
            _auction.bidder != 0x0000000000000000000000000000000000000000 || // if auction has started
            msg.value < _auction.bidPrice
        ) revert Unauthorized();

        // if the auction exists and this is the firsat bid, start the auction timer.
        // On the first bid, set the end to now + duration. `_DURATION` is a constant set to 24hrs therefore the below addition can't overflow.
        unchecked {
            _auction.end = block.timestamp + _DURATION;
            _auction.bidPrice = msg.value; // new highest bid
            _auction.bidder = payable(msg.sender); // new highest bidder
        }

        emit Bid(auctionId_);
    }

    /**
     * @notice Place a bid in an auction.
     * A bidder may place a bid which is at least the amount defined by `getMinBidAmount`.
     * If this is the first bid on the auction, the countdown will begin.
     * If there is already an outstanding bid, the previous bidder will be refunded at this time
     * and if the bid is placed in the final moments of the auction, the countdown may be extended.
     * @dev bids MUST be at least 5% higher than previous bid.
     * @param auctionId_ The id of the auction to bid on.
     * @dev auctionId_ MUST exist, auction MUST have begun and MUST not have ended.
     */
    function bid(uint256 auctionId_) external payable {
        _Auction storage _auction = auctions[auctionId_];
        // if auction hasn't started or doesn't exist, i.e. no one has called firstBid() yet, _auction.end will still be 0,
        // therefore the following require statement implicitly checks that auction has started and explicitly that it has not ended

        if (
            block.timestamp > _auction.end ||
            _auction.end == 0 || // required otherwise calling this function would start a 15 minutes auction rather than 24h
            msg.value - _auction.bidPrice < _auction.bidPrice / _MIN_BID_RAISE
        ) revert Unauthorized();

        // if there is less than 15 minutes left, increment end time by 15 more. _EXTENSION_DURATION is always set to 15 minutes so the below can't overflow.
        // already checking in previous if statement that if `block.timestamp > _auction.end` the tx reverts, meaning that `block.timestamp` must be less than `_auction.end`, i.e. auction hasn't expired,
        // if you combine that with `block.timestamp + _EXTENSION_DURATION > _auction.end` that means that `block.timestamp` must be between `_auction.end` and `_auction.end - 15 minutes`, i.e. it's the last 15 minutes of the auction.
        if (block.timestamp + _EXTENSION_DURATION > _auction.end) {
            unchecked {
                _auction.end += _EXTENSION_DURATION;
            }
        }

        // refund the previous bidder
        _sendValue(_auction.bidder, _auction.bidPrice);

        // does not follow check-effects-interactions pattern so that storing previous bidder and amount in memory is not required, however there is no reentrancy exploit in this case;
        // calling back into `bid()` requires that `msg.value` is 5% higher than previous bid, meaning that the extra 5% would not be refunded because storage has not been updated yet
        // besides the bid() function, there is no other function that can be called back into which represents a security risk, namely `createAuction()` and `firstBid()`, i.e. _auction.bidPrice and _auction.bidder are not read by any other function that may be reentered
        _auction.bidPrice = msg.value; // new highest bid
        _auction.bidder = payable(msg.sender); // new highest bidder

        emit Bid(auctionId_);
    }

    /**
     * @notice If an auction has been created but has not yet received bids, the `reservePrice` may be edited by the seller.
     * @param auctionId_ The id of the auction to change.
     * @param _newReservePrice The new reserve price for this auction, may be higher or lower than the previoius price.
     * @dev `_newReservePrice` may be equal to old price (`auctions[auctionId_].bidPrice`); although this doesn't make much sense it isn't a security requirement, hence `require(_auction.bidPrice != _price)` it has been omitted in order to save the user some gas
     * @dev `_newReservePrice` may also be 0, clearly a mistake but not a security requirement,  hence `require(_price > 0)` has been omitted in order to save the user some gas
     */
    function updateReservePrice(uint256 auctionId_, uint256 _newReservePrice)
        external
    {
        _Auction storage _auction = auctions[auctionId_];
        // code duplication because modifiers can't pass variables to functions, meanining that storage pointer cannot be instantiated in modifier
        require(_auction.owner == msg.sender && _auction.end == 0);

        // Update the current reserve price.
        _auction.bidPrice = _newReservePrice;

        emit AuctionUpdated(auctionId_);
    }

    /**
     * @notice If an auction has been created but has not yet received bids, the auction's ERC-1155 token supply may be edited by the seller.
     * @param auctionId_ The id of the auction to change.
     * @param _erc1155Amount The additional amount of ERC-1155 amount to be auctioned.
     * @dev New price be equal to old price, i.e. `auctions[auctionId_].bidPrice`, although this doesn't make much sense it isn't a strict requirement, e.g. `require(_auction.bidPrice != _price)`
     * @dev New price may also be 0, clearly a mistake but not strictly required, only done in order to save gas by removing the condition `require(_price > 0)`
     */
    function raiseAuctionErc1155Amount(
        uint256 auctionId_,
        uint256 _erc1155Amount
    ) external {
        _Auction storage _auction = auctions[auctionId_];
        // code duplication because modifiers can't pass variables to functions, meanining that storage pointer cannot be instantiated in modifier
        require(_auction.owner == msg.sender && _auction.end == 0);
        // Raise the current amount of ERC-1155 token to be auctioned
        _auction.erc1155Amount += _erc1155Amount;
        // transfer the additional amount of ERC-1155 tokens to the auction contract
        _transferNFT(
            _auction.collection,
            msg.sender,
            address(this),
            _auction.tokenId,
            _erc1155Amount
        );

        emit AuctionUpdated(auctionId_);
    }

    /**
     * @notice If an auction has been created but has not yet received bids, the `reservePrice` may be edited by the seller.
     * @param auctionId_ The id of the auction to change.
     * @param _erc1155Amount The difference in ERC-1155 amount to be withdrawn from tbe auction.
     * @dev New _erc1155Amount be equal to old _erc1155Amount, i.e. `auctions[auctionId_].erc1155Amount`, although this wouldn't make much sense it isn't enforced, e.g. `require(_auction.erc1155Amount != _erc1155Amount)`
     * @dev New _erc1155Amount may also be 0, clearly a mistake but not enforced, only done in order to save gas by removing the condition `require(_erc1155Amount > 0)`
     */
    function lowerAuctionErc1155Amount(
        uint256 auctionId_,
        uint256 _erc1155Amount
    ) external {
        _Auction storage _auction = auctions[auctionId_];
        // code duplication because modifiers can't pass variables to functions, meanining that storage pointer cannot be instantiated in modifier
        require(_auction.owner == msg.sender && _auction.end == 0);
        // Lower the current amount of ERC-1155 token to be auctioned
        _auction.erc1155Amount -= _erc1155Amount;
        // transfer the withdrawn amount of ERC-1155 tokens back to the auction creator
        _transferNFT(
            _auction.collection,
            address(this),
            msg.sender,
            _auction.tokenId,
            _erc1155Amount
        );

        emit AuctionUpdated(auctionId_);
    }

    function updateReservePriceAndErc1155Amount(
        uint256 auctionId_,
        uint256 _newReservePrice,
        uint256 _newErc1155Amount
    ) external {
        _Auction storage _auction = auctions[auctionId_];
        // code duplication because modifiers can't pass variables to functions, meanining that storage pointer cannot be instantiated in modifier
        require(_auction.owner == msg.sender && _auction.end == 0);

        // Update the current reserve price.
        _auction.bidPrice = _newReservePrice;

        uint256 diff;

        if (_newErc1155Amount > _auction.erc1155Amount) {
            diff = _newErc1155Amount - _auction.erc1155Amount;
            // Raise the current amount of ERC-1155 token to be auctioned
            _auction.erc1155Amount += diff;
            // transfer the additional amount of ERC-1155 tokens to the auction contract
            _transferNFT(
                _auction.collection,
                msg.sender,
                address(this),
                _auction.tokenId,
                diff
            );
        } else {
            diff = _auction.erc1155Amount - _newErc1155Amount;
            // Lower the current amount of ERC-1155 token to be auctioned
            _auction.erc1155Amount -= diff;
            // transfer the withdrawn amount of ERC-1155 tokens back to the auction creator
            _transferNFT(
                _auction.collection,
                address(this),
                msg.sender,
                _auction.tokenId,
                diff
            );
        }

        emit AuctionUpdated(auctionId_);
    }

    /**
     * @notice If an auction has been created but has not yet received bids, it may be canceled by the seller.
     * @dev The NFT is transferred back to the owner unless there is still a buy price set.
     * @param auctionId_ The id of the auction to cancel.
     */
    function cancelAuction(uint256 auctionId_) external {
        _Auction memory _auction = auctions[auctionId_];

        require(_auction.owner == msg.sender && _auction.end == 0);

        // Delete the _auction.
        delete auctions[auctionId_];

        _transferNFT(
            _auction.collection,
            address(this),
            msg.sender,
            _auction.tokenId,
            _auction.erc1155Amount
        );

        emit AuctionCanceled(auctionId_);
    }

    function finalize(uint256 auctionId_) external {
        _Auction memory _auction = auctions[auctionId_];

        // there must be at least one bid higher than the reserve price in order to execute the trade, no bids mean no end time
        if (block.timestamp < _auction.end || _auction.end == 0)
            revert Unauthorized();

        // Remove the auction.
        delete auctions[auctionId_];

        // transfer nft to auction winner
        _transferNFT(
            _auction.collection,
            address(this),
            _auction.bidder,
            _auction.tokenId,
            _auction.erc1155Amount
        );

        // pay seller, royalties, commissions and fees
        _trade(_auction);
    }

    function _trade(_Auction memory _auction) private {
        /// @param marketplaceAmount calculate marketplace fees
        uint256 marketplaceAmount = (_auction.bidPrice * _MARKETPLACE_FEE) /
            10000;
        /**
         * @notice Pay marketplace fee; primary and secondary market both take the same fee percentage on this auction contract
         */
        _sendValue(_feeAccount, marketplaceAmount);
        /**
         * @param sellerAmount This is a security check as well as a variable assignment, because it would revert if there was an underflow
         * @dev sellerAmount may be 0 if royalties are set too high for an external collection. If `royaltyAmount == (_auction.bidPrice - marketplaceAmount)` then `sellerAmount == 0`. if royalties amount exceeds price - fees amount the transaction will revert.
         */
        uint256 sellerAmount = _auction.bidPrice - marketplaceAmount;
        uint256 royaltyAmount;
        address royaltyReceiver;
        bool payRoyalties;

        /**
         * Collection must be whitelisted in order to be traded on the primary market; not all collections can be sold in primary market as they are considered secondary sales by default unless specified in this mapping.
         * if it is whitelisted, also read mapping `_marketInfo` to check whether it has been already sold on this contract
         * if it is a primary market collection AND it hasn't been sold on this contract before, check whether it was sold on any of the other (whitelisted) contracts stored in `_marketplacesWhitelist`
         */
        if (_isPrimaryMarket[_auction.collection] == false) {
            payRoyalties = true;
        } else {
            if (_marketInfo[_auction.collection][_auction.tokenId] == false) {
                /*
                 * @param i; ++i or --i costs less gas compared to i++ or i += 1.
                 * @dev decrement first because the `length` property is the array elements count, whereas index starts at 0, i.e. index = length - 1
                 */
                uint256 i = _marketplacesWhitelist.length;

                do {
                    --i;
                    if (
                        _staticcallUnchecked(
                            abi.encodeWithSelector(
                                0x0082f07d, // bytes4(keccak256("marketInfo(address,uint256)"))
                                _auction.collection,
                                _auction.tokenId
                            ),
                            _marketplacesWhitelist[i]
                        )
                    ) {
                        payRoyalties = true;
                        break;
                    }
                } while (i > 0);

                if (payRoyalties == false) {
                    _marketInfo[_auction.collection][_auction.tokenId] = true;
                }
            }
        }

        if (payRoyalties) {
            /****************************************************
             * If Secondary Sale ( includes erc1155 contracts ) *
             ***************************************************/

            /******************************************
             * Pay Royalties (only on secondary sales) *
             ******************************************/

            // `getRoyalty()` is a getter function from RoyaltyEngineV1, it only checks that royaltyAmount < price, i.e. royalty anount may be equal to trade price - 1 wei. Also `royaltyReceiver` may be 0x0 or any other address.
            // retrieve royalties information
            (royaltyReceiver, royaltyAmount) = getRoyalty(
                _auction.collection,
                _auction.tokenId,
                _auction.bidPrice
            );

            // > "Marketplaces that support this standard SHOULD NOT send a zero-value transaction if the royaltyAmount returned is 0. This would waste gas and serves no useful purpose in this EIP." - https://eips.ethereum.org/EIPS/eip-2981 I.e. for this reason the `if` statement checks that royalties amount is greater than 0.
            /// @dev "Marketplaces that support this standard SHOULD NOT send a zero-value transaction if the royaltyAmount returned is 0. This would waste gas and serves no useful purpose in this EIP." - https://eips.ethereum.org/EIPS/eip-2981
            ///     Requires that `royaltyAmount > (trade.price - marketplaceAmount)`. If `royaltyAmount == (trade.price - marketplaceAmount)` then `sellerAmount == 0`.
            ///     I.e. as long as `trade.price - royaltyAmount - marketplaceAmount >= 0` the trade will not revert, royalties will be paid first and the seller will get paid whatever is left after royalties, which may even be 0 if the royalties are 95% of the sale (100% - 5% marketplace fees).
            ///     "Marketplaces that support this standard MUST pay royalties no matter where the sale occurred or in what currency" - https://eips.ethereum.org/EIPS/eip-2981 . I.e. for this reason we pay royalties before seller
            if (royaltyAmount > 0) {
                // if royalties amount exceeds price - fees amount the transaction will revert. If `royaltyAmount == (trade.price - marketplaceAmount)` then `sellerAmount == 0`. I.e. as long as `trade.price - royaltyAmount - marketplaceAmount >= 0` the trade will not revert.
                // This assignment indirectly checks that: `royaltyAmount < (trade.price - marketplaceAmount)`, otherwise it would revert. This guarantees that external NFTs' royalties do not overflow!
                // Only subtract `royaltyAmount` if secondary sale. This assignment indirectly checks that: `royaltyAmount < (trade.price - marketplaceAmount)`, otherwise it would revert. This guarantees that external NFTs' royalties do not overflow!
                sellerAmount -= royaltyAmount;

                // at this point all global state changes have been made (check-effects-interactions pattern), therefore it is safe to call external (untrusted) contracts as reentrancy would not be possible.
                // > "Marketplaces that support this standard MUST pay royalties no matter where the sale occurred or in what currency" - https://eips.ethereum.org/EIPS/eip-2981 . I.e. for this reason the marketplace pais royalties receiver before the seller.
                _sendValue(payable(royaltyReceiver), royaltyAmount);
            }
        }

        /***************************
         * Pay seller commissions *
         **************************/

        // calculate commission amount, only if commission shares/bps have been added in `createAuction`. This is both a security check and for saving gas (only calculates commission amount if bps > 0)
        uint256 commissionAmount;
        if (_auction.commissionBps > 0) {
            commissionAmount =
                (_auction.bidPrice * _auction.commissionBps) /
                10000;

            /**
             * Pay commissions, if any
             * since the seller can arbitrarily provide a value for commission shares, should the seller input a BPS/shares value that exceeds the amount they are entitled to for the sale, commissions will not be paid but instead the remaining amount (after royalties and fees) is paid to the seller.
             * this is a security check in order to avoid paying more than the actual price
             * `if` is better than `require` because should the royalties or commissions be set too high by mistake, the nft and eth may get locked in the contract forever because the entire tx would revert
             */

            sellerAmount -= commissionAmount; // sellerAmount may be 0
            /**
             * Pay commissions, if any
             */
            _sendValue(_auction.commissionReceiver, commissionAmount);
        }

        /**************
         * Pay seller *
         *************/

        _sendValue(_auction.seller, sellerAmount);

        emit AuctionFinalized(_auction.auctionId, royaltyAmount);
    }

    function _transferNFT(
        address _collection,
        address _from,
        address _to,
        uint256 _tokenId,
        uint256 _erc1155Amount
    ) private {
        bool success;
        if (_erc1155Amount == 0) {
            (success, ) = _collection.call(
                abi.encodeWithSelector(
                    0x23b872dd, // bytes4(keccak256('transferFrom(address,address,uint256)')) == 0x23b872dd
                    _from,
                    _to,
                    _tokenId
                )
            );
            require(success);
        } else
            (success, ) = _collection.call(
                abi.encodeWithSelector(
                    0xf242432a, // bytes4(keccak256('safeTransferFrom(address,address,uint256,uint256,bytes)')) == 0xf242432a
                    _from,
                    _to,
                    _tokenId,
                    _erc1155Amount,
                    ""
                )
            );
        require(success);
    }

    /**
     * @dev Replacement for Solidity's `transfer`: sends `_amount` wei to
     * `_receiver`, forwarding all available gas and reverting on errors.
     *
     * https://eips.ethereum.org/EIPS/eip-1884[EIP1884] raises the gas cost
     * of certain opcodes, possibly making contracts go over the 2300 gas limit
     * imposed by `transfer`, making them unable to receive funds via
     * `transfer`. {_sendValue} removes this limitation.
     *
     * https://diligence.consensys.net/posts/2019/09/stop-using-soliditys-transfer-now/[Learn more].
     *
     * IMPORTANT: because control is transferred to `_receiver`, care must be
     * taken to not create reentrancy vulnerabilities. Consider using
     * {ReentrancyGuard} or the
     * https://solidity.readthedocs.io/en/v0.5.11/security-considerations.html#use-the-checks-effects-interactions-pattern[checks-effects-interactions pattern].
     */
    function _sendValue(address payable _receiver, uint256 _amount) private {
        // solhint-disable-next-line avoid-low-level-calls
        (bool success, ) = _receiver.call{value: _amount}("");
        require(success);
    }

    /**
     * @notice Query if a contract implements an interface, does not check ERC165 support
     * @param account The address of the contract to query for support of an interface
     * @param encodedParams prepare staticcall; encoded function selector and parameters
     * @return true if the contract at account indicates support of the interface with
     * identifier interfaceId, false otherwise.
     * Note that this function returns the actual result of the query: it does not
     * `revert`, It is up to the caller to decide what to do in these cases.
     */
    function _staticcallUnchecked(bytes memory encodedParams, address account)
        private
        view
        returns (bool)
    {
        /**
         * perform static call
         * `staticcall(g, a, in, insize, out, outsize)` identical to `call(g, a, 0, in, insize, out, outsize)` but do not allow state modifications.
         * call contract at address a with input mem[in…(in+insize)) providing g gas and v wei and output area mem[out…(out+outsize)) returning 0 on error (eg. out of gas) and 1 on success
         * - https://docs.soliditylang.org/en/latest/yul.html#yul-call-return-area
         */
        bool success;
        uint256 returnSize;
        uint256 returnValue;
        assembly {
            success := staticcall(
                30000, // gas
                account, // address
                add(encodedParams, 0x20), // encoded encodedParams input and offset indicating at which bytes index the string starts. Here 0x20 (in hex) = 32 (in decimals). add(encodedParams, 32) it moves the pointer to the raw encodedParams skipping the size field.
                mload(encodedParams), // input size. mload(encodedParams) read 32 bytes pointed by encodedParams (it returns the length of encodedParams)
                0x00, // output
                0x20 // output size
            )
            // Setting output and output size to 0 is due to historical reason. In early EVM versions you had to know the output size in advance, it was a limiting factor for some kind of operations (proxy contracts) so in the Bizantium fork new opcodes were introduced ReturnDataSize and ReturnDataCopy. This allow the caller to determine the output size after the call (ReturnDataSize) and allowing copying to memory (ReturnDataCopy).
            returnSize := returndatasize() // how much memory do we need to allocate for the response
            returnValue := mload(0x00)
        }
        return success && returnSize >= 0x20 && returnValue > 0;
    }

    /**
     * @notice external view functions called by other contract. marketInfo maps collection address and tokenId to boolean
     * @dev returns `true` if secondary market, i.e. if the NFT's primary sale happened on that contract, otherwise return `false`.
     */
    function marketInfo(address _collection, uint256 _tokenId)
        external
        view
        returns (bool)
    {
        return _marketInfo[_collection][_tokenId];
    }

    /**
     * @notice this function may be called by lazy minting contracts, so that this contract may store information about primary sales happening on those contracts.
     * @dev the reason for setting market information on this contract is so that the array `_marketplacesWhitelist` doesn't grow indefintitely requiring more external calls in the `isWhitelisted` modifier
     */
    function setMarketInfo(address _collection, uint256 _tokenId) external {
        if (_isLazyMintContract[msg.sender] == false) revert();
        _marketInfo[_collection][_tokenId] = true;
    }

    /**
     * @notice adds or removes an address from whitelist of addresses allowed to call `setMarketInfo`
     * @param _contract address of contract allowed or disallowed to call `setMarketInfo`
     * @param _authorized `true` to whitelist, `false` to remove address from `_isLazyMintContract` whitelist
     */
    function setLazyMintingContract(address _contract, bool _authorized)
        external
        onlyOwner
    {
        _isLazyMintContract[_contract] = _authorized;
    }

    /// @notice append to array, this will increase array length by 1
    /// @dev important, add them in the order of most likely collection registry, i.e. marketplace (for now), in order to reduce the number of exxeternal calls done by `isWhitelisted` modifier
    function addMarketplace(address _newMarketplace) external onlyOwner {
        _marketplacesWhitelist.push(_newMarketplace);
    }

    /// @notice remove array element by copying last element into the index to remove.
    /// @dev Deleting an element creates a gap in the array. One trick to keep the array compact is to move the last element into the place to delete.
    /// @dev If there is only one element left this won't work, that's intentional in order to avoid human mistakes; the `createAuction` function requires at least one registry to be set or else it will revert.
    function deleteMarketplace(uint256 _index) external onlyOwner {
        _marketplacesWhitelist[_index] = _marketplacesWhitelist[
            _marketplacesWhitelist.length - 1
        ];
        _marketplacesWhitelist.pop();
    }

    /**
     * @dev setter function only callable by contract admin used to change the address to which fees are paid
     * @param _newFeeAccount is the address owned by NINFA that will collect sales fees
     */
    function setFeeAccount(address payable _newFeeAccount) external onlyOwner {
        _feeAccount = _newFeeAccount;
        emit FeeAccount(_newFeeAccount);
    }

    function setPrimaryMarketCollection(address _collection, bool _authorized)
        external
        onlyOwner
    {
        _isPrimaryMarket[_collection] = _authorized;
    }

    // Solidity can return the entire array. But this function should be avoided for arrays that can grow indefinitely in length.
    function getMarketplacesWhitelist()
        external
        view
        returns (address[] memory)
    {
        return _marketplacesWhitelist;
    }

    /**
     * @param _royaltyRegistry see https://royaltyregistry.xyz/lookup for public addresses
     * @param _newCollection address of Ninfa Marketplace V1
     * @param _newMarketplace address of Ninfa Marketplace V1
     */
    constructor(
        address _royaltyRegistry,
        address _newCollection,
        address _newMarketplace,
        address payable _newFeeAccount
    ) RoyaltyEngineV1(_royaltyRegistry) {
        _marketplacesWhitelist.push(_newMarketplace);
        _feeAccount = _newFeeAccount;
        _isPrimaryMarket[_newCollection] = true;
        _isWhitelisted[_newCollection] = true;
    }
}