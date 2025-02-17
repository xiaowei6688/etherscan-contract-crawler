// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Checks - Eggs
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

///////////////////////////////////////////////////////////
//                                                       //
//                                                       //
//                                                       //
//    _________ .__                   __                 //
//    \_   ___ \|  |__   ____   ____ |  | __  ______     //
//    /    \  \/|  |  \_/ __ \_/ ___\|  |/ / /  ___/     //
//    \     \___|   Y  \  ___/\  \___|    <  \___ \      //
//     \______  /___|  /\___  >\___  >__|_ \/____  >     //
//            \/     \/     \/     \/     \/     \/      //
//              ___________                              //
//              \_   _____/  ____   ____  ______         //
//      ______   |    __)_  / ___\ / ___\/  ___/         //
//     /_____/   |        \/ /_/  > /_/  >___ \          //
//              /_______  /\___  /\___  /____  >         //
//                      \//_____//_____/     \/          //
//                                                       //
//    These eggs may or may not be notable.              //
//                                                       //
//                                                       //
///////////////////////////////////////////////////////////


contract ChecksEggs is ERC1155Creator {
    constructor() ERC1155Creator("Checks - Eggs", "ChecksEggs") {}
}