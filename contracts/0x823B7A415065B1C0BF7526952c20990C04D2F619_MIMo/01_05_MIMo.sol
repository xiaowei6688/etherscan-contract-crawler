// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: magic internet $
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                            //
//                                                                                                                            //
//                                                                                                                            //
//               /$$                             /$$                           /$$             /$$     /$$                    //
//              | $$                            | $$                          | $$            | $$    | $$                    //
//      /$$$$$$$| $$$$$$$   /$$$$$$  /$$   /$$ /$$$$$$    /$$$$$$  /$$   /$$ /$$$$$$         /$$$$$$  | $$$$$$$   /$$$$$$     //
//     /$$_____/| $$__  $$ /$$__  $$| $$  | $$|_  $$_/   /$$__  $$| $$  | $$|_  $$_/        |_  $$_/  | $$__  $$ /$$__  $$    //
//    |  $$$$$$ | $$  \ $$| $$  \ $$| $$  | $$  | $$    | $$  \ $$| $$  | $$  | $$            | $$    | $$  \ $$| $$$$$$$$    //
//     \____  $$| $$  | $$| $$  | $$| $$  | $$  | $$ /$$| $$  | $$| $$  | $$  | $$ /$$        | $$ /$$| $$  | $$| $$_____/    //
//     /$$$$$$$/| $$  | $$|  $$$$$$/|  $$$$$$/  |  $$$$/|  $$$$$$/|  $$$$$$/  |  $$$$/        |  $$$$/| $$  | $$|  $$$$$$$    //
//    |_______/ |__/  |__/ \______/  \______/    \___/   \______/  \______/    \___/           \___/  |__/  |__/ \_______/    //
//                                                                                                                            //
//                                                                                                                            //
//                                                                                                                            //
//                           /$$               /$$                                                                            //
//                          | $$              | $$                                                                            //
//      /$$$$$$   /$$$$$$  /$$$$$$    /$$$$$$ | $$   /$$  /$$$$$$   /$$$$$$   /$$$$$$   /$$$$$$   /$$$$$$   /$$$$$$$          //
//     /$$__  $$ |____  $$|_  $$_/   /$$__  $$| $$  /$$/ /$$__  $$ /$$__  $$ /$$__  $$ /$$__  $$ /$$__  $$ /$$_____/          //
//    | $$  \ $$  /$$$$$$$  | $$    | $$$$$$$$| $$$$$$/ | $$$$$$$$| $$$$$$$$| $$  \ $$| $$$$$$$$| $$  \__/|  $$$$$$           //
//    | $$  | $$ /$$__  $$  | $$ /$$| $$_____/| $$_  $$ | $$_____/| $$_____/| $$  | $$| $$_____/| $$       \____  $$          //
//    |  $$$$$$$|  $$$$$$$  |  $$$$/|  $$$$$$$| $$ \  $$|  $$$$$$$|  $$$$$$$| $$$$$$$/|  $$$$$$$| $$       /$$$$$$$//$$       //
//     \____  $$ \_______/   \___/   \_______/|__/  \__/ \_______/ \_______/| $$____/  \_______/|__/      |_______/|__/       //
//     /$$  \ $$                                                            | $$                                              //
//    |  $$$$$$/                                                            | $$                                              //
//     \______/                                                             |__/                                              //
//                                                                                                                            //
//                                                                                                                            //
//                                                                                                                            //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract MIMo is ERC721Creator {
    constructor() ERC721Creator("magic internet $", "MIMo") {}
}