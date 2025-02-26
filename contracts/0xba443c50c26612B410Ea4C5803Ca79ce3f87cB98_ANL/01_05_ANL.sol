// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Annone Line ETH Version
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

///////////////////////////////////////////////////////////////////////////////
//                                                                           //
//                                                                           //
//                                                                           //
//      ___   _   _  _   _ _____ _   _  _____   _     _____ _   _  _____     //
//     / _ \ | \ | || \ | |  _  | \ | ||  ___| | |   |_   _| \ | ||  ___|    //
//    / /_\ \|  \| ||  \| | | | |  \| || |__   | |     | | |  \| || |__      //
//    |  _  || . ` || . ` | | | | . ` ||  __|  | |     | | | . ` ||  __|     //
//    | | | || |\  || |\  \ \_/ / |\  || |___  | |_____| |_| |\  || |___     //
//    \_| |_/\_| \_/\_| \_/\___/\_| \_/\____/  \_____/\___/\_| \_/\____/     //
//                                                                           //
//                                                                           //
//                                                                           //
//                                                                           //
//                                                                           //
///////////////////////////////////////////////////////////////////////////////


contract ANL is ERC1155Creator {
    constructor() ERC1155Creator("Annone Line ETH Version", "ANL") {}
}