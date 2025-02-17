// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Ben Mosley
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

///////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                           //
//                                                                                           //
//    ██████╗ ███████╗███╗   ██╗    ███╗   ███╗ ██████╗ ███████╗██╗     ███████╗██╗   ██╗    //
//    ██╔══██╗██╔════╝████╗  ██║    ████╗ ████║██╔═══██╗██╔════╝██║     ██╔════╝╚██╗ ██╔╝    //
//    ██████╔╝█████╗  ██╔██╗ ██║    ██╔████╔██║██║   ██║███████╗██║     █████╗   ╚████╔╝     //
//    ██╔══██╗██╔══╝  ██║╚██╗██║    ██║╚██╔╝██║██║   ██║╚════██║██║     ██╔══╝    ╚██╔╝      //
//    ██████╔╝███████╗██║ ╚████║    ██║ ╚═╝ ██║╚██████╔╝███████║███████╗███████╗   ██║       //
//    ╚═════╝ ╚══════╝╚═╝  ╚═══╝    ╚═╝     ╚═╝ ╚═════╝ ╚══════╝╚══════╝╚══════╝   ╚═╝       //
//                                                                                           //
//                                                                                           //
//                                                                                           //
///////////////////////////////////////////////////////////////////////////////////////////////


contract MOSLEY is ERC1155Creator {
    constructor() ERC1155Creator("Ben Mosley", "MOSLEY") {}
}