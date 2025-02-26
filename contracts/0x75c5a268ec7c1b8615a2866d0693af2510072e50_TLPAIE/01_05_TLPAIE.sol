// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: The Lost Punk AI Editions
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

////////////////////////////////////////////////////////////////////
//                                                                //
//                                                                //
//          ___           ___           ___                       //
//         /\  \         /\__\         /\  \                      //
//         \:\  \       /:/  /        /::\  \                     //
//          \:\  \     /:/__/        /:/\:\  \                    //
//          /::\  \   /::\  \ ___   /::\~\:\  \                   //
//         /:/\:\__\ /:/\:\  /\__\ /:/\:\ \:\__\                  //
//        /:/  \/__/ \/__\:\/:/  / \:\~\:\ \/__/                  //
//       /:/  /           \::/  /   \:\ \:\__\                    //
//       \/__/            /:/  /     \:\ \/__/                    //
//                       /:/  /       \:\__\                      //
//                       \/__/         \/__/                      //
//          ___       ___           ___           ___             //
//         /\__\     /\  \         /\  \         /\  \            //
//        /:/  /    /::\  \       /::\  \        \:\  \           //
//       /:/  /    /:/\:\  \     /:/\ \  \        \:\  \          //
//      /:/  /    /:/  \:\  \   _\:\~\ \  \       /::\  \         //
//     /:/__/    /:/__/ \:\__\ /\ \:\ \ \__\     /:/\:\__\        //
//     \:\  \    \:\  \ /:/  / \:\ \:\ \/__/    /:/  \/__/        //
//      \:\  \    \:\  /:/  /   \:\ \:\__\     /:/  /             //
//       \:\  \    \:\/:/  /     \:\/:/  /     \/__/              //
//        \:\__\    \::/  /       \::/  /                         //
//         \/__/     \/__/         \/__/                          //
//          ___           ___           ___           ___         //
//         /\  \         /\__\         /\__\         /\__\        //
//        /::\  \       /:/  /        /::|  |       /:/  /        //
//       /:/\:\  \     /:/  /        /:|:|  |      /:/__/         //
//      /::\~\:\  \   /:/  /  ___   /:/|:|  |__   /::\__\____     //
//     /:/\:\ \:\__\ /:/__/  /\__\ /:/ |:| /\__\ /:/\:::::\__\    //
//     \/__\:\/:/  / \:\  \ /:/  / \/__|:|/:/  / \/_|:|~~|~       //
//          \::/  /   \:\  /:/  /      |:/:/  /     |:|  |        //
//           \/__/     \:\/:/  /       |::/  /      |:|  |        //
//                      \::/  /        /:/  /       |:|  |        //
//                       \/__/         \/__/         \|__|        //
//                                                                //
//                                                                //
////////////////////////////////////////////////////////////////////


contract TLPAIE is ERC1155Creator {
    constructor() ERC1155Creator("The Lost Punk AI Editions", "TLPAIE") {}
}