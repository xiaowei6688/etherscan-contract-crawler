// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: SKUZMIN PHOTOGRAPHY 1/1
/// @author: manifold.xyz

import "./ERC721Creator.sol";

/////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                     //
//                                                                                                     //
//                                                                                                     //
//    ███████╗██╗  ██╗██╗   ██╗███████╗███╗   ███╗██╗███╗   ██╗                                        //
//    ██╔════╝██║ ██╔╝██║   ██║╚══███╔╝████╗ ████║██║████╗  ██║                                        //
//    ███████╗█████╔╝ ██║   ██║  ███╔╝ ██╔████╔██║██║██╔██╗ ██║                                        //
//    ╚════██║██╔═██╗ ██║   ██║ ███╔╝  ██║╚██╔╝██║██║██║╚██╗██║                                        //
//    ███████║██║  ██╗╚██████╔╝███████╗██║ ╚═╝ ██║██║██║ ╚████║                                        //
//    ╚══════╝╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚═╝     ╚═╝╚═╝╚═╝  ╚═══╝                                        //
//                                                                                                     //
//    ██████╗ ██╗  ██╗ ██████╗ ████████╗ ██████╗  ██████╗ ██████╗  █████╗ ██████╗ ██╗  ██╗██╗   ██╗    //
//    ██╔══██╗██║  ██║██╔═══██╗╚══██╔══╝██╔═══██╗██╔════╝ ██╔══██╗██╔══██╗██╔══██╗██║  ██║╚██╗ ██╔╝    //
//    ██████╔╝███████║██║   ██║   ██║   ██║   ██║██║  ███╗██████╔╝███████║██████╔╝███████║ ╚████╔╝     //
//    ██╔═══╝ ██╔══██║██║   ██║   ██║   ██║   ██║██║   ██║██╔══██╗██╔══██║██╔═══╝ ██╔══██║  ╚██╔╝      //
//    ██║     ██║  ██║╚██████╔╝   ██║   ╚██████╔╝╚██████╔╝██║  ██║██║  ██║██║     ██║  ██║   ██║       //
//    ╚═╝     ╚═╝  ╚═╝ ╚═════╝    ╚═╝    ╚═════╝  ╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝╚═╝     ╚═╝  ╚═╝   ╚═╝       //
//                                                                                                     //
//                                                                                                     //
//                                                                                                     //
//                                                                                                     //
/////////////////////////////////////////////////////////////////////////////////////////////////////////


contract SKUZMIN1 is ERC721Creator {
    constructor() ERC721Creator("SKUZMIN PHOTOGRAPHY 1/1", "SKUZMIN1") {}
}