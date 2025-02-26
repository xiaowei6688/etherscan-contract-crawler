// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: The Abstracts by Abstract
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                     //
//                                                                                                                     //
//                                                                                                                     //
//    ▄▄▄█████▓ ██░ ██ ▓█████     ▄▄▄       ▄▄▄▄     ██████ ▄▄▄█████▓ ██▀███   ▄▄▄       ▄████▄  ▄▄▄█████▓  ██████     //
//    ▓  ██▒ ▓▒▓██░ ██▒▓█   ▀    ▒████▄    ▓█████▄ ▒██    ▒ ▓  ██▒ ▓▒▓██ ▒ ██▒▒████▄    ▒██▀ ▀█  ▓  ██▒ ▓▒▒██    ▒     //
//    ▒ ▓██░ ▒░▒██▀▀██░▒███      ▒██  ▀█▄  ▒██▒ ▄██░ ▓██▄   ▒ ▓██░ ▒░▓██ ░▄█ ▒▒██  ▀█▄  ▒▓█    ▄ ▒ ▓██░ ▒░░ ▓██▄       //
//    ░ ▓██▓ ░ ░▓█ ░██ ▒▓█  ▄    ░██▄▄▄▄██ ▒██░█▀    ▒   ██▒░ ▓██▓ ░ ▒██▀▀█▄  ░██▄▄▄▄██ ▒▓▓▄ ▄██▒░ ▓██▓ ░   ▒   ██▒    //
//      ▒██▒ ░ ░▓█▒░██▓░▒████▒    ▓█   ▓██▒░▓█  ▀█▓▒██████▒▒  ▒██▒ ░ ░██▓ ▒██▒ ▓█   ▓██▒▒ ▓███▀ ░  ▒██▒ ░ ▒██████▒▒    //
//      ▒ ░░    ▒ ░░▒░▒░░ ▒░ ░    ▒▒   ▓▒█░░▒▓███▀▒▒ ▒▓▒ ▒ ░  ▒ ░░   ░ ▒▓ ░▒▓░ ▒▒   ▓▒█░░ ░▒ ▒  ░  ▒ ░░   ▒ ▒▓▒ ▒ ░    //
//        ░     ▒ ░▒░ ░ ░ ░  ░     ▒   ▒▒ ░▒░▒   ░ ░ ░▒  ░ ░    ░      ░▒ ░ ▒░  ▒   ▒▒ ░  ░  ▒       ░    ░ ░▒  ░ ░    //
//      ░       ░  ░░ ░   ░        ░   ▒    ░    ░ ░  ░  ░    ░        ░░   ░   ░   ▒   ░          ░      ░  ░  ░      //
//              ░  ░  ░   ░  ░         ░  ░ ░            ░              ░           ░  ░░ ░                     ░      //
//                                               ░                                      ░                              //
//     ▄▄▄▄ ▓██   ██▓    ▄▄▄       ▄▄▄▄     ██████ ▄▄▄█████▓ ██▀███   ▄▄▄       ▄████▄  ▄▄▄█████▓                      //
//    ▓█████▄▒██  ██▒   ▒████▄    ▓█████▄ ▒██    ▒ ▓  ██▒ ▓▒▓██ ▒ ██▒▒████▄    ▒██▀ ▀█  ▓  ██▒ ▓▒                      //
//    ▒██▒ ▄██▒██ ██░   ▒██  ▀█▄  ▒██▒ ▄██░ ▓██▄   ▒ ▓██░ ▒░▓██ ░▄█ ▒▒██  ▀█▄  ▒▓█    ▄ ▒ ▓██░ ▒░                      //
//    ▒██░█▀  ░ ▐██▓░   ░██▄▄▄▄██ ▒██░█▀    ▒   ██▒░ ▓██▓ ░ ▒██▀▀█▄  ░██▄▄▄▄██ ▒▓▓▄ ▄██▒░ ▓██▓ ░                       //
//    ░▓█  ▀█▓░ ██▒▓░    ▓█   ▓██▒░▓█  ▀█▓▒██████▒▒  ▒██▒ ░ ░██▓ ▒██▒ ▓█   ▓██▒▒ ▓███▀ ░  ▒██▒ ░                       //
//    ░▒▓███▀▒ ██▒▒▒     ▒▒   ▓▒█░░▒▓███▀▒▒ ▒▓▒ ▒ ░  ▒ ░░   ░ ▒▓ ░▒▓░ ▒▒   ▓▒█░░ ░▒ ▒  ░  ▒ ░░                         //
//    ▒░▒   ░▓██ ░▒░      ▒   ▒▒ ░▒░▒   ░ ░ ░▒  ░ ░    ░      ░▒ ░ ▒░  ▒   ▒▒ ░  ░  ▒       ░                          //
//     ░    ░▒ ▒ ░░       ░   ▒    ░    ░ ░  ░  ░    ░        ░░   ░   ░   ▒   ░          ░                            //
//     ░     ░ ░              ░  ░ ░            ░              ░           ░  ░░ ░                                     //
//          ░░ ░                        ░                                      ░                                       //
//                                                                                                                     //
//                                                                                                                     //
//                                                                                                                     //
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract ABA is ERC721Creator {
    constructor() ERC721Creator("The Abstracts by Abstract", "ABA") {}
}