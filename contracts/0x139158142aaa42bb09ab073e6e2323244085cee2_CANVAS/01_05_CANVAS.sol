// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: CANVAS CAW
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////
//                                                                                    //
//                                                                                    //
//                                                                                    //
//                                                                                    //
//      /$$$$$$   /$$$$$$  /$$   /$$ /$$    /$$  /$$$$$$   /$$$$$$                    //
//     /$$__  $$ /$$__  $$| $$$ | $$| $$   | $$ /$$__  $$ /$$__  $$                   //
//    | $$  \__/| $$  \ $$| $$$$| $$| $$   | $$| $$  \ $$| $$  \__/                   //
//    | $$      | $$$$$$$$| $$ $$ $$|  $$ / $$/| $$$$$$$$|  $$$$$$                    //
//    | $$      | $$__  $$| $$  $$$$ \  $$ $$/ | $$__  $$ \____  $$                   //
//    | $$    $$| $$  | $$| $$\  $$$  \  $$$/  | $$  | $$ /$$  \ $$                   //
//    |  $$$$$$/| $$  | $$| $$ \  $$   \  $/   | $$  | $$|  $$$$$$/                   //
//     \______/ |__/  |__/|__/  \__/    \_/    |__/  |__/ \______/                    //
//                                                                                    //
//                                                                                    //
//                                                                                    //
//     /$$$$$$$$ /$$$$$$$  /$$$$$$ /$$$$$$$$ /$$$$$$  /$$$$$$  /$$   /$$  /$$$$$$     //
//    | $$_____/| $$__  $$|_  $$_/|__  $$__/|_  $$_/ /$$__  $$| $$$ | $$ /$$__  $$    //
//    | $$      | $$  \ $$  | $$     | $$     | $$  | $$  \ $$| $$$$| $$| $$  \__/    //
//    | $$$$$   | $$  | $$  | $$     | $$     | $$  | $$  | $$| $$ $$ $$|  $$$$$$     //
//    | $$__/   | $$  | $$  | $$     | $$     | $$  | $$  | $$| $$  $$$$ \____  $$    //
//    | $$      | $$  | $$  | $$     | $$     | $$  | $$  | $$| $$\  $$$ /$$  \ $$    //
//    | $$$$$$$$| $$$$$$$/ /$$$$$$   | $$    /$$$$$$|  $$$$$$/| $$ \  $$|  $$$$$$/    //
//    |________/|_______/ |______/   |__/   |______/ \______/ |__/  \__/ \______/     //
//                                                                                    //
//                                                                                    //
//                                                                                    //
//                                                                                    //
//                                                                                    //
//                                                                                    //
//                                                                                    //
////////////////////////////////////////////////////////////////////////////////////////


contract CANVAS is ERC1155Creator {
    constructor() ERC1155Creator("CANVAS CAW", "CANVAS") {}
}