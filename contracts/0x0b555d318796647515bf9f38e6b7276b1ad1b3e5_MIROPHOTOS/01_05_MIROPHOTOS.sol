// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Miro Photography
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

///////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                           //
//                                                                                           //
//                                                                                           //
//    ___  ____            ______ _           _                              _               //
//    |  \/  (_)           | ___ \ |         | |                            | |              //
//    | .  . |_ _ __ ___   | |_/ / |__   ___ | |_ ___   __ _ _ __ __ _ _ __ | |__  _   _     //
//    | |\/| | | '__/ _ \  |  __/| '_ \ / _ \| __/ _ \ / _` | '__/ _` | '_ \| '_ \| | | |    //
//    | |  | | | | | (_) | | |   | | | | (_) | || (_) | (_| | | | (_| | |_) | | | | |_| |    //
//    \_|  |_/_|_|  \___/  \_|   |_| |_|\___/ \__\___/ \__, |_|  \__,_| .__/|_| |_|\__, |    //
//                                                      __/ |         | |           __/ |    //
//                                                     |___/          |_|          |___/     //
//                                                                                           //
//                                                                                           //
//                                                                                           //
//                                                                                           //
//                                                                                           //
///////////////////////////////////////////////////////////////////////////////////////////////


contract MIROPHOTOS is ERC1155Creator {
    constructor() ERC1155Creator("Miro Photography", "MIROPHOTOS") {}
}