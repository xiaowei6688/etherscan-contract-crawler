// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Certificate of Authenticity by Giuseppe Lo Schiavo
/// @author: manifold.xyz

import "./ERC721Creator.sol";

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                                                                                                                                  //
//                                                                                                                                                                                                                                                  //
//      ______                        __      __   ______   __                      __                                 ______                               __      __                             __      __            __    __                   //
//     /      \                      |  \    |  \ /      \ |  \                    |  \                               /      \                             |  \    |  \                           |  \    |  \          |  \  |  \                  //
//    |  $$$$$$\  ______    ______  _| $$_    \$$|  $$$$$$\ \$$  _______  ______  _| $$_     ______          ______  |  $$$$$$\        ______   __    __  _| $$_   | $$____    ______   _______  _| $$_    \$$  _______  \$$ _| $$_    __    __     //
//    | $$   \$$ /      \  /      \|   $$ \  |  \| $$_  \$$|  \ /       \|      \|   $$ \   /      \        /      \ | $$_  \$$       |      \ |  \  |  \|   $$ \  | $$    \  /      \ |       \|   $$ \  |  \ /       \|  \|   $$ \  |  \  |  \    //
//    | $$      |  $$$$$$\|  $$$$$$\\$$$$$$  | $$| $$ \    | $$|  $$$$$$$ \$$$$$$\\$$$$$$  |  $$$$$$\      |  $$$$$$\| $$ \            \$$$$$$\| $$  | $$ \$$$$$$  | $$$$$$$\|  $$$$$$\| $$$$$$$\\$$$$$$  | $$|  $$$$$$$| $$ \$$$$$$  | $$  | $$    //
//    | $$   __ | $$    $$| $$   \$$ | $$ __ | $$| $$$$    | $$| $$      /      $$ | $$ __ | $$    $$      | $$  | $$| $$$$           /      $$| $$  | $$  | $$ __ | $$  | $$| $$    $$| $$  | $$ | $$ __ | $$| $$      | $$  | $$ __ | $$  | $$    //
//    | $$__/  \| $$$$$$$$| $$       | $$|  \| $$| $$      | $$| $$_____|  $$$$$$$ | $$|  \| $$$$$$$$      | $$__/ $$| $$            |  $$$$$$$| $$__/ $$  | $$|  \| $$  | $$| $$$$$$$$| $$  | $$ | $$|  \| $$| $$_____ | $$  | $$|  \| $$__/ $$    //
//     \$$    $$ \$$     \| $$        \$$  $$| $$| $$      | $$ \$$     \\$$    $$  \$$  $$ \$$     \       \$$    $$| $$             \$$    $$ \$$    $$   \$$  $$| $$  | $$ \$$     \| $$  | $$  \$$  $$| $$ \$$     \| $$   \$$  $$ \$$    $$    //
//      \$$$$$$   \$$$$$$$ \$$         \$$$$  \$$ \$$       \$$  \$$$$$$$ \$$$$$$$   \$$$$   \$$$$$$$        \$$$$$$  \$$              \$$$$$$$  \$$$$$$     \$$$$  \$$   \$$  \$$$$$$$ \$$   \$$   \$$$$  \$$  \$$$$$$$ \$$    \$$$$  _\$$$$$$$    //
//                                                                                                                                                                                                                                    |  \__| $$    //
//                                                                                                                                                                                                                                     \$$    $$    //
//                                                                                                                                                                                                                                      \$$$$$$     //
//                                                                                                                                                                                                                                                  //
//                                                                                                                                                                                                                                                  //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract GLOS is ERC721Creator {
    constructor() ERC721Creator("Certificate of Authenticity by Giuseppe Lo Schiavo", "GLOS") {}
}