// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: JOHN HAMON - MASK
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

//////////////////////////////////////////////////////////
//                                                      //
//                                                      //
//                                                      //
//             ██  ██████  ██   ██ ███    ██            //
//             ██ ██    ██ ██   ██ ████   ██            //
//             ██ ██    ██ ███████ ██ ██  ██            //
//        ██   ██ ██    ██ ██   ██ ██  ██ ██            //
//         █████   ██████  ██   ██ ██   ████            //
//                                                      //
//                                                      //
//    ██   ██  █████  ███    ███  ██████  ███    ██     //
//    ██   ██ ██   ██ ████  ████ ██    ██ ████   ██     //
//    ███████ ███████ ██ ████ ██ ██    ██ ██ ██  ██     //
//    ██   ██ ██   ██ ██  ██  ██ ██    ██ ██  ██ ██     //
//    ██   ██ ██   ██ ██      ██  ██████  ██   ████     //
//                                                      //
//                                                      //
//                                                      //
//                                                      //
//////////////////////////////////////////////////////////


contract JHM is ERC1155Creator {
    constructor() ERC1155Creator("JOHN HAMON - MASK", "JHM") {}
}