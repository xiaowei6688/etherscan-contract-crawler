// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Charity for Turkey
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                //
//                                                                                                                //
//                                                                                                                //
//        ████████████████████████████████████████████████████████████████████████████████████████████████████    //
//        ████████████████████████████▓▓██████████████████████████████████████████████████████████████████████    //
//        █████████████████████████████████████████████████████████████████▓▓█████████████████████████████████    //
//        ████████████████████████████████████████████████████████████████████████████████████████████████████    //
//        ███████████████████████████████████████████████████████▓╬▓██████████████████████████████████████████    //
//        ████████████████████████████████████████████████████████████████████████████████████████████████████    //
//        █████████████████████████████████████████████████████████████████████████████████████████╣██████████    //
//        ████████████████████████████████████████████████████████████████████████████████████████████████████    //
//        ████████████████████████████████████████▓▓██████████████████████████████████████████████████████████    //
//        █████████████████████████████████████████▓██████████████████████████████████████████████████████████    //
//        █████████████████████████████████████████▓███████████▓▓▓▓███████████████████████████████████████████    //
//        ████████████████████████████████████████▓▓▓▓▓▓▓██████▓▓▓▓▓██████████████████████████████████████████    //
//        ██████████████████████████████████████████████████████▓▓▓████████████▓▓█████████████████████████████    //
//        ████████████████████████████████████████████████████████████████████████████████████████████████████    //
//        █████████████████████╣█████████████████████████████████████████▓████████████████████████████▓███████    //
//        ████████████████▓▓██▓╣▓██████████████████████████████████████████╬╬╣████████████████████████████████    //
//        ████████████████▓███╬██▓████████████████████████████╬╬███████████╬╣▓▓███████████████████████████████    //
//        █████████████████▓▓██▓██▓███████████████▒╠╠╠███████╬╬╬╬╬▓████████╬╬╬▓▓██████████████████████████████    //
//        ██████████████████▓▓██▓▓▓▓██████████████▓╟╣██████╬╬╣╬╣▓██████████▓╬╬╬╬▓██▓██████████████████████████    //
//        ████████████████████████▓▓▓▓███████████████████▓▓▓▓▓▓███████╬██████▓╬╣╣╬██▓▓████████████████████████    //
//        ███████████████████▓██▓██▓▓▓▓███████████████▓▓▓▓▓███████████▓███████▓╬╬╬╬╣████████▓█████████████████    //
//        ██████████████████████▓▓▓▓▓▓╬████████████████▓▓██████████████████████▓╣▓▓╬╬███████▓█████████████████    //
//        ██████████████████████▓▓▓▓▓▓╬▓████████████████▓███████████████████████▓╬▓▓▓╣██████▓█████████████████    //
//        ██████████████████▓▓▓▓▓▓▓▓▓▓▓▓▓╬████▓██████████▓██████████████████▓████▓╬██▓████████████████████████    //
//        ██████████████████▓▓╬▓▓▓▓▓▓▓▓╣▓▓▓╬███▓████████████████████████▓██▓╬╬████▓▓██████████████████████████    //
//        ██████████████████▓▓▓╬╬╣╬▓▓▓▓▓▓▓▓▓╬▓█▓▓█▓██▓████▓████████████▓▓███▓╬▓███████████████████████████████    //
//        ██████████████████▓▓▓╬╬╬╠╠╬╣╣▓▓▓▓▓▓▓▓╬▓╬▓▓████▓████████████▓▓████████████████████████▓█▓▓▓██████████    //
//        ██████████████████▓▓▓╬╬╠╠▒▒▒╠╣╣▓▓▓▓▓▓▓╣╬╬██▓▓█████▓████████████████████████████████▓╬▓██████████████    //
//        ███████████████████▓▓▓▓╣╬╬▒▒╠╠╬╣▓▓▓▓▓▓▓▓▓╠╣██╬█████████████████╬╫███████████████▓██████▓╬╬▓▓▓▓█▓████    //
//        █████████████████████▓▓▓╬╬╬▒▒╣╣▓▓▓▓▓▓▓▓▓▓▓╬╬╣██████╣╬███▓╬██████╬▓█████████████████▓╬╩╠╠╠╠╬╬▓▓▓█████    //
//        ███████████████████████▓▓╬╬╠╬╬╬▓▓██████████▓▓╬▓▓██╬╣╬╬╬▓███████████████████████▓╬╩░▒▄╬▓╣╬╬╬╫╬╬╬▓████    //
//        ██████████████████████████████▓╣██████████████╬╬╬╬╬▒▒╠▓▓███▒╠███████████████▓╬╠▒▒╣▓▓▓▓▓▓▓▓▓▓▓█████▓▓    //
//        █████████████████████████████▓▓╬███████████████╬╬╬╠╠╬╬▓████▓██▓▓█████████╬╬╬╬▓▓▓▓▓▓▓██▓███╬╬╬▓▓▓▓▓██    //
//        ███████████████████████████████▓█████████████▓████████████╬▓╠▓█████████╬╬╬▓███████████▓▓▓╣▓▓▓▓██████    //
//        ████████████████████████████████████████████████████████╬╬╣▓█████████▓▓▓██████████▓▓▓▓▓▓▓▓▓█████████    //
//        █████████████████████████████████████████████████████╬╣╬╣█████████████████████▓▓█▓▓╬╬▓▓▓▓███████████    //
//        ██████████████████████████████████████████████████╬╬╬╬╣█████████████████████╬╣▓▓╬╬╣▓████████████████    //
//        ███████████████████████████████████▓▓████████████╬╠╠╬▓████╬▓███████████████▓▓▓╬▓▓▓██▓▓████▓▓▓▓██████    //
//        █████████████████████████████████████████████████╬╠╬╣███╬╣██████████████████████████████████████████    //
//        ███████████████████████╬╬▓███████████████████████╬╠╬╣▓▓╬▓███████████████████████████████████████████    //
//        █████████████████╬████████▓╬╬╬╬▓█████████████████▓╣╬╫╬╣╫████████████████████████████████████████████    //
//        ████████████████████████████████▓╬██▓╬████████████▓╬╣╬▓█████████████████████████████████████████████    //
//        ██████████████████████████████████▓╬████▓▓█████████▓╬███████████████████████████████████████████████    //
//        ██████████████████████████████████████████▓███████▓╣████████████████████████████████████████████████    //
//        ███████████████████████████████████████████▓████████████████████████████████████████████████████████    //
//        ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀╙▀▀▀▀╙▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀    //
//                                                                                                                //
//                                                                                                                //
//                                                                                                                //
//                                                                                                                //
//                                                                                                                //
//    ---                                                                                                         //
//    asciiart.club                                                                                               //
//                                                                                                                //
//                                                                                                                //
//                                                                                                                //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract CFT is ERC1155Creator {
    constructor() ERC1155Creator("Charity for Turkey", "CFT") {}
}