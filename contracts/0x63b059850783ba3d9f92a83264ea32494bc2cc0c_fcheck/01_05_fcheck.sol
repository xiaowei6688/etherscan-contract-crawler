// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: fuck check
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                               //
//                                                                                                                                               //
//          ___           ___           ___           ___                    ___           ___           ___           ___           ___         //
//         /\  \         /\__\         /\  \         /\__\                  /\  \         /\__\         /\  \         /\  \         /\__\        //
//        /::\  \       /:/  /        /::\  \       /:/  /                 /::\  \       /:/  /        /::\  \       /::\  \       /:/  /        //
//       /:/\:\  \     /:/  /        /:/\:\  \     /:/__/                 /:/\:\  \     /:/__/        /:/\:\  \     /:/\:\  \     /:/__/         //
//      /::\~\:\  \   /:/  /  ___   /:/  \:\  \   /::\__\____            /:/  \:\  \   /::\  \ ___   /::\~\:\  \   /:/  \:\  \   /::\__\____     //
//     /:/\:\ \:\__\ /:/__/  /\__\ /:/__/ \:\__\ /:/\:::::\__\          /:/__/ \:\__\ /:/\:\  /\__\ /:/\:\ \:\__\ /:/__/ \:\__\ /:/\:::::\__\    //
//     \/__\:\ \/__/ \:\  \ /:/  / \:\  \  \/__/ \/_|:|~~|~             \:\  \  \/__/ \/__\:\/:/  / \:\~\:\ \/__/ \:\  \  \/__/ \/_|:|~~|~       //
//          \:\__\    \:\  /:/  /   \:\  \          |:|  |               \:\  \            \::/  /   \:\ \:\__\    \:\  \          |:|  |        //
//           \/__/     \:\/:/  /     \:\  \         |:|  |                \:\  \           /:/  /     \:\ \/__/     \:\  \         |:|  |        //
//                      \::/  /       \:\__\        |:|  |                 \:\__\         /:/  /       \:\__\        \:\__\        |:|  |        //
//                       \/__/         \/__/         \|__|                  \/__/         \/__/         \/__/         \/__/         \|__|        //
//                                                                                                                                               //
//                                                                                                                                               //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract fcheck is ERC721Creator {
    constructor() ERC721Creator("fuck check", "fcheck") {}
}