// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Gamaccho Voxel Lab
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                                                                  //
//                                                                                                                                                                                  //
//                                                                                                                                                                                  //
//     $$$$$$\                                                        $$\                       $$\    $$\                               $$\       $$\                $$\           //
//    $$  __$$\                                                       $$ |                      $$ |   $$ |                              $$ |      $$ |               $$ |          //
//    $$ /  \__| $$$$$$\  $$$$$$\$$$$\   $$$$$$\   $$$$$$$\  $$$$$$$\ $$$$$$$\   $$$$$$\        $$ |   $$ | $$$$$$\  $$\   $$\  $$$$$$\  $$ |      $$ |      $$$$$$\  $$$$$$$\      //
//    $$ |$$$$\  \____$$\ $$  _$$  _$$\  \____$$\ $$  _____|$$  _____|$$  __$$\ $$  __$$\       \$$\  $$  |$$  __$$\ \$$\ $$  |$$  __$$\ $$ |      $$ |      \____$$\ $$  __$$\     //
//    $$ |\_$$ | $$$$$$$ |$$ / $$ / $$ | $$$$$$$ |$$ /      $$ /      $$ |  $$ |$$ /  $$ |       \$$\$$  / $$ /  $$ | \$$$$  / $$$$$$$$ |$$ |      $$ |      $$$$$$$ |$$ |  $$ |    //
//    $$ |  $$ |$$  __$$ |$$ | $$ | $$ |$$  __$$ |$$ |      $$ |      $$ |  $$ |$$ |  $$ |        \$$$  /  $$ |  $$ | $$  $$<  $$   ____|$$ |      $$ |     $$  __$$ |$$ |  $$ |    //
//    \$$$$$$  |\$$$$$$$ |$$ | $$ | $$ |\$$$$$$$ |\$$$$$$$\ \$$$$$$$\ $$ |  $$ |\$$$$$$  |         \$  /   \$$$$$$  |$$  /\$$\ \$$$$$$$\ $$ |      $$$$$$$$\\$$$$$$$ |$$$$$$$  |    //
//     \______/  \_______|\__| \__| \__| \_______| \_______| \_______|\__|  \__| \______/           \_/     \______/ \__/  \__| \_______|\__|      \________|\_______|\_______/     //
//                                                                                                                                                                                  //
//                                                                                                                                                                                  //
//                                                                                                                                                                                  //
//                                                                                                                                                                                  //
//                                                                                                                                                                                  //
//                                                                                                                                                                                  //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract GVL is ERC1155Creator {
    constructor() ERC1155Creator("Gamaccho Voxel Lab", "GVL") {}
}