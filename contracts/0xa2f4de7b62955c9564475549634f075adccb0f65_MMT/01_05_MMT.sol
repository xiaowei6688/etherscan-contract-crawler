// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Mad Maya Tribe
/// @author: manifold.xyz

import "./ERC721Creator.sol";

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                       //
//                                                                                                                       //
//                                                                                                                       //
//     ███▄ ▄███▓ ▄▄▄      ▓█████▄     ███▄ ▄███▓ ▄▄▄     ▓██   ██▓ ▄▄▄         ▄▄▄█████▓ ██▀███   ██▓ ▄▄▄▄   ▓█████     //
//    ▓██▒▀█▀ ██▒▒████▄    ▒██▀ ██▌   ▓██▒▀█▀ ██▒▒████▄    ▒██  ██▒▒████▄       ▓  ██▒ ▓▒▓██ ▒ ██▒▓██▒▓█████▄ ▓█   ▀     //
//    ▓██    ▓██░▒██  ▀█▄  ░██   █▌   ▓██    ▓██░▒██  ▀█▄   ▒██ ██░▒██  ▀█▄     ▒ ▓██░ ▒░▓██ ░▄█ ▒▒██▒▒██▒ ▄██▒███       //
//    ▒██    ▒██ ░██▄▄▄▄██ ░▓█▄   ▌   ▒██    ▒██ ░██▄▄▄▄██  ░ ▐██▓░░██▄▄▄▄██    ░ ▓██▓ ░ ▒██▀▀█▄  ░██░▒██░█▀  ▒▓█  ▄     //
//    ▒██▒   ░██▒ ▓█   ▓██▒░▒████▓    ▒██▒   ░██▒ ▓█   ▓██▒ ░ ██▒▓░ ▓█   ▓██▒     ▒██▒ ░ ░██▓ ▒██▒░██░░▓█  ▀█▓░▒████▒    //
//    ░ ▒░   ░  ░ ▒▒   ▓▒█░ ▒▒▓  ▒    ░ ▒░   ░  ░ ▒▒   ▓▒█░  ██▒▒▒  ▒▒   ▓▒█░     ▒ ░░   ░ ▒▓ ░▒▓░░▓  ░▒▓███▀▒░░ ▒░ ░    //
//    ░  ░      ░  ▒   ▒▒ ░ ░ ▒  ▒    ░  ░      ░  ▒   ▒▒ ░▓██ ░▒░   ▒   ▒▒ ░       ░      ░▒ ░ ▒░ ▒ ░▒░▒   ░  ░ ░  ░    //
//    ░      ░     ░   ▒    ░ ░  ░    ░      ░     ░   ▒   ▒ ▒ ░░    ░   ▒        ░        ░░   ░  ▒ ░ ░    ░    ░       //
//           ░         ░  ░   ░              ░         ░  ░░ ░           ░  ░               ░      ░   ░         ░  ░    //
//                          ░                              ░ ░                                              ░            //
//                                                                                                                       //
//                                                                                                                       //
//                                                                                                                       //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract MMT is ERC721Creator {
    constructor() ERC721Creator("Mad Maya Tribe", "MMT") {}
}