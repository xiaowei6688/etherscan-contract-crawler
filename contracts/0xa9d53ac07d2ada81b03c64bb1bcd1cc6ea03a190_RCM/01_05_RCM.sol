// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Rue's Claw Machine
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

///////////////////////////////////////////////////////////////////////////////////////
//                                                                                   //
//                                                                                   //
//                                                                                   //
//              _____                    _____                    _____              //
//             /\    \                  /\    \                  /\    \             //
//            /::\    \                /::\    \                /::\____\            //
//           /::::\    \              /::::\    \              /::::|   |            //
//          /::::::\    \            /::::::\    \            /:::::|   |            //
//         /:::/\:::\    \          /:::/\:::\    \          /::::::|   |            //
//        /:::/__\:::\    \        /:::/  \:::\    \        /:::/|::|   |            //
//       /::::\   \:::\    \      /:::/    \:::\    \      /:::/ |::|   |            //
//      /::::::\   \:::\    \    /:::/    / \:::\    \    /:::/  |::|___|______      //
//     /:::/\:::\   \:::\____\  /:::/    /   \:::\    \  /:::/   |::::::::\    \     //
//    /:::/  \:::\   \:::|    |/:::/____/     \:::\____\/:::/    |:::::::::\____\    //
//    \::/   |::::\  /:::|____|\:::\    \      \::/    /\::/    / ~~~~~/:::/    /    //
//     \/____|:::::\/:::/    /  \:::\    \      \/____/  \/____/      /:::/    /     //
//           |:::::::::/    /    \:::\    \                          /:::/    /      //
//           |::|\::::/    /      \:::\    \                        /:::/    /       //
//           |::| \::/____/        \:::\    \                      /:::/    /        //
//           |::|  ~|               \:::\    \                    /:::/    /         //
//           |::|   |                \:::\    \                  /:::/    /          //
//           \::|   |                 \:::\____\                /:::/    /           //
//            \:|   |                  \::/    /                \::/    /            //
//             \|___|                   \/____/                  \/____/             //
//                                                                                   //
//                                                                                   //
//                                                                                   //
//                                                                                   //
///////////////////////////////////////////////////////////////////////////////////////


contract RCM is ERC1155Creator {
    constructor() ERC1155Creator("Rue's Claw Machine", "RCM") {}
}