// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Thomas Lin Pedersen Editions
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                        //
//                                                                                        //
//                                                                                        //
//                  ___       ___       ___       ___       ___       ___                 //
//                 /\  \     /\__\     /\  \     /\__\     /\  \     /\  \                //
//                 \:\  \   /:/__/_   /::\  \   /::L_L_   /::\  \   /::\  \               //
//                 /::\__\ /::\/\__\ /:/\:\__\ /:/L:\__\ /::\:\__\ /\:\:\__\              //
//                /:/\/__/ \/\::/  / \:\/:/  / \/_/:/  / \/\::/  / \:\:\/__/              //
//                \/__/      /:/  /   \::/  /    /:/  /    /:/  /   \::/  /               //
//                           \/__/     \/__/     \/__/     \/__/     \/__/                //
//                                 ___       ___       ___                                //
//                                /\__\     /\  \     /\__\                               //
//                               /:/  /    _\:\  \   /:| _|_                              //
//                              /:/__/    /\/::\__\ /::|/\__\                             //
//                              \:\  \    \::/\/__/ \/|::/  /                             //
//                               \:\__\    \:\__\     |:/  /                              //
//                                \/__/     \/__/     \/__/                               //
//        ___       ___       ___       ___       ___       ___       ___       ___       //
//       /\  \     /\  \     /\  \     /\  \     /\  \     /\  \     /\  \     /\__\      //
//      /::\  \   /::\  \   /::\  \   /::\  \   /::\  \   /::\  \   /::\  \   /:| _|_     //
//     /::\:\__\ /::\:\__\ /:/\:\__\ /::\:\__\ /::\:\__\ /\:\:\__\ /::\:\__\ /::|/\__\    //
//     \/\::/  / \:\:\/  / \:\/:/  / \:\:\/  / \;:::/  / \:\:\/__/ \:\:\/  / \/|::/  /    //
//        \/__/   \:\/  /   \::/  /   \:\/  /   |:\/__/   \::/  /   \:\/  /    |:/  /     //
//                 \/__/     \/__/     \/__/     \|__|     \/__/     \/__/     \/__/      //
//        ___       ___       ___       ___       ___       ___       ___       ___       //
//       /\  \     /\  \     /\  \     /\  \     /\  \     /\  \     /\__\     /\  \      //
//      /::\  \   /::\  \   _\:\  \    \:\  \   _\:\  \   /::\  \   /:| _|_   /::\  \     //
//     /::\:\__\ /:/\:\__\ /\/::\__\   /::\__\ /\/::\__\ /:/\:\__\ /::|/\__\ /\:\:\__\    //
//     \:\:\/  / \:\/:/  / \::/\/__/  /:/\/__/ \::/\/__/ \:\/:/  / \/|::/  / \:\:\/__/    //
//      \:\/  /   \::/  /   \:\__\    \/__/     \:\__\    \::/  /    |:/  /   \::/  /     //
//       \/__/     \/__/     \/__/               \/__/     \/__/     \/__/     \/__/      //
//                                                                                        //
//                                                                                        //
//                                                                                        //
////////////////////////////////////////////////////////////////////////////////////////////


contract TLPED is ERC1155Creator {
    constructor() ERC1155Creator("Thomas Lin Pedersen Editions", "TLPED") {}
}