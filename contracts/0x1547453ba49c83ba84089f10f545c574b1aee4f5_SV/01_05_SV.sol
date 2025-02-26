// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Squirrelverse
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                                                                            //
//                                                                            //
//       _____             _               _                                  //
//      / ____|           (_)             | |                                 //
//     | (___   __ _ _   _ _ _ __ _ __ ___| |_   _____ _ __ ___  ___          //
//      \___ \ / _` | | | | | '__| '__/ _ \ \ \ / / _ \ '__/ __|/ _ \         //
//      ____) | (_| | |_| | | |  | | |  __/ |\ V /  __/ |  \__ \  __/         //
//     |_____/ \__, |\__,_|_|_|  |_|  \___|_|_\_/ \___|_|  |___/\___|         //
//      / ____|   | |     (_)             | | |      | |                      //
//     | (___   __|_|_   _ _ _ __ _ __ ___| | |_ ___ | | ___   __ _ _   _     //
//      \___ \ / _` | | | | | '__| '__/ _ \ | __/ _ \| |/ _ \ / _` | | | |    //
//      ____) | (_| | |_| | | |  | | |  __/ | || (_) | | (_) | (_| | |_| |    //
//     |_____/ \__, |\__,_|_|_|  |_|  \___|_|\__\___/|_|\___/ \__, |\__, |    //
//                | |                                          __/ | __/ |    //
//                |_|                                         |___/ |___/     //
//                                                                            //
//                                                                            //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////


contract SV is ERC721Creator {
    constructor() ERC721Creator("Squirrelverse", "SV") {}
}