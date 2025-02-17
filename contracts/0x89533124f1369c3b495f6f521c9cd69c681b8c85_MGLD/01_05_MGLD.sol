// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Merge - Glitch Edition
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

//////////////////////////////////////////////////////////////////////////////////////////
//                                                                                      //
//                                                                                      //
//       _____                                 ________.__  .__  __         .__         //
//      /     \   ___________  ____   ____    /  _____/|  | |__|/  |_  ____ |  |__      //
//     /  \ /  \_/ __ \_  __ \/ ___\_/ __ \  /   \  ___|  | |  \   __\/ ___\|  |  \     //
//    /    Y    \  ___/|  | \/ /_/  >  ___/  \    \_\  \  |_|  ||  | \  \___|   Y  \    //
//    \____|__  /\___  >__|  \___  / \___  >  \______  /____/__||__|  \___  >___|  /    //
//            \/     \/     /_____/      \/          \/                   \/     \/     //
//                                                                                      //
//                                                                                      //
//////////////////////////////////////////////////////////////////////////////////////////


contract MGLD is ERC721Creator {
    constructor() ERC721Creator("Merge - Glitch Edition", "MGLD") {}
}