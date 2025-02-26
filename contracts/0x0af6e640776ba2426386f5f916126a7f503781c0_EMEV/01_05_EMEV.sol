// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Empepes - Evolutions
/// @author: manifold.xyz

import "./ERC721Creator.sol";

///////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                           //
//                                                                                                           //
//      ______                                             ______          _       _   _                     //
//     |  ____|                                           |  ____|        | |     | | (_)                    //
//     | |__   _ __ ___  _ __   ___ _ __   ___  ___ ______| |____   _____ | |_   _| |_ _  ___  _ __  ___     //
//     |  __| | '_ ` _ \| '_ \ / _ \ '_ \ / _ \/ __|______|  __\ \ / / _ \| | | | | __| |/ _ \| '_ \/ __|    //
//     | |____| | | | | | |_) |  __/ |_) |  __/\__ \      | |___\ V / (_) | | |_| | |_| | (_) | | | \__ \    //
//     |______|_| |_| |_| .__/ \___| .__/ \___||___/      |______\_/ \___/|_|\__,_|\__|_|\___/|_| |_|___/    //
//                      | |        | |                                                                       //
//                      |_|        |_|                                                                       //
//                                                                                                           //
//                                                                                                           //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract EMEV is ERC721Creator {
    constructor() ERC721Creator("Empepes - Evolutions", "EMEV") {}
}