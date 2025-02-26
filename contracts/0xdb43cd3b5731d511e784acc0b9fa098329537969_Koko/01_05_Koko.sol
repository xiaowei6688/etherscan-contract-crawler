// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Koko's Adventures
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

//////////////////////////////////////////////////////////////////////////////////////////
//                                                                                      //
//                                                                                      //
//                                                   _                                  //
//                     ___                          (_)                                 //
//                   _/XXX\                                                             //
//    _             /XXXXXX\_                                    __                     //
//    X\__    __   /X XXXX XX\                          _       /XX\__      ___         //
//        \__/  \_/__       \ \                       _/X\__   /XX XXX\____/XXX\        //
//      \  ___   \/  \_      \ \               __   _/      \_/  _/  -   __  -  \__/    //
//     ___/   \__/   \ \__     \\__           /  \_//  _ _ \  \     __  /  \____//      //
//    /  __    \  /     \ \_   _//_\___     _/    //           \___/  \/     __/        //
//    __/_______\________\__\_/________\_ _/_____/_____________/_______\____/_______    //
//                                      /|\                                             //
//                                     / | \                                            //
//                                    /  |  \                                           //
//                                   /   |   \                                          //
//                                  /    |    \                                         //
//                                 /     |     \                                        //
//                                /      |      \                                       //
//                               /       |       \                                      //
//                              /        |        \                                     //
//                             /         |         \                                    //
//    Collection by Chichi                                                              //
//                                                                                      //
//                                                                                      //
//////////////////////////////////////////////////////////////////////////////////////////


contract Koko is ERC721Creator {
    constructor() ERC721Creator("Koko's Adventures", "Koko") {}
}