// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: MMIRO GENESIS
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

///////////////////////////////////////////////////////////////////////////////////////
//                                                                                   //
//                                                                                   //
//        ___       ___       ___       ___       ___            ___       ___       //
//       /\__\     /\__\     /\  \     /\  \     /\  \          /\  \     /\  \      //
//      /::L_L_   /::L_L_   _\:\  \   /::\  \   /::\  \        /::\  \   /::\  \     //
//     /:/L:\__\ /:/L:\__\ /\/::\__\ /::\:\__\ /:/\:\__\      /:/\:\__\ /::\:\__\    //
//     \/_/:/  / \/_/:/  / \::/\/__/ \;:::/  / \:\/:/  /      \:\:\/__/ \:\:\/  /    //
//       /:/  /    /:/  /   \:\__\    |:\/__/   \::/  /        \::/  /   \:\/  /     //
//       \/__/     \/__/     \/__/     \|__|     \/__/          \/__/     \/__/      //
//                                                                                   //
//                                                                                   //
///////////////////////////////////////////////////////////////////////////////////////


contract MMIROGE is ERC721Creator {
    constructor() ERC721Creator("MMIRO GENESIS", "MMIROGE") {}
}