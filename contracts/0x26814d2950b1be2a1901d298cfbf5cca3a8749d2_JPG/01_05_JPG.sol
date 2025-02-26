// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: JPEG TIMES
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

///////////////////////////////////////////////////////////////////////////////////////
//                                                                                   //
//                                                                                   //
//     ▄▄▄██▀▀▀██▓███  ▓█████   ▄████    ▄▄▄█████▓ ██▓ ███▄ ▄███▓▓█████   ██████     //
//       ▒██  ▓██░  ██▒▓█   ▀  ██▒ ▀█▒   ▓  ██▒ ▓▒▓██▒▓██▒▀█▀ ██▒▓█   ▀ ▒██    ▒     //
//       ░██  ▓██░ ██▓▒▒███   ▒██░▄▄▄░   ▒ ▓██░ ▒░▒██▒▓██    ▓██░▒███   ░ ▓██▄       //
//    ▓██▄██▓ ▒██▄█▓▒ ▒▒▓█  ▄ ░▓█  ██▓   ░ ▓██▓ ░ ░██░▒██    ▒██ ▒▓█  ▄   ▒   ██▒    //
//     ▓███▒  ▒██▒ ░  ░░▒████▒░▒▓███▀▒     ▒██▒ ░ ░██░▒██▒   ░██▒░▒████▒▒██████▒▒    //
//     ▒▓▒▒░  ▒▓▒░ ░  ░░░ ▒░ ░ ░▒   ▒      ▒ ░░   ░▓  ░ ▒░   ░  ░░░ ▒░ ░▒ ▒▓▒ ▒ ░    //
//     ▒ ░▒░  ░▒ ░      ░ ░  ░  ░   ░        ░     ▒ ░░  ░      ░ ░ ░  ░░ ░▒  ░ ░    //
//     ░ ░ ░  ░░          ░   ░ ░   ░      ░       ▒ ░░      ░      ░   ░  ░  ░      //
//     ░   ░              ░  ░      ░              ░         ░      ░  ░      ░      //
//                                                                                   //
//                                                                                   //
//                                                                                   //
//                                                                                   //
//    ╦╔╦╗╔═╗  ╔╦╗╦ ╦╔═╗  ╔╦╗╔═╗╦ ╦╔╗╔  ╔═╗╔═╗  ╔╦╗╦ ╦╔═╗   ╦╔═╗╔═╗╔═╗╔═╗            //
//    ║ ║ ╚═╗   ║ ╠═╣║╣    ║║╠═╣║║║║║║  ║ ║╠╣    ║ ╠═╣║╣    ║╠═╝║╣ ║ ╦╚═╗            //
//    ╩ ╩ ╚═╝   ╩ ╩ ╩╚═╝  ═╩╝╩ ╩╚╩╝╝╚╝  ╚═╝╚     ╩ ╩ ╩╚═╝  ╚╝╩  ╚═╝╚═╝╚═╝            //
//                                                                                   //
//    ╔╦╗╦╔╗╔╔╦╗  ╔═╗╦═╗  ╔═╗╔═╗╦═╗╔═╗╦  ╦╔═╗╦═╗  ╔═╗╔═╗╔═╗╦ ╦  ╔═╗╔═╗╔═╗╔╦╗╔═╗      //
//    ║║║║║║║ ║   ║ ║╠╦╝  ╠╣ ║ ║╠╦╝║╣ ╚╗╔╝║╣ ╠╦╝  ║  ║ ║╠═╝╚╦╝  ╠═╝╠═╣╚═╗ ║ ╠═╣      //
//    ╩ ╩╩╝╚╝ ╩   ╚═╝╩╚═  ╚  ╚═╝╩╚═╚═╝ ╚╝ ╚═╝╩╚═  ╚═╝╚═╝╩   ╩   ╩  ╩ ╩╚═╝ ╩ ╩ ╩      //
//                                                                                   //
//                                                                                   //
///////////////////////////////////////////////////////////////////////////////////////


contract JPG is ERC721Creator {
    constructor() ERC721Creator("JPEG TIMES", "JPG") {}
}