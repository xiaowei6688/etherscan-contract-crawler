// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Atomic Symphony
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                     //
//                                                                                                                                     //
//     _______  _______  _______  __   __  ___   _______    _______  __   __  __   __  _______  __   __  _______  __    _  __   __     //
//    |   _   ||       ||       ||  |_|  ||   | |       |  |       ||  | |  ||  |_|  ||       ||  | |  ||       ||  |  | ||  | |  |    //
//    |  |_|  ||_     _||   _   ||       ||   | |       |  |  _____||  |_|  ||       ||    _  ||  |_|  ||   _   ||   |_| ||  |_|  |    //
//    |       |  |   |  |  | |  ||       ||   | |       |  | |_____ |       ||       ||   |_| ||       ||  | |  ||       ||       |    //
//    |       |  |   |  |  |_|  ||       ||   | |      _|  |_____  ||_     _||       ||    ___||       ||  |_|  ||  _    ||_     _|    //
//    |   _   |  |   |  |       || ||_|| ||   | |     |_    _____| |  |   |  | ||_|| ||   |    |   _   ||       || | |   |  |   |      //
//    |__| |__|  |___|  |_______||_|   |_||___| |_______|  |_______|  |___|  |_|   |_||___|    |__| |__||_______||_|  |__|  |___|      //
//                                                                                                                                     //
//                                                                                                                                     //
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract ATMS is ERC721Creator {
    constructor() ERC721Creator("Atomic Symphony", "ATMS") {}
}