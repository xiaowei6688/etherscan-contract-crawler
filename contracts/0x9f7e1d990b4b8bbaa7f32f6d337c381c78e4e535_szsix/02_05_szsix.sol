// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: szcollection6
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

//////////////////////////////////////////////////////////////////////////
//                                                                      //
//                                                                      //
//                                                                      //
//     _____                 _       ______           _                 //
//    /  ___|               | |     |___  /          | |                //
//    \ `--.  __ _ _ __ __ _| |__      / / _   _  ___| | _____ _ __     //
//     `--. \/ _` | '__/ _` | '_ \    / / | | | |/ __| |/ / _ \ '__|    //
//    /\__/ / (_| | | | (_| | | | | ./ /__| |_| | (__|   <  __/ |       //
//    \____/ \__,_|_|  \__,_|_| |_| \_____/\__,_|\___|_|\_\___|_|       //
//                                                                      //
//                                                                      //
//            A collection by Sarah Zucker / @thesarahshow              //
//                                                                      //
//                                                                      //
//////////////////////////////////////////////////////////////////////////


contract szsix is ERC721Creator {
    constructor() ERC721Creator("szcollection6", "szsix") {}
}