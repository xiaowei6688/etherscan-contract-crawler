// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: PB's Memes
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

/////////////////////////////////////////////////////////////////////////////////
//                                                                             //
//                                                                             //
//             _          _              _                                     //
//            /\ \       / /\           / /\                                   //
//           /  \ \     / /  \         / /  \                                  //
//          / /\ \ \   / / /\ \       / / /\ \__                               //
//         / / /\ \_\ / / /\ \ \     / / /\ \___\                              //
//        / / /_/ / // / /\ \_\ \    \ \ \ \/___/                              //
//       / / /__\/ // / /\ \ \___\    \ \ \                                    //
//      / / /_____// / /  \ \ \__/_    \ \ \                                   //
//     / / /      / / /____\_\ \ /_/\__/ / /                                   //
//    / / /      / / /__________\\ \/___/ /                                    //
//    \/_/       \/_____________/ \_____\/                                     //
//            _   _         _           _   _         _           _            //
//           /\_\/\_\ _    /\ \        /\_\/\_\ _    /\ \        / /\          //
//          / / / / //\_\ /  \ \      / / / / //\_\ /  \ \      / /  \         //
//         /\ \/ \ \/ / // /\ \ \    /\ \/ \ \/ / // /\ \ \    / / /\ \__      //
//        /  \____\__/ // / /\ \_\  /  \____\__/ // / /\ \_\  / / /\ \___\     //
//       / /\/________// /_/_ \/_/ / /\/________// /_/_ \/_/  \ \ \ \/___/     //
//      / / /\/_// / // /____/\   / / /\/_// / // /____/\      \ \ \           //
//     / / /    / / // /\____\/  / / /    / / // /\____\/  _    \ \ \          //
//    / / /    / / // / /______ / / /    / / // / /______ /_/\__/ / /          //
//    \/_/    / / // / /_______\\/_/    / / // / /_______\\ \/___/ /           //
//            \/_/ \/__________/        \/_/ \/__________/ \_____\/            //
//                                                                             //
//                                                                             //
//                                                                             //
/////////////////////////////////////////////////////////////////////////////////


contract PBM is ERC721Creator {
    constructor() ERC721Creator("PB's Memes", "PBM") {}
}