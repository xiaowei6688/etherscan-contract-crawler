// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Moon Man Sir
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

/////////////////////////////////////////////////////////////////////////////
//                                                                         //
//                                                                         //
//                                                                         //
//     __  __ ____ ____ __  _     __  __  ____  __  _      ____ ______     //
//    |  \/  / () / () |  \| |   |  \/  |/ () \|  \| |    (_ (_| | () )    //
//    |_|\/|_\____\____|_|\__|   |_|\/|_/__/\__|_|\__|   .__)__|_|_|\_\    //
//                                                                         //
//                                                                         //
//                                                                         //
/////////////////////////////////////////////////////////////////////////////


contract MMS is ERC1155Creator {
    constructor() ERC1155Creator("Moon Man Sir", "MMS") {}
}