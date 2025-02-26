// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: A Year In Colour Community
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                              //
//                                                                                                                                              //
//                                                                                                                                              //
//                                                                                 _..._       .-'''-.             .-'''-.                      //
//                                                                              .-'_..._''.   '   _    \  .---.   '   _    \                    //
//                              __.....__                     .--.  _..._     .' .'      '.\/   /` '.   \ |   | /   /` '.   \                   //
//           .-.          .-.-''         '.                   |__|.'     '.  / .'          .   |     \  ' |   |.   |     \  '                   //
//            \ \        / /     .-''"'-.  `.          .-,.--..--.   .-.   .. '            |   '      |  '|   ||   '      |  '     .-,.--.      //
//        __   \ \      / /     /________\   \    __   |  .-. |  |  '   '  || |            \    \     / / |   |\    \     / /      |  .-. |     //
//     .:--.'.  \ \    / /|                  | .:--.'. | |  | |  |  |   |  || |             `.   ` ..' /  |   | `.   ` ..' /_    _ | |  | |     //
//    / |   \ |  \ \  / / \    .-------------'/ |   \ || |  | |  |  |   |  |. '                '-...-'`   |   |    '-...-'`| '  / || |  | |     //
//    `" __ | |   \ `  /   \    '-.____...---.`" __ | || |  '-|  |  |   |  | \ '.          .              |   |           .' | .' || |  '-      //
//     .'.''| |    \  /     `.             .'  .'.''| || |    |__|  |   |  |  '. `._____.-'/              |   |           /  | /  || |          //
//    / /   | |_   / /        `''-...... -'   / /   | || |       |  |   |  |    `-.______ /               '---'          |   `'.  || |          //
//    \ \._,\ '/`-' /                         \ \._,\ '/_|       |  |   |  |             `                               '   .'|  '/_|          //
//     `--'  `" '..'                           `--'  `"          '--'   '--'                                              `-'  `--'             //
//                                                                                                                                              //
//                                                                                                                                              //
//                                                                                                                                              //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract AYIC23 is ERC721Creator {
    constructor() ERC721Creator("A Year In Colour Community", "AYIC23") {}
}