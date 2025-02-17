// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: CHECKBARS
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

/////////////////////
//                 //
//                 //
//    CHECKBARS    //
//                 //
//                 //
/////////////////////


contract CB is ERC721Creator {
    constructor() ERC721Creator("CHECKBARS", "CB") {}
}