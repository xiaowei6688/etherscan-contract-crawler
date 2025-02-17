// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: 1/1's
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

///////////////////////////////////////////////////////////////////
//                                                               //
//                                                               //
//        ____                     ____        __                //
//       / __ \____  ____ ___     / __ )____ _/ /_____  _____    //
//      / / / / __ \/ __ `__ \   / __  / __ `/ //_/ _ \/ ___/    //
//     / /_/ / /_/ / / / / / /  / /_/ / /_/ / ,< /  __/ /        //
//    /_____/\____/_/ /_/ /_/  /_____/\__,_/_/|_|\___/_/         //
//                                                               //
//                                                               //
//                                                               //
///////////////////////////////////////////////////////////////////


contract DomBaker is ERC721Creator {
    constructor() ERC721Creator("1/1's", "DomBaker") {}
}