// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Resurrected Idea
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                    //
//                                                                                                                                    //
//       ____           __      __       _____             ____                                                        _              //
//      / __ \_  ______/ /___ _/ /_     / __(_)___  ____ _/ / /_  __   ____ _________ _      __   ____ _   _________  (_)___  ___     //
//     / / / / |/_/ __  / __ `/ __ \   / /_/ / __ \/ __ `/ / / / / /  / __ `/ ___/ _ \ | /| / /  / __ `/  / ___/ __ \/ / __ \/ _ \    //
//    / /_/ />  </ /_/ / /_/ / /_/ /  / __/ / / / / /_/ / / / /_/ /  / /_/ / /  /  __/ |/ |/ /  / /_/ /  (__  ) /_/ / / / / /  __/    //
//    \____/_/|_|\__,_/\__, /_.___/  /_/ /_/_/ /_/\__,_/_/_/\__, /   \__, /_/   \___/|__/|__/   \__,_/  /____/ .___/_/_/ /_/\___/     //
//                    /____/                               /____/   /____/                                  /_/                       //
//                                                                                                                                    //
//                                                                                                                                    //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract OXDGB is ERC1155Creator {
    constructor() ERC1155Creator("Resurrected Idea", "OXDGB") {}
}