// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Eggs x Checks
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

///////////////////////////////////////////////////////////////////////////////////////
//                                                                                   //
//                                                                                   //
//              _____                    _____                    _____              //
//             /\    \                  /\    \                  /\    \             //
//            /::\    \                /::\    \                /::\    \            //
//           /::::\    \              /::::\    \              /::::\    \           //
//          /::::::\    \            /::::::\    \            /::::::\    \          //
//         /:::/\:::\    \          /:::/\:::\    \          /:::/\:::\    \         //
//        /:::/__\:::\    \        /:::/  \:::\    \        /:::/  \:::\    \        //
//       /::::\   \:::\    \      /:::/    \:::\    \      /:::/    \:::\    \       //
//      /::::::\   \:::\    \    /:::/    / \:::\    \    /:::/    / \:::\    \      //
//     /:::/\:::\   \:::\    \  /:::/    /   \:::\ ___\  /:::/    /   \:::\ ___\     //
//    /:::/__\:::\   \:::\____\/:::/____/  ___\:::|    |/:::/____/  ___\:::|    |    //
//    \:::\   \:::\   \::/    /\:::\    \ /\  /:::|____|\:::\    \ /\  /:::|____|    //
//     \:::\   \:::\   \/____/  \:::\    /::\ \::/    /  \:::\    /::\ \::/    /     //
//      \:::\   \:::\    \       \:::\   \:::\ \/____/    \:::\   \:::\ \/____/      //
//       \:::\   \:::\____\       \:::\   \:::\____\       \:::\   \:::\____\        //
//        \:::\   \::/    /        \:::\  /:::/    /        \:::\  /:::/    /        //
//         \:::\   \/____/          \:::\/:::/    /          \:::\/:::/    /         //
//          \:::\    \               \::::::/    /            \::::::/    /          //
//           \:::\____\               \::::/    /              \::::/    /           //
//            \::/    /                \::/____/                \::/____/            //
//             \/____/                                                               //
//                                                                                   //
//                                                                                   //
//                                                                                   //
///////////////////////////////////////////////////////////////////////////////////////


contract EGG is ERC1155Creator {
    constructor() ERC1155Creator("Eggs x Checks", "EGG") {}
}