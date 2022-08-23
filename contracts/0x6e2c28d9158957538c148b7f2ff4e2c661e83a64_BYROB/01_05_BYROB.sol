// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: DRONE ART BYROB
/// @author: manifold.xyz

import "./ERC721Creator.sol";

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                 //
//                                                                                                                 //
//      __                                                    __        __                           __            //
//     /\ \                                                  /\ \__    /\ \                         /\ \           //
//     \_\ \  _ __   ___     ___      __          __     _ __\ \ ,_\   \ \ \____  __  __  _ __   ___\ \ \____      //
//     /'_` \/\`'__\/ __`\ /' _ `\  /'__`\      /'__`\  /\`'__\ \ \/    \ \ '__`\/\ \/\ \/\`'__\/ __`\ \ '__`\     //
//    /\ \L\ \ \ \//\ \L\ \/\ \/\ \/\  __/     /\ \L\.\_\ \ \/ \ \ \_    \ \ \L\ \ \ \_\ \ \ \//\ \L\ \ \ \L\ \    //
//    \ \___,_\ \_\\ \____/\ \_\ \_\ \____\    \ \__/.\_\\ \_\  \ \__\    \ \_,__/\/`____ \ \_\\ \____/\ \_,__/    //
//     \/__,_ /\/_/ \/___/  \/_/\/_/\/____/     \/__/\/_/ \/_/   \/__/     \/___/  `/___/> \/_/ \/___/  \/___/     //
//                                                                                    /\___/                       //
//                                                                                    \/__/                        //
//                                                                                                                 //
//                                                                                                                 //
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract BYROB is ERC721Creator {
    constructor() ERC721Creator("DRONE ART BYROB", "BYROB") {}
}