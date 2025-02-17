// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Turkey Tents
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                                                   //
//                                                                                                                                                                   //
//                                                                                                                                                                   //
//                      ___           ___           ___           ___                                            ___           ___                       ___         //
//          ___        /__/\         /  /\         /__/|         /  /\          ___                  ___        /  /\         /__/\          ___        /  /\        //
//         /  /\       \  \:\       /  /::\       |  |:|        /  /:/_        /__/|                /  /\      /  /:/_        \  \:\        /  /\      /  /:/_       //
//        /  /:/        \  \:\     /  /:/\:\      |  |:|       /  /:/ /\      |  |:|               /  /:/     /  /:/ /\        \  \:\      /  /:/     /  /:/ /\      //
//       /  /:/     ___  \  \:\   /  /:/~/:/    __|  |:|      /  /:/ /:/_     |  |:|              /  /:/     /  /:/ /:/_   _____\__\:\    /  /:/     /  /:/ /::\     //
//      /  /::\    /__/\  \__\:\ /__/:/ /:/___ /__/\_|:|____ /__/:/ /:/ /\  __|__|:|             /  /::\    /__/:/ /:/ /\ /__/::::::::\  /  /::\    /__/:/ /:/\:\    //
//     /__/:/\:\   \  \:\ /  /:/ \  \:\/:::::/ \  \:\/:::::/ \  \:\/:/ /:/ /__/::::\            /__/:/\:\   \  \:\/:/ /:/ \  \:\~~\~~\/ /__/:/\:\   \  \:\/:/~/:/    //
//     \__\/  \:\   \  \:\  /:/   \  \::/~~~~   \  \::/~~~~   \  \::/ /:/     ~\~~\:\           \__\/  \:\   \  \::/ /:/   \  \:\  ~~~  \__\/  \:\   \  \::/ /:/     //
//          \  \:\   \  \:\/:/     \  \:\        \  \:\        \  \:\/:/        \  \:\               \  \:\   \  \:\/:/     \  \:\           \  \:\   \__\/ /:/      //
//           \__\/    \  \::/       \  \:\        \  \:\        \  \::/          \__\/                \__\/    \  \::/       \  \:\           \__\/     /__/:/       //
//                     \__\/         \__\/         \__\/         \__\/                                          \__\/         \__\/                     \__\/        //
//                                                                                                                                                                   //
//                                                                                                                                                                   //
//                                                                                                                                                                   //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract T2023 is ERC721Creator {
    constructor() ERC721Creator("Turkey Tents", "T2023") {}
}