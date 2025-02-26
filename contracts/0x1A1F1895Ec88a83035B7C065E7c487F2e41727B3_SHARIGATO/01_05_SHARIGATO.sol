// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: SHARIGATO
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

///////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                       //
//                                                                                                       //
//      ####    ##  ##     ##     #####     ####     ####      ##     ######    ####      ##       ##    //
//     ##  ##   ##  ##    ####    ##  ##     ##     ##  ##    ####      ##     ##  ##     ##       ##    //
//     ##       ##  ##   ##  ##   ##  ##     ##     ##       ##  ##     ##     ##  ##     ##       ##    //
//      ####    ######   ######   #####      ##     ## ###   ######     ##     ##  ##     ##       ##    //
//         ##   ##  ##   ##  ##   ####       ##     ##  ##   ##  ##     ##     ##  ##                    //
//     ##  ##   ##  ##   ##  ##   ## ##      ##     ##  ##   ##  ##     ##     ##  ##                    //
//      ####    ##  ##   ##  ##   ##  ##    ####     ####    ##  ##     ##      ####      ##       ##    //
//                                                                                                       //
//                                                                                                       //
///////////////////////////////////////////////////////////////////////////////////////////////////////////


contract SHARIGATO is ERC721Creator {
    constructor() ERC721Creator("SHARIGATO", "SHARIGATO") {}
}