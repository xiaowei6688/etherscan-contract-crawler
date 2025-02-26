// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: LeChatN0ir
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

//////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                          //
//                                                                                          //
//                                                                                          //
//    //    ▓▒▒▒▒░░░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▓▓▓█▓▓▓▓▓▒▒▒▒▒▓▓▓▓▓▓▓░▒▓▓▓▒░▒▓▓▓▓▓▓▓▓▓███████    //    //
//    //    ████████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓██▓▓▓▓▓▓▓▓▒▒▒▒▓▓▓▓▓▒▒▒▒▒▒▓▓▓███▓▓▓▓███████    //    //
//    //    █████████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█████████████▓▓▓██▓███████████▓▒▒▓████▓▓▓    //    //
//    //    █▓██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▒▓▓▒▒▒▓▓███████████████▓█▓▒▓████▓▓▓▒█▓▒▒▒▓███▓▓▓▓    //    //
//    //    ▓▒▓▓▒▒▓▓▓▒░▒▒▒▓▓▓▒░▓▒░▒░░░▒█████████████████▓▓▒▒▓█▓▓▓░▒▒▒▓▓▒▒▒▓██▓▓▓▓▓    //    //
//    //    ▒▒▓▓▒▒▓▓▓░░░░▒▒░▓░░▒▒▒░▒▒░▓████▓▓▓██████▓▓███▒▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓███▓█▓▓▓▓    //    //
//    //    ▓▓▓▓▒▓▓░░▒░░░░▒▒▒░░▒▒▒▒▒▓▒▒█████████▓█████████▓▒▓▓▓█▓▓▓▓▓▓▓▓▒▓▓▓▓█▓▓▓▓    //    //
//    //    ▓▒▓█▓▓█▒░▒▓▒░░░▒▓▒░▒▓▒░▒░▒▒███████████████████▓▓▓█▓███▓██▓▓▓▒▓▓▓█▓▓▓▓▓    //    //
//    //    ▓▓▓▓▓▓▓▒▒▒▓▒▒░▒███▓▒▒▒░░▒▒▒▒▓███████████████▒▒▒▓▓▓▓███▓▓▓▓▓▓▓██▓▓▓▓▓▓█    //    //
//    //    ▒▓▒▒▓▓▓▒▒▒▒▒▒▒▓███▓▒▓▓▓▓▓▓▓▓████████████████▓▓▓▓▓▓████████████████████    //    //
//    //    ███████▓▓▓▓▓▓▓▒████▓▓█▓▒▒▒▒▒▓███████████████▒▒▓▓▓▓▓█████▓▓████████████    //    //
//    //    ▓▓▓▓▓▓▓▒▒▒▒▒▒▒▒▒▓██████▒▒▒▒▒██████████████████████████████████████████    //    //
//    //    ███████▓▓▓▓▓▓▓▓▓▓▓█████▓▓▓▓███████████████████████████████▓███▓▓▓▓▓▓▓▓    //    //
//    //    ██████████████████████████████████████████▓▓███▓▓▓▓▒▓▓▒▒▒▒░▒▒░▒▒▒▒▒▒▒▓    //    //
//    //    █████████▓██████▓▓▓▓████▓█████████████████▓▓███▓▒░░░░░░░░░░░░░░▒▒▒▒▒▒▒    //    //
//    //    ███▓▓▓▓▓▓▒▓▒▒▒▒▒▒▒▒▓███████████████████████▓█████▒░░░░░░░░░░░▒████▓▒▒▒    //    //
//    //    ▓▓▓██████▓▓▓▓▓▓▒▒▒▒▓██████████████████████████████▓▒░░░░░░▒▒▓██████▓▓▓    //    //
//    //    █░░░░░░░▓████████▓▓▓████████████████████████████████▓▒▒▒▒▒▒▒███████▓▓▓    //    //
//    //    █▓░░░░░▒██▓▓███████████████████████████████████████████████████████▓▓▓    //    //
//    //    ██▓▒▒░▒▓███▓████▓▓▓███████████████████████████████████▒▓▓▓▓▓██████████    //    //
//    //    ██▓▓▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓█▓█████████████████████████████████▓▒▒▒▒▒▓█████▓▓██    //    //
//    //    ▓▓▓█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒▓▒▓█████████████████████████████████▒▒▒▒▒▓█████▓▓▓▓    //    //
//    //    ████▓█████▓▓▓▓▒▒▒▒▓▒▒▒▓████████████████████████████████▓▒▓▓▓▓█████▓▓▓▓    //    //
//    //    ██▓▒▒▒▓█▓███████▓▓▓▒▒▒▒█████████████████████████████████▒▓▓▓▓█████▓▓▓▓    //    //
//    //    ████▓▓▓█████████████████████████████████████████████████▓▓▓▓██████▓▓▓▓    //    //
//    //    ███████████▓▓▓▓▓▓▓███▓▓▓▓▓▓▓████████████████████████████▓▓▓▓█████▒▒▓▓▓    //    //
//                                                                                          //
//                                                                                          //
//                                                                                          //
//                                                                                          //
//                                                                                          //
//////////////////////////////////////////////////////////////////////////////////////////////


contract LCN is ERC721Creator {
    constructor() ERC721Creator("LeChatN0ir", "LCN") {}
}