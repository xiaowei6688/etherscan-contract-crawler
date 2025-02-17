// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: IN THE ROOM
/// @author: manifold.xyz

import "./ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                                                                            //
//                      ___           ___           ___           ___         //
//          ___        /\  \         /\  \         /\  \         /\__\        //
//         /\  \       \:\  \       /::\  \       /::\  \       /::|  |       //
//         \:\  \       \:\  \     /:/\:\  \     /:/\:\  \     /:|:|  |       //
//         /::\__\      /::\  \   /::\~\:\  \   /:/  \:\  \   /:/|:|__|__     //
//      __/:/\/__/     /:/\:\__\ /:/\:\ \:\__\ /:/__/ \:\__\ /:/ |::::\__\    //
//     /\/:/  /       /:/  \/__/ \/_|::\/:/  / \:\  \ /:/  / \/__/~~/:/  /    //
//     \::/__/       /:/  /         |:|::/  /   \:\  /:/  /        /:/  /     //
//      \:\__\       \/__/          |:|\/__/     \:\/:/  /        /:/  /      //
//       \/__/                      |:|  |        \::/  /        /:/  /       //
//                                   \|__|         \/__/         \/__/        //
//                                                                            //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////


contract ITROM is ERC721Creator {
    constructor() ERC721Creator("IN THE ROOM", "ITROM") {}
}