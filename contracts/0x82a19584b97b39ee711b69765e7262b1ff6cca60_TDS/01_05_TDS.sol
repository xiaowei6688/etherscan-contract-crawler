// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: EBABE COME TO LIFE
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                               //
//                                                                                                                               //
//    ,--------. ,---.,--.   ,--.,-----. ,------.    ,---.  ,--.   ,--.,--.  ,--. ,---.  ,--.  ,--. ,-----. ,------. ,---.       //
//    '--.  .--'/  O  \\  `.'  /'  .-.  '|  .-.  \  /  O  \ |   `.'   ||  ,'.|  |'   .-' |  '--'  |'  .-.  '|  .---''   .-'      //
//       |  |  |  .-.  |'.    / |  | |  ||  |  \  :|  .-.  ||  |'.'|  ||  |' '  |`.  `-. |  .--.  ||  | |  ||  `--, `.  `-.      //
//       |  |  |  | |  |  |  |  '  '-'  '|  '--'  /|  | |  ||  |   |  ||  | `   |.-'    ||  |  |  |'  '-'  '|  `---..-'    |     //
//       `--'  `--' `--'  `--'   `-----' `-------' `--' `--'`--'   `--'`--'  `--'`-----' `--'  `--' `-----' `------'`-----'      //
//                                                                                                                               //
//                                                                                                                               //
//                                                                                                                               //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract TDS is ERC721Creator {
    constructor() ERC721Creator("EBABE COME TO LIFE", "TDS") {}
}