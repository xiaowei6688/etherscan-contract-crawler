// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Dezentral
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

////////////////////////////////////////////////////
//                                                //
//                                                //
//                                                //
//                       ___          ___         //
//         _____        /\__\        /\__\        //
//        /::\  \      /:/ _/_      /::|  |       //
//       /:/\:\  \    /:/ /\__\    /:/:|  |       //
//      /:/  \:\__\  /:/ /:/ _/_  /:/|:|  |__     //
//     /:/__/ \:|__|/:/_/:/ /\__\/:/ |:| /\__\    //
//     \:\  \ /:/  /\:\/:/ /:/  /\/__|:|/:/  /    //
//      \:\  /:/  /  \::/_/:/  /     |:/:/  /     //
//       \:\/:/  /    \:\/:/  /      |::/  /      //
//        \::/  /      \::/  /       |:/  /       //
//         \/__/        \/__/        |/__/        //
//                                                //
//                                                //
//                                                //
////////////////////////////////////////////////////


contract DEZ is ERC721Creator {
    constructor() ERC721Creator("Dezentral", "DEZ") {}
}