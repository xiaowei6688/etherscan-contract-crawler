// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: meis3d
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

//////////////////////////////////////////////////////////
//                                                      //
//                                                      //
//    ███╗   ███╗███████╗██╗███████╗██████╗ ██████╗     //
//    ████╗ ████║██╔════╝██║██╔════╝╚════██╗██╔══██╗    //
//    ██╔████╔██║█████╗  ██║███████╗ █████╔╝██║  ██║    //
//    ██║╚██╔╝██║██╔══╝  ██║╚════██║ ╚═══██╗██║  ██║    //
//    ██║ ╚═╝ ██║███████╗██║███████║██████╔╝██████╔╝    //
//    ╚═╝     ╚═╝╚══════╝╚═╝╚══════╝╚═════╝ ╚═════╝     //
//                                                      //
//                                                      //
//////////////////////////////////////////////////////////


contract msg3d is ERC1155Creator {
    constructor() ERC1155Creator("meis3d", "msg3d") {}
}