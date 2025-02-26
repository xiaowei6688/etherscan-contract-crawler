// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: ETHIOPIA - Collector's Edition
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

//////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                              //
//                                                                                              //
//                                                                                              //
//     _______   _________             _________   _______    _______   _________   _______     //
//    (  ____ \  \__   __/  |\     /|  \__   __/  (  ___  )  (  ____ )  \__   __/  (  ___  )    //
//    | (    \/     ) (     | )   ( |     ) (     | (   ) |  | (    )|     ) (     | (   ) |    //
//    | (__         | |     | (___) |     | |     | |   | |  | (____)|     | |     | (___) |    //
//    |  __)        | |     |  ___  |     | |     | |   | |  |  _____)     | |     |  ___  |    //
//    | (           | |     | (   ) |     | |     | |   | |  | (           | |     | (   ) |    //
//    | (____/\     | |     | )   ( |  ___) (___  | (___) |  | )        ___) (___  | )   ( |    //
//    (_______/     )_(     |/     \|  \_______/  (_______)  |/         \_______/  |/     \|    //
//                                                                                              //
//                                                                                              //
//                                                                                              //
//                                                                                              //
//////////////////////////////////////////////////////////////////////////////////////////////////


contract ETH is ERC721Creator {
    constructor() ERC721Creator("ETHIOPIA - Collector's Edition", "ETH") {}
}