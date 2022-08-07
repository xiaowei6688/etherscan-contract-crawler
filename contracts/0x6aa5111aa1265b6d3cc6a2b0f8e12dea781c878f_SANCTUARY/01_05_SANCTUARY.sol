// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: // SANCTUARY //
/// @author: manifold.xyz

import "./ERC1155Creator.sol";

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                                               //
//                                                                                                                                                               //
//    ▄ ▄                                                                   ▄▄▄▄▄▄▄                                                                      ▄ ▄     //
//                                                                           ▀█████                                                                              //
//                                                                            █████                                                                              //
//                                                                            █████                                                                              //
//    ▀███████▀▀██▄▄     ▄▀▀▀▀▀▀████▀▀▀▀▀███▀▀▀▀▀▀██▄▄        ▄▄████▀▀▀▀▀▀▀▀▀██████▀▀▀▀▀▀███████▀▀███████▀▀▀▀▀▀▀▀▀████▀▀▀▀▀███▀▀▀▀▀███████▀███████▀▀███████▀     //
//     ▐█████▌   ████▄  █       ▐████▄    █       ▐████▄     █████▌           █████       █████▌   █████▌         ▐████▄    █       ▐█████ ▐█████   ▐█████       //
//      █████    █████▌ ▀        █████    █        █████    ▐█████            █████       █████▌   █████▌          █████▌   █        ▀▀▀▀▀ ▐█████   ▐█████       //
//      █████    ▐████▌          █████    █▌       █████    ▐█████            █████       █████▌   █████▌          █████▌   █▄             ▐█████   ▐█████       //
//      █████              ▄█    █████    ███      █████    ▐█████        ▄   █████       █████▌   █████▌    ▄▄    █████▌   ███            ▐████▀   ▐█████       //
//      █████            ▄███    █████    ████▄    █████    ▐█████      ▄██   █████       █████▌   ▀████▌  ▄███    █████▌   ████▄          ▐██▀     ▐█████       //
//      ▀▀▀▀▀▀▀▀▀██████ █████      ▀██    █████    █████    ▐█████    █████   █████       █████▌     ▀██▌ █████      ▀██▌   █████          ▐█       ▐█████       //
//               ██████ █████        █    █████▌   █████    ▐█████   ▐█████   █████       █████▌       █▌ █████        █▌   █████          ▐▌       ▐█████       //
//               ██████ █████        █    █████▌   █████    ▐█████   ▐█████   █████       ▐████▌       ▐▌ █████        █▌   █████           ▀▄     ▄██████       //
//      █████    ██████  █████      ▄█▌  ▄█████▌  ▄█████▌   ██████▄  ▐████▀  ▐█████▌       ▀████▄      █▌  █████      ▄█▌  ▄██████            ▀▀▀▀▀▀▀█████       //
//      █████    ██████     ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀   ▀▀▀▀▀▀▀▀▀         ▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀██████   ▐█████       //
//       ████▌   ██████                                                                                                                     █████   ▐████▌       //
//        ▀████▄███████▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄█████▄▄████▀        //
//                                                                                                                                                               //
//    ▄ ▄                                                                                                                                               ▄ ▄      //
//                                                                                                                                                               //
//                                                                                                                                                               //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract SANCTUARY is ERC1155Creator {
    constructor() ERC1155Creator() {}
}