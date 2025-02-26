// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: EDITIONS by pli
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

//////////////////////////////////////////////
//                                          //
//                                          //
//                                          //
//                                          //
//           Photographic Art by            //
//                                          //
//                      dP  07              //
//                      88                  //
//            88d888b.  88  dP              //
//            92'  ;84  73  07              //
//            86'  `43  72  88              //
//            87.  .88  88  88              //
//            88Y568P'  dP  ED              //
//            88                            //
//            88                            //
//            dP                            //
//                                          //
//                                          //
//                                          //
//////////////////////////////////////////////


contract ED is ERC721Creator {
    constructor() ERC721Creator("EDITIONS by pli", "ED") {}
}