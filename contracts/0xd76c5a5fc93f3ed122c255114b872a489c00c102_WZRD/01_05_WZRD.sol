// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Wizardry
/// @author: manifold.xyz

import "./ERC721Creator.sol";

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                      //
//                                                                                                                      //
//                                                                                                                      //
//     █████  ██      ███████ ██   ██ ███████ ████████ ██   ██ ███████ ██     ██ ██ ███████  █████  ██████  ██████      //
//    ██   ██ ██      ██      ██  ██  ██         ██    ██   ██ ██      ██     ██ ██    ███  ██   ██ ██   ██ ██   ██     //
//    ███████ ██      █████   █████   ███████    ██    ███████ █████   ██  █  ██ ██   ███   ███████ ██████  ██   ██     //
//    ██   ██ ██      ██      ██  ██       ██    ██    ██   ██ ██      ██ ███ ██ ██  ███    ██   ██ ██   ██ ██   ██     //
//    ██   ██ ███████ ███████ ██   ██ ███████    ██    ██   ██ ███████  ███ ███  ██ ███████ ██   ██ ██   ██ ██████      //
//                                                                                                                      //
//                                                                                                                      //
//                                                                                                                      //
//                                                                                                                      //
//                                                                                                                      //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract WZRD is ERC721Creator {
    constructor() ERC721Creator("Wizardry", "WZRD") {}
}