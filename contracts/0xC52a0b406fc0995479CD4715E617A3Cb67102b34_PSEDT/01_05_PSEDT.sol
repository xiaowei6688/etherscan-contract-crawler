// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: plodes studio | editions
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

/////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                         //
//                                                                                         //
//                                                                                         //
//            █▌              ▐█            //R/          ▄                █▐█             //
//    ▄ ▄▄▄▄  █▌  ▄▄▄▄    ▄▄▄▄▐█  ▄▄▄▄   ▄▄▄▄       ▄▄▄  ▄█▄ ▄     ▄  ▄▄▄▄▐█ ▄  ▄▄▄▄       //
//    ██    █ █▌██   ▀█ ▄█    ██▐█   ▀█ █▌   ▀    ▐█   ▀  █▌ █▌    █ █▀   ██▐█ █▀   █▌     //
//    █▌    ▐▌█▌█     █▐█▌    ▐█▐█▀▀▀▀▀  ▀▀██▄     ▀▀██▄  █▌ █▌    █▐█     █▐█▐▌    ▐█     //
//    ██    █ █▌██   ▄█ ▀█    ██▐█    █ █▄   █▌   ▐█   ▐█ █▌ ▐█   ▄█▐█▄   ██▐█▐█▄   ██     //
//    █▌▀▀▀▀  ▀   ▀▀▀▀    ▀▀▀▀ ▀  ▀▀▀▀   ▀▀▀▀       ▀▀▀▀   ▀▀ ▀▀▀▀ ▀  ▀▀▀▀ ▀ ▀  ▀▀▀▀       //
//    █▌                                                                                   //
//                                                                                         //
//                                                                                         //
//                                                                                         //
//                                                                                         //
/////////////////////////////////////////////////////////////////////////////////////////////


contract PSEDT is ERC1155Creator {
    constructor() ERC1155Creator("plodes studio | editions", "PSEDT") {}
}