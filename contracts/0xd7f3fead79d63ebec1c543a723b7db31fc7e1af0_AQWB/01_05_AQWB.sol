// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: A Quiet World - Bidders Editions
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

///////////////////////////////////////////////////////////////////////////////////////////
//                                                                                       //
//                                                                                       //
//     ,-----.           ,--.         ,--.      ,--.   ,--.              ,--.   ,--.     //
//    '  .-.  '  ,--.,--.`--' ,---. ,-'  '-.    |  |   |  | ,---. ,--.--.|  | ,-|  |     //
//    |  | |  |  |  ||  |,--.| .-. :'-.  .-'    |  |.'.|  || .-. ||  .--'|  |' .-. |     //
//    '  '-'  '-.'  ''  '|  |\   --.  |  |      |   ,'.   |' '-' '|  |   |  |\ `-' |     //
//     `-----'--' `----' `--' `----'  `--'      '--'   '--' `---' `--'   `--' `---'      //
//    ,-----.  ,--.   ,--.   ,--.                                                        //
//    |  |) /_ `--' ,-|  | ,-|  | ,---. ,--.--. ,---.                                    //
//    |  .-.  \,--.' .-. |' .-. || .-. :|  .--'(  .-'                                    //
//    |  '--' /|  |\ `-' |\ `-' |\   --.|  |   .-'  `)                                   //
//    `------' `--' `---'  `---'  `----'`--'   `----'                                    //
//    ,------.   ,--.,--.  ,--.  ,--.                                                    //
//    |  .---' ,-|  |`--',-'  '-.`--' ,---. ,--,--,  ,---.                               //
//    |  `--, ' .-. |,--.'-.  .-',--.| .-. ||      \(  .-'                               //
//    |  `---.\ `-' ||  |  |  |  |  |' '-' '|  ||  |.-'  `)                              //
//    `------' `---' `--'  `--'  `--' `---' `--''--'`----'                               //
//                                                                                       //
//                                                                                       //
//                                                                                       //
///////////////////////////////////////////////////////////////////////////////////////////


contract AQWB is ERC1155Creator {
    constructor() ERC1155Creator("A Quiet World - Bidders Editions", "AQWB") {}
}