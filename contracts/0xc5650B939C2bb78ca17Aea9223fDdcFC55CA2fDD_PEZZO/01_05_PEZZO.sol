// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: picozzo℗ pepes
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

/////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                         //
//                                                                                         //
//                                                                                         //
//                                                                                         //
//           .__                                                                           //
//    ______ |__| ____  ________________________   ______   ____ ______   ____   ______    //
//    \____ \|  |/ ___\/  _ \___   /\___   /  _ \  \____ \_/ __ \\____ \_/ __ \ /  ___/    //
//    |  |_> >  \  \__(  <_> )    /  /    (  <_> ) |  |_> >  ___/|  |_> >  ___/ \___ \     //
//    |   __/|__|\___  >____/_____ \/_____ \____/  |   __/ \___  >   __/ \___  >____  >    //
//    |__|           \/           \/      \/       |__|        \/|__|        \/     \/     //
//                                                                                         //
//                                                                                         //
//                                                                                         //
//                                                                                         //
/////////////////////////////////////////////////////////////////////////////////////////////


contract PEZZO is ERC721Creator {
    constructor() ERC721Creator(unicode"picozzo℗ pepes", "PEZZO") {}
}