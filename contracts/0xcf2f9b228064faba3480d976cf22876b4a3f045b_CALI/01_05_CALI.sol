// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: CALIMA
/// @author: manifold.xyz

import "./ERC721Creator.sol";

/////////////////////////////////////////////////////////////////////////////////////
//                                                                                 //
//                                                                                 //
//                                                                                 //
//     .-.-. .-.-. .-.-. .-.-. .-.-. .-.-.                                         //
//    ( C .'( A .'( L .'( I .'( M .'( A .'                                         //
//     `.(   `.(   `.(   `.(   `.(   `.(                                           //
//                                                                                 //
//     .-.-. .-.-.                                                                 //
//    ( B .'( Y .'.-.-.                                                            //
//     `.(   `.(  '._.'                                                            //
//                                                                                 //
//     .-.-. .-.-. .-.-. .-.-. .-.-. .-.-. .-.-. .-.-. .-.-. .-.-. .-.-. .-.-.     //
//    ( S .'( A .'( V .'( A .'( N .'( N .'( A .'( H .'( 0 .'( N .'( E .'( Y .'     //
//     `.(   `.(   `.(   `.(   `.(   `.(   `.(   `.(   `.(   `.(   `.(   `.(       //
//                                                                                 //
//                                                                                 //
//                                                                                 //
//                                                                                 //
//                                                                                 //
//                                                                                 //
//                                                                                 //
/////////////////////////////////////////////////////////////////////////////////////


contract CALI is ERC721Creator {
    constructor() ERC721Creator("CALIMA", "CALI") {}
}