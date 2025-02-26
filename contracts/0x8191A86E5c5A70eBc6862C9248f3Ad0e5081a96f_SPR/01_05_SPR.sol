// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: DISTANT UNIVERSE SOLO OPEN
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

////////////////////////////////////////////////////////////////////////////
//                                                                        //
//                                                                        //
//                                                                        //
//          ___          ___                     ___          ___         //
//         /  /\        /  /\        ___        /  /\        /  /\        //
//        /  /::\      /  /:/       /  /\      /  /::\      /  /::\       //
//       /__/:/\:\    /  /:/       /  /::\    /  /:/\:\    /  /:/\:\      //
//      _\_ \:\ \:\  /  /:/       /  /:/\:\  /  /::\ \:\  /  /::\ \:\     //
//     /__/\ \:\ \:\/__/:/     /\/  /::\ \:\/__/:/\:\ \:\/__/:/\:\_\:\    //
//     \  \:\ \:\_\/\  \:\    /:/__/:/\:\_\:\  \:\ \:\_\/\__\/~|::\/:/    //
//      \  \:\_\:\   \  \:\  /:/\__\/  \:\/:/\  \:\ \:\     |  |:|::/     //
//       \  \:\/:/    \  \:\/:/      \  \::/  \  \:\_\/     |  |:|\/      //
//        \  \::/      \  \::/        \__\/    \  \:\       |__|:|~       //
//         \__\/        \__\/                   \__\/        \__\|        //
//                                                                        //
//                                                                        //
//                                                                        //
////////////////////////////////////////////////////////////////////////////


contract SPR is ERC1155Creator {
    constructor() ERC1155Creator("DISTANT UNIVERSE SOLO OPEN", "SPR") {}
}