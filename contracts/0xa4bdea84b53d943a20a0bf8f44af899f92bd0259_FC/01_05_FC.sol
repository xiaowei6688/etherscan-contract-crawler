// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Forever Christmas
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                                          //
//                                                                                                                                                          //
//                                                                                                                                                          //
//     _______  _______  _______  _______           _______  _______    _______           _______ _________ _______ _________ _______  _______  _______     //
//    (  ____ \(  ___  )(  ____ )(  ____ \|\     /|(  ____ \(  ____ )  (  ____ \|\     /|(  ____ )\__   __/(  ____ \\__   __/(       )(  ___  )(  ____ \    //
//    | (    \/| (   ) || (    )|| (    \/| )   ( || (    \/| (    )|  | (    \/| )   ( || (    )|   ) (   | (    \/   ) (   | () () || (   ) || (    \/    //
//    | (__    | |   | || (____)|| (__    | |   | || (__    | (____)|  | |      | (___) || (____)|   | |   | (_____    | |   | || || || (___) || (_____     //
//    |  __)   | |   | ||     __)|  __)   ( (   ) )|  __)   |     __)  | |      |  ___  ||     __)   | |   (_____  )   | |   | |(_)| ||  ___  |(_____  )    //
//    | (      | |   | || (\ (   | (       \ \_/ / | (      | (\ (     | |      | (   ) || (\ (      | |         ) |   | |   | |   | || (   ) |      ) |    //
//    | )      | (___) || ) \ \__| (____/\  \   /  | (____/\| ) \ \__  | (____/\| )   ( || ) \ \_____) (___/\____) |   | |   | )   ( || )   ( |/\____) |    //
//    |/       (_______)|/   \__/(_______/   \_/   (_______/|/   \__/  (_______/|/     \||/   \__/\_______/\_______)   )_(   |/     \||/     \|\_______)    //
//                                                                                                                                                          //
//                                                                                                                                                          //
//                                                                                                                                                          //
//                                                                                                                                                          //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract FC is ERC1155Creator {
    constructor() ERC1155Creator("Forever Christmas", "FC") {}
}