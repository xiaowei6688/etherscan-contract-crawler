// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Thunderbird Labz AI
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

///////////////////
//               //
//               //
//    AI LABZ    //
//               //
//               //
///////////////////


contract AILABZ is ERC1155Creator {
    constructor() ERC1155Creator("Thunderbird Labz AI", "AILABZ") {}
}