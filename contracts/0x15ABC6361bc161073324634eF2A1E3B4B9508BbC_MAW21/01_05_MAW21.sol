// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Memo Akten - Waves 2.0: Mountains, fragment #001
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

///////////////////////////////////////////////////////////////////////////////////////////
//                                                                                       //
//                                                                                       //
//                                                                                       //
//                                                                                       //
//     ___      ___   _______  ___      ___     ______     ___________  ___      ___     //
//    |"  \    /"  | /"     "||"  \    /"  |   /    " \   ("     _   ")|"  \    /"  |    //
//     \   \  //   |(: ______) \   \  //   |  // ____  \   )__/  \\__/  \   \  //  /     //
//     /\\  \/.    | \/    |   /\\  \/.    | /  /    ) :)     \\_ /      \\  \/. ./      //
//    |: \.        | // ___)_ |: \.        |(: (____/ //_____ |.  |       \.    //       //
//    |.  \    /:  |(:      "||.  \    /:  | \        /))_  ")\:  |        \\   /        //
//    |___|\__/|___| \_______)|___|\__/|___|  \"_____/(_____(  \__|         \__/         //
//                                                                                       //
//                                                                                       //
//                                                                                       //
//                                                                                       //
//                                                                                       //
///////////////////////////////////////////////////////////////////////////////////////////


contract MAW21 is ERC721Creator {
    constructor() ERC721Creator("Memo Akten - Waves 2.0: Mountains, fragment #001", "MAW21") {}
}