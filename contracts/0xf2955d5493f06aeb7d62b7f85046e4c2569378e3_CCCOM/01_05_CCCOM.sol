// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Canis Coven Comic
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                        //
//                                                                                        //
//    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░░░░░░░░█▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░░░░░░░██▓░▒█░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░▓████████████▒██░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░▓█████████████████░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░▒██████████████████▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░▓███████▒▒▒████▓▒███░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░    //
//    ░░░░░░░▓████▓▒░░░░░░░██████░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░    //
//    ░░░░░░▓████░░░░░░░░░░█████░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░    //
//    ░░░░░▒███▓░░░░░░░░░░▒███▓░░░░░░░░░░░░░░▓█▒░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░    //
//    ░░░░░▓███▒░░░░░░░░░░▓▓▒░░░░░░▒▓░░░▒░░░░░░░░░░▒▓▓█░░░░▒▓░░▓█░░░░░░░░░░░░░░░░░░░░░    //
//    ░░░░░███▓░░░░░░░░░░░▓████▓░▒███░▒██▓░░▒██▒░▒▓░░██░░░░░██▓██▓▒█░░░░░░░░░░░░░░░░░░    //
//    ░░░░░▓██▒░░░░░░░░░▓█▓░████░░▒██▒████░░░██▒▓██▓░░░░░░▓▒▓█▒▓▓▒██▒░░░░░░░░░░░░░░░░░    //
//    ░░░░░▒██▓░░░░░░░░░██░▓▓▓██▓▒▓███▒▒██▓░░██░▒▓▓███▒░░░▒██▒████▓▓▒░░░░░░░░░░░░░░░░░    //
//    ░░░░░░▓██▒░░░░░░░▒██▓▓░░▓▓▒░▒██▒░░▓██▓▒██▓▓░░░▒▓██▒░░▒▓▓▓▓▓▓▓██▒░░░░░░░░░░░░░░░░    //
//    ░░░░░░░▒███▒░░░░░▒█▓░░░░░░░░▓▓░░░▒▓▓▓▒▒▓▒░░░░░░░░██░░░▒██▓▓▓█▓█▓░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░▓███▓▒▒░░░░░░░░▒▒▒▒░▒▓▒▒▒░▒▒▓███▓░░░░░░░▓▒░░░░████▓▓▓▒░░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░▒▓▓███████▓▓▒░░▒▓▓░░░░░░░░░▒███▓▒▒▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░░░░░░░░░▓▓░░░░░░░░▒░▒██▒░░░░░░░░░░░░░░░░░░░░░░░▒▒▓▓▒░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░░░░░░░▒█▓░░░░░░░▓▓▓▓▓░░░░░░░░░▓█▒░░░░░░░░░░░░░░░░░░▓██░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░░░░░░░██░░░░░░░░▒▒░░░░░░░░░░░░░█▒░░░░░░░░░░░░░░░░░░░░██▓░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░░░░░░░██░░░░░░░░░░▒▓▓▓▓░░░▒▒░░▒█░░▒▓▓██▒░▓█▒░░▓█░░░░░░██▒░░░░░░    //
//    ░░░░░░░░░░░░░░░░░░░░░░░██░░░░░░░░▒██▒░▓██░███░░▓▓▓██░▓█▓░▒██▒▒███▒░░░░░██▓░░░░░░    //
//    ░░░░░░░░░░░░░░░░░░░░░░░██▒░░░░░░░██▒░░░█▒░░██░▒█▒██▓▒▒░░░░██▒█▒██▓░░░░▓██▓░░░░░░    //
//    ░░░░░░░░░░░░░░░░░░░░░░░░██▒░░░░░░██▓▒▒▓░░░░██▓█░░███░░░░▒▒███▒░▓██░░▒███▓░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░░░░░░░░░▓██▒░░░░▒▓▓▒░░░░░░▒█▓░░░▒▓▓▓▓▒░░░██▒░░░▒▓███▓▓░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░░░░░░░░░░░▓███▓▓▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░    //
//                                                                                        //
//                                                                                        //
//                                                                                        //
////////////////////////////////////////////////////////////////////////////////////////////


contract CCCOM is ERC1155Creator {
    constructor() ERC1155Creator("Canis Coven Comic", "CCCOM") {}
}