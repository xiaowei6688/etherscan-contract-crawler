// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Stories at Night
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

//////////////////////////////////////////////////////////////////
//                                                              //
//                                                              //
//           _____   ______________________  _________          //
//           ___  | / /___  _/_  ____/__  / / /__  __/          //
//           __   |/ / __  / _  / __ __  /_/ /__  /             //
//           _  /|  / __/ /  / /_/ / _  __  / _  /              //
//           /_/ |_/  /___/  \____/  /_/ /_/  /_/               //
//                                                              //
//    _____________________________________________________     //
//    __  ___/__  __/_  __ \__  __ \___  _/__  ____/_  ___/     //
//    _____ \__  /  _  / / /_  /_/ /__  / __  __/  _____ \      //
//    ____/ /_  /   / /_/ /_  _, _/__/ /  _  /___  ____/ /      //
//    /____/ /_/    \____/ /_/ |_| /___/  /_____/  /____/       //
//                                                  by smef     //
//                                                              //
//                                                              //
//////////////////////////////////////////////////////////////////


contract STORY is ERC1155Creator {
    constructor() ERC1155Creator("Stories at Night", "STORY") {}
}