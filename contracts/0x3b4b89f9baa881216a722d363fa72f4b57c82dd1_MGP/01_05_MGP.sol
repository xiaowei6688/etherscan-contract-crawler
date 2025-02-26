// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: MetaGlades
/// @author: manifold.xyz

import "./ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                        //
//                                                                                        //
//    ▓▓▓▓▓▓███████▓▓▓▓▓▓▓▓▓████████▓▓▓▓▓██████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█▓█▓▓██▓▓███▓▓▓▓▓▓▓▓▓▓▓▓    //
//                                                                                        //
//    ▓▓████▓▓███████████▓▓▓▓▓▓▓▓▓▓▓▓▓█████████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓    //
//                                                                                        //
//    ▓██▓▓╫██▌▓█╣▓▓▓██╣▓▓████████▓▓███████████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓    //
//                                                                                        //
//    ███▓▓███▓█▓▓█████▓▓▓▓▓▓██████████▓▓▓▓███▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓    //
//                                                                                        //
//    ▓██▓██▓▓█▓████████████▓▓▓▓▓█▓▓▓█╣▓▓█████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓    //
//                                                                                        //
//    ▓████▓███▓▓▓▓▓▓▓▓▓▓▓╢▓██████▓▓█▓▓█▓█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓    //
//                                                                                        //
//    ▓▓▓▓▓███▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█▓▓█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓╣▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓    //
//                                                                                        //
//    ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓╣▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓    //
//                                                                                        //
//    ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓    //
//                                                                                        //
//    ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓    //
//                                                                                        //
//    ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓╣▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█▓▓▓▓▓▓▓▓▓▓▓█▓████▓▓█▓▓▓▓▓▓▓▓█▓▓▓▓▓▓▓▓▓    //
//                                                                                        //
//    ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓████████████▓█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓    //
//                                                                                        //
//    ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█▓╣╢▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██████▓██████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓    //
//                                                                                        //
//    ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█▓▓▓╢╣▓▓▓▓▓▓▓▓▓▓██████████████▓▓████████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓    //
//                                                                                        //
//    ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓███▓▓▓▓██▓▓▓▓██████████▓▓██▓▓▓▓▓▓▓▓▓▓╣▓▓▓▓▓▓    //
//                                                                                        //
//    ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓╣▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█▓▓▓▓▓▓▓▓▓▓▓██████████████╣▓▓▓▓▓▓▓▓▓▓╢▓▓▓▓▓▓    //
//                                                                                        //
//    ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█▓╢▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██████████████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓    //
//                                                                                        //
//    ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓███▓▓████████████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓    //
//                                                                                        //
//    ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓███████████████▓▓▓▓▓▓▓▓▓▓▓▓╣▓▓▓▓▓▓    //
//                                                                                        //
//    ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██▓▓▓▓▓▓█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██▓███████▓█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓    //
//                                                                                        //
//    ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█████▓▓█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓████████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓    //
//                                                                                        //
//    █╣▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█████▓▓▓█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓███████▓▓▓▓▓▓▓▓▓▓▓▓█▓▓▓▓▓▓▓▓    //
//                                                                                        //
//    ██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█████▓▓▓▓▓▓▓▓▓▓▓▓████▓████▓    //
//                                                                                        //
//    ██╢▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓███▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓████████████▓▓▓▓▓▓▓▓▓█████▓█████╣    //
//                                                                                        //
//    █▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█████▓▓▓▓▓▓▓▓▓▓▓▓█▓▓▓▓▓▓▓▓▓█████████████▓▓▓▓▓▓▓▓▓████▓███████▓    //
//                                                                                        //
//    ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██▓▓█▓▓▓████████▓▓▓▓▓▓█▓███▓▓█████▓██╣    //
//                                                                                        //
//    ▓▓▓▓▓▓▓▓▓▓▓▓█▓▓▓▓▓██▓▓▓▓▓███▓█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓███▓▓▓▓▓▓▓███▓▓▓▓███▓▓█▓▓    //
//                                                                                        //
//    ▓▓▓▓▓▓▓▓▓▓▓█▓▓▓▓▓▓██▓▓▓█▓████▓▓▓█▓▓▓▓▓▓▓▓▓▓▓▓█████▓▓▓▓▓▓▓▓▓╣▓▓▓█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓    //
//                                                                                        //
//    ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██▓█████████▓▓▓▓▓▓▓▓████████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓    //
//                                                                                        //
//    ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓████▓▓▓▓▓▓▓▓▓█████████████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓    //
//                                                                                        //
//    ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█▓▓█▓▓▓▓██▓▓▓▓▓█▓▓█▓▓████████████▓▓▓█▓▓▓╣╢▓▓▓██▓█▓▓█▓▓█▓█▓▓▓▓▓    //
//                                                                                        //
//    ▓▓▓▓▓▓▓▓▓▓▓▓███████▓▓▓▓█▓█████▓▓▓▓▓████████▓█████▓█▓▓▓▓▓▓▓▓███▓▓▓▓█████▓▓██████▓    //
//                                                                                        //
//    ▓▓▓▓▓▓▓▓███████████▓█▓▓▓▓▓▓▓▓█▓▓▓▓▓▓███████████████▓▓▓▓▓▓▓▓██▓▓█████████████████    //
//                                                                                        //
//    █▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█▓▓▓▓▓▓▓█▓█████████▓▓▓▓▓▓▓▓▓▓▓▓██████████████████▓    //
//                                                                                        //
//    █████████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██████████████▓▓████████▓█▓███████████    //
//                                                                                        //
//    ██████▓▓▓▓▓▓▓██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█▓▓██▓▓████▓▓▓▓▓▓████████▓█▓████▓▓████████████    //
//                                                                                        //
//    █████████████████████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█▓▓▓██▓▓▓▓▓▓▓█████████▓▓▓▓▓▓██▓████████████    //
//                                                                                        //
//    ██████████▓▓████████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██▓▓▓▓█████████████▓▓▓▓▓▓▓▓█████████████    //
//                                                                                        //
//    █████▓▓▓▓▓▓▓▓▓▓█████▓▓▓▓▓▓▓▓▓▓▓▓▓███▓▓███▓██▓██████████████▓▓▓██████████████████    //
//                                                                                        //
//    ████▓▓▓▓▓▓▓▓▓▓██████▓▓▓▓▓▓▓▓██▓███▓▓▓███████████████████████████████████████████    //
//                                                                                        //
//    ██▓▓▓▓▓▓▓▓▓▓▓███████▓▓▓██▓▓▓█▓████████▓▓▓▓██████████████████████████████████████    //
//                                                                                        //
//    ███▓█████████████████▓████▓▓██▓▓██▓███████████████████▓██▓██████████████████████    //
//                                                                                        //
//    ████████████████████████████▓▓▓▓███████████████████▓▓▓▓▓██▓▓▓█▓▓▓▓▓▓████████████    //
//                                                                                        //
//    █████████████████████████████████████████████████▓▓█████▓██▓█▓█████▓▓███████████    //
//                                                                                        //
//    ████████▓▓█▓▓█▓▓▓█████████████████████████████████▓█▓▓▓▓▓▓▓█▓▓▓▓▓███████████████    //
//                                                                                        //
//    ████▓▓███▓██████████▓▓▓█▓▓███████████████████████▓▓███▓█████████████████████████    //
//                                                                                        //
//    ██████▓▓███▓▓▓▓▓▓▓██▓███▓▓▓█▓███▓▓████████████████▓▓██▓▓█▓▓▓▓███████████████████    //
//                                                                                        //
//    ███████▓█▓███████████▓███████████▓▓████████████████▓▓▓▓▓▓▓██████████████████████    //
//                                                                                        //
//    ███████▓▓██▓▓▓▓▓▓▓█▓▓█▓▓▓▓▓███████████████████████████▓████▓▓▓▓▓▓███████████████    //
//                                                                                        //
//    ███████▓▓▓█████████████████████████████████████████▓▓▓█▓▓▓██████████████████████    //
//                                                                                        //
//    █████████████████▓████████████████████████████████▓▓█▓▓████▓▓██▓████████████████    //
//                                                                                        //
//    ▓▓▓██████▓▓█▓▓▓▓▓▓▓▓▓▓▓██████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█▓▓▓▓▓▓▓▓▓▓▓██▓██▓▓███████████▓▓▓    //
//                                                                                        //
//                                                                                        //
////////////////////////////////////////////////////////////////////////////////////////////


contract MGP is ERC721Creator {
    constructor() ERC721Creator("MetaGlades", "MGP") {}
}