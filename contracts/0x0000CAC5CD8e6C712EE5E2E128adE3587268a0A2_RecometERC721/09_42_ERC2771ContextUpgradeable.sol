// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts v4.4.1 (metatx/ERC2771Context.sol)

pragma solidity ^0.8.0;

import "@openzeppelin/contracts-upgradeable/utils/ContextUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";

/**
 * @title ERC2771Context
 * ERC2771Context - This contract manages the ERC2771 for ERC721.
 */
abstract contract ERC2771ContextUpgradeable is
    Initializable,
    ContextUpgradeable
{
    address private _trustedForwarder;

    function __ERC2771Context_init(address trustedForwarder)
        internal
        onlyInitializing
    {
        __Context_init_unchained();
        __ERC2771Context_init_unchained(trustedForwarder);
    }

    function __ERC2771Context_init_unchained(address trustedForwarder)
        internal
        onlyInitializing
    {
        _trustedForwarder = trustedForwarder;
    }

    function isTrustedForwarder(address forwarder)
        public
        view
        virtual
        returns (bool)
    {
        return forwarder == _trustedForwarder;
    }

    function _msgSender()
        internal
        view
        virtual
        override
        returns (address sender)
    {
        if (isTrustedForwarder(msg.sender)) {
            // The assembly code is more direct than the Solidity version using `abi.decode`.
            assembly {
                sender := shr(96, calldataload(sub(calldatasize(), 20)))
            }
        } else {
            return super._msgSender();
        }
    }

    function _msgData()
        internal
        view
        virtual
        override
        returns (bytes calldata)
    {
        if (isTrustedForwarder(msg.sender)) {
            return msg.data[:msg.data.length - 20];
        } else {
            return super._msgData();
        }
    }

    uint256[49] private __gap;
}