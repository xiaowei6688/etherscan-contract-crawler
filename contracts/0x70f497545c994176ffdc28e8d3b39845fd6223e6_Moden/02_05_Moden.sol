// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: MoneyOden
/// @author: manifold.xyz

import "./ERC721Creator.sol";

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                                              //
//                                                                                                                                                              //
//    ██████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████    //
//    ██████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████    //
//    ██████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████    //
//    ██████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████    //
//    ██████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████    //
//    ██████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████    //
//    ██████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████    //
//    █████████████████████████████████████████████████████████████████████████████▓░▒██████████████████████████████████████████████████████████████████████    //
//    ██████████████████████████████████████████████████████████████████████████▓▒▒░░░░█▓░░▓████████████████████████████████████████████████████████████████    //
//    █████████████████████████████████████████████████▓░▒█▓██████████▓▓▓▓▒▒▓████▓▓░░▒▓▓▓▓▓▒████▒▒▒▒▓▓▓▓████████████████████████████████████████████████████    //
//    ████████████████████████████████████████████████▓▒░░░░░█████▓░░░░░▒▒▒▒▓████▒░░░▒▒▒░░▒█████▓▓▓▒░░░░░░░█████████████████████████████████████████████████    //
//    ███████████████████████████████████████████████░░▒▓▒░▒▓▒▒▓████████████████░░▒░░█▓▓▒░░███████▒░▒▓██▓▓▓█████████████████████████████████████████████████    //
//    █████████████████████████████████████████▓████████▒░░░▓▓▒▓█████████████████▓▒░▓▓▒▒▒▓███████▓░░████▒▓▓███████▓▓▓███████████████████████████████████████    //
//    ██████████████████████████████████████▓░░░░█████▓░░▓▒░▒█████████████████████████████████████░░▒▓█████████▓▒░░░▒███████████████████████████████████████    //
//    ███████████████████████████████████▓▒░░▓░░▓█████▓▓███▒▒██████████████████████████████████████▓▒░░████▓▒░░░░░▓█████████████████████████████████████████    //
//    █████████████████████████████████▓░░▒▓▓▓░░██████████████████████████████████████████████████████████▒░▒▓██▒░░█████████████████████████████████████████    //
//    ██████████████████████████████████▓██▓▒░░░░▓█████████████████████████████████████████████████████████████▒░▒██████████████████████████████████████████    //
//    █████████████████████████████████████████████████████████████████████▓▓▓▓▓▓▓▓▓▓▓█████████████████████████░░░░░░▓██████████████████████████████████████    //
//    ████████████████████████████████████████████████████████████▓▒▒░░░░░░░░░░░░░░░░░░░░░░▒▒▓▓██████████████████▓▓█████████████████████████████████████████    //
//    ███████████████████████████████████████████████████████▓▒░░░░░░▒▒▓▓▓▓▓█████████▓▓▓▓▒▒▒░░░░░░▒▓████████████████████████████████████████████████████████    //
//    ███████████████████████████████████████████████████▓▒░░░░▒▒▓████████████████████████████▓▓▒▒░░░░▒▓████████████████████████████████████████████████████    //
//    ████████████████████████████████████████████████▓░░░░▒▓███████████████████████████████████████▓▒░░░░▒█████████████████████████████████████████████████    //
//    █████████████████████████████████████████████▓▒░░░▒▓█████████████████████████████████████████████▓▓▒░░░▓██████████████████████████████████████████████    //
//    ███████████████████████████████████████████▓░░░▒▓████████████████▓▒▒░░░▒▒▓▓▓▓▓▓▓▓▓██████████████████▓▒░░░▒████████████████████████████████████████████    //
//    █████████████████████████████████████████▓░░░▓██████████████▓▓▒▒░░░░░░░░░░░░░░▒▒▒▒▒▒▒▒▒▓▓▓█████████████▓▒░░▒██████████████████████████████████████████    //
//    ████████████████████████████████████████▒░░▒████████████▓▓▒▒▒░░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▒▒▒▒▒▒▓▓██████████▓░░░▓████████████████████████████████████████    //
//    ████████████▓▓█████████▓██████████████▓░░░▓█████████▓▓▒▒▒▓▓▒░░░░░░░░▓▒░░░░░░░░░░░░░░▒▒▓▓▓▓▓▓▓▒▒▒▒▓▓████████▓░░▒███████████████████████████████████████    //
//    ███████▒▒▒▒▒░░▒▒▒██▒▒▒░░▒▒▒▒▒████████▓░░▒█████████▓▒▒▓▓▓▓▒░░░░░░░░░▓░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▒▒▒▓███████▓░░░██████████▓▓▓▓▓▓▓▓▓░░▓▓▓▓▓▓▓▓▓▓███████    //
//    ████████▓▓▓▓▒▒▓▓▓▓███▓▓▓████████████▓░░▒████████▓▒▒▓▓▓▓▓▒░░░░░░░░░▓░░▒░░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▒▒▓▓█████▓░░░████████▓░▓▓▓▓▒░▓▓▓▓▓▓▓░▒▓▓▓▓████████    //
//    ████████░░▒▒▒░▒▒▒▓██▒░▒▒▒▒▒▒▓███████░░▒███████▓▒▓▓▓▓▓▓▓░░░░░░░░░░▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▒▒▓█████▓░░▒███████▓░▓█▒▒▓░▓▒▒█▓▒▓░▒▓▒▓█████████    //
//    ████████░░▓▓▓▓▓▓░▒▓░▒██████████████▒░░▓█████▓▓▓▓▓▓▓▓▓▒░░░░▒░░░░░▒▒░░░░▒▒▒▒▒░░░░░▒▓▓▓▓▒░░░░░░░░░▒▓▓▓▓▓▓▓▓▒▒▓████▒░░███████▓░▓▓▒██░▓▒▒▓▒▓█▒▓█▒▓▓████████    //
//    ████████░▒▓▓▓░▒▓▓▓▓▓▓▒▒▒▒▒▒▒███████░░▒█████▓▓▓▓▓▓▓▓▓▒░░░▒░░░░░░▒▓░░░▒▓▓▒▒▒▓▓▓░░▒▓▒░░▒▓▒░░░░░░░░░░░▒▓▓▓▓▓▓▓▒▓████░░▒██████▓░▓█▓░▓▒▒▒▓▒▒▓▓▓▓▓░▓█████████    //
//    █████████▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓███████▓░░▓████▓▓▓▓▓▓▓▓▓▒░░░▒░░░░░░░▓░░░░▓▓░░░░░░░░░░░░░▒░░░░░░░▒░░░░░░░░▒▓▓▓▓▓▓▒▓███▒░░██████▒░██▒░▓▓▓▓▓░░▓▓▓▓▓░▒█████████    //
//    █████████▒░███▓░▓███░▓███░▒███████▒░░████▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░▓░░░░░░░░░▒▓▒░░░░░░░▓▓▓░░░░░░░▒▓▒░░░░░░░▒▓▓▓▓▓▒▓██▒░░██████░▒██▓▒▓▓▒░▒▒▒░▒▓░▒▒▓█████████    //
//    ██████▓▒▒░░▒▒▒▒░▒▒▒▒░▒▒▒▒░░▒▒▓████▒░░███▓▓▓▓▓▓▓▓▓▒░░░░░░░░░░░▒▒░░░░░░░░░▓▓▓░░░░░░░▒▓▒░░░░░░░░░░▒▒░░░░░░░▒▓▓▓▓▒██▒░░█████▒░████▓▓▒░▓███░▓▓▒▓▓▒▓▓███████    //
//    ██████████████████████████████████▒░░███▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░▓░░░░░░░░░░░▒░░░░░░░░░░░▒░░░░░░░░░░░▒▒▒░░░░▓▓▓▓▓▒▓█▒░░█████▓▓██▓▓▓▓██████▓▓▓▓▓▓▓▓████████    //
//    ██████████████████████████████████▓░░▓█▓▓▓▓▓▓▓▓▒░░░░░░░░░░░░▓▒░░░░▒░░░░░░░░░▒▒▓▓▓▓▓▓▓▓▓░░░░░░░░░░░░░▒░░▒▓▓▓▓▓▓▒█░░▒███████████████████████████████████    //
//    ███████████████████████████████████░░░█▓▓▓▓▓▓▓▓▒░░░░░░░░░░░▒▓░░░░░▒░░░░░░░▓▓▓▓▓▒▒▒▒▒▒▓▓▒░░░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓░░████████████████████████████████████    //
//    █████████████████▓░▒███████████████▓░░▒▓▓▓▓▓▓▓▓▓▒░░░▒░░░░░░▓▒░░░░░░░░░░░░░▒▓▓▓░░░░░░▒▓▓▒░░░░░░░░░░░▒▓▓▓▓▓▓▓▓▓▓▒░░▒███████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓████████    //
//    ████████▓░▒▓▓▓▒░▒▓▓▓▒░▒▓▓▓▓▓▓███████▒░░▒▓▓▓▓▓▓▓▓▓▒░▒░░░░░░░▓░░░░░░░░░░░░░░░▒▓▓▓▒▒▒▒▓▓▓▒░░░░░░░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓░░░████████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓████████    //
//    ████████▓░▒▒▒▒░░▒▒▒▒▒░▒▒▒▒▒▒▓████████▒░░▒▓▓▓▓▓▓▓▓▓▒▒░░░░░░▒▒░░░░░░░░░░░░░░░░░▒▓▓▓▓▓▓▒░░░░░░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░░███████████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒███████████    //
//    ████████▓░▓███▒░████▓░▓███▓░▓█████████▓░░░▓▓▓▓▓▓▓▓▓▓▒░░░░░▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░░░████████████░░████████████░░███████████    //
//    ████████▓░▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▓███████████▒░░▒▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▒░░░░░░░░░░░░░░░░░░░░░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▓▓▓▓▒░░▒█████████████░░▓▓▓▓▓▓▓▓▓▓▓▓░░███████████    //
//    ████████▒░██░▒██████▒░███████████████████▓░░░▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▒░░░▓██████████████▓▓▒▒▓▓▓▓▓▓▓▓▒▒▒▓███████████    //
//    ████████░▒██░░▓▓▓▓▓█▒░▓▓▓▓▓▓▓██████████████▓░░░▒▓▓▓▓▓▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒▒▒▓▓▓▓▓▓▓▒▒▒▒▓▓▓▒░░░▓██████████████████▓░▒██████▓░▒█████████████    //
//    ███████▒░███░▒█▓▓▓▓█▒░█████▓░████████████████▓▒░░░▒▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒▓▓▒░░░░▓█▓██████████████▓▓▓▓▓▓░▓▓▓▓▓▒░▒▓▓▓▓▓▓████████    //
//    ███████▒███▓▒▒▓▓▓▓██▓▒▒▒▒▒▒▒▓██████████████▓████▒░░░░▒▓▓▓▓▓▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░▒█▓▒░▓█████████████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓████████    //
//    ███████████████████████████████████████████▓░░▒████▒░░░░▒▒▒▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒░░░░▒▓██▒░░░▒████████████████████████████████████████████    //
//    ████████████████████████████████████████████▒░░░░▒▓███▓▒░░░░░▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▒▒░░░░░▒▒▓█▓▒░░░░░░█████████████████████████████████████████████    //
//    ████████████████████████████████████████████▓░░░░░░░▒▒▓███▓▒▒░░░░░░░░░▒▒▒▒▒▒▒▒░░░░░░░░░░▒▒▓███▓▒░░░░░░░░▓█████████████████████████████████████████████    //
//    █████████████████████████████████████████████▒░░░░░░░░░░░▒▒▓▓███▓▓▓▒▒▒▒▒▒░░▒▒▒▒▒▒▓▓▓████▓▓▒▒░░░░░░░░░░░▒██████████████████████████████████████████████    //
//    ██████████████████████████████████████████████▒░░░░░░░░░░░░░░░░▒▒▒▓▓▓▓▓████████▓▓▓▓▒▒▒░░░░░░░░░░░░░░░░▒███████████████████████████████████████████████    //
//    ███████████████████████████████████████████████▓░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒█████████████████████████████████████████████████    //
//    █████████████████████████████████████▓▒▓█████████▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓████████▓▓████████████████████████████████████████    //
//    ███████████████████████████████████▓▒░░░▓██████████▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓███████████▒░░▓██████████████████████████████████████    //
//    █████████████████████████████████▓▒░▒▒░▓█▓▒▓██████████▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓██████████▒░▓██▓░░█████████████████████████████████████    //
//    █████████████████████████████████▒▒▓░░▒░░░░░█████████████▓▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓██████████▓▒▓█▒░▒▓███░░███████████████████████████████████    //
//    ███████████████████████████████████▒░▒▓▒░▒▓██▓▒▒▓█████████████▓▒▒░░░░░░░░░░░░░░░░░░░▒▒▓██████████████▓░░░░░▒░░▒███████████████████████████████████████    //
//    █████████████████████████████████████▓░▒▓██▒░░▓▓░░██████████████████▓▓▓▓▓▓▓▓▓▓▓▓▓███████████████▓▒░░▓██▒░▒▓▒░░░▓██████████████████████████████████████    //
//    ██████████████████████████████████████████▒░▒███░░▓██▒▒▓████████████████████████████████████████░░▓█▓▒███▒░▒██████████████████████████████████████████    //
//    ██████████████████████████████████████████▓░▓█▓░░▓██░░░▒█▒▒█████████████████████████████▓▒░░░░▓██▒░░▓█████▓███████████████████████████████████████████    //
//    ███████████████████████████████████████████▓▒▒▒▒███░░▓░▒▓░▒██░░░░▒█▓▓▓███▓███████▒▒░▒▓██▒░▒██▒░▒██▒░▒▒░▒██████████████████████████████████████████████    //
//    ██████████████████████████████████████████████████▒░▓▓░▒░▒██▓░░█████░░▓█░░▓█████░░██▒░▒██░░▓██░░███▓▒▓████████████████████████████████████████████████    //
//    ██████████████████████████████████████████████████▓▓█▒░░░███░░▒▒▒████░░░░███████░░███░░███░░▒▒░▓██████████████████████████████████████████████████████    //
//    ███████████████████████████████████████████████████████▓███▓░░▓▓▓████▓░░████████▒░▒▓▓░░███▓▒▓█████████████████████████████████████████████████████████    //
//    █████████████████████████████████████████████████████████████▓▓▓▓████▓░▒█████████▓▒▒▒▓████████████████████████████████████████████████████████████████    //
//    ██████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████    //
//    ██████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████    //
//    ██████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████    //
//    ██████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████    //
//    ██████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████    //
//    ██████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████    //
//    ██████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████    //
//    ██████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████    //
//    ██████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████████    //
//                                                                                                                                                              //
//                                                                                                                                                              //
//                                                                                                                                                              //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract Moden is ERC721Creator {
    constructor() ERC721Creator("MoneyOden", "Moden") {}
}