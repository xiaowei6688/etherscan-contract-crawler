// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: MIND OVER MATTER
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////////////
//                                                                                //
//                                                                                //
//                                                                                //
//                                   _______                                      //
//     __  __   ___   .--.   _..._   \  ___ `'.                                   //
//    |  |/  `.'   `. |__| .'     '.  ' |--.\  \                                  //
//    |   .-.  .-.   '.--..   .-.   . | |    \  '                                 //
//    |  |  |  |  |  ||  ||  '   '  | | |     |  '                                //
//    |  |  |  |  |  ||  ||  |   |  | | |     |  |                                //
//    |  |  |  |  |  ||  ||  |   |  | | |     ' .'                                //
//    |  |  |  |  |  ||  ||  |   |  | | |___.' /'                                 //
//    |__|  |__|  |__||__||  |   |  |/_______.'/                                  //
//                        |  |   |  |\_______|/                                   //
//        .-'''-.         |  |   |  |                                             //
//       '   _    \       '--'   '--'                                             //
//     /   /` '.   \.----.     .----.   __.....__                                 //
//    .   |     \  ' \    \   /    /.-''         '.                               //
//    |   '      |  ' '   '. /'   //     .-''"'-.  `. .-,.--.                     //
//    \    \     / /  |    |'    //     /________\   \|  .-. |                    //
//     `.   ` ..' /   |    ||    ||                  || |  | |                    //
//        '-...-'`    '.   `'   .'\    .-------------'| |  | |                    //
//                     \        /  \    '-.____...---.| |  '-                     //
//                      \      /    `.             .' | |                         //
//                       '----'       `''-...... -'   | |                         //
//     __  __   ___                                   |_|.....__                  //
//    |  |/  `.'   `.                              .-''         '.                //
//    |   .-.  .-.   '              .|       .|   /     .-''"'-.  `. .-,.--.      //
//    |  |  |  |  |  |    __      .' |_    .' |_ /     /________\   \|  .-. |     //
//    |  |  |  |  |  | .:--.'.  .'     | .'     ||                  || |  | |     //
//    |  |  |  |  |  |/ |   \ |'--.  .-''--.  .-'\    .-------------'| |  | |     //
//    |  |  |  |  |  |`" __ | |   |  |     |  |   \    '-.____...---.| |  '-      //
//    |__|  |__|  |__| .'.''| |   |  |     |  |    `.             .' | |          //
//                    / /   | |_  |  '.'   |  '.'    `''-...... -'   | |          //
//        .-'''-.     \ \._,\ '/  |   /    |   /                .---.|_|          //
//       '   _    \    `--'  `"   `'-'     `'-'                 |   |             //
//     /   /` '.   \               __.....__        _..._       '---'.--.         //
//    .   |     \  '           .-''         '.    .'     '.     .---.|__|         //
//    |   '      |  '.-,.--.  /     .-''"'-.  `. .   .-.   .    |   |.--.         //
//    \    \     / / |  .-. |/     /________\   \|  '   '  |    |   ||  |         //
//     `.   ` ..' /  | |  | ||                  ||  |   |  |    |   ||  |         //
//        '-...-'`   | |  | |\    .-------------'|  |   |  |    |   ||  |         //
//                   | |  '-  \    '-.____...---.|  |   |  |    |   ||  |         //
//                   | |       `.             .' |  |   |  |    |   ||__|         //
//                   | |         `''-...... -'   |  |   |  | __.'   '             //
//                   |_|                         |  |   |  ||      '              //
//                  .-'''-.                      '--'   '--'|____.'               //
//                 '   _    \                                                     //
//       .       /   /` '.   \                       __.....__                    //
//     .'|      .   |     \  '                   .-''         '.                  //
//    <  |      |   '      |  '                 /     .-''"'-.  `.                //
//     | |      \    \     / /                 /     /________\   \               //
//     | | .'''-.`.   ` ..' /_    _         _  |                  |               //
//     | |/.'''. \  '-...-'`| '  / |      .' | \    .-------------'               //
//     |  /    | |         .' | .' |     .   | /\    '-.____...---.               //
//     | |     | |         /  | /  |   .'.'| |// `.             .'                //
//     | |     | |        |   `'.  | .'.'.-'  /    `''-...... -'                  //
//     | '.    | '.       '   .'|  '/.'   \_.'                                    //
//     '---'   '---'       `-'  `--'                                              //
//                                                                                //
//                                                                                //
////////////////////////////////////////////////////////////////////////////////////


contract MNDOM is ERC721Creator {
    constructor() ERC721Creator("MIND OVER MATTER", "MNDOM") {}
}