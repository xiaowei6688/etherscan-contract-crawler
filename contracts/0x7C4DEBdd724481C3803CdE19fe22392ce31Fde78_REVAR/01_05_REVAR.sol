// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Reaper Variants
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

/////////////////////////////////////////////////////////////////
//                                                             //
//                                                             //
//    __________                                               //
//    \______   \ ____ _____  ______   ___________             //
//     |       _// __ \\__  \ \____ \_/ __ \_  __ \            //
//     |    |   \  ___/ / __ \|  |_> >  ___/|  | \/            //
//     |____|_  /\___  >____  /   __/ \___  >__|               //
//            \/     \/     \/|__|        \/                   //
//    ____   ____            .__               __              //
//    \   \ /   /____ _______|__|____    _____/  |_  ______    //
//     \   Y   /\__  \\_  __ \  \__  \  /    \   __\/  ___/    //
//      \     /  / __ \|  | \/  |/ __ \|   |  \  |  \___ \     //
//       \___/  (____  /__|  |__(____  /___|  /__| /____  >    //
//                   \/              \/     \/          \/     //
//                                                             //
//                                                             //
/////////////////////////////////////////////////////////////////


contract REVAR is ERC1155Creator {
    constructor() ERC1155Creator("Reaper Variants", "REVAR") {}
}