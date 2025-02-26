// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: jamesMendenhall Originals
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////////////
//                                                                                //
//                                                                                //
//                                                           /$$      /$$         //
//                                                          | $$$    /$$$         //
//           /$$  /$$$$$$  /$$$$$$/$$$$   /$$$$$$   /$$$$$$$| $$$$  /$$$$         //
//          |__/ |____  $$| $$_  $$_  $$ /$$__  $$ /$$_____/| $$ $$/$$ $$         //
//           /$$  /$$$$$$$| $$ \ $$ \ $$| $$$$$$$$|  $$$$$$ | $$  $$$| $$         //
//          | $$ /$$__  $$| $$ | $$ | $$| $$_____/ \____  $$| $$\  $ | $$         //
//          | $$|  $$$$$$$| $$ | $$ | $$|  $$$$$$$ /$$$$$$$/| $$ \/  | $$         //
//          | $$ \_______/|__/ |__/ |__/ \_______/|_______/ |__/     |__/         //
//     /$$  | $$                                                                  //
//    |  $$$$$$/                                                                  //
//     \______/                                                                   //
//      /$$$$$$            /$$           /$$                     /$$              //
//     /$$__  $$          |__/          |__/                    | $$              //
//    | $$  \ $$  /$$$$$$  /$$  /$$$$$$  /$$ /$$$$$$$   /$$$$$$ | $$  /$$$$$$$    //
//    | $$  | $$ /$$__  $$| $$ /$$__  $$| $$| $$__  $$ |____  $$| $$ /$$_____/    //
//    | $$  | $$| $$  \__/| $$| $$  \ $$| $$| $$  \ $$  /$$$$$$$| $$|  $$$$$$     //
//    | $$  | $$| $$      | $$| $$  | $$| $$| $$  | $$ /$$__  $$| $$ \____  $$    //
//    |  $$$$$$/| $$      | $$|  $$$$$$$| $$| $$  | $$|  $$$$$$$| $$ /$$$$$$$/    //
//     \______/ |__/      |__/ \____  $$|__/|__/  |__/ \_______/|__/|_______/     //
//                             /$$  \ $$                                          //
//                            |  $$$$$$/                                          //
//                             \______/                                           //
//                                                                                //
//                                                                                //
////////////////////////////////////////////////////////////////////////////////////


contract JMOG is ERC721Creator {
    constructor() ERC721Creator("jamesMendenhall Originals", "JMOG") {}
}