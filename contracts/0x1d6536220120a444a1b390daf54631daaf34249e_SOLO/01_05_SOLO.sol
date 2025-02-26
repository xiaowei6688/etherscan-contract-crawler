// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: SOLO TRIP
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

/////////////////////////////////////////////////////////////
//                                                         //
//                                                         //
//                                                         //
//    //     ▄████████  ▄██████▄   ▄█        ▄██████▄      //
//    //    ███    ███ ███    ███ ███       ███    ███     //
//    //    ███    █▀  ███    ███ ███       ███    ███     //
//    //    ███        ███    ███ ███       ███    ███     //
//    //  ▀███████████ ███    ███ ███       ███    ███     //
//    //           ███ ███    ███ ███       ███    ███     //
//    //     ▄█    ███ ███    ███ ███▌    ▄ ███    ███     //
//    //   ▄████████▀   ▀██████▀  █████▄▄██  ▀██████▀      //
//    //                          ▀                        //
//    //      ███        ▄████████  ▄█     ▄███████▄       //
//    //  ▀█████████▄   ███    ███ ███    ███    ███       //
//    //     ▀███▀▀██   ███    ███ ███▌   ███    ███       //
//    //      ███   ▀  ▄███▄▄▄▄██▀ ███▌   ███    ███       //
//    //      ███     ▀▀███▀▀▀▀▀   ███▌ ▀█████████▀        //
//    //      ███     ▀███████████ ███    ███              //
//    //      ███       ███    ███ ███    ███              //
//    //     ▄████▀     ███    ███ █▀    ▄████▀            //
//    //                ███    ███                         //
//                                                         //
//                                                         //
//                                                         //
/////////////////////////////////////////////////////////////


contract SOLO is ERC721Creator {
    constructor() ERC721Creator("SOLO TRIP", "SOLO") {}
}