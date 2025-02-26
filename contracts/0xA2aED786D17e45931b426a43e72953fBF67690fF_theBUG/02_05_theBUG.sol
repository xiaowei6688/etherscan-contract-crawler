// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Summer Wagner 1/1
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

//////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                  //
//                                                                                                  //
//    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░     //
//    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░    //
//    ░░░░░▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░█▓░░░░░░░░░░░█▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓▓▒░░░░    //
//    ░░░░░▒▓▓▓▓▓▒░▒░░░░░░░░░░░░░░░░░░░░░░░░▒▒░░░░░░░░░░░█░░░░░░░░░░░░░░░░░░░░░░░░▒▒░▓▓▓▓▓▓░░░░░    //
//    ░░░░░░░░░░▒▓▓▓▒▒░░░░░░░░░░░░░░░░░░░░░░▒█▓▓███████▓▓▓▒░░░░░░░░░░░░░░░░░░░░░▒▒▓▓▓▓░░░░░░░░░░    //
//    ░░░░░░░░░░░▒▓▓█▓▒▒▒░░░░░░░░░░░░░░░░▒▓████▓▓▓▓▓▓▓▓▓████▓▒░░░░░░░░░░░░░░░░▒▒▓▓█▓▓▒░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░▒▓▓▒▒▒░░░░░░░░░░░░░▓███▓▓▓▓▒▒▒▒▒▒▒▓▓▓▓██▓▓░░░░░░░░░░░░░▒▓▓▓▒░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░░▒▓▒▒░░░░░░░░░░░█▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓█▓░░░░░░░░░░░▓▓▓░░░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░░░░▓▒▓▒░░░░░░░░░█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█▓░░░░░░░░░▒▓▓▒░░░░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░░░░░▒▓▓▒▒░▒▒▓▓██▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓█▓▓▒▒░░▒▒▓▓▒░░░░░░░░░░░░░░░░░░░░     //
//    ░░░░░░░░░░░░░░░░░░░░░░█▓▓▓█████▓▓▓▓▒▒ Summer Wagner ▒▓▓▓▓████▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░       //
//    ░░░░░░░░░░░░░░░░░░░░░░▒▒▒██████▓▓▓▒▒▒BUG IN DREAMLAND▒▒▒▓▓▓▓▓█████▒▒░░░░░░░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░░░░░░░░▒██████▓▓▓▓▒▒▒▒▒▒▒▒1/1▒▒▒▒▒▒▒▓▓▓▓▓▓▓█████░░░░░░░░░░░░░░░░░░░░░░░░     //
//    ░░░░░░░░░░░░░░░░░░░░░░░░▒███████▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓██████░░░░░░░░░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░░░░░░░░░████████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██████▓░░░░░░░░░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░▒▒▒░░░░░░▓███████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓███████▒░░░░░░▒▒░░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░▒█▓▓▓▓▒▒▓▓▓▓███████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██████▓▓▓▓▒▒▒▓▓▓█▓░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░▒█▒░░▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓█▓▓▓▓▓▓██▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓▓▓▓▓▓░░░▓▓░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░▒▓█▒░░▒▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒██▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓░░░▓█▓▒░░░░░░░░░░░░    //
//    ░░░░░░░░░▒▒▓▓█▒░░░▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓█▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓░░░░▓█▓▒▒░░░░░░░░░    //
//    ░░░░░▒▒▒▓▓▒▓░░░░░▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓█▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓░░░░░▒▓▓▓▒▒▒░░░░░    //
//    ░░░░▓█▒░░░░░░░░░░▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓█▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░█▓▒░░░    //
//    ░░░░░▒░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓█▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░▒░░░░    //
//    ░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓█▓▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓█▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░▒▓▓██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░▓▓▓█████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░▒▓▓███▓██████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓███▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█▓▓██▓▓▓░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░▒██░░▒▓███████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓███▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██▓▓░░▓██▒░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░██░░░▓▓███████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓███▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓████▓▒░░▓█▓░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░▓█▓░░░▓▓████████▓▓▓▓▓▓▓▓▓▓▓▓▓███▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██▓▓▒░░░██▒░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░▓█▓░░░░▓▓████████▓▓▓▓▓▓▓▓▓▓▓▓███▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓███▓▓▒░░░▒██░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░▓██░░░░░░▓▓████████▓▓▓▓▓▓▓▓▓▓███▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█▓▓▒░░░░░▓█▓░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░▓▓▓░░░░░░░▓▓████████▓▓▓▓▓▓▓▓▓███▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░▒█▓▒░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░▒▓▓▓░░░░░░░░▒▒▓▓██████▓▓▓▓▓▓▓▓███▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░█▓▓░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░▒▓▒▓▒░░░░░░░░░░░▒▓▓▓█████▓▓▓▓▓▓███▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░▓▓▓▓▒░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░▓█░░░░░░░░░░░░░░░░▒▒▓▓▓▓▓▓▓▓▓▓███▓▓▓▓▓▓▓▓▓▓▒▒░░░░░░░░░░░░░░░▒█▒░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░▒▓█▒░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒▒▒▒▓▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░▓█▓░░░░░░░░░░░░    //
//    ░░░░░░░░░░░▓██▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓█▓░░░░░░░░░░░    //
//    ░░░░░░░░░░░░▓█▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓█▒░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░    //
//                                                                                                  //
//                                                                                                  //
//                                                                                                  //
//                                                                                                  //
//////////////////////////////////////////////////////////////////////////////////////////////////////


contract theBUG is ERC721Creator {
    constructor() ERC721Creator("Summer Wagner 1/1", "theBUG") {}
}