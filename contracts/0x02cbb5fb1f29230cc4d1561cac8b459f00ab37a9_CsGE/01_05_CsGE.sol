// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Check(s) - Gestalt Edition
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

//////////////////////////////////////
//                                  //
//                                  //
//    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⢀⣴⣾⣶⣷⣶⣦⣀⠀⠀⠀⠀⠀⠀⠀⠀⠀    //
//    ⠀⠀⠀⠀⣠⣴⣤⣤⣴⣿⣿⣿⣿⣿⣿⣿⣷⣦⣤⣤⣦⣄⠀⠀⠀⠀    //
//    ⠀⠀⢀⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣷⡀⠀⠀    //
//    ⠀⠀⢨⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀    //
//    ⠀⢀⣸⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠓⠙⢿⣿⣿⣿⣿⣇⣀⠀    //
//    ⣰⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠛⠀⠀⣰⣿⣿⣿⣿⣿⣿⣿⣆    //
//    ⣿⣿⣿⣿⣿⣿⡿⠋⠈⠻⣿⣿⠫⠀⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⡧    //
//    ⠹⢿⣿⣿⣿⣿⣿⣷⣄⠀⠈⠃⠀⣠⣾⣿⣿⣿⣿⣿⣿⣿⣿⣿⡿⠇    //
//    ⠀⠈⢻⣿⣿⣿⣿⣿⣿⣧⣄⢀⣴⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠏⠁⠀    //
//    ⠀⠀⢘⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⠀⠀⠀    //
//    ⠀⠀⠈⢿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⣿⡯⠁⠀⠀    //
//    ⠀⠀⠀⠀⠙⠛⠛⠛⠻⣿⣿⣿⣿⣿⣿⣿⡿⠿⠛⠛⠏⠃⠀⠀⠀⠀    //
//    ⠀⠀⠀⠀⠀⠀⠀⠀⠀⠈⠹⢿⠿⡿⠿⠋⠁⠀⠀⠀⠀⠀⠀⠀⠀⠀    //
//                                  //
//                                  //
//////////////////////////////////////


contract CsGE is ERC721Creator {
    constructor() ERC721Creator("Check(s) - Gestalt Edition", "CsGE") {}
}