// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: breathe
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

////////////////////////
//                    //
//                    //
//       __   _       //
//     _(  )_( )_     //
//    (_   _    _)    //
//      (_) (__)      //
//                    //
//                    //
////////////////////////


contract brthe is ERC721Creator {
    constructor() ERC721Creator("breathe", "brthe") {}
}