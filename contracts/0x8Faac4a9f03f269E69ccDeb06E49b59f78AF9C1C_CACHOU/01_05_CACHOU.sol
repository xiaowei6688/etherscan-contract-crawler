// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: CA CHOU
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                                                      //
//                                                                                                                                                                      //
//                                                                                                                                                                      //
//              _____                    _____                            _____                    _____                   _______                   _____              //
//             /\    \                  /\    \                          /\    \                  /\    \                 /::\    \                 /\    \             //
//            /::\    \                /::\    \                        /::\    \                /::\____\               /::::\    \               /::\____\            //
//           /::::\    \              /::::\    \                      /::::\    \              /:::/    /              /::::::\    \             /:::/    /            //
//          /::::::\    \            /::::::\    \                    /::::::\    \            /:::/    /              /::::::::\    \           /:::/    /             //
//         /:::/\:::\    \          /:::/\:::\    \                  /:::/\:::\    \          /:::/    /              /:::/~~\:::\    \         /:::/    /              //
//        /:::/  \:::\    \        /:::/__\:::\    \                /:::/  \:::\    \        /:::/____/              /:::/    \:::\    \       /:::/    /               //
//       /:::/    \:::\    \      /::::\   \:::\    \              /:::/    \:::\    \      /::::\    \             /:::/    / \:::\    \     /:::/    /                //
//      /:::/    / \:::\    \    /::::::\   \:::\    \            /:::/    / \:::\    \    /::::::\    \   _____   /:::/____/   \:::\____\   /:::/    /      _____      //
//     /:::/    /   \:::\    \  /:::/\:::\   \:::\    \          /:::/    /   \:::\    \  /:::/\:::\    \ /\    \ |:::|    |     |:::|    | /:::/____/      /\    \     //
//    /:::/____/     \:::\____\/:::/  \:::\   \:::\____\        /:::/____/     \:::\____\/:::/  \:::\    /::\____\|:::|____|     |:::|    ||:::|    /      /::\____\    //
//    \:::\    \      \::/    /\::/    \:::\  /:::/    /        \:::\    \      \::/    /\::/    \:::\  /:::/    / \:::\    \   /:::/    / |:::|____\     /:::/    /    //
//     \:::\    \      \/____/  \/____/ \:::\/:::/    /          \:::\    \      \/____/  \/____/ \:::\/:::/    /   \:::\    \ /:::/    /   \:::\    \   /:::/    /     //
//      \:::\    \                       \::::::/    /            \:::\    \                       \::::::/    /     \:::\    /:::/    /     \:::\    \ /:::/    /      //
//       \:::\    \                       \::::/    /              \:::\    \                       \::::/    /       \:::\__/:::/    /       \:::\    /:::/    /       //
//        \:::\    \                      /:::/    /                \:::\    \                      /:::/    /         \::::::::/    /         \:::\__/:::/    /        //
//         \:::\    \                    /:::/    /                  \:::\    \                    /:::/    /           \::::::/    /           \::::::::/    /         //
//          \:::\    \                  /:::/    /                    \:::\    \                  /:::/    /             \::::/    /             \::::::/    /          //
//           \:::\____\                /:::/    /                      \:::\____\                /:::/    /               \::/____/               \::::/    /           //
//            \::/    /                \::/    /                        \::/    /                \::/    /                 ~~                      \::/____/            //
//             \/____/                  \/____/                          \/____/                  \/____/                                           ~~                  //
//                                                                                                                                                                      //
//                                                                                                                                                                      //
//                                                                                                                                                                      //
//                                                                                                                                                                      //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract CACHOU is ERC721Creator {
    constructor() ERC721Creator("CA CHOU", "CACHOU") {}
}