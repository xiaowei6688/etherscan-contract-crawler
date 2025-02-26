// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Eszter Lakatos Editions
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                    //
//                                                                                                                    //
//                                                                                                                    //
//          ___           ___           ___           ___           ___           ___                                 //
//         /\  \         /\  \         /\  \         /\  \         /\  \         /\  \                                //
//        /::\  \       /::\  \        \:\  \        \:\  \       /::\  \       /::\  \                               //
//       /:/\:\  \     /:/\ \  \        \:\  \        \:\  \     /:/\:\  \     /:/\:\  \                              //
//      /::\~\:\  \   _\:\~\ \  \        \:\  \       /::\  \   /::\~\:\  \   /::\~\:\  \                             //
//     /:/\:\ \:\__\ /\ \:\ \ \__\ _______\:\__\     /:/\:\__\ /:/\:\ \:\__\ /:/\:\ \:\__\                            //
//     \:\~\:\ \/__/ \:\ \:\ \/__/ \::::::::/__/    /:/  \/__/ \:\~\:\ \/__/ \/_|::\/:/  /                            //
//      \:\ \:\__\    \:\ \:\__\    \:\~~\~~       /:/  /       \:\ \:\__\      |:|::/  /                             //
//       \:\ \/__/     \:\/:/  /     \:\  \        \/__/         \:\ \/__/      |:|\/__/                              //
//        \:\__\        \::/  /       \:\__\                      \:\__\        |:|  |                                //
//         \/__/         \/__/         \/__/                       \/__/         \|__|                                //
//          ___       ___           ___           ___           ___           ___           ___                       //
//         /\__\     /\  \         /\__\         /\  \         /\  \         /\  \         /\  \                      //
//        /:/  /    /::\  \       /:/  /        /::\  \        \:\  \       /::\  \       /::\  \                     //
//       /:/  /    /:/\:\  \     /:/__/        /:/\:\  \        \:\  \     /:/\:\  \     /:/\ \  \                    //
//      /:/  /    /::\~\:\  \   /::\__\____   /::\~\:\  \       /::\  \   /:/  \:\  \   _\:\~\ \  \                   //
//     /:/__/    /:/\:\ \:\__\ /:/\:::::\__\ /:/\:\ \:\__\     /:/\:\__\ /:/__/ \:\__\ /\ \:\ \ \__\                  //
//     \:\  \    \/__\:\/:/  / \/_|:|~~|~    \/__\:\/:/  /    /:/  \/__/ \:\  \ /:/  / \:\ \:\ \/__/                  //
//      \:\  \        \::/  /     |:|  |          \::/  /    /:/  /       \:\  /:/  /   \:\ \:\__\                    //
//       \:\  \       /:/  /      |:|  |          /:/  /     \/__/         \:\/:/  /     \:\/:/  /                    //
//        \:\__\     /:/  /       |:|  |         /:/  /                     \::/  /       \::/  /                     //
//         \/__/     \/__/         \|__|         \/__/                       \/__/         \/__/                      //
//          ___           ___                       ___                       ___           ___           ___         //
//         /\  \         /\  \          ___        /\  \          ___        /\  \         /\__\         /\  \        //
//        /::\  \       /::\  \        /\  \       \:\  \        /\  \      /::\  \       /::|  |       /::\  \       //
//       /:/\:\  \     /:/\:\  \       \:\  \       \:\  \       \:\  \    /:/\:\  \     /:|:|  |      /:/\ \  \      //
//      /::\~\:\  \   /:/  \:\__\      /::\__\      /::\  \      /::\__\  /:/  \:\  \   /:/|:|  |__   _\:\~\ \  \     //
//     /:/\:\ \:\__\ /:/__/ \:|__|  __/:/\/__/     /:/\:\__\  __/:/\/__/ /:/__/ \:\__\ /:/ |:| /\__\ /\ \:\ \ \__\    //
//     \:\~\:\ \/__/ \:\  \ /:/  / /\/:/  /       /:/  \/__/ /\/:/  /    \:\  \ /:/  / \/__|:|/:/  / \:\ \:\ \/__/    //
//      \:\ \:\__\    \:\  /:/  /  \::/__/       /:/  /      \::/__/      \:\  /:/  /      |:/:/  /   \:\ \:\__\      //
//       \:\ \/__/     \:\/:/  /    \:\__\       \/__/        \:\__\       \:\/:/  /       |::/  /     \:\/:/  /      //
//        \:\__\        \::/__/      \/__/                     \/__/        \::/  /        /:/  /       \::/  /       //
//         \/__/         ~~                                                  \/__/         \/__/         \/__/        //
//                                                                                                                    //
//                                                                                                                    //
//                                                                                                                    //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract ELE is ERC1155Creator {
    constructor() ERC1155Creator("Eszter Lakatos Editions", "ELE") {}
}