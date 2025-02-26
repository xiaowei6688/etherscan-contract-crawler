// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: EGG
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                            //
//                                                                                            //
//                                                                                            //
//        ████████████████████████████████████████████████████████████████████████████████    //
//        ████████████████████████████████████████████████████████████████████████████████    //
//        ████████████████████████████████████████████████████████████████████████████████    //
//        ████████████████████████████████████████████████████████████████████████████████    //
//        ████████████████████████████████████████████████████████████████████████████████    //
//        ████████████████████████████████████████████████████████████████████████████████    //
//        ██████████████████████████████████▀╙        ╙▀██████████████████████████████████    //
//        ███████████████████████████████▀`              └▀███████████████████████████████    //
//        █████████████████████████████▀                    ╙█████████████████████████████    //
//        ████████████████████████████                        ▀███████████████████████████    //
//        ██████████████████████████▀                          └██████████████████████████    //
//        █████████████████████████                              █████████████████████████    //
//        ████████████████████████                                ████████████████████████    //
//        ███████████████████████                                  ███████████████████████    //
//        ██████████████████████¬                                   ██████████████████████    //
//        █████████████████████▌                                    ╙█████████████████████    //
//        █████████████████████                                      █████████████████████    //
//        █████████████████████                                      ╟████████████████████    //
//        ████████████████████▌                                      ▐████████████████████    //
//        ████████████████████▌                                      j████████████████████    //
//        ████████████████████▌                                      ▐████████████████████    //
//        ████████████████████▌                                      ╟████████████████████    //
//        █████████████████████                                      █████████████████████    //
//        █████████████████████▌                                    ▐█████████████████████    //
//        ██████████████████████⌐                                   ██████████████████████    //
//        ███████████████████████µ                                 ███████████████████████    //
//        ████████████████████████▄                              ╓████████████████████████    //
//        ██████████████████████████                            ▓█████████████████████████    //
//        ████████████████████████████▄                      ╓▓███████████████████████████    //
//        ██████████████████████████████▓▄                ▄▓██████████████████████████████    //
//        ████████████████████████████████████▄▄▄▄▄▄▄▄████████████████████████████████████    //
//        ████████████████████████████████████████████████████████████████████████████████    //
//        ████████████████████████████████████████████████████████████████████████████████    //
//        ████████████████████████████████████████████████████████████████████████████████    //
//        ████████████████████████████████████████████████████████████████████████████████    //
//        ████████████████████████████████████████████████████████████████████████████████    //
//                                                                                            //
//    ---                                                                                     //
//    asciiart.club                                                                           //
//                                                                                            //
//                                                                                            //
//                                                                                            //
////////////////////////////////////////////////////////////////////////////////////////////////


contract Eggs is ERC721Creator {
    constructor() ERC721Creator("EGG", "Eggs") {}
}