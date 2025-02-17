// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Fuzzzle
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

///////////////////////////////////////////////////////////////////////////////////
//                                                                               //
//                                                                               //
//       ▄████████ ███    █▄   ▄███████▄   ▄███████▄   ▄█          ▄████████     //
//      ███    ███ ███    ███ ██▀     ▄██ ██▀     ▄██ ███         ███    ███     //
//      ███    █▀  ███    ███       ▄███▀       ▄███▀ ███         ███    █▀      //
//     ▄███▄▄▄     ███    ███  ▀█▀▄███▀▄▄  ▀█▀▄███▀▄▄ ███        ▄███▄▄▄         //
//    ▀▀███▀▀▀     ███    ███   ▄███▀   ▀   ▄███▀   ▀ ███       ▀▀███▀▀▀         //
//      ███        ███    ███ ▄███▀       ▄███▀       ███         ███    █▄      //
//      ███        ███    ███ ███▄     ▄█ ███▄     ▄█ ███▌    ▄   ███    ███     //
//      ███        ████████▀   ▀████████▀  ▀████████▀ █████▄▄██   ██████████     //
//                                                                               //
//                                                                               //
///////////////////////////////////////////////////////////////////////////////////


contract FUZZZ is ERC721Creator {
    constructor() ERC721Creator("Fuzzzle", "FUZZZ") {}
}