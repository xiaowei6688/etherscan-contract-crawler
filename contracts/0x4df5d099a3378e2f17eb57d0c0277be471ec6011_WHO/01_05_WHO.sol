// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: WHO?
/// @author: manifold.xyz

import "./ERC721Creator.sol";

//////////////////////////////////////////////////////////////////////////////////////
//                                                                                  //
//                                                                                  //
//                                                                                  //
//    ███╗   ██╗██╗████████╗ ██████╗ ██████╗ ██╗  ██╗ ██████╗ ████████╗ ██████╗     //
//    ████╗  ██║██║╚══██╔══╝██╔═══██╗██╔══██╗██║  ██║██╔═══██╗╚══██╔══╝██╔═══██╗    //
//    ██╔██╗ ██║██║   ██║   ██║   ██║██████╔╝███████║██║   ██║   ██║   ██║   ██║    //
//    ██║╚██╗██║██║   ██║   ██║   ██║██╔═══╝ ██╔══██║██║   ██║   ██║   ██║   ██║    //
//    ██║ ╚████║██║   ██║   ╚██████╔╝██║     ██║  ██║╚██████╔╝   ██║   ╚██████╔╝    //
//    ╚═╝  ╚═══╝╚═╝   ╚═╝    ╚═════╝ ╚═╝     ╚═╝  ╚═╝ ╚═════╝    ╚═╝    ╚═════╝     //
//                                                                                  //
//                                                                                  //
//                                                                                  //
//                                                                                  //
//////////////////////////////////////////////////////////////////////////////////////


contract WHO is ERC721Creator {
    constructor() ERC721Creator("WHO?", "WHO") {}
}