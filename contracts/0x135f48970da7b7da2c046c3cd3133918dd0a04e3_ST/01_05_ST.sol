// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Salem Trials
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

///////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                   //
//                                                                                                   //
//    ███████╗ █████╗ ██╗     ███████╗███╗   ███╗    ████████╗██████╗ ██╗ █████╗ ██╗     ███████╗    //
//    ██╔════╝██╔══██╗██║     ██╔════╝████╗ ████║    ╚══██╔══╝██╔══██╗██║██╔══██╗██║     ██╔════╝    //
//    ███████╗███████║██║     █████╗  ██╔████╔██║       ██║   ██████╔╝██║███████║██║     ███████╗    //
//    ╚════██║██╔══██║██║     ██╔══╝  ██║╚██╔╝██║       ██║   ██╔══██╗██║██╔══██║██║     ╚════██║    //
//    ███████║██║  ██║███████╗███████╗██║ ╚═╝ ██║       ██║   ██║  ██║██║██║  ██║███████╗███████║    //
//    ╚══════╝╚═╝  ╚═╝╚══════╝╚══════╝╚═╝     ╚═╝       ╚═╝   ╚═╝  ╚═╝╚═╝╚═╝  ╚═╝╚══════╝╚══════╝    //
//                                                                                                   //
//                                                                                                   //
///////////////////////////////////////////////////////////////////////////////////////////////////////


contract ST is ERC1155Creator {
    constructor() ERC1155Creator("Salem Trials", "ST") {}
}