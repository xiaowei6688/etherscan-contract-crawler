// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Toks
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                    //
//                                                                                                    //
//                                                                                                    //
//     _____  ____  _  __ ____            ____    _      _____ _      _____   _     _  _____ _____    //
//    /__ __\/  _ \/ |/ // ___\          /  _ \  / \__/|/  __// \__/|/  __/  / \   / \/    //  __/    //
//      / \  | / \||   / |    \  _____   | / \|  | |\/|||  \  | |\/|||  \    | |   | ||  __\|  \      //
//      | |  | \_/||   \ \___ |  \____\  | |-||  | |  |||  /_ | |  |||  /_   | |_/\| || |   |  /_     //
//      \_/  \____/\_|\_\\____/          \_/ \|  \_/  \|\____\\_/  \|\____\  \____/\_/\_/   \____\    //
//                                                                                                    //
//                                                                                                    //
//                                                                                                    //
//                                                                                                    //
////////////////////////////////////////////////////////////////////////////////////////////////////////


contract Toks is ERC721Creator {
    constructor() ERC721Creator("Toks", "Toks") {}
}