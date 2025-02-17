// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: digibo
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

/////////////////////////////////////////////////////
//                                                 //
//                                                 //
//    ▓█████▄  ██▓  ▄████  ██▓ ▄▄▄▄    ▒█████      //
//    ▒██▀ ██▌▓██▒ ██▒ ▀█▒▓██▒▓█████▄ ▒██▒  ██▒    //
//    ░██   █▌▒██▒▒██░▄▄▄░▒██▒▒██▒ ▄██▒██░  ██▒    //
//    ░▓█▄   ▌░██░░▓█  ██▓░██░▒██░█▀  ▒██   ██░    //
//    ░▒████▓ ░██░░▒▓███▀▒░██░░▓█  ▀█▓░ ████▓▒░    //
//     ▒▒▓  ▒ ░▓   ░▒   ▒ ░▓  ░▒▓███▀▒░ ▒░▒░▒░     //
//     ░ ▒  ▒  ▒ ░  ░   ░  ▒ ░▒░▒   ░   ░ ▒ ▒░     //
//     ░ ░  ░  ▒ ░░ ░   ░  ▒ ░ ░    ░ ░ ░ ░ ▒      //
//       ░     ░        ░  ░   ░          ░ ░      //
//     ░                            ░              //
//                                                 //
//                                                 //
/////////////////////////////////////////////////////


contract digibo is ERC721Creator {
    constructor() ERC721Creator("digibo", "digibo") {}
}