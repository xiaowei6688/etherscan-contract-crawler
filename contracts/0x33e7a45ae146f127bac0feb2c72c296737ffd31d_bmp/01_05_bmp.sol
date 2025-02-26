// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: big mac profits - check
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                                   //
//                                                                                                                                                   //
//                                                                                                                                                   //
//    .______    __    _______    .___  ___.      ___        ______    .______   .______        ______    _______  __  .___________.     _______.    //
//    |   _  \  |  |  /  _____|   |   \/   |     /   \      /      |   |   _  \  |   _  \      /  __  \  |   ____||  | |           |    /       |    //
//    |  |_)  | |  | |  |  __     |  \  /  |    /  ^  \    |  ,----'   |  |_)  | |  |_)  |    |  |  |  | |  |__   |  | `---|  |----`   |   (----`    //
//    |   _  <  |  | |  | |_ |    |  |\/|  |   /  /_\  \   |  |        |   ___/  |      /     |  |  |  | |   __|  |  |     |  |         \   \        //
//    |  |_)  | |  | |  |__| |    |  |  |  |  /  _____  \  |  `----.   |  |      |  |\  \----.|  `--'  | |  |     |  |     |  |     .----)   |       //
//    |______/  |__|  \______|    |__|  |__| /__/     \__\  \______|   | _|      | _| `._____| \______/  |__|     |__|     |__|     |_______/        //
//                                                                                                                                                   //
//                                                                                                                                                   //
//                                                                                                                                                   //
//                                                                                                                                                   //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract bmp is ERC721Creator {
    constructor() ERC721Creator("big mac profits - check", "bmp") {}
}