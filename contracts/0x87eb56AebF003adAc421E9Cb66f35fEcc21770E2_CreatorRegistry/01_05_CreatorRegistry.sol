// SPDX-License-Identifier: MIT
pragma solidity ^0.8.12;

import {IERC165} from "@openzeppelin/contracts/utils/introspection/IERC165.sol";
import {ICreatorRegistry} from "./interface/ICreatorRegistry.sol";
import {IFoundationNftV1TokenCreator} from "./interface/external/IFoundationNftV1TokenCreator.sol";
import {ISuperRareRegistry} from "./interface/external/ISuperRareRegistry.sol";

library SuperRareContracts {
    address public constant SUPERRARE_REGISTRY =
        0x17B0C8564E53f22364A6C8de6F7ca5CE9BEa4e5D;
    address public constant SUPERRARE_V1 =
        0x41A322b28D0fF354040e2CbC676F0320d8c8850d;
    address public constant SUPERRARE_V2 =
        0xb932a70A57673d89f4acfFBE830E8ed7f75Fb9e0;
}

library FoundationContracts {
    address public constant FOUNDATION_V1 =
        0x3B3ee1931Dc30C1957379FAc9aba94D1C48a5405;
}

contract CreatorRegistry is ICreatorRegistry, IERC165 {
    function getCreatorOf(address nftContract_, uint256 tokenId_)
        external
        view
        override
        returns (address)
    {
        // Foundation V1
        if (nftContract_ == FoundationContracts.FOUNDATION_V1) {
            try
                IFoundationNftV1TokenCreator(FoundationContracts.FOUNDATION_V1)
                    .tokenCreator(tokenId_)
            returns (address payable creator) {
                return creator;
            } catch {}
        }

        if (
            nftContract_ == SuperRareContracts.SUPERRARE_V1 ||
            nftContract_ == SuperRareContracts.SUPERRARE_V2
        ) {
            try
                ISuperRareRegistry(SuperRareContracts.SUPERRARE_REGISTRY)
                    .tokenCreator(nftContract_, tokenId_)
            returns (address payable creator) {
                return creator;
            } catch {}
        }

        // Foundation V2 (Creator-owned Collections)
        if (nftContract_.code.length > 0) {
            try
                IFoundationNftV1TokenCreator(nftContract_).tokenCreator(
                    tokenId_
                )
            returns (address payable creator) {
                return creator;
            } catch {}
        }

        revert("Cannot determine creator of NFT");
    }

    function supportsInterface(bytes4 interfaceId)
        external
        pure
        returns (bool)
    {
        return interfaceId == type(ICreatorRegistry).interfaceId;
    }
}