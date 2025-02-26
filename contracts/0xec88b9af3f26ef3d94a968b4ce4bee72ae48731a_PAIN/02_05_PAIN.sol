// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: .Pain
/// @author: manifold.xyz

import "./ERC721Creator.sol";

//////////////////////////////////////////////////////
//                                                  //
//                                                  //
//                                                  //
//         /$$$$$$$   /$$$$$$  /$$$$$$ /$$   /$$    //
//        | $$__  $$ /$$__  $$|_  $$_/| $$$ | $$    //
//        | $$  \ $$| $$  \ $$  | $$  | $$$$| $$    //
//        | $$$$$$$/| $$$$$$$$  | $$  | $$ $$ $$    //
//        | $$____/ | $$__  $$  | $$  | $$  $$$$    //
//        | $$      | $$  | $$  | $$  | $$\  $$$    //
//     /$$| $$      | $$  | $$ /$$$$$$| $$ \  $$    //
//    |__/|__/      |__/  |__/|______/|__/  \__/    //
//                                                  //
//                                                  //
//                                                  //
//                                                  //
//                                                  //
//                                                  //
//////////////////////////////////////////////////////


contract PAIN is ERC721Creator {
    constructor() ERC721Creator(".Pain", "PAIN") {}
}