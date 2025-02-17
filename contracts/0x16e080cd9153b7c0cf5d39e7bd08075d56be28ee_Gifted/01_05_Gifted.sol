// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Gifted by Ely
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                              //
//                                                                                                                              //
//     ______     __     ______   ______   ______     _____        ______     __  __        ______     __         __  __        //
//    /\  ___\   /\ \   /\  ___\ /\__  _\ /\  ___\   /\  __-.     /\  == \   /\ \_\ \      /\  ___\   /\ \       /\ \_\ \       //
//    \ \ \__ \  \ \ \  \ \  __\ \/_/\ \/ \ \  __\   \ \ \/\ \    \ \  __<   \ \____ \     \ \  __\   \ \ \____  \ \____ \      //
//     \ \_____\  \ \_\  \ \_\      \ \_\  \ \_____\  \ \____-     \ \_____\  \/\_____\     \ \_____\  \ \_____\  \/\_____\     //
//      \/_____/   \/_/   \/_/       \/_/   \/_____/   \/____/      \/_____/   \/_____/      \/_____/   \/_____/   \/_____/     //
//                                                                                                                              //
//                                                                                                                              //
//                                                                                                                              //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract Gifted is ERC721Creator {
    constructor() ERC721Creator("Gifted by Ely", "Gifted") {}
}