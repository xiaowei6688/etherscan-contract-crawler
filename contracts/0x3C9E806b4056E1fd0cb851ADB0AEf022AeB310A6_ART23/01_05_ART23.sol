// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: History of Art Twitter
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                                                                                              //
//                                                                                                                                                                                                              //
//    ### ###   ######   #####   ########  #####   ######   ##   ##            #####   #######           ######   ######   ########          ######## ##   ##   ######  ######## ######## #######  ######       //
//     ## ##      ##    ##   ##  ## ## ## ### ###   ##  ##  ##   ##           ### ###   ##  ##            ## ###   ##  ##  ## ## ##          ## ## ## ##   ##     ##    ## ## ## ## ## ##  ##  ##   ##  ##      //
//     ## ##      ##    ##          ##    ##   ##   ##  ##  ##   ##           ##   ##   ##                ##  ##   ##  ##     ##                ##    ##   ##     ##       ##       ##     ##       ##  ##      //
//     #####      ##     #####      ##    ##   ##   #####    ######           ##   ##   ####              ######   #####      ##                ##    ##   ##     ##       ##       ##     ####     #####       //
//     #  ##      ##         ##     ##    ##   ##   ##  ##       ##           ##   ##   ##                ##  ##   ##  ##     ##                ##    ## # ##     ##       ##       ##     ##       ##  ##      //
//     ## ##      ##    ##   ##     ##    ### ###   ##  ##  ##   ##           ### ###   ##                ##  ##   ##  ##     ##                ##    #######     ##       ##       ##     ##  ##   ##  ##      //
//    ### ###   ######   #####     ####    #####   #### ###  #####             #####   ####              ###  ##  #### ###   ####              ####   ##   ##   ######    ####     ####   #######  #### ###     //
//                                                                                                                                                                                                              //
//    ##   ##  ######   ### ###           ### ###  ##   ##  ###       #####   ### ###   ######  ###  ##   #####   ### ###  ##   ##            ####     # ###    ####     #####                                  //
//    #######   ## ###   ## ##             ## ##    #   ##   ##      ##   ##   ## ##      ##     ### ##  ##   ##   ## ##   ##   ##           ##  ##   ##  ###  ##  ##   ##   ##                                 //
//    ## # ##   ##  ##   ## ##             ## ##   ##   ##   ##      ##   ##   ## ##      ##     ######  ##        ## ##   ##   ##              ##    ##  ###     ##         ##                                 //
//    ##   ##   ######    ###              ####    ##   ##   ##      ##        #####      ##     ## ###   #####    ####     ######             ##     ## # ##    ##         ##                                  //
//    ##   ##   ##  ##   ## ##             ## ##   ##   ##   ##      ##   ##   #  ##      ##     ##  ##       ##   ## ##        ##            ##      ###  ##   ##           ##                                 //
//    ##   ##   ##  ##   ## ##             ## ##   ### ###   ##  ##  ##   ##   ## ##      ##     ##  ##  ##   ##   ## ##   ##   ##           ##  ##   ###  ##  ##  ##   ##   ##                                 //
//    ##   ##  ###  ##  ### ###           ### ###   #####   #######   #####   ### ###   ######  ###  ##   #####   ### ###   #####            ######    #####   ######    #####                                  //
//                                                                                                                                                                                                              //
//                                                                                                                                                                                                              //
//                                                                                                                                                                                                              //
//                                                                                                                                                                                                              //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract ART23 is ERC1155Creator {
    constructor() ERC1155Creator("History of Art Twitter", "ART23") {}
}