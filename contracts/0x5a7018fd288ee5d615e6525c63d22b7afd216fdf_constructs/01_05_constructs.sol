// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Constructs x Ry Hawthorne
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                            //
//                                                                                                            //
//    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    //
//    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    //
//    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    //
//    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    //
//    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    //
//    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    //
//    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    //
//    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    //
//    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    //
//    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    //
//    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    //
//    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    //
//    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$iiiiiiiiiiiiii$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    //
//    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$              $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    //
//    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$              $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    //
//    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$              $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    //
//    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$              $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    //
//    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$              $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    //
//    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$              $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    //
//    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$iiiiiiiiiiiiii$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    //
//    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    //
//    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$!!!!!!!!!!!!!!$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    //
//    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$              $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    //
//    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$              $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    //
//    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$              $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    //
//    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$              $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    //
//    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$              $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    //
//    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$              $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    //
//    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$!!!!!!!!!!!!!!$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    //
//    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    //
//    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$iiiiiiiiiiiiii$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    //
//    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$              $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    //
//    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$              $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    //
//    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$              $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    //
//    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$              $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    //
//    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$              $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    //
//    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$              $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    //
//    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$iiiiiiiiiiiiii$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    //
//    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    //
//    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    //
//    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    //
//    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    //
//    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    //
//    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    //
//    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    //
//    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    //
//    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    //
//    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    //
//    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    //
//    $$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$$    //
//                                                                                                            //
//                                                                                                            //
//                                                                                                            //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract constructs is ERC721Creator {
    constructor() ERC721Creator("Constructs x Ry Hawthorne", "constructs") {}
}