// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Layer
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                         //
//                                                                                                                         //
//              _____            _____                _____                    _____                    _____              //
//             /\    \          /\    \              |\    \                  /\    \                  /\    \             //
//            /::\____\        /::\    \             |:\____\                /::\    \                /::\    \            //
//           /:::/    /       /::::\    \            |::|   |               /::::\    \              /::::\    \           //
//          /:::/    /       /::::::\    \           |::|   |              /::::::\    \            /::::::\    \          //
//         /:::/    /       /:::/\:::\    \          |::|   |             /:::/\:::\    \          /:::/\:::\    \         //
//        /:::/    /       /:::/__\:::\    \         |::|   |            /:::/__\:::\    \        /:::/__\:::\    \        //
//       /:::/    /       /::::\   \:::\    \        |::|   |           /::::\   \:::\    \      /::::\   \:::\    \       //
//      /:::/    /       /::::::\   \:::\    \       |::|___|______    /::::::\   \:::\    \    /::::::\   \:::\    \      //
//     /:::/    /       /:::/\:::\   \:::\    \      /::::::::\    \  /:::/\:::\   \:::\    \  /:::/\:::\   \:::\____\     //
//    /:::/____/       /:::/  \:::\   \:::\____\    /::::::::::\____\/:::/__\:::\   \:::\____\/:::/  \:::\   \:::|    |    //
//    \:::\    \       \::/    \:::\  /:::/    /   /:::/~~~~/~~      \:::\   \:::\   \::/    /\::/   |::::\  /:::|____|    //
//     \:::\    \       \/____/ \:::\/:::/    /   /:::/    /          \:::\   \:::\   \/____/  \/____|:::::\/:::/    /     //
//      \:::\    \               \::::::/    /   /:::/    /            \:::\   \:::\    \            |:::::::::/    /      //
//       \:::\    \               \::::/    /   /:::/    /              \:::\   \:::\____\           |::|\::::/    /       //
//        \:::\    \              /:::/    /    \::/    /                \:::\   \::/    /           |::| \::/____/        //
//         \:::\    \            /:::/    /      \/____/                  \:::\   \/____/            |::|  ~|              //
//          \:::\    \          /:::/    /                                 \:::\    \                |::|   |              //
//           \:::\____\        /:::/    /                                   \:::\____\               \::|   |              //
//            \::/    /        \::/    /                                     \::/    /                \:|   |              //
//             \/____/          \/____/                                       \/____/                  \|___|              //
//                                                                                                                         //
//    © Layer, Inc                                                                                                         //
//                                                                                                                         //
//                                                                                                                         //
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract LAYER is ERC721Creator {
    constructor() ERC721Creator("Layer", "LAYER") {}
}