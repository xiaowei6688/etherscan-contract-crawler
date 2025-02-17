// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: PikachuJLB
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

///////////////////////////////////////////////////////////////////////////////////////
//                                                                                   //
//                                                                                   //
//    __________.__ __                  .__               ____.____   __________     //
//    \______   \__|  | _______    ____ |  |__  __ __    |    |    |  \______   \    //
//     |     ___/  |  |/ /\__  \ _/ ___\|  |  \|  |  \   |    |    |   |    |  _/    //
//     |    |   |  |    <  / __ \\  \___|   Y  \  |  /\__|    |    |___|    |   \    //
//     |____|   |__|__|_ \(____  /\___  >___|  /____/\________|_______ \______  /    //
//                      \/     \/     \/     \/                       \/      \/     //
//                                                                                   //
//                                                                                   //
//                                                                                   //
///////////////////////////////////////////////////////////////////////////////////////


contract PJLB is ERC721Creator {
    constructor() ERC721Creator("PikachuJLB", "PJLB") {}
}