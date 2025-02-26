// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: PFP animations by satvrn.eth
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

/////////////////////////////////////////////////////
//                                                 //
//                                                 //
//    __________████████_____██████                //
//    _________█░░░░░░░░██_██░░░░░░█               //
//    ________█░░░░░░░░░░░█░░░░░░░░░█              //
//    _______█░░░░░░░███░░░█░░░░░░░░░█             //
//    _______█░░░░███░░░███░█░░░████░█             //
//    ______█░░░██░░░░░░░░███░██░░░░██             //
//    _____█░░░░░░░░░░░░░░░░░█░░░░░░░░███          //
//    ____█░░░░░░░░░░░░░██████░░░░░████░░█         //
//    ____█░░░░░░░░░█████░░░████░░██░░██░░█        //
//    ___██░░░░░░░███░░░░░░░░░░█░░░░░░░░███        //
//    __█░░░░░░░░░░░░░░█████████░░█████████        //
//    _█░░░░░░░░░░█████_████___████_█████___█      //
//    _█░░░░░░░░░░█______█_███__█_____███_█___█    //
//    █░░░░░░░░░░░░█___████_████____██_██████      //
//    ░░░░░░░░░░░░░█████████░░░████████░░░█        //
//    ░░░░░░░░░░░░░░░░█░░░░░█░░░░░░░░░░░░█         //
//    ░░░░░░░░░░░░░░░░░░░░██░░░░█░░░░░░██          //
//    ░░░░░░░░░░░░░░░░░░██░░░░░░░███████           //
//    ░░░░░░░░░░░░░░░░██░░░░░░░░░░█░░░░░█          //
//    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░█         //
//    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░█         //
//    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░█         //
//    ░░░░░░░░░░░█████████░░░░░░░░░░░░░░██         //
//    ░░░░░░░░░░█▒▒▒▒▒▒▒▒███████████████▒▒█        //
//    ░░░░░░░░░█▒▒███████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒█        //
//    ░░░░░░░░░█▒▒▒▒▒▒▒▒▒█████████████████         //
//    ░░░░░░░░░░████████▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒█        //
//    ░░░░░░░░░░░░░░░░░░██████████████████         //
//    ░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░█             //
//    ██░░░░░░░░░░░░░░░░░░░░░░░░░░░██              //
//    ▓██░░░░░░░░░░░░░░░░░░░░░░░░██                //
//    ▓▓▓███░░░░░░░░░░░░░░░░░░░░█                  //
//    ▓▓▓▓▓▓███░░░░░░░░░░░░░░░██                   //
//    ▓▓▓▓▓▓▓▓▓███████████████▓▓█                  //
//    ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██                //
//    ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█                //
//    ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█               //
//                                                 //
//                                                 //
/////////////////////////////////////////////////////


contract SATVRNPFP is ERC721Creator {
    constructor() ERC721Creator("PFP animations by satvrn.eth", "SATVRNPFP") {}
}