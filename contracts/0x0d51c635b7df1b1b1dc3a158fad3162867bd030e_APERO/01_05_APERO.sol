// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: ApeRock NFT
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

///////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                               //
//                                                                                               //
//                                                                                               //
//       _____               __________               __      _______  ______________________    //
//      /  _  \ ______   ____\______   \ ____   ____ |  | __  \      \ \_   _____/\__    ___/    //
//     /  /_\  \\____ \_/ __ \|       _//  _ \_/ ___\|  |/ /  /   |   \ |    __)    |    |       //
//    /    |    \  |_> >  ___/|    |   (  <_> )  \___|    <  /    |    \|     \     |    |       //
//    \____|__  /   __/ \___  >____|_  /\____/ \___  >__|_ \ \____|__  /\___  /     |____|       //
//            \/|__|        \/       \/            \/     \/         \/     \/                   //
//                                                                                               //
//                                                                                               //
//                                                                                               //
///////////////////////////////////////////////////////////////////////////////////////////////////


contract APERO is ERC1155Creator {
    constructor() ERC1155Creator("ApeRock NFT", "APERO") {}
}