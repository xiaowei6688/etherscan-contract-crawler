// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import { MetadataRendererUtil } from "./MetadataRendererUtil.sol";
import "./interfaces/IMetadataRenderer.sol";
import "./interfaces/IEditionsMetadataRenderer.sol";
import "../erc721/interfaces/IEditionCollection.sol";
import "../tokenManager/interfaces/ITokenManagerEditions.sol";
import "../erc721/ERC721MinimizedBase.sol";

import "@openzeppelin/contracts/proxy/utils/UUPSUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/OwnableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol";

/**
 * @title Editions Metadata Render
 * @author [email protected], [email protected]
 * @notice Editions ERC721 Metadata Renderer
 * Inspired by Zora (zora.co) Editions Contract
 */
contract EditionsMetadataRenderer is
    IMetadataRenderer,
    IEditionsMetadataRenderer,
    UUPSUpgradeable,
    OwnableUpgradeable,
    ReentrancyGuardUpgradeable
{
    /**
     * @notice Maps collection to list of edition infos for each edition on collection, edition-indexed
     */
    mapping(address => TokenEditionInfo[]) public tokenInfos;

    /**
     * @notice Emitted when edition's metadata is initialized
     * @param contractAddress Collection address of edition
     * @param editionId Edition id
     * @param data Edition metadata
     */
    event MetadataInitialized(address indexed contractAddress, uint256 indexed editionId, bytes data);

    /**
     * @notice Emitted when edition's name is updated
     * @param contractAddress Collection address of edition
     * @param editionId Edition id
     * @param data Changed metadata (in this case, name)
     */
    event NameUpdated(address indexed contractAddress, uint256 indexed editionId, string data);

    /**
     * @notice Emitted when edition's description is updated
     * @param contractAddress Collection address of edition
     * @param editionId Edition id
     * @param data Changed metadata (in this case, description)
     */
    event DescriptionUpdated(address indexed contractAddress, uint256 indexed editionId, string data);

    /**
     * @notice Emitted when edition's imageUrl is updated
     * @param contractAddress Collection address of edition
     * @param editionId Edition id
     * @param data Changed metadata (in this case, imageUrl)
     */
    event ImageUrlUpdated(address indexed contractAddress, uint256 indexed editionId, string data);

    /**
     * @notice Emitted when edition's animationUrl is updated
     * @param contractAddress Collection address of edition
     * @param editionId Edition id
     * @param data Changed metadata (in this case, animationUrl)
     */
    event AnimationUrlUpdated(address indexed contractAddress, uint256 indexed editionId, string data);

    /**
     * @notice Emitted when edition's externalUrl is updated
     * @param contractAddress Collection address of edition
     * @param editionId Edition id
     * @param data Changed metadata (in this case, externalUrl)
     */
    event ExternalUrlUpdated(address indexed contractAddress, uint256 indexed editionId, string data);

    /**
     * @notice Emitted when edition's attributes is updated
     * @param contractAddress Collection address of edition
     * @param editionId Edition id
     * @param data Changed metadata (in this case, attributes)
     */
    event AttributesUpdated(address indexed contractAddress, uint256 indexed editionId, string data);

    /**
     * @notice Initialize implementation with initial owner
     * @param _owner Initial owner
     */
    function initialize(address _owner) external initializer nonReentrant {
        __Ownable_init();
        __ReentrancyGuard_init();
        _transferOwnership(_owner);
    }

    /**
     * @notice Add TokenInfo data for edition
     * @param data Token Info data encoded
     */
    function initializeMetadata(bytes memory data) external nonReentrant {
        address msgSender = msg.sender;
        tokenInfos[msgSender].push(abi.decode(data, (TokenEditionInfo)));

        emit MetadataInitialized(msgSender, tokenInfos[msgSender].length, data);
    }

    /**
     * See {IEditionsMetadataRenderer-updateName}
     */
    function updateName(
        address editionsAddress,
        uint256 editionId,
        string calldata name
    ) external nonReentrant {
        tokenInfos[editionsAddress][editionId].name = name;

        require(
            _verifyCanUpdateMetadata(editionsAddress, editionId, name, ITokenManagerEditions.FieldUpdated.name),
            "Can't update metadata"
        );

        emit NameUpdated(editionsAddress, editionId, name);
    }

    /**
     * See {IEditionsMetadataRenderer-updateDescription}
     */
    function updateDescription(
        address editionsAddress,
        uint256 editionId,
        string calldata description
    ) external nonReentrant {
        tokenInfos[editionsAddress][editionId].description = description;

        require(
            _verifyCanUpdateMetadata(
                editionsAddress,
                editionId,
                description,
                ITokenManagerEditions.FieldUpdated.description
            ),
            "Can't update metadata"
        );

        emit DescriptionUpdated(editionsAddress, editionId, description);
    }

    /**
     * See {IEditionsMetadataRenderer-updateImageUrl}
     */
    function updateImageUrl(
        address editionsAddress,
        uint256 editionId,
        string calldata imageUrl
    ) external nonReentrant {
        tokenInfos[editionsAddress][editionId].imageUrl = imageUrl;

        require(
            _verifyCanUpdateMetadata(editionsAddress, editionId, imageUrl, ITokenManagerEditions.FieldUpdated.imageUrl),
            "Can't update metadata"
        );

        emit ImageUrlUpdated(editionsAddress, editionId, imageUrl);
    }

    /**
     * See {IEditionsMetadataRenderer-updateAnimationUrl}
     */
    function updateAnimationUrl(
        address editionsAddress,
        uint256 editionId,
        string calldata animationUrl
    ) external nonReentrant {
        tokenInfos[editionsAddress][editionId].animationUrl = animationUrl;

        require(
            _verifyCanUpdateMetadata(
                editionsAddress,
                editionId,
                animationUrl,
                ITokenManagerEditions.FieldUpdated.animationUrl
            ),
            "Can't update metadata"
        );

        emit AnimationUrlUpdated(editionsAddress, editionId, animationUrl);
    }

    /**
     * See {IEditionsMetadataRenderer-updateExternalUrl}
     */
    function updateExternalUrl(
        address editionsAddress,
        uint256 editionId,
        string calldata externalUrl
    ) external nonReentrant {
        tokenInfos[editionsAddress][editionId].externalUrl = externalUrl;

        require(
            _verifyCanUpdateMetadata(
                editionsAddress,
                editionId,
                externalUrl,
                ITokenManagerEditions.FieldUpdated.externalUrl
            ),
            "Can't update metadata"
        );

        emit ExternalUrlUpdated(editionsAddress, editionId, externalUrl);
    }

    /**
     * See {IEditionsMetadataRenderer-updateAttributes}
     */
    function updateAttributes(
        address editionsAddress,
        uint256 editionId,
        string calldata attributes
    ) external nonReentrant {
        tokenInfos[editionsAddress][editionId].attributes = attributes;

        require(
            _verifyCanUpdateMetadata(
                editionsAddress,
                editionId,
                attributes,
                ITokenManagerEditions.FieldUpdated.attributes
            ),
            "Can't update metadata"
        );

        emit AttributesUpdated(editionsAddress, editionId, attributes);
    }

    /**
     * @notice Returns Edition URI based on EditionID
     * @param editionId ID to get the EditionURI for
     */
    function editionURI(uint256 editionId) external view override returns (string memory) {
        IEditionCollection.EditionDetails memory details = IEditionCollection(msg.sender).getEditionDetails(editionId);
        TokenEditionInfo storage info = tokenInfos[msg.sender][editionId];
        return _createEditionMetadata(info, details.size);
    }

    /**
     * @notice Returns Token URI based on TokenID
     * @param tokenId ID to get the TokenURI for
     */
    function tokenURI(uint256 tokenId) external view override returns (string memory) {
        IEditionCollection collection = IEditionCollection(msg.sender);
        uint256 editionId = collection.getEditionId(tokenId);
        IEditionCollection.EditionDetails memory details = collection.getEditionDetails(editionId);
        uint256 editionTokenId = tokenId - details.initialTokenId + 1;
        TokenEditionInfo storage info = tokenInfos[msg.sender][editionId];
        return _createTokenMetadata(info, editionTokenId, details.size);
    }

    /**
     * @notice Get TokenEditionInfo for an edition
     * @param editionsAddress Address of Editions contract
     * @param editionsId Editions id
     */
    function editionInfo(address editionsAddress, uint256 editionsId) external view returns (TokenEditionInfo memory) {
        return tokenInfos[editionsAddress][editionsId];
    }

    /* solhint-disable no-empty-blocks */
    /**
     * @notice Limit upgrades of contract to EditionsMetadataRenderer owner
     * @param // New implementation
     */
    function _authorizeUpgrade(address) internal override onlyOwner {}

    /* solhint-enable no-empty-blocks */

    /**
     * @notice Returns encoded string uri
     * @param _name Name of the Contract
     * @param _symbol Symbol for the Contract
     */
    function _createContractMetadata(string memory _name, string memory _symbol) internal pure returns (string memory) {
        // solhint-disable quotes
        return
            MetadataRendererUtil.encodeMetadataJSON(
                abi.encodePacked('{"name": "', _name, '", "symbol": "', _symbol, '"}')
            );
        // solhint-enable quotes
    }

    /**
     * @notice Returns encoded string uri
     * @param _info Edition Token Info
     * @param _editionSize Size of the Edition
     */
    function _createEditionMetadata(TokenEditionInfo memory _info, uint256 _editionSize)
        internal
        pure
        returns (string memory)
    {
        string memory _size = "Unlimited";
        if (_editionSize > 0) {
            _size = MetadataRendererUtil.numberToString(_editionSize);
        }
        string memory attributes = _info.attributes;
        bool noAttributes = bytes(_info.attributes).length < 1;
        if (noAttributes) {
            attributes = "[]";
        }
        string memory _tokenMedia = _tokenMediaData(_info.imageUrl, _info.animationUrl);
        // solhint-disable quotes
        return
            MetadataRendererUtil.encodeMetadataJSON(
                abi.encodePacked(
                    '{"name": "',
                    _info.name,
                    '", "',
                    'size": "',
                    _size,
                    '", "',
                    'description": "',
                    _info.description,
                    '", ',
                    _tokenMedia,
                    '"external_url": "',
                    _info.externalUrl,
                    '", "',
                    'attributes": ',
                    attributes,
                    "}"
                )
            );
        // solhint-enable quotes
    }

    /**
     * @notice Returns encoded string uri
     * @param _info Edition Token Info
     * @param _editionTokenId ID of the Token within the Edition
     * @param _editionSize Size of the Edition
     */
    function _createTokenMetadata(
        TokenEditionInfo memory _info,
        uint256 _editionTokenId,
        uint256 _editionSize
    ) internal pure returns (string memory) {
        string memory _ofEdition = "";
        string memory editionTokenId = "";
        if (_editionSize != 1) {
            editionTokenId = string(abi.encodePacked(" ", MetadataRendererUtil.numberToString(_editionTokenId)));

            if (_editionSize > 1) {
                _ofEdition = string(abi.encodePacked("/", MetadataRendererUtil.numberToString(_editionSize)));
            }
        }
        string memory attributes = _info.attributes;
        bool noAttributes = bytes(_info.attributes).length < 1;
        if (noAttributes) {
            attributes = "[]";
        }
        string memory _tokenMedia = _tokenMediaData(_info.imageUrl, _info.animationUrl);
        /* solhint-disable quotes */
        return
            MetadataRendererUtil.encodeMetadataJSON(
                abi.encodePacked(
                    '{"name": "',
                    _info.name,
                    editionTokenId,
                    _ofEdition,
                    '", "',
                    'description": "',
                    _info.description,
                    '", ',
                    _tokenMedia,
                    '"external_url": "',
                    _info.externalUrl,
                    '", "',
                    'attributes": ',
                    attributes,
                    "}"
                )
            );
        /* solhint-enable quotes */
    }

    /**
     * @notice Returns encoded media data
     * @param _imageUrl Edition image url
     * @param _animationUrl Edition animation url
     */
    function _tokenMediaData(string memory _imageUrl, string memory _animationUrl)
        internal
        pure
        returns (string memory)
    {
        bool hasImage = bytes(_imageUrl).length > 0;
        bool hasAnimation = bytes(_animationUrl).length > 0;
        // solhint-disable quotes
        if (hasImage && hasAnimation) {
            return string(abi.encodePacked('"image": "', _imageUrl, '", "animation_url": "', _animationUrl, '", '));
        }
        if (hasImage) {
            return string(abi.encodePacked('"image": "', _imageUrl, '", '));
        }
        if (hasAnimation) {
            return string(abi.encodePacked('"animation_url": "', _animationUrl, '", '));
        }
        // solhint-enable quotes

        return "";
    }

    /**
     * @notice If edition has a token manager, delegate management of updatability to it
            Otherwise, updater must be collection owner
     * @param editionsAddress Collection address (where edition is on)
     * @param editionId ID of edition
     * @param newMetadata New metadata that was changed for edition
     */
    function _verifyCanUpdateMetadata(
        address editionsAddress,
        uint256 editionId,
        string calldata newMetadata,
        ITokenManagerEditions.FieldUpdated fieldUpdated
    ) private returns (bool) {
        address _manager = ERC721MinimizedBase(editionsAddress).tokenManager(editionId);
        if (_manager == address(0)) {
            return msg.sender == OwnableUpgradeable(editionsAddress).owner();
        } else {
            if (IERC165Upgradeable(_manager).supportsInterface(type(ITokenManagerEditions).interfaceId)) {
                return
                    ITokenManagerEditions(_manager).canUpdateEditionsMetadata(
                        editionsAddress,
                        msg.sender,
                        editionId,
                        bytes(newMetadata),
                        fieldUpdated
                    );
            } else {
                return ITokenManager(_manager).canUpdateMetadata(msg.sender, editionId, bytes(newMetadata));
            }
        }
    }
}