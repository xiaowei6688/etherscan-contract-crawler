// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Illuminati Checks - Open Eye Edition
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

///////////////////////////////////////////////////////////////////////////////////
//                                                                               //
//                                                                               //
//              _____                _____                    _____              //
//             /\    \              |\    \                  /\    \             //
//            /::\    \             |:\____\                /::\    \            //
//           /::::\    \            |::|   |               /::::\    \           //
//          /::::::\    \           |::|   |              /::::::\    \          //
//         /:::/\:::\    \          |::|   |             /:::/\:::\    \         //
//        /:::/__\:::\    \         |::|   |            /:::/__\:::\    \        //
//       /::::\   \:::\    \        |::|   |           /::::\   \:::\    \       //
//      /::::::\   \:::\    \       |::|___|______    /::::::\   \:::\    \      //
//     /:::/\:::\   \:::\    \      /::::::::\    \  /:::/\:::\   \:::\    \     //
//    /:::/__\:::\   \:::\____\    /::::::::::\____\/:::/__\:::\   \:::\____\    //
//    \:::\   \:::\   \::/    /   /:::/~~~~/~~      \:::\   \:::\   \::/    /    //
//     \:::\   \:::\   \/____/   /:::/    /          \:::\   \:::\   \/____/     //
//      \:::\   \:::\    \      /:::/    /            \:::\   \:::\    \         //
//       \:::\   \:::\____\    /:::/    /              \:::\   \:::\____\        //
//        \:::\   \::/    /    \::/    /                \:::\   \::/    /        //
//         \:::\   \/____/      \/____/                  \:::\   \/____/         //
//          \:::\    \                                    \:::\    \             //
//           \:::\____\                                    \:::\____\            //
//            \::/    /                                     \::/    /            //
//             \/____/                                       \/____/             //
//                                                                               //
//                                                                               //
//                                                                               //
///////////////////////////////////////////////////////////////////////////////////


contract IEYE is ERC721Creator {
    constructor() ERC721Creator("Illuminati Checks - Open Eye Edition", "IEYE") {}
}