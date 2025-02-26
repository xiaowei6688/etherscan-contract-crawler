// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: WPF 2023
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

////////////////////////////////////
//                                //
//                                //
//    $$$$$$$$$$$$$$$$$$$$$$$$    //
//    $                      $    //
//    $                      $    //
//    $       WPF 2023       $    //
//    $      COLLECTION      $    //
//    $                      $    //
//    $                      $    //
//    $$$$$$$$$$$$$$$$$$$$$$$$    //
//                                //
//                                //
////////////////////////////////////


contract WPF23 is ERC1155Creator {
    constructor() ERC1155Creator("WPF 2023", "WPF23") {}
}