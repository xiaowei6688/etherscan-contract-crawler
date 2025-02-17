// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Editions by Sterling Crispin
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

//////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                  //
//                                                                                                  //
//         __     _               _  _                            _              _            __    //
//        / /___ | |_  ___  _ __ | |(_) _ __    __ _   ___  _ __ (_) ___  _ __  (_) _ __     / /    //
//       / // __|| __|/ _ \| '__|| || || '_ \  / _` | / __|| '__|| |/ __|| '_ \ | || '_ \   / /     //
//      / / \__ \| |_|  __/| |   | || || | | || (_| || (__ | |   | |\__ \| |_) || || | | | / /      //
//     /_/  |___/ \__|\___||_|   |_||_||_| |_| \__, | \___||_|   |_||___/| .__/ |_||_| |_|/_/       //
//                                             |___/                     |_|                        //
//                                                                                                  //
//                                                                                                  //
//////////////////////////////////////////////////////////////////////////////////////////////////////


contract SRC is ERC721Creator {
    constructor() ERC721Creator("Editions by Sterling Crispin", "SRC") {}
}