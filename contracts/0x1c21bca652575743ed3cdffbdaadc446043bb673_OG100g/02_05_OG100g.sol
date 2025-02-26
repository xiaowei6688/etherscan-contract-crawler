// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: OG 100 Guys
/// @author: manifold.xyz

import "./ERC721Creator.sol";

//////////////////////////////////////////////////////////////////////////////////
//                                                                              //
//                                                                              //
//                                                                              //
//     /$$   /$$                           /$$                           /$$    //
//    | $$  | $$                          | $$                          | $$    //
//    | $$  | $$ /$$   /$$ /$$$$$$$   /$$$$$$$  /$$$$$$   /$$$$$$   /$$$$$$$    //
//    | $$$$$$$$| $$  | $$| $$__  $$ /$$__  $$ /$$__  $$ /$$__  $$ /$$__  $$    //
//    | $$__  $$| $$  | $$| $$  \ $$| $$  | $$| $$  \__/| $$$$$$$$| $$  | $$    //
//    | $$  | $$| $$  | $$| $$  | $$| $$  | $$| $$      | $$_____/| $$  | $$    //
//    | $$  | $$|  $$$$$$/| $$  | $$|  $$$$$$$| $$      |  $$$$$$$|  $$$$$$$    //
//    |__/  |__/ \______/ |__/  |__/ \_______/|__/       \_______/ \_______/    //
//                                                                              //
//                                                                              //
//                                                                              //
//                                                                              //
//                                                                              //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////


contract OG100g is ERC721Creator {
    constructor() ERC721Creator("OG 100 Guys", "OG100g") {}
}