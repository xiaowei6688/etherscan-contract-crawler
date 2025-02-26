// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: BLURETINA OE
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

/////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                         //
//                                                                                         //
//    ######   ####     ##   ##  ######   #######   ######   ######  ###  ##   #####       //
//     ##  ##   ##      ##   ##  ##   ##   ##  ##     ##       ##    #### ##  ##   ##      //
//     ##  ##   ##      ##   ##  ##   ##   ##         ##       ##    #######  ##   ##      //
//     #####    ##      ##   ##  ######    ####       ##       ##    ## ####  #######      //
//     ##  ##   ##      ##   ##  ## ##     ##         ##       ##    ##  ###  ##   ##      //
//     ##  ##   ##  ##  ##   ##  ##  ##    ##  ##     ##       ##    ##   ##  ##   ##      //
//    ######    ######   #####   ##   ##  #######     ##     ######  ##   ##  ##   ##      //
//                                                                                         //
//    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░     //
//    ░░░░░░░░░░░░░░▒▒▒▒▓▓▓▓▓▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░     //
//    ░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░     //
//    ░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░     //
//    ░░░░░░░░░░▓██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒░░░░░░░░     //
//    ░░░░░░░░░░▓█████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░█▓░░░░░░░░░░░██▓▓▓░░░░     //
//    ░░░░░░░░░░░███▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░░░▒████░░░░░░░░░░░▓████░░░░░     //
//    ░░░░░░░░░░░▓█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░▒░░░░░░░▒███▓░░░░░░░▓▒░▒▒▒██░░░░░     //
//    ░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓███▓▒░░░░░██▒░░░░░░░░▓██░░░░▓█▓░░░░     //
//    ░░░░░░░░░░░▒▓▓▓▓▓▓▓▓█████▓▓▓▓▓████▓▓▓▓▓▓▓███████▒░░░░░▒██░░░░░░░▒████▒░░░░██░░░░     //
//    ░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓████████▓▒░░░░░░░░░▓██████▓▒░░░░░▒██░░░░░░▓█████▓░░░░██░░░░     //
//    ░░░░░░░░░░▓▓█▓█▓▓▓▓▓▓▓████████▓▒░░░░░░░▓████▒░▓█▓▒░░░░░██▓░░░▒████▓▓██░░░░██░░░░     //
//    ░░░░░░░░░▒▓█▓█▓█▓▓▓▓██▓░░░▒█████▓▒░░░░░▓██▓░░░░██▓░░░░░░▓█████▓▒██░░███░▒██▒░░░░     //
//    ░░░░░░░░░▒██████▓███▓░░░░░░▒░▒▒▒░░░░░░░░▒░░░░░░░█▓░░░░░░░███▓░░▓█▒░░░███▓▒░░░░░░     //
//    ░░░░░░░░░▓█▒░░▒█████▒░░░░░▓█░░░░░░░░░░░░░░▓█░░░░▓█░░░░░▓██▓░░░▒██░▒▓▓▒██▓░░░░░░░     //
//    ░░░░░░░░░▓█░░░░░████░░░░░░██▒░░░░░░░░░░░░░██▒░░░▒▓░░░███▒░░░░░▓█▓░▓▓▓░▒██▓░░░░░░     //
//    ░░░░░░░░░▒█▒░█▒░████░░▒▓████▓▓▓▓░░░░░░░▓██████▓░▓▓░░░░██▓░░░░░█████▓▓▓▓███▒░░░░░     //
//    ░░░░░░░░░▒██▓▒████▓█░░░░░░██░░░░░░░░░░░░░░▓█▒░░░▒▓░░░░░██▓░░░▒██▒▒▒▒▒▓███▓░░░░░░     //
//    ░░░░░░░░░░████▒▒███▓░░░░░░▓▓░░░░░░░░░░░░░░░▓░░░░░█▓░░░░▒██▒░░▓█▓░░░░▓██▓░░░░░░░░     //
//    ░░░░░░░░░░▒██████▓█▒░▒▒░░░░░░░░░▒▒░░░░░░░░░░▓█▓░░██░░░░░▓██░░██▒░░▓██▓░░░░░░░░░░     //
//    ░░░░░░░░░░░▓██▓████░████░░░░░░░▓█▒░░░░█▓░░░▓███▒▒██░░░░░░███▒██░▓███▒░░░░░░░░░░░     //
//    ░░░░░░░░░░░▒█▓█▓██▓░░▓▓▓░░░░░░▒██░░░░▓█▒░░░░░░░░█▓█░░░░░▓█████▓████░░░░░░░░░░░░░     //
//    ░░░░░░░░░░░▒████████░░░░░░░░░░▓██░░░▒██░░░░░░░░▓▓██░░░░▓█▓▒█████▓███░░░░░░░░░░░░     //
//    ░░░░░░░░░░░░█▓█▒██▓█▓░░░░░░░░░▒██▓▒▓██▒░░░░░░░▒█▓██▒░░▒██░░▒███▒░░██▓░░░░░░░░░░░     //
//    ░░░░░░░░░░░▒██▓██▓████▓░░░░░░░░░▒▓▓▓▒░░░░░░░░▒███▓██░░▓█▒░░░▓▓░░░░▓█▓░░░░░░░░░░░     //
//    ░░░░░░░░░░░█████▓███████▓▒░░░░░░░░░░░░░░░░░░▓████████▓██▓▒▒░░░░░░░▓█▒░░░░░░░░░░░     //
//    ░░░░░░░░░░▓████▓▓▓██▓████▓▓█▒▒░░░░░░░░░░░░░▓██▓█▓▓███▓█████▓▒░▒░░▒██░░░░░░░░░░░░     //
//    ░░░░░░░░▒██████▓▒███▓████▓▓█▓▓▓▓▒▒░░░░░░░▒▓▓▓█▓░▓█████▓▒░▒▒▒▓▒▒▒▒███▓░░░░░░░░░░░     //
//    ░░░░░░▓█████████▓▒███▓███▓▒▓▒▓▓▒▓▒▓▓▓▓▓▓████▓▓▓▓▒█████▓▓▒▒▒▒░▒▒▒▒░░▒▓▒░░░░░░░░░░     //
//    ░░░░░█████████████▓▓██████▓▓▒▓▓▒▓▒▓▓█████████████████▓▓▓▒░░▒▒▒░▒░▒▒▒▒▒░░▒░░░░░░░     //
//    ░░░░▓██████████████▓▓▓▓▓▓▓▓█░▒▒░▓▒▓▓▓███████████▓████▓▓▒▒▒▒░▓▒▒░▒░▒▒░░░░░░░░░░░░     //
//    ░░░▓▒▒▓████████████████▓▒█▓░░▒▒░▒░░░▒▓▓█████████████▓▓▒▒▒░▒▓▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒░░░     //
//    ░░░░▒▒░▒▓████████████████▓█▓░░░░░░░▒▓███████████████▓▓▒▒▒▒▒░▓░░▒░▒▒▒▒▓▓▓▒▒░▒▒▒░░     //
//                                                                                         //
//    E V E R Y T H I N G ' S   G O I N G   T O   B E   O K  + + + + + + + + + + + + +     //
//                                                                                         //
//                                                                                         //
/////////////////////////////////////////////////////////////////////////////////////////////


contract BLROE is ERC1155Creator {
    constructor() ERC1155Creator("BLURETINA OE", "BLROE") {}
}