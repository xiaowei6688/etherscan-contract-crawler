// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: HAIROFMEDUSA
/// @author: manifold.xyz

import "./ERC721Creator.sol";

/////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                             //
//                                                                                             //
//                                                                                             //
//     __ __   ____  ____  ____    ___   _____  ___ ___    ___  ___    __ __   _____  ____     //
//    |  |  | /    ||    ||    \  /   \ |     ||   |   |  /  _]|   \  |  |  | / ___/ /    |    //
//    |  |  ||  o  | |  | |  D  )|     ||   __|| _   _ | /  [_ |    \ |  |  |(   \_ |  o  |    //
//    |  _  ||     | |  | |    / |  O  ||  |_  |  \_/  ||    _]|  D  ||  |  | \__  ||     |    //
//    |  |  ||  _  | |  | |    \ |     ||   _] |   |   ||   [_ |     ||  :  | /  \ ||  _  |    //
//    |  |  ||  |  | |  | |  .  \|     ||  |   |   |   ||     ||     ||     | \    ||  |  |    //
//    |__|__||__|__||____||__|\_| \___/ |__|   |___|___||_____||_____| \__,_|  \___||__|__|    //
//                                                                                             //
//                                                                                             //
//                                                                                             //
//                                                                                             //
/////////////////////////////////////////////////////////////////////////////////////////////////


contract HOFM is ERC721Creator {
    constructor() ERC721Creator("HAIROFMEDUSA", "HOFM") {}
}