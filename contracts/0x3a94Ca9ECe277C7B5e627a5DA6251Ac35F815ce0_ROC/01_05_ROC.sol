// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Reflections on Canvas
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                        //
//                                                                                        //
//    .-. .-. .-. .   .-. .-. .-. .-. .-. . . .-.   .-. . .   .-. .-. . . . . .-. .-.     //
//    |(  |-  |-  |   |-  |    |   |  | | |\| `-.   | | |\|   |   |-| |\| | | |-| `-.     //
//    ' ' `-' '   `-' `-' `-'  '  `-' `-' ' ` `-'   `-' ' `   `-' ` ' ' ` `.' ` ' `-'     //
//                                                                                        //
//                                                                                        //
////////////////////////////////////////////////////////////////////////////////////////////


contract ROC is ERC721Creator {
    constructor() ERC721Creator("Reflections on Canvas", "ROC") {}
}