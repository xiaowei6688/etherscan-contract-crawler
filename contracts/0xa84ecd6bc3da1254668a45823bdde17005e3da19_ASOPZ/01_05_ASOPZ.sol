// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Aesopica.ZCreativeMedia
/// @author: manifold.xyz

import "./ERC721Creator.sol";

///////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                               //
//                                                                                               //
//                                                                                               //
//      __   ____  ____   __  ____  __  ___   __                                                 //
//     / _\ (  __)/ ___) /  \(  _ \(  )/ __) / _\                                                //
//    /    \ ) _) \___ \(  O )) __/ )(( (__ /    \                                               //
//    \_/\_/(____)(____/ \__/(__)  (__)\___)\_/\_/                                               //
//                                                                                               //
//    X                                                                                          //
//     ___________ ______ _____  ___ _____ _____ _   _ ________  ___ ___________ _____  ___      //
//    |___  /  __ \| ___ \  ___|/ _ \_   _|_   _| | | |  ___|  \/  ||  ___|  _  \_   _|/ _ \     //
//       / /| /  \/| |_/ / |__ / /_\ \| |   | | | | | | |__ | .  . || |__ | | | | | | / /_\ \    //
//      / / | |    |    /|  __||  _  || |   | | | | | |  __|| |\/| ||  __|| | | | | | |  _  |    //
//    ./ /__| \__/\| |\ \| |___| | | || |  _| |_\ \_/ / |___| |  | || |___| |/ / _| |_| | | |    //
//    \_____/\____/\_| \_\____/\_| |_/\_/  \___/ \___/\____/\_|  |_/\____/|___/  \___/\_| |_/    //
//                                                                                               //
//                                                                                               //
//                                                                                               //
//                                                                                               //
///////////////////////////////////////////////////////////////////////////////////////////////////


contract ASOPZ is ERC721Creator {
    constructor() ERC721Creator("Aesopica.ZCreativeMedia", "ASOPZ") {}
}