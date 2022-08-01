// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Crypto Blueprints
/// @author: manifold.xyz

import "./ERC721Creator.sol";

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                  //
//                                                                                                                                  //
//                                                                                                                                  //
//      ,ad8888ba,   88888888ba  8b        d8  88888888ba  888888888888  ,ad8888ba,                                                 //
//     d8"'    `"8b  88      "8b  Y8,    ,8P   88      "8b      88      d8"'    `"8b                                                //
//    d8'            88      ,8P   Y8,  ,8P    88      ,8P      88     d8'        `8b                                               //
//    88             88aaaaaa8P'    "8aa8"     88aaaaaa8P'      88     88          88                                               //
//    88             88""""88'       `88'      88""""""'        88     88          88                                               //
//    Y8,            88    `8b        88       88               88     Y8,        ,8P                                               //
//     Y8a.    .a8P  88     `8b       88       88               88      Y8a.    .a8P                                                //
//      `"Y8888Y"'   88      `8b      88       88               88       `"Y8888Y"'                                                 //
//                                                                                                                                  //
//                                                                                                                                  //
//                                                                                                                                  //
//    88888888ba   88          88        88  88888888888  88888888ba   88888888ba   88  888b      88  888888888888  ad88888ba       //
//    88      "8b  88          88        88  88           88      "8b  88      "8b  88  8888b     88       88      d8"     "8b      //
//    88      ,8P  88          88        88  88           88      ,8P  88      ,8P  88  88 `8b    88       88      Y8,              //
//    88aaaaaa8P'  88          88        88  88aaaaa      88aaaaaa8P'  88aaaaaa8P'  88  88  `8b   88       88      `Y8aaaaa,        //
//    88""""""8b,  88          88        88  88"""""      88""""""'    88""""88'    88  88   `8b  88       88        `"""""8b,      //
//    88      `8b  88          88        88  88           88           88    `8b    88  88    `8b 88       88              `8b      //
//    88      a8P  88          Y8a.    .a8P  88           88           88     `8b   88  88     `8888       88      Y8a     a8P      //
//    88888888P"   88888888888  `"Y8888Y"'   88888888888  88           88      `8b  88  88      `888       88       "Y88888P"       //
//                                                                                                                                  //
//                                                                                                                                  //
//                                                                                                                                  //
//                                                                                                                                  //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract CB is ERC721Creator {
    constructor() ERC721Creator("Crypto Blueprints", "CB") {}
}