// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: oPenny Edition
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

/////////////////////////////////////////////////////////////
//                                                         //
//                                                         //
//    _______ _______ _______ _______ _______ _______      //
//    |\     /|\     /|\     /|\     /|\     /|\     /|    //
//    | +---+ | +---+ | +---+ | +---+ | +---+ | +---+ |    //
//    | |   | | |   | | |   | | |   | | |   | | |   | |    //
//    | |o  | | |P  | | |e  | | |n  | | |n  | | |y  | |    //
//    | +---+ | +---+ | +---+ | +---+ | +---+ | +---+ |    //
//    |/_____\|/_____\|/_____\|/_____\|/_____\|/_____\|    //
//                                                         //
//                                                         //
/////////////////////////////////////////////////////////////


contract oPenny is ERC721Creator {
    constructor() ERC721Creator("oPenny Edition", "oPenny") {}
}