// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Things you need to know
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

//////////////////////////////////////////////////////////////////////////////
//                                                                          //
//                                                                          //
//                                                                          //
//           _    _        _          _           _            _            //
//          /\ \ /\ \     /\_\       /\ \     _  /\ \         /\_\          //
//          \_\ \\ \ \   / / /      /  \ \   /\_\\_\ \       / / /  _       //
//          /\__ \\ \ \_/ / /      / /\ \ \_/ / //\__ \     / / /  /\_\     //
//         / /_ \ \\ \___/ /      / / /\ \___/ // /_ \ \   / / /__/ / /     //
//        / / /\ \ \\ \ \_/      / / /  \/____// / /\ \ \ / /\_____/ /      //
//       / / /  \/_/ \ \ \      / / /    / / // / /  \/_// /\_______/       //
//      / / /         \ \ \    / / /    / / // / /      / / /\ \ \          //
//     / / /           \ \ \  / / /    / / // / /      / / /  \ \ \         //
//    /_/ /             \ \_\/ / /    / / //_/ /      / / /    \ \ \        //
//    \_\/               \/_/\/_/     \/_/ \_\/       \/_/      \_\_\       //
//                                                                          //
//                                                                          //
//                                                                          //
//                                                                          //
//////////////////////////////////////////////////////////////////////////////


contract TYNTK is ERC1155Creator {
    constructor() ERC1155Creator("Things you need to know", "TYNTK") {}
}