// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Global Healing Society Guardians
/// @author: manifold.xyz

import "./ERC721Creator.sol";

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                          //
//                                                                                                          //
//                                                                                                          //
//     __        __   __                     ___                   __      __   __   __     ___ ___         //
//    / _` |    /  \ |__)  /\  |       |__| |__   /\  |    | |\ | / _`    /__` /  \ /  ` | |__   |  \ /     //
//    \__> |___ \__/ |__) /~~\ |___    |  | |___ /~~\ |___ | | \| \__>    .__/ \__/ \__, | |___  |   |      //
//                                                                                                          //
//                                                                                                          //
//                                                                                                          //
//                                                                                                          //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract GHSG is ERC721Creator {
    constructor() ERC721Creator("Global Healing Society Guardians", "GHSG") {}
}