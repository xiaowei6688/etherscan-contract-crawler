// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: AI Sculptures
/// @author: manifold.xyz

import "./ERC721Creator.sol";

//////////////////////////////////////////////////////////////
//                                                          //
//                                                          //
//    ░▀█▀░█░█░█▀▀                                          //
//    ░░█░░█▀█░█▀▀                                          //
//    ░░▀░░▀░▀░▀▀▀                                          //
//    ░█▀▄░▀█▀░█▀▄░▀█▀░█░█                                  //
//    ░█▀▄░░█░░█▀▄░░█░░█▀█                                  //
//    ░▀▀░░▀▀▀░▀░▀░░▀░░▀░▀                                  //
//    ░█▀█░█▀▀                                              //
//    ░█░█░█▀▀                                              //
//    ░▀▀▀░▀░░                                              //
//    ░█▀█░▀█▀░░░█▀▀░█▀▀░█░█░█░░░█▀█░▀█▀░█░█░█▀▄░█▀▀░█▀▀    //
//    ░█▀█░░█░░░░▀▀█░█░░░█░█░█░░░█▀▀░░█░░█░█░█▀▄░█▀▀░▀▀█    //
//    ░▀░▀░▀▀▀░░░▀▀▀░▀▀▀░▀▀▀░▀▀▀░▀░░░░▀░░▀▀▀░▀░▀░▀▀▀░▀▀▀    //
//    ░█▀▄░█░█                                              //
//    ░█▀▄░░█░                                              //
//    ░▀▀░░░▀░                                              //
//    ░█▀▀░█▀█░█▀▄░█░█░▀█▀░▀█▀░█▀▀                          //
//    ░█░█░█░█░█░█░█▄█░░█░░░█░░▀▀█                          //
//    ░▀▀▀░▀▀▀░▀▀░░▀░▀░▀▀▀░░▀░░▀▀▀                          //
//                                                          //
//                                                          //
//////////////////////////////////////////////////////////////


contract AIS is ERC721Creator {
    constructor() ERC721Creator("AI Sculptures", "AIS") {}
}