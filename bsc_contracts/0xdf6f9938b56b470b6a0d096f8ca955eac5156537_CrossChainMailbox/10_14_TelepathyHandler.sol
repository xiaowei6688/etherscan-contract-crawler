pragma solidity ^0.8.0;

import {ITelepathyHandler} from "./ITelepathy.sol";

abstract contract TelepathyHandler is ITelepathyHandler {
    error NotFromTelepathyReceiever(address sender);

    address private _telepathyReceiever;

    constructor(address telepathyReceiever) {
        _telepathyReceiever = telepathyReceiever;
    }

    function handleTelepathy(uint32 _sourceChainId, address _senderAddress, bytes memory _data)
        external
        override
        returns (bytes4)
    {
        if (msg.sender != _telepathyReceiever) {
            revert NotFromTelepathyReceiever(msg.sender);
        }
        handleTelepathyImpl(_sourceChainId, _senderAddress, _data);
        return ITelepathyHandler.handleTelepathy.selector;
    }

    function handleTelepathyImpl(uint32 _sourceChainId, address _senderAddress, bytes memory _data)
        internal
        virtual;
}