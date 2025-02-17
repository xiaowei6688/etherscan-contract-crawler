// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Danny Ives - things we do.
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

//////////////////////////////////////////////////////////////////////////////////
//                                                                              //
//                                                                              //
//                                                                              //
//      __  .__    .__                                            .___          //
//    _/  |_|  |__ |__| ____    ____  ______ __  _  __ ____     __| _/____      //
//    \   __\  |  \|  |/    \  / ___\/  ___/ \ \/ \/ // __ \   / __ |/  _ \     //
//     |  | |   Y  \  |   |  \/ /_/  >___ \   \     /\  ___/  / /_/ (  <_> )    //
//     |__| |___|  /__|___|  /\___  /____  >   \/\_/  \___  > \____ |\____/     //
//               \/        \//_____/     \/               \/       \/           //
//                                                                              //
//                                                                              //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////


contract twedo is ERC721Creator {
    constructor() ERC721Creator("Danny Ives - things we do.", "twedo") {}
}