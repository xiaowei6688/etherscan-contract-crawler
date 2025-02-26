// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Take A Seat
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                                                                          //
//                                                                                                                                                                                          //
//                                                                                                                                                                                          //
//                                                                       _____                                                            _____                                             //
//      ________    ________      _____         ______   _______    _____\    \            _____                           _____     _____\    \     _____       ________    ________       //
//     /        \  /        \   /      |_      |\     \  \      \  /    / |    |         /      |_                    _____\    \   /    / |    |  /      |_    /        \  /        \      //
//    |\         \/         /| /         \      \\     \  |     /|/    /  /___/|        /         \                  /    / \    | /    /  /___/| /         \  |\         \/         /|     //
//    | \            /\____/ ||     /\    \      \|     |/     //|    |__ |___|/       |     /\    \                |    |  /___/||    |__ |___|/|     /\    \ | \            /\____/ |     //
//    |  \______/\   \     | ||    |  |    \      |     |_____// |       \             |    |  |    \            ____\    \ |   |||       \      |    |  |    \|  \______/\   \     | |     //
//     \ |      | \   \____|/ |     \/      \     |     |\     \ |     __/ __          |     \/      \          /    /\    \|___|/|     __/ __   |     \/      \\ |      | \   \____|/      //
//      \|______|  \   \      |\      /\     \   /     /|\|     ||\    \  /  \         |\      /\     \        |    |/ \    \     |\    \  /  \  |\      /\     \\|______|  \   \           //
//               \  \___\     | \_____\ \_____\ /_____/ |/_____/|| \____\/    |        | \_____\ \_____\       |\____\ /____/|    | \____\/    | | \_____\ \_____\        \  \___\          //
//                \ |   |     | |     | |     ||     | / |    | || |    |____/|        | |     | |     |       | |   ||    | |    | |    |____/| | |     | |     |         \ |   |          //
//                 \|___|      \|_____|\|_____||_____|/  |____|/  \|____|   | |         \|_____|\|_____|        \|___||____|/      \|____|   | |  \|_____|\|_____|          \|___|          //
//                                                                      |___|/                                                           |___|/                                             //
//                                                                                                                                                                                          //
//                                                                                                                                                                                          //
//                                                                                                                                                                                          //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract TAS is ERC1155Creator {
    constructor() ERC1155Creator("Take A Seat", "TAS") {}
}