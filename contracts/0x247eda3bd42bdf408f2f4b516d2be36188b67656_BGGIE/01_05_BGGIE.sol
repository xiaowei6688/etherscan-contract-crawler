// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: BiggieStardust
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                        //
//                                                                                                                                        //
//                                                                                                                                        //
//                                                                                                                                        //
//     __        __                      __                        __                                __                        __         //
//    |  \      |  \                    |  \                      |  \                              |  \                      |  \        //
//    | $$____   \$$  ______    ______   \$$  ______    _______  _| $$_     ______    ______    ____| $$ __    __   _______  _| $$_       //
//    | $$    \ |  \ /      \  /      \ |  \ /      \  /       \|   $$ \   |      \  /      \  /      $$|  \  |  \ /       \|   $$ \      //
//    | $$$$$$$\| $$|  $$$$$$\|  $$$$$$\| $$|  $$$$$$\|  $$$$$$$ \$$$$$$    \$$$$$$\|  $$$$$$\|  $$$$$$$| $$  | $$|  $$$$$$$ \$$$$$$      //
//    | $$  | $$| $$| $$  | $$| $$  | $$| $$| $$    $$ \$$    \   | $$ __  /      $$| $$   \$$| $$  | $$| $$  | $$ \$$    \   | $$ __     //
//    | $$__/ $$| $$| $$__| $$| $$__| $$| $$| $$$$$$$$ _\$$$$$$\  | $$|  \|  $$$$$$$| $$      | $$__| $$| $$__/ $$ _\$$$$$$\  | $$|  \    //
//    | $$    $$| $$ \$$    $$ \$$    $$| $$ \$$     \|       $$   \$$  $$ \$$    $$| $$       \$$    $$ \$$    $$|       $$   \$$  $$    //
//     \$$$$$$$  \$$ _\$$$$$$$ _\$$$$$$$ \$$  \$$$$$$$ \$$$$$$$     \$$$$   \$$$$$$$ \$$        \$$$$$$$  \$$$$$$  \$$$$$$$     \$$$$     //
//                  |  \__| $$|  \__| $$                                                                                                  //
//                   \$$    $$ \$$    $$                                                                                                  //
//                    \$$$$$$   \$$$$$$                                                                                                   //
//                                                                                                                                        //
//                                                                                                                                        //
//                                                                                                                                        //
//                                                                                                                                        //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract BGGIE is ERC1155Creator {
    constructor() ERC1155Creator("BiggieStardust", "BGGIE") {}
}