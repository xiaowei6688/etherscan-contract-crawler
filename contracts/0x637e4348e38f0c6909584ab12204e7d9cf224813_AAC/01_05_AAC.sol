// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Arisse Art Commissions
/// @author: manifold.xyz

import "./ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                            //
//                                                                                            //
//                                                                                            //
//                                                                                            //
//        ████████████████████████████████████████████████████████████████████████████████    //
//        ████████████████████████████████████████████████████████████████████████████████    //
//        ██████████████████████████████████  ████████████████████████████████████████████    //
//        ███████████████████████████████     ████████████████████████████████████████████    //
//        ████████████████████████████   ██  █████████████████████████████████████████████    //
//        ██████████████████████████   ███   ███████████████████████████      ████████████    //
//        █████████████████████████  ████   █████████████    ████████   ████   ███████████    //
//        ███████████████████████  ██████  ████████████  ██  ██████   ████████████████████    //
//        █████████████████████   ██████  ███████████  ████  █████  ██████████████████████    //
//        ████████████████████  ███████  ██████████   █████  ████  ███████████████████████    //
//        ██████████████████   ███████  ██████████  ██████   ███  ████████████████████████    //
//        █████████████████  ████████  ██████████  ███████  ████  ███████████████  ███████    //
//        ███████████████   ████████   ████████   ███████   ████  █████████████   ████████    //
//        ██████████████              ████████             █████  ███████████   ██████████    //
//        █████████████   █████████  █████████  █████████  ██████  ███████    ████████████    //
//        ████████████  ███████████  ███████   █████████   █████████      ████████████████    //
//        ███████████  ███████████  ███████   ██████████  ███████████████   ██████████████    //
//        ██████████  ███████████  ████████  ███████████████████████    ██████████████████    //
//        █████████  ████████████  ███████  ██████████████████    ████████████████████████    //
//        ████████  ████████████  ███████   ████████████     █████████████████████████████    //
//        ███████  ████████████  ████████  ████████     ██████████████████████████████████    //
//        ██████  █████████████  ███████████     █████████████████████████████████████████    //
//        █████  █████████████  ███████    ███████████████████████████████████████████████    //
//        █████  █████████████        ████████████████████████████████████████████████████    //
//        ████████████████████████████████████████████████████████████████████████████████    //
//        ████████████████████████████████████████████████████████████████████████████████    //
//        ████████████████████████████████████████████████████████████████████████████████    //
//        ████████████████████████████████████████████████████████████████████████████████    //
//                                                                                            //
//                                                                                            //
//                                                                                            //
//                                                                                            //
//                                                                                            //
////////////////////////////////////////////////////////////////////////////////////////////////


contract AAC is ERC721Creator {
    constructor() ERC721Creator("Arisse Art Commissions", "AAC") {}
}