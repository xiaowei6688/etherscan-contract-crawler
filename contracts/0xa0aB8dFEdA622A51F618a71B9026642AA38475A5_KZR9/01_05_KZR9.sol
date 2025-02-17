// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: KZR9
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                                                                                     //
//                                                                                                                                                                                                     //
//    oooo    oooo     oooooooooooo    ooooooooo.       .ooooo.                             .oooooo.      oooooooooooo    ooooooooo.      ooooooooooooo    ooooo      .oooooo.      ooooo      ooo     //
//    `888   .8P'     d'""""""d888'    `888   `Y88.    888' `Y88.                          d8P'  `Y8b     `888'     `8    `888   `Y88.    8'   888   `8    `888'     d8P'  `Y8b     `888b.     `8'     //
//     888  d8'             .888P       888   .d88'    888    888       oooo    ooo       888              888             888   .d88'         888          888     888      888     8 `88b.    8      //
//     88888[              d888'        888ooo88P'      `Vbood888        `88b..8P'        888              888oooo8        888ooo88P'          888          888     888      888     8   `88b.  8      //
//     888`88b.          .888P          888`88b.             888'          Y888'          888              888    "        888`88b.            888          888     888      888     8     `88b.8      //
//     888  `88b.       d888'    .P     888  `88b.         .88P'         .o8"'88b         `88b    ooo      888       o     888  `88b.          888          888     `88b    d88'     8       `888      //
//    o888o  o888o    .8888888888P     o888o  o888o      .oP'           o88'   888o        `Y8bood8P'     o888ooooood8    o888o  o888o        o888o        o888o     `Y8bood8P'     o8o        `8      //
//                                                                                                                                                                                                     //
//                                                                                                                                                                                                     //
//                                                                                                                                                                                                     //
//                                                                                                                                                                                                     //
//                                                                                                                                                                                                     //
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract KZR9 is ERC721Creator {
    constructor() ERC721Creator("KZR9", "KZR9") {}
}