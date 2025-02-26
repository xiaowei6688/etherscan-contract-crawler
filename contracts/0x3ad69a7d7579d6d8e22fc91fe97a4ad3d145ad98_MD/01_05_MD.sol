// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Mintin' Donuts
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

///////////////////////////////////////////////////////////////////////////////
//                                                                           //
//                                                                           //
//     ________  ________  ________   ___  ___  _________  ________          //
//    |\   ___ \|\   __  \|\   ___  \|\  \|\  \|\___   ___\\   ____\         //
//    \ \  \_|\ \ \  \|\  \ \  \\ \  \ \  \\\  \|___ \  \_\ \  \___|_        //
//     \ \  \ \\ \ \  \\\  \ \  \\ \  \ \  \\\  \   \ \  \ \ \_____  \       //
//      \ \  \_\\ \ \  \\\  \ \  \\ \  \ \  \\\  \   \ \  \ \|____|\  \      //
//       \ \_______\ \_______\ \__\\ \__\ \_______\   \ \__\  ____\_\  \     //
//        \|_______|\|_______|\|__| \|__|\|_______|    \|__| |\_________\    //
//                                                           \|_________|    //
//                                                                           //
//                                                                           //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////


contract MD is ERC721Creator {
    constructor() ERC721Creator("Mintin' Donuts", "MD") {}
}