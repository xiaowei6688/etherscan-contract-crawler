// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: //Galleryhaus: MtGoxBunni3
/// @author: manifold.xyz

import "./ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                        //
//                                                                                        //
//    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓███░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓██▓▒░▓█▒░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓███▒░░░░░▒█▒░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░▓████████▓▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓███▓░░░░░░░░▒█░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░▓▓░░░░▒▒▒▓███▓░░░░░░░░░░░░░░░░░░░░░░░░░▓██▓▒░░░░░░░░░░▓█░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░▓▓░░░░░░░░░▓███▓░░░░░░░░░░░░░░░░░░░░░░██▓▒░░░░░░░░░░░░█▒░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░█▓░░░░░░░░░░▒▓██▓░░░░░░░░░░░░░░░░░░░░██▓░░░░░░░░░░░░░▒█░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░▓█░░░░░░░░░░░░▓███▒░░░░░░░░░░░░░░░░▒██▒░░░░░░░░░░░░░░█░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░▒█▓░░░░░░░░░░░░░▓██▓░░░░░░░░░░░░░░▓██▒░░░░░█░░░░░░░▒█▒░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░▓█▒░░░░░░▓▒▒▒░░░░▓██▓▒▒░░░░░░░░░░██▓░▒▓▓▒▓█░░░░░░▓█▒░░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░▓█░░░░░░▓▒▒░▒▒░░░▓██████▒░░░░░░▓██▓▓▓▒▓▒█▒░░░░▒██▒░░░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░▓▓░░░░░▒▓▒░░░▒▒▓██████████████████▓▓███▓░░░▓███░░░░░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░▓▓░░░░░▓▒▒░░▓▓▓███████████████████▓█▓▓░░▓███▒░░░░░░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░██░░░░▒▒▓██████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒█████▒▓██▓▒░░░░░░░░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░▒██▒░░░▒▓█████▓░░░░░░░░░░░░░░░░███████▓░░░░░░░░░░░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░▓██▓▓▓███▓▓▓▓░░░░░░░░░░░░░░░░░▓▓▓▓▓▓▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░▒███████░░░░░░░░░░░░░░░░░░░░░░▓░░░████░░░░░░░░░░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░░░▓█████░▓▒░░░░░░▒▓░░░░▒▓▒░░░▒▓░░▒████░░░░░░░░░░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░░░░█████░░░▒▓▒░░▓▓░░░░░░░▓▓░░█░░░▒████░░░░░░░░░░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░░░░█████░░░░░░▓█▓░░░░░░░░░▒▓█▒░░░▒████░░░░░░░░░░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░░░░█████░░░░░▒▓▒░▒▓▒░░░░░░░▒█▓▒░░▒████░░░░░░░░░░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░░░░█████░░░░▒▓░░░▒░▒▓▓▒░░░░▓░░▓▒░▓████░░░░░░░░░░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░░░▒█████░░░▓█▓▒▒▒░▓▒▒▓▓▓▓▓▓█▓▓▓▓▓▓████░░░░░░░░░░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░░░░█████░▒██▓▓░░█▒▒▓░░▒▓░░░█████▓█████░░░░░░░░░░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░░░░▓████▓▓▓▒░▒▓░██▓█░░░▓▒░░▓▓▒▒▒▒█████░░░░░░░░░░▒▓▓▓▒▒░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░░░░░░░░▒████░░▒▓▓▒▓█▒░░░▓░░▓▓▓████░░░░░░░░░░▒▓█▓▒░░░░▒▓█▓▒░░░░░    //
//    ░░░░░░░░░░░░░░░░░░░░░░░░▒████▓▒▒▓█▓▒██▒▒▒▓▓▒▒▓▓████▒░░░░░░░▒█▓░░░░░░░░░░░▒█▒░░░░    //
//    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓█████████████████▓░░░▒████░░░░█░░░░░░░░░░░░░░▒█░░░░    //
//    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓█████████████████▒░░░░████░░░▒█░░░░░░░░░░░░░░░█▒░░░    //
//    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓▓▓██████████████▒░░░░█████████░░░░░░░░░░░░░░░█▒░░░    //
//    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░██████░░░░░░░░░░░░░▓█░░░░    //
//    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▒████▓░░░░░░░░░░░░░░█▓▓█▓█    //
//    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒▓█▓▒▒▒▒▓██████░▓███████████▓░░    //
//    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░██▒░░░░░░░░████████▓░░░░▓████▒░░    //
//    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓█▒░░░░░░░░░░▒░░██▓░░░░░░░▓███░░▒    //
//    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▓█▒▒▒░░░░░░░░░░██▒░░░░░░░░░████▓▒    //
//    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░███▓▓██▓░░░░░░▓█▓░░░░░░░░░░▒█░░░░    //
//    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░▒██▒▒▓▓██▓░░░░▓██▒▒▓▓█▓▓▓▓▓▓██░░░░    //
//    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░█████████░░░░▒▓▒▒▒░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░    //
//    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░    //
//                                                                                        //
//                                                                                        //
//                                                                                        //
////////////////////////////////////////////////////////////////////////////////////////////


contract MGB is ERC721Creator {
    constructor() ERC721Creator("//Galleryhaus: MtGoxBunni3", "MGB") {}
}