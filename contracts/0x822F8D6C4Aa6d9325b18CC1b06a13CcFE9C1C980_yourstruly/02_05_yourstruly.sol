// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: i love you
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                      //
//                                                                                                                      //
//    ██    ██  ██████  ██    ██ ██████  ███████     ████████ ██████  ██    ██ ██   ██    ██                            //
//     ██  ██  ██    ██ ██    ██ ██   ██ ██             ██    ██   ██ ██    ██ ██    ██  ██                             //
//      ████   ██    ██ ██    ██ ██████  ███████        ██    ██████  ██    ██ ██     ████                              //
//       ██    ██    ██ ██    ██ ██   ██      ██        ██    ██   ██ ██    ██ ██      ██                               //
//       ██     ██████   ██████  ██   ██ ███████        ██    ██   ██  ██████  ███████ ██                               //
//                                                                                                                      //
//                                                                                                                      //
//                                                                                                                      //
//                                                                                                                      //
//                                                                                                                      //
//                                                                                                                      //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract yourstruly is ERC1155Creator {
    constructor() ERC1155Creator("i love you", "yourstruly") {}
}