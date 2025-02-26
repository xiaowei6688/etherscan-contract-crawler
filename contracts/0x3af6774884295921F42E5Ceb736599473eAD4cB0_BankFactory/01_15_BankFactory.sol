pragma solidity ^0.8.0;

// SPDX-License-Identifier: MIT
import "../../core/DaoRegistry.sol";
import "../../core/CloneFactory.sol";
import "../IFactory.sol";
import "./Bank.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

/**
MIT License

Copyright (c) 2020 Openlaw

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
 */

contract BankFactory is IFactory, CloneFactory, ReentrancyGuard {
    address public identityAddress;

    event BankCreated(address daoAddress, address extensionAddress);

    mapping(address => address) private _extensions;

    constructor(address _identityAddress) {
        require(_identityAddress != address(0x0), "invalid addr");
        identityAddress = _identityAddress;
    }

    /**
     * @notice Creates a new extension using clone factory.
     * @notice It can set additional arguments to the extension.
     * @notice It initializes the extension and sets the DAO owner as the extension creator.
     * @notice The DAO owner is stored at index 1 in the members storage.
     * @notice The safest way to read the new extension address is to read it from the event.
     * @param dao The dao address that will be associated with the new extension.
     * @param maxExternalTokens The maximum number of external tokens stored in the Bank
     */
    // slither-disable-next-line reentrancy-events
    function create(DaoRegistry dao, uint8 maxExternalTokens)
        external
        nonReentrant
    {
        address daoAddress = address(dao);
        require(daoAddress != address(0x0), "invalid dao addr");
        address extensionAddr = _createClone(identityAddress);
        _extensions[daoAddress] = extensionAddr;

        BankExtension extension = BankExtension(extensionAddr);
        extension.setMaxExternalTokens(maxExternalTokens);
        // Member at index 1 is the DAO owner, but also the payer of the DAO deployment
        extension.initialize(dao, dao.getMemberAddress(1));
        // slither-disable-next-line reentrancy-events
        emit BankCreated(daoAddress, address(extension));
    }

    /**
     * @notice Returns the extension address created for that DAO, or 0x0... if it does not exist.
     * @notice Do not rely on the result returned by this right after the new extension is cloned,
     * because it is prone to front-running attacks. During the extension creation it is safer to
     * read the new extension address from the event generated in the create call transaction.
     */
    function getExtensionAddress(address dao)
        external
        view
        override
        returns (address)
    {
        return _extensions[dao];
    }
}