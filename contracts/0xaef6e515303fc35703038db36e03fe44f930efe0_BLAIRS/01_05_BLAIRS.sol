// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Loch Of Blairs & The Surroundings
/// @author: manifold.xyz

import "./ERC721Creator.sol";

///////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                           //
//                                                                                           //
//                                                                                           //
//    _________  ________   ________ __________  _________    _____ _____________________    //
//    \_   ___ \ \_____  \  \_____  \\______   \/   _____/   /  _  \\______   \__    ___/    //
//    /    \  \/  /   |   \  /   |   \|     ___/\_____  \   /  /_\  \|       _/ |    |       //
//    \     \____/    |    \/    |    \    |    /        \ /    |    \    |   \ |    |       //
//     \______  /\_______  /\_______  /____|   /_______  / \____|__  /____|_  / |____|       //
//            \/         \/         \/                 \/          \/       \/               //
//                                                                                           //
//                                                                                           //
//                                                                                           //
///////////////////////////////////////////////////////////////////////////////////////////////


contract BLAIRS is ERC721Creator {
    constructor() ERC721Creator("Loch Of Blairs & The Surroundings", "BLAIRS") {}
}