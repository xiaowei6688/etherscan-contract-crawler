// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Ravi Vora
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

//////////////////////////////////////////////////////////////////////////////
//                                                                          //
//                                                                          //
//    ██████   █████  ██    ██ ██     ██    ██  ██████  ██████   █████      //
//    ██   ██ ██   ██ ██    ██ ██     ██    ██ ██    ██ ██   ██ ██   ██     //
//    ██████  ███████ ██    ██ ██     ██    ██ ██    ██ ██████  ███████     //
//    ██   ██ ██   ██  ██  ██  ██      ██  ██  ██    ██ ██   ██ ██   ██     //
//    ██   ██ ██   ██   ████   ██       ████    ██████  ██   ██ ██   ██     //
//                                                                          //
//                                                                          //
//////////////////////////////////////////////////////////////////////////////


contract RAVI is ERC721Creator {
    constructor() ERC721Creator("Ravi Vora", "RAVI") {}
}