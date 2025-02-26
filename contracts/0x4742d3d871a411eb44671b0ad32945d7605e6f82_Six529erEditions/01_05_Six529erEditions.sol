// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: 6529er Editions
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                            //
//                                                                                                            //
//    ▓▓▓▓█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▌▓▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█▓▓▓▓▓▓▓▓▓▓▓▓▓    //
//    ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▓▓▀▀▀▀▓▓▓▓▓▀▒▒▒▒▒▒▀▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓    //
//    ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▀░  ░ ░░  ▀▓▓▓▓▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓    //
//    ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▀▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▒▒▒▒▒▒   ░▒▒▄      ▀▒▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓    //
//    ▓▓▓▄▓▓▓▓▓▓▓▓▓▓▓▓▓▌▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▒▒▒▒▒ ░▒▒▓▓▓▓▓▒▒▒░  ▐▒▒▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓    //
//    ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▓▀▀▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒░▒▒▒▓▓▓█▓▓▓▓▒▒░░ ▐▒▒▒▒▒▀▀▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒    //
//    ▒▓▀▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▀▒▒▒▒▓▒▒▒▒▒▒▒▒░▒▒▓▓▓▓▓██▓▓▓▓▓▒▒░ ▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒    //
//    ▒▒▒▀▓▓▌▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▓▓▓██▓██▓▓▓▓▓▒▒▒░░▒▒▒▒▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒    //
//    ▒▒▒▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓█████▓▓▓▓▓▓▒░▐▒▒▒▓▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒    //
//    ▒▒▒▒▒▒▒▒▀▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓████████▓▓▓▓▓▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▀▓▓▀▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▓    //
//    ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▀▓▓█████▓████▓▌▒▒▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▒▒▒▒▒▒▒▒▓    //
//    ▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒░░░░░░░▒▒▒▒▒▓▓▓▓▓███▓▓▒▒▓▒▒▓▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▀▒▒▒▒▒▒▒▒▒▒    //
//    ▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▒▒▒▒▒░░░░░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓██▒▓█▌▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒    //
//    ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░▒▀▀░░░▒▒▒▒▒▒▒▒▒▒░░░▐▀▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒    //
//    ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░ ░░░░░░░░░░░░░░░░░░░░░░  ░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒    //
//    ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░  ░░░░░░░ ░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░▐▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░▒▒▒▒▒▒▒▒    //
//    ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░   ░░░░░▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒    //
//    ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒▒▒▒▒▒▒▒▒▒    //
//    ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░▒▒▒▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓███████████████▓██▓▓▓▓▓▓▓▓▓▓▓▓▒░░░▒▒▒▒▒▒▒▒▒▒▒░▒░░▒▒▒▒▒▒▒▒▒    //
//    ▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░▒▒▓▓▓▓▓▓▓▓█████████████████████████▓▓▓▓██▓▓█▓▒▒░░▒░░░░▒▒▒░░░░░░░▒▒▒▒▒▒▒░         //
//    ▒░▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▓▓▓███▓████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█▓██▓████▒░░▒░░░░░░▐░░░░░░░░░▒░░░░    //
//    ▒▒░░░▒▒▒▒▒▒▒░░▒▒▒▒▒▒░░▒▓▓▓███████████▌ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▓███████████▓▒░░░░░░░░░░░░░░░░░░░░░░▒    //
//    ▒▒▒▒░░░▒▒▒░░░░░░▒▒░░▒▒▓▓█████████████▌ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄  █████████████▓▒░░░░░░░░  ░░░░░░░▒░░▒░    //
//    ▒▒▒▒▒▒░░▒▒░░░░  ░░░░▐▒▓▓██████████████▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄██████████████▓▒░░░░░ ░  ░░░░░░░░░░░░    //
//    ▒▒▒▒▒▒▒▒▒▒░░░░   ░░░▒▓███████████████▌ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ████████████▓▒░░░ ░░░░░░░░░░░░░░░░░░    //
//    ▒▒▒▒▒▒▒▒▒▒▒▒░     ░▐▒█████████████████▄▄▄▄▄▄▄▄▄▄▄ ▐█  ▄▄▄▄▄▄▄▄▄▄██████████████▒░░░░░░░░░░░░░░░░░░░░░    //
//    ▒▒░░▒░░░▒░░░░░░  ░ ▒▓█████████████████▄▄▄▄▄▄▄▄▄▄▄▄▄█▄▄▄▄▄▄▄▄▄▄▄▄███████████████▓▌░░░░░░░░░░░░ ░░░░░░    //
//    ▒▒░░░░░░░░░░░░░░░░▐▒▓█████████▓███████▌ ▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄  ████████████████▌░░░░░░░░░░░░░░░░░░    //
//    ▒▒░░░░░░░░░░░░░░░ ▓▒█████████▀▐████████▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄  █████████████████░░░░░░░░░░░░░░░░░░    //
//    ▒▒▒░░░░░░░░░░░░░░▐▓▓▓████████ ▐████████▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄███████▌▓████████▌ ░   ░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░ ░ ▓█▓▓███████▌  ████████▌ ▄▄▄▄▄▄▄▄▄  █  ▄▄▄▄▄▄▄▄  ████▌ ▓███████████     ░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░▓██████████   █████████  ▄▄▄▄▄▄▄▄▄▄█  ███████▓███████  ▀██████████▒    ░░░░░░░░░░░░    //
//    ░░  ░░░░░░░░░░░░▐██████████▒   ▀███████▓▄▄▄▄▄▄▄▄▄▄▄▄█▄▄█████████████▌    ▓██████████▒   ░░ ░░░░░░░░░    //
//    ░     ░░░░░░░░░░▐██████████     █████████████████████████████████████▌    ▐█████████▒░       ░░░░░░░    //
//    ░░░░  ░░░░░░░░░░▐█████████▌      ▄█████████████▓▓▓▓▓▓█▓██████████████     ▐██████████░    ░░░░░░        //
//    ░░░░░  ░░░░░░░░ ▓▓████████       ████████████████████████████████████      ▓█████████▌   ░░░░░░░░░░░    //
//    ░░░░░░ ░░░░░░   ▓▓▓██████▌      ▐█████████████████████████████████████      █████████░     ░ ░░░░░░░    //
//    ░░░░░░░ ░░  ░   ▓▓▓██████▀      ▓████████████████████████████████████▌      ▐██████▓▓      ░░ ░ ░ ░░    //
//    ░░░░░░░░░       ▓████████        ▓███████████████████████████████████▌       ▓█████▓█         ░    ░    //
//    ░░░░░░░░░░░  ░ ░▓███████▌        ▀███████████████████████████████████▌       ▐███████░        ░  ░░░    //
//                                                                                                            //
//                                                                                                            //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract Six529erEditions is ERC1155Creator {
    constructor() ERC1155Creator("6529er Editions", "Six529erEditions") {}
}