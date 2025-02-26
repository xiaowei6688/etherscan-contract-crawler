// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: HotPocketses_01
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

////////////////////////////////////////////////////////////////////////////////////
//                                                                                //
//                                                                                //
//      _    _       _   _____           _        _                   ___  __     //
//     | |  | |     | | |  __ \         | |      | |                 / _ \/_ |    //
//     | |__| | ___ | |_| |__) |__   ___| | _____| |_ ___  ___  ___ | | | || |    //
//     |  __  |/ _ \| __|  ___/ _ \ / __| |/ / _ \ __/ __|/ _ \/ __|| | | || |    //
//     | |  | | (_) | |_| |  | (_) | (__|   <  __/ |_\__ \  __/\__ \| |_| || |    //
//     |_|  |_|\___/ \__|_|   \___/ \___|_|\_\___|\__|___/\___||___/ \___/ |_|    //
//                                                               ______           //
//                                                              |______|          //
//                                                                                //
//                                                                                //
////////////////////////////////////////////////////////////////////////////////////


contract HPS01 is ERC1155Creator {
    constructor() ERC1155Creator("HotPocketses_01", "HPS01") {}
}