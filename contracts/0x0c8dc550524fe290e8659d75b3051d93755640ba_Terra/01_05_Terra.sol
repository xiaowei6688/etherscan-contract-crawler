// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: TerraCotta
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

///////////////////////////////////////////////////////////////////////////////////
//                                                                               //
//                                                                               //
//    ___________                        _________         __    __              //
//    \__    ___/______________________  \_   ___ \  _____/  |__/  |______       //
//      |    |_/ __ \_  __ \_  __ \__  \ /    \  \/ /  _ \   __\   __\__  \      //
//      |    |\  ___/|  | \/|  | \// __ \\     \___(  <_> )  |  |  |  / __ \_    //
//      |____| \___  >__|   |__|  (____  /\______  /\____/|__|  |__| (____  /    //
//                 \/                  \/        \/                       \/     //
//                                                                               //
//                                                                               //
///////////////////////////////////////////////////////////////////////////////////


contract Terra is ERC721Creator {
    constructor() ERC721Creator("TerraCotta", "Terra") {}
}