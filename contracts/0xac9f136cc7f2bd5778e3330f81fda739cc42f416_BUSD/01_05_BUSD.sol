// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: A Dollar Bills
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                          //
//                                                                                                                          //
//                                                                                                                          //
//                                                                                                                          //
//     ____    ____  ____  _     _     ____  ____    ____  _  _     _       ____ ___  _   _     _  _      ____  _     _     //
//    /  _ \  /  _ \/  _ \/ \   / \   /  _ \/  __\  /  __\/ \/ \   / \     /  _ \\  \//  / \   / \/ \  /|/  _ \/ \   / \    //
//    | / \|  | | \|| / \|| |   | |   | / \||  \/|  | | //| || |   | |     | | // \  /   | |   | || |\ ||| / \|| |   | |    //
//    | |-||  | |_/|| \_/|| |_/\| |_/\| |-|||    /  | |_\\| || |_/\| |_/\  | |_\\ / /    | |_/\| || | \||| |-||| |_/\| |    //
//    \_/ \|  \____/\____/\____/\____/\_/ \|\_/\_\  \____/\_/\____/\____/  \____//_/     \____/\_/\_/  \|\_/ \|\____/\_/    //
//                                                                                                                          //
//                                                                                                                          //
//                                                                                                                          //
//                                                                                                                          //
//                                                                                                                          //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract BUSD is ERC721Creator {
    constructor() ERC721Creator("A Dollar Bills", "BUSD") {}
}