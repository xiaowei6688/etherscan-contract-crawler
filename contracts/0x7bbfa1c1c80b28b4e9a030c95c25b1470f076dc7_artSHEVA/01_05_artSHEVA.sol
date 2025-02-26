// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: artSHEVA
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                        //
//                                                                                        //
//       ###    ########  ########     ######  ##     ## ######## ##     ##    ###        //
//      ## ##   ##     ##    ##       ##    ## ##     ## ##       ##     ##   ## ##       //
//     ##   ##  ##     ##    ##       ##       ##     ## ##       ##     ##  ##   ##      //
//    ##     ## ########     ##        ######  ######### ######   ##     ## ##     ##     //
//    ######### ##   ##      ##             ## ##     ## ##        ##   ##  #########     //
//    ##     ## ##    ##     ##       ##    ## ##     ## ##         ## ##   ##     ##     //
//    ##     ## ##     ##    ##        ######  ##     ## ########    ###    ##     ##     //
//                                                                                        //
//                                                                                        //
////////////////////////////////////////////////////////////////////////////////////////////


contract artSHEVA is ERC1155Creator {
    constructor() ERC1155Creator("artSHEVA", "artSHEVA") {}
}