// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: CHECKERS
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

///////////////////////////////////////////////////////////////////
//                                                               //
//                                                               //
//       _____ _    _ ______ _____ _  ________ _____   _____     //
//      / ____| |  | |  ____/ ____| |/ /  ____|  __ \ / ____|    //
//     | |    | |__| | |__ | |    | ' /| |__  | |__) | (___      //
//     | |    |  __  |  __|| |    |  < |  __| |  _  / \___ \     //
//     | |____| |  | | |___| |____| . \| |____| | \ \ ____) |    //
//      \_____|_|  |_|______\_____|_|\_\______|_|  \_\_____/     //
//                                                               //
//                                                               //
//                                                               //
//                                                               //
///////////////////////////////////////////////////////////////////


contract CHECKERS is ERC1155Creator {
    constructor() ERC1155Creator("CHECKERS", "CHECKERS") {}
}