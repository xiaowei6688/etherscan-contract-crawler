// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: test
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

////////////////////
//                //
//                //
//    burntest    //
//                //
//                //
////////////////////


contract burntest is ERC1155Creator {
    constructor() ERC1155Creator("test", "burntest") {}
}