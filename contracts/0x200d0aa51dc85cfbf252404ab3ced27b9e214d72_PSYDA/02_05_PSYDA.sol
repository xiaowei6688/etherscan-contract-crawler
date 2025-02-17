// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: psydigitalart
/// @author: manifold.xyz

import "./ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                        //
//                                                                                                                                        //
//     ______   ______     __  __     _____     __     ______     __     ______   ______     __         ______     ______     ______      //
//    /\  == \ /\  ___\   /\ \_\ \   /\  __-.  /\ \   /\  ___\   /\ \   /\__  _\ /\  __ \   /\ \       /\  __ \   /\  == \   /\__  _\     //
//    \ \  _-/ \ \___  \  \ \____ \  \ \ \/\ \ \ \ \  \ \ \__ \  \ \ \  \/_/\ \/ \ \  __ \  \ \ \____  \ \  __ \  \ \  __<   \/_/\ \/     //
//     \ \_\    \/\_____\  \/\_____\  \ \____-  \ \_\  \ \_____\  \ \_\    \ \_\  \ \_\ \_\  \ \_____\  \ \_\ \_\  \ \_\ \_\    \ \_\     //
//      \/_/     \/_____/   \/_____/   \/____/   \/_/   \/_____/   \/_/     \/_/   \/_/\/_/   \/_____/   \/_/\/_/   \/_/ /_/     \/_/     //
//                                                                                                                                        //
//                                                                                                                                        //
//                                                                                                                                        //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract PSYDA is ERC721Creator {
    constructor() ERC721Creator("psydigitalart", "PSYDA") {}
}