// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Coin Droids
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

//////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                          //
//                                                                                                          //
//    + + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - + +                       //
//    +                                                                             +                       //
//    .                                                  *                          .                       //
//    .                                      /\                                     .                       //
//    .                         .           /  \                                    .                       //
//    .                                ||  /    \     .                             .                       //
//    .                                || /______\                                  .                       //
//    .                                |||    _   |                                 .                       //
//    .                               |  |   |_)  |           +                     .                       //
//    .                   *           |  |   |_)  |                                 .                       //
//    .                               |__|________|                                 .                       //
//    .                               |___________|               .                 .                       //
//    .                            .  |  |        |                                 .                       //
//    .                               |__|   ||   |\       .                        .                       //
//    .                                |||   ||   | \                               .                       //
//    .                 +             /|||   ||   |  \                              .                       //
//    .                              /_|||...||...|___\                             .                       //
//    .                                |||::::::::|                   .             .                       //
//    .              .                 || \::::::/                                  .                       //
//    .                                ||  ||__||                                   .                       //
//    .                                ||    ||                                     .                       //
//    .                                ||     \\__________________________________  .                       //
//    .  ______________________________||______`----------------------------------  .                       //
//    .                                                                             .                       //
//    .   __      __  __      .______   __   __ .______  .______   __      ______   .                       //
//    .  |  |    |  ||  |     |   _  \ |  | |  ||   _  \ |   _  \ |  |    |   ___|  .                       //
//    .  |  |    |  ||  |     |  |_)  ||  | |  ||  |_)  ||  |_)  ||  |    |  |__    .                       //
//    .  |  |    |  ||  |     |   _  < |  | |  ||   _  < |   _  < |  |    |   __|   .                       //
//    .  |  `---.|  ||  `---. |  |_)  ||  `-'  ||  |_)  ||  |_)  ||  `---.|  |___   .                       //
//    .  |______||__||______| |______/  \______/|______/ |______/ |______||______|  .                       //
//    .                                                                             .                       //
//    .  _________________________________________________________________________  .                       //
//    .                                                                             .                       //
//    +                                                                             +                       //
//    + - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - - + +                       //
//                                                                                                          //
//                                                                                                          //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract DROID is ERC1155Creator {
    constructor() ERC1155Creator("Coin Droids", "DROID") {}
}