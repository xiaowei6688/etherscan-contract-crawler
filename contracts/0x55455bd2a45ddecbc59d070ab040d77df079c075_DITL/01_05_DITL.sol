// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Day in the Life
/// @author: manifold.xyz

import "./ERC721Creator.sol";

////////////////////////////////////////////////////////
//                                                    //
//                                                    //
//     _______     ______      __       _______       //
//    |   _  "\   /    " \    /""\     |   _  "\      //
//    (. |_)  :) // ____  \  /    \    (. |_)  :)     //
//    |:     \/ /  /    ) :)/' /\  \   |:     \/      //
//    (|  _  \\(: (____/ ////  __'  \  (|  _  \\      //
//    |: |_)  :)\        //   /  \\  \ |: |_)  :)     //
//    (_______/  \"_____/(___/    \___)(_______/      //
//                                                    //
//                                                    //
////////////////////////////////////////////////////////


contract DITL is ERC721Creator {
    constructor() ERC721Creator("Day in the Life", "DITL") {}
}