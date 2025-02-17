// SPDX-License-Identifier: AGPL-3.0

pragma solidity 0.8.15;

import "@openzeppelin/contracts/access/Ownable.sol";

import "../../../common/LicenseExtension.sol";
import "../../../common/meta-transactions/ERC2771ContextOwnable.sol";
import "../../ERC721/extensions/ERC721RoyaltyExtension.sol";
import "../extensions/ERC721AMinterExtension.sol";
import "../extensions/ERC721ACollectionMetadataExtension.sol";
import "../extensions/ERC721APerTokenMetadataExtension.sol";
import "../extensions/ERC721AOneOfOneMintExtension.sol";
import "../extensions/ERC721AOwnerMintExtension.sol";

contract ERC721AOneOfOneCollection is
    Initializable,
    Ownable,
    ERC165Storage,
    LicenseExtension,
    ERC721ACollectionMetadataExtension,
    ERC721AOwnerMintExtension,
    ERC721AOneOfOneMintExtension,
    ERC721RoyaltyExtension,
    ERC2771ContextOwnable
{
    struct Config {
        string name;
        string symbol;
        string contractURI;
        uint256 maxSupply;
        address defaultRoyaltyAddress;
        uint16 defaultRoyaltyBps;
        address trustedForwarder;
        LicenseVersion licenseVersion;
    }

    constructor(Config memory config) ERC721A(config.name, config.symbol) {
        initialize(config, msg.sender);
    }

    function initialize(Config memory config, address deployer)
        public
        initializer
    {
        _setupRole(DEFAULT_ADMIN_ROLE, deployer);
        _setupRole(MINTER_ROLE, deployer);

        _transferOwnership(deployer);

        __ERC721ACollectionMetadataExtension_init(
            config.name,
            config.symbol,
            config.contractURI
        );
        __ERC721APerTokenMetadataExtension_init();
        __ERC721AOwnerMintExtension_init();
        __ERC721AOneOfOneMintExtension_init();
        __ERC721AMinterExtension_init(config.maxSupply);
        __ERC721RoyaltyExtension_init(
            config.defaultRoyaltyAddress,
            config.defaultRoyaltyBps
        );
        __ERC2771ContextOwnable_init(config.trustedForwarder);
        __LicenseExtension_init(config.licenseVersion);
    }

    function _burn(uint256 tokenId)
        internal
        virtual
        override(ERC721A, ERC721AOneOfOneMintExtension)
    {
        return ERC721AOneOfOneMintExtension._burn(tokenId);
    }

    function _msgSender()
        internal
        view
        virtual
        override(ERC2771ContextOwnable, Context)
        returns (address sender)
    {
        return super._msgSender();
    }

    function _msgData()
        internal
        view
        virtual
        override(ERC2771ContextOwnable, Context)
        returns (bytes calldata)
    {
        return super._msgData();
    }

    /* PUBLIC */

    function supportsInterface(bytes4 interfaceId)
        public
        view
        virtual
        override(
            ERC165Storage,
            ERC721ACollectionMetadataExtension,
            ERC721AOwnerMintExtension,
            ERC721AOneOfOneMintExtension,
            ERC721RoyaltyExtension,
            LicenseExtension
        )
        returns (bool)
    {
        return ERC165Storage.supportsInterface(interfaceId);
    }

    function name()
        public
        view
        override(
            ERC721ACollectionMetadataExtension,
            ERC721AOneOfOneMintExtension
        )
        returns (string memory)
    {
        return ERC721AOneOfOneMintExtension.name();
    }

    function symbol()
        public
        view
        override(
            ERC721ACollectionMetadataExtension,
            ERC721AOneOfOneMintExtension
        )
        returns (string memory)
    {
        return ERC721AOneOfOneMintExtension.symbol();
    }

    function tokenURI(uint256 _tokenId)
        public
        view
        virtual
        override(ERC721A, ERC721AOneOfOneMintExtension)
        returns (string memory)
    {
        return ERC721AOneOfOneMintExtension.tokenURI(_tokenId);
    }

    function getInfo()
        external
        view
        returns (
            uint256 _maxSupply,
            uint256 _totalSupply,
            uint256 _senderBalance
        )
    {
        uint256 balance = 0;

        if (_msgSender() != address(0)) {
            balance = this.balanceOf(_msgSender());
        }

        return (maxSupply, this.totalSupply(), balance);
    }
}