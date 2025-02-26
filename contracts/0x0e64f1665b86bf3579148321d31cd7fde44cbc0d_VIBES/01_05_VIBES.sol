// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Vibes & Times
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                           //
//                                                                                                                           //
//                                                                                                                           //
//    $$\    $$\ $$\ $$\                                  $$$\           $$$$$$$$\ $$\                                       //
//    $$ |   $$ |\__|$$ |                                $$ $$\          \__$$  __|\__|                                      //
//    $$ |   $$ |$$\ $$$$$$$\   $$$$$$\   $$$$$$$\       \$$$\ |            $$ |   $$\ $$$$$$\$$$$\   $$$$$$\   $$$$$$$\     //
//    \$$\  $$  |$$ |$$  __$$\ $$  __$$\ $$  _____|      $$\$$\$$\          $$ |   $$ |$$  _$$  _$$\ $$  __$$\ $$  _____|    //
//     \$$\$$  / $$ |$$ |  $$ |$$$$$$$$ |\$$$$$$\        $$ \$$ __|         $$ |   $$ |$$ / $$ / $$ |$$$$$$$$ |\$$$$$$\      //
//      \$$$  /  $$ |$$ |  $$ |$$   ____| \____$$\       $$ |\$$\           $$ |   $$ |$$ | $$ | $$ |$$   ____| \____$$\     //
//       \$  /   $$ |$$$$$$$  |\$$$$$$$\ $$$$$$$  |       $$$$ $$\          $$ |   $$ |$$ | $$ | $$ |\$$$$$$$\ $$$$$$$  |    //
//        \_/    \__|\_______/  \_______|\_______/        \____\__|         \__|   \__|\__| \__| \__| \_______|\_______/     //
//                                                                                                                           //
//                                                                                                                           //
//                                                                                                                           //
//                                                                                                                           //
//                                                                                                                           //
//                                                                                                                           //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract VIBES is ERC1155Creator {
    constructor() ERC1155Creator("Vibes & Times", "VIBES") {}
}