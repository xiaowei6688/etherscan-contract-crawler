// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Divine Femme by REBDUCE
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                               //
//                                                                                                                                               //
//    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░    //
//    ░▒▓▓▓▒▒▒▒▒▒▒▓▓▒▒░░░░▒▓▓▓▒▒▒▒▒▒▒▓▓▒░░▒▓▓▓▓▒▒▒▒▒▒▓▓▒░░░░▒▓▓▓▒▒▒▒▒▒▒▒▓▒▒░░░░░░▒▓▓▓▓▒░░░░░░░░░░▒▓▓▓▒░░░░░▒▒▓▒▒▒▒▒▒▒▓▓▒▒░░░▒▓▓▓▒▒▒▒▒▒▒▒▓▓▓░░    //
//    ░░░██░░░░░░░░░▓▓▓░░░░▒█▓░░░░░░░▒▓▒░░░░▓█▒░░░░░░░▒▓▓▒░░░░▓█▒░░░░░░░░▒▓▓▓░░░░░▒█▓░░░░░░░░░░░░░░▓░░░░░▒▓▓▒░░░░░░░░░▒▓▓▓░░░▓█▒░░░░░░░░░▒▓▒░    //
//    ░░░██░░░░░░░░░░▓█▒░░░▒█▓░░░░░░░░░░░░░░▓█▒░░░░░░░░▓█▒░░░░▓█▒░░░░░░░░░░▒▓▓▒░░░▒█▓░░░░░░░░░░░░░░▓░░░▒▓▓▒░░░░░░░░░░░░░▒▓░░░▓█▒░░░░░░░░░░░░░    //
//    ░░░██░░░░░░░░░░▒█▓░░░▒█▓▒▒▒▒▒▒▓▓░░░░░░▓█▒░░░░░░░▒▓▓░░░░░▓█▒░░░░░░░░░░░░▓▓▒░░▒█▓░░░░░░░░░░░░░░▓░░░▓█▒░░░░░░░░░░░░░░░░░░░▓█▒░░░░░░░░▒▒░░░    //
//    ░░░██░░░░░░░░░░▓█▓░░░▒█▓░░░░░▒▒▓░░░░░░▓█▓▒▒▒▒▒▓▓▓▒░░░░░░▓█▒░░░░░░░░░░░░▓█▒░░▒█▓░░░░░░░░░░░░░░▓░░▒█▓░░░░░░░░░░░░░░░░░░░░▓█▓▒▒▒▒▒▒▓▓█▒░░░    //
//    ░░░██░░░░░░░░░▒█▓▒░░░▒█▓░░░░░░░░░░░░░░▓█▒░░░░░░▒▒▓▓▒░░░░▓█▒░░░░░░░░░░░░▒█▒░░▒█▓░░░░░░░░░░░░░░▓░░▒█▓░░░░░░░░░░░░░░░░░░░░▓█▒░░░░░░░░▒▒░░░    //
//    ░░░██▒▒▒▒▒▒▒▒▓▓▒░░░░░▒█▓░░░░░░░░░░░░░░▓█▒░░░░░░░░░▓█▒░░░▓█▒░░░░░░░░░░░░▓█▒░░▒█▓░░░░░░░░░░░░░░▓░░▒█▓░░░░░░░░░░░░░░░░░░░░▓█▒░░░░░░░░░░░░░    //
//    ░░░██▒▒▒▒▒▒▒▓▓▓▒░░░░░▒█▓░░░░░░░▒▓▓░░░░▓█▒░░░░░░░░░▒█▓░░░▓█▒░░░░░░░░░░░▒▓▓░░░░▓█▒░░░░░░░░░░░░▒▓░░░▓█▓░░░░░░░░░░░░░░░░░░░▓█▒░░░░░░░░░░░░░    //
//    ░░░██░░░░░░░░░▒▓▓▒░░▒▒▓▒▒▒▒▒▒▒▒▓▓▒░░░░▓█▒░░░░░░░░░▓█▒░░░▓█▒░░░░░░░░░░▒▓▓░░░░░▒▓▓▒░░░░░░░░░░▒▓▒░░░░▒▓▓░░░░░░░░░░░░░▓▓░░░▓█▒░░░░░░░░░░░▒░    //
//    ░░▒██▒░░░░░░░░░░▒▓▓▒▒░░░░░░░░░░░░░▒░░▒▓█▒░░░░░░▒▒▓▓▒░░░▒▓█▒░░░░░░░▒▒▓▓▒░░░░░░░░▒▓▓▒▒░░░▒▒▒▓▓▒░░░░░░▒▓▓▓▒▒░░░░░░▒▒▓▓▒░░░▓█▒░░░░░░░░▒▒▓▓░    //
//    ░▒▒▒▒▒▒░░░░░░░░░░░▒▓▓▓▒▒░░░░░▒▒▓▓▒▒░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░    //
//    ░░░░░░░░░░░░░░░░░░░░░▒▒▒▓▓▓▓▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░    //
//                                                                                                                                               //
//                                                                                                                                               //
//                                                                                                                                               //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract REBDUCE is ERC721Creator {
    constructor() ERC721Creator("Divine Femme by REBDUCE", "REBDUCE") {}
}