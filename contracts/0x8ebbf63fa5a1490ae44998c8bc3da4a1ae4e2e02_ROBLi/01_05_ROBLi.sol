// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Rich or Bridge - Lite Pass
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

///////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                               //
//                                                                                               //
//    __________.__       .__                     __________        .__    .___                  //
//    \______   \__| ____ |  |__     ___________  \______   \_______|__| __| _/ ____   ____      //
//     |       _/  |/ ___\|  |  \   /  _ \_  __ \  |    |  _/\_  __ \  |/ __ | / ___\_/ __ \     //
//     |    |   \  \  \___|   Y  \ (  <_> )  | \/  |    |   \ |  | \/  / /_/ |/ /_/  >  ___/     //
//     |____|_  /__|\___  >___|  /  \____/|__|     |______  / |__|  |__\____ |\___  / \___  >    //
//            \/        \/     \/                         \/                \/_____/      \/     //
//                                                                                               //
//                                                                                               //
///////////////////////////////////////////////////////////////////////////////////////////////////


contract ROBLi is ERC721Creator {
    constructor() ERC721Creator("Rich or Bridge - Lite Pass", "ROBLi") {}
}