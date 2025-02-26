// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Fables- Storytime Dao
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

///////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                           //
//                                                                                           //
//                                                                                           //
//    ▄████  ██   ███   █     ▄███▄     ▄▄▄▄▄          ▄▄▄▄▄      ▄▄▄▄▀ ██▄   ██   ████▄     //
//    █▀   ▀ █ █  █  █  █     █▀   ▀   █     ▀▄       █     ▀▄ ▀▀▀ █    █  █  █ █  █   █     //
//    █▀▀    █▄▄█ █ ▀ ▄ █     ██▄▄   ▄  ▀▀▀▀▄       ▄  ▀▀▀▀▄       █    █   █ █▄▄█ █   █     //
//    █      █  █ █  ▄▀ ███▄  █▄   ▄▀ ▀▄▄▄▄▀         ▀▄▄▄▄▀       █     █  █  █  █ ▀████     //
//     █        █ ███       ▀ ▀███▀                              ▀      ███▀     █           //
//      ▀      █                                                                █            //
//            ▀                                                                ▀             //
//                                                                                           //
//                                                                                           //
//                                                                                           //
///////////////////////////////////////////////////////////////////////////////////////////////


contract AFSD1 is ERC721Creator {
    constructor() ERC721Creator("Fables- Storytime Dao", "AFSD1") {}
}