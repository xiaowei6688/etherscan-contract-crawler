// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Check Norris Ordinal
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

/////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                         //
//                                                                                         //
//    _________ .__                   __      _______                      .__             //
//    \_   ___ \|  |__   ____   ____ |  | __  \      \   __________________|__| ______     //
//    /    \  \/|  |  \_/ __ \_/ ___\|  |/ /  /   |   \ /  _ \_  __ \_  __ \  |/  ___/     //
//    \     \___|   Y  \  ___/\  \___|    <  /    |    (  <_> )  | \/|  | \/  |\___ \      //
//     \______  /___|  /\___  >\___  >__|_ \ \____|__  /\____/|__|   |__|  |__/____  >     //
//            \/     \/     \/     \/     \/         \/                            \/      //
//                                                                                         //
//                                                                                         //
/////////////////////////////////////////////////////////////////////////////////////////////


contract CNO is ERC721Creator {
    constructor() ERC721Creator("Check Norris Ordinal", "CNO") {}
}