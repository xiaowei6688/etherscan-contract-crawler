// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Editions by Josh Grenon
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                   //
//                                                                                                                                   //
//     ▄▄▄██▀▀▀▒█████    ██████  ██░ ██   ▄████  ██▀███  ▓█████  ███▄    █  ▒█████   ███▄    █       ▄████▄   ▒█████   ███▄ ▄███▓    //
//       ▒██  ▒██▒  ██▒▒██    ▒ ▓██░ ██▒ ██▒ ▀█▒▓██ ▒ ██▒▓█   ▀  ██ ▀█   █ ▒██▒  ██▒ ██ ▀█   █      ▒██▀ ▀█  ▒██▒  ██▒▓██▒▀█▀ ██▒    //
//       ░██  ▒██░  ██▒░ ▓██▄   ▒██▀▀██░▒██░▄▄▄░▓██ ░▄█ ▒▒███   ▓██  ▀█ ██▒▒██░  ██▒▓██  ▀█ ██▒     ▒▓█    ▄ ▒██░  ██▒▓██    ▓██░    //
//    ▓██▄██▓ ▒██   ██░  ▒   ██▒░▓█ ░██ ░▓█  ██▓▒██▀▀█▄  ▒▓█  ▄ ▓██▒  ▐▌██▒▒██   ██░▓██▒  ▐▌██▒     ▒▓▓▄ ▄██▒▒██   ██░▒██    ▒██     //
//     ▓███▒  ░ ████▓▒░▒██████▒▒░▓█▒░██▓░▒▓███▀▒░██▓ ▒██▒░▒████▒▒██░   ▓██░░ ████▓▒░▒██░   ▓██░ ██▓ ▒ ▓███▀ ░░ ████▓▒░▒██▒   ░██▒    //
//     ▒▓▒▒░  ░ ▒░▒░▒░ ▒ ▒▓▒ ▒ ░ ▒ ░░▒░▒ ░▒   ▒ ░ ▒▓ ░▒▓░░░ ▒░ ░░ ▒░   ▒ ▒ ░ ▒░▒░▒░ ░ ▒░   ▒ ▒  ▒▓▒ ░ ░▒ ▒  ░░ ▒░▒░▒░ ░ ▒░   ░  ░    //
//     ▒ ░▒░    ░ ▒ ▒░ ░ ░▒  ░ ░ ▒ ░▒░ ░  ░   ░   ░▒ ░ ▒░ ░ ░  ░░ ░░   ░ ▒░  ░ ▒ ▒░ ░ ░░   ░ ▒░ ░▒    ░  ▒     ░ ▒ ▒░ ░  ░      ░    //
//     ░ ░ ░  ░ ░ ░ ▒  ░  ░  ░   ░  ░░ ░░ ░   ░   ░░   ░    ░      ░   ░ ░ ░ ░ ░ ▒     ░   ░ ░  ░   ░        ░ ░ ░ ▒  ░      ░       //
//     ░   ░      ░ ░        ░   ░  ░  ░      ░    ░        ░  ░         ░     ░ ░           ░   ░  ░ ░          ░ ░         ░       //
//                                                                                               ░  ░                                //
//                                                                                                                                   //
//                                                                                                                                   //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract JGEDITIONS is ERC1155Creator {
    constructor() ERC1155Creator("Editions by Josh Grenon", "JGEDITIONS") {}
}