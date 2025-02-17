// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: CryptoGft Collections
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                          //
//                                                                                                                                          //
//                                                                                                                                          //
//       _____ _______     _______ _______ ____   _____ ______ _______ _____ ____  _      _      ______ _____ _______ _____ ____  _   _     //
//      / ____|  __ \ \   / /  __ \__   __/ __ \ / ____|  ____|__   __/ ____/ __ \| |    | |    |  ____/ ____|__   __|_   _/ __ \| \ | |    //
//     | |    | |__) \ \_/ /| |__) | | | | |  | | |  __| |__     | | | |   | |  | | |    | |    | |__ | |       | |    | || |  | |  \| |    //
//     | |    |  _  / \   / |  ___/  | | | |  | | | |_ |  __|    | | | |   | |  | | |    | |    |  __|| |       | |    | || |  | | . ` |    //
//     | |____| | \ \  | |  | |      | | | |__| | |__| | |       | | | |___| |__| | |____| |____| |___| |____   | |   _| || |__| | |\  |    //
//      \_____|_|  \_\ |_|  |_|      |_|  \____/ \_____|_|       |_|  \_____\____/|______|______|______\_____|  |_|  |_____\____/|_| \_|    //
//                                                                                                                                          //
//                                                                                                                                          //
//                                                                                                                                          //
//                                                                                                                                          //
//                                                                                                                                          //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract CRYPTOGFTCOLLECTION is ERC1155Creator {
    constructor() ERC1155Creator("CryptoGft Collections", "CRYPTOGFTCOLLECTION") {}
}