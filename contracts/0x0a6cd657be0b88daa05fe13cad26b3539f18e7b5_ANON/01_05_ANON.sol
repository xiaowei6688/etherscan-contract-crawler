// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Anonymous
/// @author: manifold.xyz

import "./ERC721Creator.sol";

////////////////////////////////////////////////////////////////////
//                                                                //
//                                                                //
//          ___           ___                                     //
//         /\  \         /\__\                                    //
//        _\:\  \       /:/ _/_                                   //
//       /\ \:\  \     /:/ /\__\                                  //
//      _\:\ \:\  \   /:/ /:/ _/_                                 //
//     /\ \:\ \:\__\ /:/_/:/ /\__\                                //
//     \:\ \:\/:/  / \:\/:/ /:/  /                                //
//      \:\ \::/  /   \::/_/:/  /                                 //
//       \:\/:/  /     \:\/:/  /                                  //
//        \::/  /       \::/  /                                   //
//         \/__/         \/__/                                    //
//          ___           ___           ___                       //
//         /\  \         /\  \         /\__\                      //
//        /::\  \       /::\  \       /:/ _/_                     //
//       /:/\:\  \     /:/\:\__\     /:/ /\__\                    //
//      /:/ /::\  \   /:/ /:/  /    /:/ /:/ _/_                   //
//     /:/_/:/\:\__\ /:/_/:/__/___ /:/_/:/ /\__\                  //
//     \:\/:/  \/__/ \:\/:::::/  / \:\/:/ /:/  /                  //
//      \::/__/       \::/~~/~~~~   \::/_/:/  /                   //
//       \:\  \        \:\~~\        \:\/:/  /                    //
//        \:\__\        \:\__\        \::/  /                     //
//         \/__/         \/__/         \/__/                      //
//          ___           ___           ___           ___         //
//         /\  \         /\  \         /\  \         /\  \        //
//        /::\  \        \:\  \       /::\  \        \:\  \       //
//       /:/\:\  \        \:\  \     /:/\:\  \        \:\  \      //
//      /:/ /::\  \   _____\:\  \   /:/  \:\  \   _____\:\  \     //
//     /:/_/:/\:\__\ /::::::::\__\ /:/__/ \:\__\ /::::::::\__\    //
//     \:\/:/  \/__/ \:\~~\~~\/__/ \:\  \ /:/  / \:\~~\~~\/__/    //
//      \::/__/       \:\  \        \:\  /:/  /   \:\  \          //
//       \:\  \        \:\  \        \:\/:/  /     \:\  \         //
//        \:\__\        \:\__\        \::/  /       \:\__\        //
//         \/__/         \/__/         \/__/         \/__/        //
//                                                                //
//                                                                //
////////////////////////////////////////////////////////////////////


contract ANON is ERC721Creator {
    constructor() ERC721Creator("Anonymous", "ANON") {}
}