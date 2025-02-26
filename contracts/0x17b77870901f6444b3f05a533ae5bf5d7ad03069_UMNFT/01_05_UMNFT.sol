// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Financial Commitment via Emoji
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                                          //
//                                                                                                                                                          //
//                                                                                                                                                          //
//     ________                             ______          ______                             __        ________  __                                       //
//    |        \                           /      \        /      \                           |  \      |        \|  \                                      //
//    | $$$$$$$$  ______    ______        |  $$$$$$\      |  $$$$$$\  ______    ______    ____| $$       \$$$$$$$$ \$$ ______ ____    ______                //
//    | $$__     /      \  /      \       | $$__| $$      | $$ __\$$ /      \  /      \  /      $$         | $$   |  \|      \    \  /      \               //
//    | $$  \   |  $$$$$$\|  $$$$$$\      | $$    $$      | $$|    \|  $$$$$$\|  $$$$$$\|  $$$$$$$         | $$   | $$| $$$$$$\$$$$\|  $$$$$$\              //
//    | $$$$$   | $$  | $$| $$   \$$      | $$$$$$$$      | $$ \$$$$| $$  | $$| $$  | $$| $$  | $$         | $$   | $$| $$ | $$ | $$| $$    $$              //
//    | $$      | $$__/ $$| $$            | $$  | $$      | $$__| $$| $$__/ $$| $$__/ $$| $$__| $$         | $$   | $$| $$ | $$ | $$| $$$$$$$$ __           //
//    | $$       \$$    $$| $$            | $$  | $$       \$$    $$ \$$    $$ \$$    $$ \$$    $$         | $$   | $$| $$ | $$ | $$ \$$     \|  \          //
//     \$$        \$$$$$$  \$$             \$$   \$$        \$$$$$$   \$$$$$$   \$$$$$$   \$$$$$$$          \$$    \$$ \$$  \$$  \$$  \$$$$$$$| $$          //
//                                                                                                                                             \$           //
//                                                                                                                                                          //
//                                                                                                                                                          //
//     ________                             ______          ______                             __        ________  __                                       //
//    |        \                           /      \        /      \                           |  \      |        \|  \                                      //
//    | $$$$$$$$  ______    ______        |  $$$$$$\      |  $$$$$$\  ______    ______    ____| $$       \$$$$$$$$ \$$ ______ ____    ______                //
//    | $$__     /      \  /      \       | $$__| $$      | $$ __\$$ /      \  /      \  /      $$         | $$   |  \|      \    \  /      \               //
//    | $$  \   |  $$$$$$\|  $$$$$$\      | $$    $$      | $$|    \|  $$$$$$\|  $$$$$$\|  $$$$$$$         | $$   | $$| $$$$$$\$$$$\|  $$$$$$\              //
//    | $$$$$   | $$  | $$| $$   \$$      | $$$$$$$$      | $$ \$$$$| $$  | $$| $$  | $$| $$  | $$         | $$   | $$| $$ | $$ | $$| $$    $$              //
//    | $$      | $$__/ $$| $$            | $$  | $$      | $$__| $$| $$__/ $$| $$__/ $$| $$__| $$         | $$   | $$| $$ | $$ | $$| $$$$$$$$ __           //
//    | $$       \$$    $$| $$            | $$  | $$       \$$    $$ \$$    $$ \$$    $$ \$$    $$         | $$   | $$| $$ | $$ | $$ \$$     \|  \          //
//     \$$        \$$$$$$  \$$             \$$   \$$        \$$$$$$   \$$$$$$   \$$$$$$   \$$$$$$$          \$$    \$$ \$$  \$$  \$$  \$$$$$$$| $$          //
//                                                                                                                                             \$           //
//                                                                                                                                                          //
//                                                                                                                                                          //
//      ______             __  __        __    __                      __                  __       __              __        __                            //
//     /      \           |  \|  \      |  \  |  \                    |  \                |  \     /  \            |  \      |  \                           //
//    |  $$$$$$\  ______  | $$| $$      | $$  | $$ _______    _______ | $$  ______        | $$\   /  $$  ______   _| $$_    _| $$_                          //
//    | $$   \$$ |      \ | $$| $$      | $$  | $$|       \  /       \| $$ /      \       | $$$\ /  $$$ |      \ |   $$ \  |   $$ \                         //
//    | $$        \$$$$$$\| $$| $$      | $$  | $$| $$$$$$$\|  $$$$$$$| $$|  $$$$$$\      | $$$$\  $$$$  \$$$$$$\ \$$$$$$   \$$$$$$                         //
//    | $$   __  /      $$| $$| $$      | $$  | $$| $$  | $$| $$      | $$| $$    $$      | $$\$$ $$ $$ /      $$  | $$ __   | $$ __                        //
//    | $$__/  \|  $$$$$$$| $$| $$      | $$__/ $$| $$  | $$| $$_____ | $$| $$$$$$$$      | $$ \$$$| $$|  $$$$$$$  | $$|  \  | $$|  \                       //
//     \$$    $$ \$$    $$| $$| $$       \$$    $$| $$  | $$ \$$     \| $$ \$$     \      | $$  \$ | $$ \$$    $$   \$$  $$   \$$  $$                       //
//      \$$$$$$   \$$$$$$$ \$$ \$$        \$$$$$$  \$$   \$$  \$$$$$$$ \$$  \$$$$$$$       \$$      \$$  \$$$$$$$    \$$$$     \$$$$                        //
//                                                                                                                                                          //
//                                                                                                                                                          //
//                                                                                                                                                          //
//         ______                                                              __        __        __                  __      __                           //
//       _/      \_                                                           |  \      |  \      |  \                |  \    |  \                          //
//      /   $$$$$$ \   __    __  _______    _______  ______ ____    ______   _| $$_    _| $$_    _| $$_     ______   _| $$_   | $$____                      //
//     /  $$$____$$$\ |  \  |  \|       \  /       \|      \    \  |      \ |   $$ \  |   $$ \  |   $$ \   /      \ |   $$ \  | $$    \                     //
//    |  $$/     \ $$\| $$  | $$| $$$$$$$\|  $$$$$$$| $$$$$$\$$$$\  \$$$$$$\ \$$$$$$   \$$$$$$   \$$$$$$  |  $$$$$$\ \$$$$$$  | $$$$$$$\                    //
//    | $$|  $$$$$| $$| $$  | $$| $$  | $$| $$      | $$ | $$ | $$ /      $$  | $$ __   | $$ __   | $$ __ | $$    $$  | $$ __ | $$  | $$                    //
//    | $$| $$| $$| $$| $$__/ $$| $$  | $$| $$_____ | $$ | $$ | $$|  $$$$$$$  | $$|  \  | $$|  \  | $$|  \| $$$$$$$$  | $$|  \| $$  | $$                    //
//    | $$ \$$  $$| $$ \$$    $$| $$  | $$ \$$     \| $$ | $$ | $$ \$$    $$   \$$  $$   \$$  $$   \$$  $$ \$$     \   \$$  $$| $$  | $$                    //
//     \$$\ \$$$$$$$$   \$$$$$$  \$$   \$$  \$$$$$$$ \$$  \$$  \$$  \$$$$$$$    \$$$$     \$$$$     \$$$$   \$$$$$$$    \$$$$  \$$   \$$                    //
//      \$$\ __/   \                                                                                                                                        //
//       \$$$    $$$                                                                                                                                        //
//         \$$$$$$                                                                                                                                          //
//                                                                                                                                                          //
//                                                                                                                                                          //
//                                                                                                                                                          //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract UMNFT is ERC1155Creator {
    constructor() ERC1155Creator("Financial Commitment via Emoji", "UMNFT") {}
}