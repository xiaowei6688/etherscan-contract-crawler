// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Anubis
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

/////////////////////////////////////////////////////////
//                                                     //
//                                                     //
//                                                     //
//    ░█████╗░███╗░░██╗██╗░░░██╗██████╗░██╗░██████╗    //
//    ██╔══██╗████╗░██║██║░░░██║██╔══██╗██║██╔════╝    //
//    ███████║██╔██╗██║██║░░░██║██████╦╝██║╚█████╗░    //
//    ██╔══██║██║╚████║██║░░░██║██╔══██╗██║░╚═══██╗    //
//    ██║░░██║██║░╚███║╚██████╔╝██████╦╝██║██████╔╝    //
//    ╚═╝░░╚═╝╚═╝░░╚══╝░╚═════╝░╚═════╝░╚═╝╚═════╝░    //
//                                                     //
//                                                     //
/////////////////////////////////////////////////////////


contract ANB is ERC1155Creator {
    constructor() ERC1155Creator("Anubis", "ANB") {}
}