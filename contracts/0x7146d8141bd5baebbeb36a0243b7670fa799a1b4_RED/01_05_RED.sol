// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: R.E.D
/// @author: manifold.xyz

import "./ERC721Creator.sol";

////////////////////////////////////
//                                //
//                                //
//                                //
//     ██▀███  ▓█████ ▓█████▄     //
//    ▓██ ▒ ██▒▓█   ▀ ▒██▀ ██▌    //
//    ▓██ ░▄█ ▒▒███   ░██   █▌    //
//    ▒██▀▀█▄  ▒▓█  ▄ ░▓█▄   ▌    //
//    ░██▓ ▒██▒░▒████▒░▒████▓     //
//    ░ ▒▓ ░▒▓░░░ ▒░ ░ ▒▒▓  ▒     //
//      ░▒ ░ ▒░ ░ ░  ░ ░ ▒  ▒     //
//      ░░   ░    ░    ░ ░  ░     //
//       ░        ░  ░   ░        //
//                     ░          //
//                                //
//                                //
//                                //
////////////////////////////////////


contract RED is ERC721Creator {
    constructor() ERC721Creator("R.E.D", "RED") {}
}