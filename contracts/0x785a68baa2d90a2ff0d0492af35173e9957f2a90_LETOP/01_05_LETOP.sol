// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Le Top
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

//////////////////////////////////////////////////////////////
//                                                          //
//                                                          //
//    $$\                   $$\                             //
//    $$ |                  $$ |                            //
//    $$ | $$$$$$\        $$$$$$\    $$$$$$\   $$$$$$\      //
//    $$ |$$  __$$\       \_$$  _|  $$  __$$\ $$  __$$\     //
//    $$ |$$$$$$$$ |        $$ |    $$ /  $$ |$$ /  $$ |    //
//    $$ |$$   ____|        $$ |$$\ $$ |  $$ |$$ |  $$ |    //
//    $$ |\$$$$$$$\         \$$$$  |\$$$$$$  |$$$$$$$  |    //
//    \__| \_______|         \____/  \______/ $$  ____/     //
//                                            $$ |          //
//                                            $$ |          //
//                                            \__|          //
//                                                          //
//                                                          //
//////////////////////////////////////////////////////////////


contract LETOP is ERC1155Creator {
    constructor() ERC1155Creator("Le Top", "LETOP") {}
}