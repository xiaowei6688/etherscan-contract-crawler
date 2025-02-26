// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: insomnia
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                                                                            //
//                                                                            //
//                                                                            //
//                                                                            //
//                                                                            //
//        ████████████████████████████████████████████████████████████        //
//        ████████████████████████████████████████████████████████████        //
//        ████████████████████████████▓▓▓▓▓▓▓▓▓▓▓▓▓███████████████████        //
//        █████████████████████▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓█████████████        //
//        █████████████████▓▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▓▓█████████████        //
//        ██████████████▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▒▓▓▓▓▒▒▒▓███████████        //
//        ███████████▓▒░░░▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒░░▒▓█▓▓▓▒░▒▓▓▓▓▓▒▒██████████        //
//        █████████▓░▒▒░░░▒▒▓▓████▓▒▒▓▓▓▒▒▒▒░░▓███▓▓▒▒▒▒▓▓▓▒▒█████████        //
//        ████████▒░▒░▒░▒▒▓▓█████▓▒▓█▓▒░░░░░░░░▓█████▓▓▒▒▓▓▓▓▒████████        //
//        ███████▒▒░▒▓░▓▓▓██████▒▒▓▓▓▒░▒▒▒▓▒░░▒▒▓██████▓▓▒▒▓█▓▒███████        //
//        ██████▓░░▓▓▒▒▓███████▓▒▓▓▓▓░░░░░░░░░▒▓▒▓██▓▓██▓▓▒▒▓█▓▓██████        //
//        ██████▒░▓▓█▒▒▓███████▒▒▓▓█▓▒░░░▒▒▒░░▓█▒▒████▓▓▓▓▓▒▒▒▓▒██████        //
//        █████▓░▒▓██▓░▓███████▓▒▓▓██▓▒▒▒▒░░▒▓██▒▒██▓▓▓▓▓▓▓▓▓▒▓▓▓█████        //
//        █████▓░░▓███▒▒███████▓▒▓▓████▓▒▓▓▓███▓▒▓██████████▓▓▒▓▓█████        //
//        ██████▒▒░▓███▒▒███████▒▒▓█████▓▒▒▓▓▓▓▓████████████▓▒▒▓██████        //
//        ██████▓░▓▒░▒▓▓▒▒▓██████▒▓████████▓▓▓█████████████▓▒▒▒▓██████        //
//        ███████▒▒▓▓▓▒░░▒▒▒▒▒▓▓▓▓▒▓████████████▓▓▓▓▓▓▓▓▒▒▒▒▒▒████████        //
//        ████████▓▒▓███▓▓▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▒▒▒▒▓▓▓▓▓▓▓▓▓▓▒▓█████████        //
//        █████████▓▒▒▓█████▓▓▓▒▒▒░▒▒░░░▒▓▓▓▒▒▓▓████████▓▓▓███████████        //
//        ███████████▓▒▒▓▓███████▓▓▓█▓▓▓▓███████████▓▓▓▓▓█████████████        //
//        ██████████████▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▒▒▒▓▓▓▓▓██████████████████        //
//        ███████████████████▓▓▓▓▓▓▓▓▓▓▓▓▓████████████████████████████        //
//        ████████████████████████████████████████████████████████████        //
//        ████████████████████████████████████████████████████████████        //
//                                                                            //
//        ░█▀▀░█░█░█▀█░█▀▀░▀█▀░█░░░█░█░░░█░█░█▀█░█▀▄░▀█▀░█░█░█▀▀░█░█          //
//        ░█░█░█▀█░█░█░▀▀█░░█░░█░░░░█░░░░▀▄▀░█▀█░█▀▄░░█░░█░█░▀▀█░█▀█          //
//        ░▀▀▀░▀░▀░▀▀▀░▀▀▀░░▀░░▀▀▀░░▀░░░░░▀░░▀░▀░▀░▀░░▀░░▀▀▀░▀▀▀░▀░▀          //
//                                                                            //
//                                    .-.                                     //
//                                   (o o) boo!                               //
//                                   | O \                                    //
//                                    \   \                                   //
//                                     `~~~'                                  //
//                                                                            //
//                                                                            //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////


contract EYE is ERC721Creator {
    constructor() ERC721Creator("insomnia", "EYE") {}
}