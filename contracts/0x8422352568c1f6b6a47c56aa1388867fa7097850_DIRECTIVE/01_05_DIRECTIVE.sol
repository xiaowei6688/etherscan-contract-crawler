// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: DIRECTIVE CREATOR
/// @author: manifold.xyz

import "./ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////
//                                                                        //
//                                                                        //
//                                                                        //
//    ██████╗░██╗██████╗░███████╗░█████╗░████████╗██╗██╗░░░██╗███████╗    //
//    ██╔══██╗██║██╔══██╗██╔════╝██╔══██╗╚══██╔══╝██║██║░░░██║██╔════╝    //
//    ██║░░██║██║██████╔╝█████╗░░██║░░╚═╝░░░██║░░░██║╚██╗░██╔╝█████╗░░    //
//    ██║░░██║██║██╔══██╗██╔══╝░░██║░░██╗░░░██║░░░██║░╚████╔╝░██╔══╝░░    //
//    ██████╔╝██║██║░░██║███████╗╚█████╔╝░░░██║░░░██║░░╚██╔╝░░███████╗    //
//    ╚═════╝░╚═╝╚═╝░░╚═╝╚══════╝░╚════╝░░░░╚═╝░░░╚═╝░░░╚═╝░░░╚══════╝    //
//                                                                        //
//    ░█████╗░██████╗░███████╗░█████╗░████████╗░█████╗░██████╗░           //
//    ██╔══██╗██╔══██╗██╔════╝██╔══██╗╚══██╔══╝██╔══██╗██╔══██╗           //
//    ██║░░╚═╝██████╔╝█████╗░░███████║░░░██║░░░██║░░██║██████╔╝           //
//    ██║░░██╗██╔══██╗██╔══╝░░██╔══██║░░░██║░░░██║░░██║██╔══██╗           //
//    ╚█████╔╝██║░░██║███████╗██║░░██║░░░██║░░░╚█████╔╝██║░░██║           //
//    ░╚════╝░╚═╝░░╚═╝╚══════╝╚═╝░░╚═╝░░░╚═╝░░░░╚════╝░╚═╝░░╚═╝           //
//                                                                        //
//                                                                        //
////////////////////////////////////////////////////////////////////////////


contract DIRECTIVE is ERC721Creator {
    constructor() ERC721Creator("DIRECTIVE CREATOR", "DIRECTIVE") {}
}