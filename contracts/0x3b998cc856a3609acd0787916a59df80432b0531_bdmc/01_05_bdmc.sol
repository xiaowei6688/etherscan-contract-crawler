// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Beadedmoc
/// @author: manifold.xyz

import "./ERC721Creator.sol";

////////////////////////////////////////////////////////////////////
//                                                                //
//                                                                //
//    ▄▄▄▄· ▄▄▄ . ▄▄▄· ·▄▄▄▄  ▄▄▄ .·▄▄▄▄  • ▌ ▄ ·.        ▄▄·     //
//    ▐█ ▀█▪▀▄.▀·▐█ ▀█ ██▪ ██ ▀▄.▀·██▪ ██ ·██ ▐███▪▪     ▐█ ▌▪    //
//    ▐█▀▀█▄▐▀▀▪▄▄█▀▀█ ▐█· ▐█▌▐▀▀▪▄▐█· ▐█▌▐█ ▌▐▌▐█· ▄█▀▄ ██ ▄▄    //
//    ██▄▪▐█▐█▄▄▌▐█ ▪▐▌██. ██ ▐█▄▄▌██. ██ ██ ██▌▐█▌▐█▌.▐▌▐███▌    //
//    ·▀▀▀▀  ▀▀▀  ▀  ▀ ▀▀▀▀▀•  ▀▀▀ ▀▀▀▀▀• ▀▀  █▪▀▀▀ ▀█▄▀▪·▀▀▀     //
//                                                                //
//                                                                //
////////////////////////////////////////////////////////////////////


contract bdmc is ERC721Creator {
    constructor() ERC721Creator("Beadedmoc", "bdmc") {}
}