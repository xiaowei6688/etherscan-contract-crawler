// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Super Acrobats by Francois Visser
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                                                                          //
//                                                                                                                                                                                          //
//     _________  ___  ___  _______           ________  ________  ___  ________  ________  _______           ________  ________  ___       ___       _______   ________      ___    ___     //
//    |\___   ___\\  \|\  \|\  ___ \         |\   __  \|\   __  \|\  \|\   ___ \|\   ____\|\  ___ \         |\   ____\|\   __  \|\  \     |\  \     |\  ___ \ |\   __  \    |\  \  /  /|    //
//    \|___ \  \_\ \  \\\  \ \   __/|        \ \  \|\ /\ \  \|\  \ \  \ \  \_|\ \ \  \___|\ \   __/|        \ \  \___|\ \  \|\  \ \  \    \ \  \    \ \   __/|\ \  \|\  \   \ \  \/  / /    //
//         \ \  \ \ \   __  \ \  \_|/__       \ \   __  \ \   _  _\ \  \ \  \ \\ \ \  \  __\ \  \_|/__       \ \  \  __\ \   __  \ \  \    \ \  \    \ \  \_|/_\ \   _  _\   \ \    / /     //
//          \ \  \ \ \  \ \  \ \  \_|\ \       \ \  \|\  \ \  \\  \\ \  \ \  \_\\ \ \  \|\  \ \  \_|\ \       \ \  \|\  \ \  \ \  \ \  \____\ \  \____\ \  \_|\ \ \  \\  \|   \/  /  /      //
//           \ \__\ \ \__\ \__\ \_______\       \ \_______\ \__\\ _\\ \__\ \_______\ \_______\ \_______\       \ \_______\ \__\ \__\ \_______\ \_______\ \_______\ \__\\ _\ __/  / /        //
//            \|__|  \|__|\|__|\|_______|        \|_______|\|__|\|__|\|__|\|_______|\|_______|\|_______|        \|_______|\|__|\|__|\|_______|\|_______|\|_______|\|__|\|__|\___/ /         //
//                                                                                                                                                                         \|___|/          //
//                                                                                                                                                                                          //
//                                                                                                                                                                                          //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract ACBTS is ERC721Creator {
    constructor() ERC721Creator("Super Acrobats by Francois Visser", "ACBTS") {}
}