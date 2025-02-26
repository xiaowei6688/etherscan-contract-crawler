// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: rahul iyer editions
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

//////////////////////////////////////////////////////////////////////
//                                                                  //
//                                                                  //
//                                                                  //
//                  .__          .__    .__                         //
//    ____________  |  |__  __ __|  |   |__|___.__. ___________     //
//    \_  __ \__  \ |  |  \|  |  \  |   |  <   |  |/ __ \_  __ \    //
//     |  | \// __ \|   Y  \  |  /  |__ |  |\___  \  ___/|  | \/    //
//     |__|  (____  /___|  /____/|____/ |__|/ ____|\___  >__|       //
//                \/     \/                 \/         \/           //
//               .___.__  __  .__                                   //
//      ____   __| _/|__|/  |_|__| ____   ____   ______             //
//    _/ __ \ / __ | |  \   __\  |/  _ \ /    \ /  ___/             //
//    \  ___// /_/ | |  ||  | |  (  <_> )   |  \\___ \              //
//     \___  >____ | |__||__| |__|\____/|___|  /____  >             //
//         \/     \/                         \/     \/              //
//                                                                  //
//                                                                  //
//                                                                  //
//////////////////////////////////////////////////////////////////////


contract rie is ERC721Creator {
    constructor() ERC721Creator("rahul iyer editions", "rie") {}
}