// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Knockout by Marco $olo
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                                                                                           //
//                                                                                                                                                                                                           //
//     ____  __._______   ________  _________  ____  __.________   ____ ______________ _______________.___.    _____      _____ ___________________  ________      ____/\__________  .____    ________       //
//    |    |/ _|\      \  \_____  \ \_   ___ \|    |/ _|\_____  \ |    |   \__    ___/ \______   \__  |   |   /     \    /  _  \\______   \_   ___ \ \_____  \    /   / /_/\_____  \ |    |   \_____  \      //
//    |      <  /   |   \  /   |   \/    \  \/|      <   /   |   \|    |   / |    |     |    |  _//   |   |  /  \ /  \  /  /_\  \|       _/    \  \/  /   |   \   \__/ / \  /   |   \|    |    /   |   \     //
//    |    |  \/    |    \/    |    \     \___|    |  \ /    |    \    |  /  |    |     |    |   \\____   | /    Y    \/    |    \    |   \     \____/    |    \  / / /   \/    |    \    |___/    |    \    //
//    |____|__ \____|__  /\_______  /\______  /____|__ \\_______  /______/   |____|     |______  // ______| \____|__  /\____|__  /____|_  /\______  /\_______  / /_/ /__  /\_______  /_______ \_______  /    //
//            \/       \/         \/        \/        \/        \/                             \/ \/                \/         \/       \/        \/         \/    \/   \/         \/        \/       \/     //
//                                                                                                                                                                                                           //
//                                                                                                                                                                                                           //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract KNKOUT is ERC1155Creator {
    constructor() ERC1155Creator("Knockout by Marco $olo", "KNKOUT") {}
}