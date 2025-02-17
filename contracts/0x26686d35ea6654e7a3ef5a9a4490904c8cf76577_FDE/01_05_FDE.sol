// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Fever Dreams Editions
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                                //
//                                                                                                                                                //
//                                                                                                                                                //
//    ___________                        ________                                        ___________    .___.__  __  .__                          //
//    \_   _____/______  __ ___________  \______ \_______   ____ _____    _____   ______ \_   _____/  __| _/|__|/  |_|__| ____   ____   ______    //
//     |    __)/ __ \  \/ // __ \_  __ \  |    |  \_  __ \_/ __ \\__  \  /     \ /  ___/  |    __)_  / __ | |  \   __\  |/  _ \ /    \ /  ___/    //
//     |     \\  ___/\   /\  ___/|  | \/  |    `   \  | \/\  ___/ / __ \|  Y Y  \\___ \   |        \/ /_/ | |  ||  | |  (  <_> )   |  \\___ \     //
//     \___  / \___  >\_/  \___  >__|    /_______  /__|    \___  >____  /__|_|  /____  > /_______  /\____ | |__||__| |__|\____/|___|  /____  >    //
//         \/      \/          \/                \/            \/     \/      \/     \/          \/      \/                         \/     \/     //
//                                                                                                                                                //
//                                                                                                                                                //
//                                                                                                                                                //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract FDE is ERC1155Creator {
    constructor() ERC1155Creator("Fever Dreams Editions", "FDE") {}
}