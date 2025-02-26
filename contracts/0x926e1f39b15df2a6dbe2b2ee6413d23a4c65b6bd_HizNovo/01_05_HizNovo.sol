// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Hizzys CryptoNovo OE
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

//////////////////////////////////////////////////////////////////////////////
//                                                                          //
//                                                                          //
//                                                                          //
//      ___ ___ .__                         _______                         //
//     /   |   \|__|__________________.__.  \      \   _______  ______      //
//    /    ~    \  \___   /\___   <   |  |  /   |   \ /  _ \  \/ /  _ \     //
//    \    Y    /  |/    /  /    / \___  | /    |    (  <_> )   (  <_> )    //
//     \___|_  /|__/_____ \/_____ \/ ____| \____|__  /\____/ \_/ \____/     //
//           \/          \/      \/\/              \/                       //
//                                                                          //
//                                                                          //
//                                                                          //
//////////////////////////////////////////////////////////////////////////////


contract HizNovo is ERC721Creator {
    constructor() ERC721Creator("Hizzys CryptoNovo OE", "HizNovo") {}
}