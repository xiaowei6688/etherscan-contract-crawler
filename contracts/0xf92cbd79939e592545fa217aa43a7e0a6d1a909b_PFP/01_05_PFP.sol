// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: NOT SO BLUE PFP
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

////////////////////////////////////////////////////////////////////
//                                                                //
//                                                                //
//                                                                //
//    ███    ██  ██████  ████████     ██████  ███████ ██████      //
//    ████   ██ ██    ██    ██        ██   ██ ██      ██   ██     //
//    ██ ██  ██ ██    ██    ██        ██████  █████   ██████      //
//    ██  ██ ██ ██    ██    ██        ██      ██      ██          //
//    ██   ████  ██████     ██        ██      ██      ██          //
//                                                                //
//                                                                //
//                                                                //
//                                                                //
//                                                                //
////////////////////////////////////////////////////////////////////


contract PFP is ERC1155Creator {
    constructor() ERC1155Creator("NOT SO BLUE PFP", "PFP") {}
}