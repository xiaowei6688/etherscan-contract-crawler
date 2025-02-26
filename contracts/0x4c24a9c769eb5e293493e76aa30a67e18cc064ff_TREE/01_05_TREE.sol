// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: THUJA - Tree of Life
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                            //
//                                                                                            //
//                                                                                            //
//        ████████████████████████████████████████████████████████████████████████████████    //
//        ██████████████████████████████████████▓▓▓▓▓▓████████████████████████████████████    //
//        █████████████████████████████████▓▓▓█▓▓▓▓▓▓▓▓▓▓▓▓███████████▓▓▓▀▓▓▓████████████▓    //
//        █████████████████████▓▓▓▓▓▓▓▓█▓██████▓█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█▓▓▓▓▓▓▒▓▓▓▓▓▓▓▓▓▓▓▓██▓▓    //
//        █████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓████████████████▓████▓▓▓▓▓▓▓▓▓▓▓▓╢╫▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓    //
//        █▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█▓███████▓██████████▓▓████████▓▓▓▓▓▓▓▓▓▓╣╫▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓    //
//        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█▓██▓██▓▓▓█▓█▓▓███████▓▓▓▓╣▓████▓███▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓    //
//        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█▓█████████████████████████▓▓▓▓▓███████▓▓▓▓▓▓▓▓▓▓▓╣▓▓▓▓▓▓▓▓▓▓▓▓▓▓    //
//        ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓███████████████████████████████████████████▓█▓▓▓▓▓▓▓╣╫▓▓▓▓▓▓▓▓▓▓    //
//        ▓▓▓▓▓▓▓▓▓▓█▓▓██████▓▓▓▓▓▓████▓████▓█████▓█████▓█████▓███▓██▓▓▓▓▓▓▓▓▓▓▓╢╫╫╫╫╫╫▓▓▓    //
//        ▓▓▓▓╣╫╫▓▓▓█████▓███████████▓▓█▓███▓▓███▓▓▓▓██▓▓████▓████▓▓█▓▓▓▓▓▓▓▓▓▓▓▓╫╫╫╫╫╫╫╫▓    //
//        ╫╫╫╫╫╫▓▓▓▓███████████████████▓▓███▓███▓▓╣▒▓██▓▓██▓█▓█▓█▓██████████▓▓▓▓▓▓╫╫╫╫╫╫╫╫    //
//        ╫╫╫╫╫╫▓▓███████▓█▓█████████▓█▓▓▓▓▓▓█▓▓██▓▓▓▓██▓▓▓▓▓▓▓▓▓╣▓▓▓▓▓▓█▓█▓▓▓▓▓▓▓▓╫╫▒▒╫╫╫    //
//        ╫╫╫╫╫▓▓▓██████████████████████▓▓▓▓▓▓▓███▓▓███▓███▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█▓▓▓▓▓▓▓╫╫╫╫╫╫    //
//        ╫╫╫▒▒▓▓█████████████████████████████▓███▓▓█████████████████████████▓▓▓▓▓▓▓▓▒▒▒▒▒    //
//        ▒▒▒▒▒▓███████████████████████████████████████████████████████████▓▓▓███▓▓▓▓▒▒▒▒▒    //
//        ▒▒▒░╙▓▓████████████████████████████████▓████████████████████████████▓▓█▓█▓▓░░░░▒    //
//        ░░░░░▒▒▒▀▀▀▀▓▀▓▓▓▓▓▓▓▓▓██████████████████████████████████▓▓▓▓▓▓▓▓▓▓▓▀▀▀⌠░░░░░░░░    //
//             ▒▒░░░░░░░░╘░░░░░░░╙╙╙╙▀▀▀▓█▀▀▀╙▐██▓▓██▌ ▀▀▀▀▀▀▀▀▀╙╙⌠░░░░░░░░"░░░░²░░░░         //
//          `  ╟▒░╓▓▓▓▓▓▓▓▄▄g&▄▄╓▄▄▓▄▄╖      ,████▓▓▓▌       ,▄▓▓▓▄╖╓▄ΦWw▓█▓▓▓▓▓▓@░░░         //
//             ╟▓▓▓▓▓▓▓▓▓▓▄▄▄φ╩▓▓▓▓▓▓▓▓▓▓████████▓▓█▓▓▓╫m▒@▓▓▓▓▓▓▓▓▓▓╩φ@▄▄▓█▓▓▓▓▓▓▓▓@         //
//            ]▓███████▓▓██▓█████▓▓▓▓▓█▓███▓▓███████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█▓▓█▓▓████▓▓▓▓▓         //
//             ▓███▓▓▓▀▀▓▓▓█╥▄▓▓▓▓▓▒└--     ,,▓▓▓▓█▓▓▓▌      `└└╓▓▓▓▓▓@≡▓█▓▓▀▀▀▓█▓▓▓╜         //
//               ▒▒░░░░░    ╙█▓██▓▓▓░  -   ╓█▓▓█▓▓▓███▓▒▒   .   ╫▓▓▓▓▓╝     "░░░░░░           //
//                ▒▒▒▒░░░  ~              ▐███▓▓▓▓▓▓▓▓▓▓▓╫        `      ``░░░░░░░░           //
//                 ▒░░▒░░░░░      -  w   ,███████▓▓▓▓▓▓▓▓▌Ü        ═  . ░░░░░░░░░             //
//                  ▒▒░▒▒▒░░░░░.,  `    [email protected]█████████▓██▓▓▓▓k         ░░░░░░░░░░░▒              //
//                   ╙▒▒▒▒▒▒▒▒▒▒▒░░░░░░░▓░▀███████▓█████▓▀╕░░░░░░░╓╖░░░░░▒▒▒▒▒▒               //
//                     ╙▒▒▒▒▒▒▒▒░░░▒▒░░░⌠▌▄███████████▓▓▓░░░░░░░╫▓▓▓▓▓░░▒▒░░▒                 //
//        ░░░░░░░░░░░░░░ ╙▒▒▒▒▒▒▒▒▒▒▒██████████████▓███▓█▓▄░░░░░▓▓▓▓▓▓Ñ▒▒▒▒         ░░ ░░░    //
//        ░░░░░░░░░░░░░░░░░░▒▓▓▒▒░▐▒██████████████▓█████▓█▓▓▌K╫▓╖▒▐▒gm░▒░░░░░░░░░░░░░░░░░░    //
//        ▒▒▒▒▒▓▓▓╫▒▒▒▒▒▒▒▓▒▒█████████████████▓██╣▓█▓███████▓▓█▓▓▓▓▓╫▒▒▒▓▓░░░░░░░░░░▒░░░░▒    //
//        ╫╫╫╫╫╫╫╫╫╫╫╫▒▒▒████▓▓▓███▓█▓█▓▓█████▓▓▓▓██████▓█▓███████▓▓▓▓▓╫▓▓▓▓▓▒▒▒▒▒▒▒▓▓▒▒▒▒    //
//        ▓▓▓▓▓▓▓▓▓╫▓▓█▓██████▓▓▓▓▓▓█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██▓▓▓▓▓▓▓▓▓▓▓▓▓╫▓▓╢▓▓▓╫▒╫╫▓▓▓▓▓╫╫╫    //
//        ▓▓▓▓▓▓█▓▓▓█████████████████▓█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓╣╫╫▓▓█▓▓▓▓╣▓▓╣▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓    //
//        ████████████████████████████████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓    //
//                                                                                            //
//                                                                                            //
////////////////////////////////////////////////////////////////////////////////////////////////


contract TREE is ERC721Creator {
    constructor() ERC721Creator("THUJA - Tree of Life", "TREE") {}
}