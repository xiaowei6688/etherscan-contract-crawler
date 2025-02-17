// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: The Sign
/// @author: manifold.xyz

import "./ERC721Creator.sol";

///////////////////////////////////////////////////////////////////////////////////////////
//                                                                                       //
//                                                                                       //
//     _________  ___  ___  _______           ________  ___  ________  ________          //
//    |\___   ___\\  \|\  \|\  ___ \         |\   ____\|\  \|\   ____\|\   ___  \        //
//    \|___ \  \_\ \  \\\  \ \   __/|        \ \  \___|\ \  \ \  \___|\ \  \\ \  \       //
//         \ \  \ \ \   __  \ \  \_|/__       \ \_____  \ \  \ \  \  __\ \  \\ \  \      //
//          \ \  \ \ \  \ \  \ \  \_|\ \       \|____|\  \ \  \ \  \|\  \ \  \\ \  \     //
//           \ \__\ \ \__\ \__\ \_______\        ____\_\  \ \__\ \_______\ \__\\ \__\    //
//            \|__|  \|__|\|__|\|_______|       |\_________\|__|\|_______|\|__| \|__|    //
//                                              \|_________|                             //
//                                                                                       //
//                                                                                       //
//                                                                                       //
//                                                                                       //
///////////////////////////////////////////////////////////////////////////////////////////


contract THSGN is ERC721Creator {
    constructor() ERC721Creator("The Sign", "THSGN") {}
}