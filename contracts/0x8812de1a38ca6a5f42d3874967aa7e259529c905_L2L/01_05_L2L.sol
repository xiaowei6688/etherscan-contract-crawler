// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Layer 2 Lounge
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

/////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                         //
//                                                                                         //
//                                                                                         //
//     __           ________       __  __     ______       ______          _____           //
//    /_/\         /_______/\     /_/\/_/\   /_____/\     /_____/\        /_____/\         //
//    \:\ \        \::: _  \ \    \ \ \ \ \  \::::_\/_    \:::_ \ \       \:::_:\ \        //
//     \:\ \        \::(_)  \ \    \:\_\ \ \  \:\/___/\    \:(_) ) )_         _\:\|        //
//      \:\ \____    \:: __  \ \    \::::_\/   \::___\/_    \: __ `\ \       /::_/__       //
//       \:\/___/\    \:.\ \  \ \     \::\ \    \:\____/\    \ \ `\ \ \      \:\____/\     //
//     __ \_____\/  ___\__\/\__\/__  __\__\/  ___\_____\/    _\_\/_\_\/   ____\_____\/     //
//    /_/\         /_____/\     /_/\/_/\     /__/\ /__/\    /______/\    /_____/\          //
//    \:\ \        \:::_ \ \    \:\ \:\ \    \::\_\\  \ \   \::::__\/__  \::::_\/_         //
//     \:\ \        \:\ \ \ \    \:\ \:\ \    \:. `-\  \ \   \:\ /____/\  \:\/___/\        //
//      \:\ \____    \:\ \ \ \    \:\ \:\ \    \:. _    \ \   \:\\_  _\/   \::___\/_       //
//       \:\/___/\    \:\_\ \ \    \:\_\:\ \    \. \`-\  \ \   \:\_\ \ \    \:\____/\      //
//        \_____\/     \_____\/     \_____\/     \__\/ \__\/    \_____\/     \_____\/      //
//                                                                                         //
//                                                                                         //
//                                                                                         //
//                                                                                         //
/////////////////////////////////////////////////////////////////////////////////////////////


contract L2L is ERC1155Creator {
    constructor() ERC1155Creator("Layer 2 Lounge", "L2L") {}
}