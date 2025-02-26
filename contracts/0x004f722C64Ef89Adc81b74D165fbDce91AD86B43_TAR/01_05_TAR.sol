// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: TestingARN
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////////
//                                                                            //
//                                                                            //
//                                                                            //
//    ______________________ ____________________.___ _______    ________     //
//    \__    ___/\_   _____//   _____/\__    ___/|   |\      \  /  _____/     //
//      |    |    |    __)_ \_____  \   |    |   |   |/   |   \/   \  ___     //
//      |    |    |        \/        \  |    |   |   /    |    \    \_\  \    //
//      |____|   /_______  /_______  /  |____|   |___\____|__  /\______  /    //
//                       \/        \/                        \/        \/     //
//                                                                            //
//                                                                            //
//                                                                            //
////////////////////////////////////////////////////////////////////////////////


contract TAR is ERC721Creator {
    constructor() ERC721Creator("TestingARN", "TAR") {}
}