// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Roo's Editions
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

//////////////////////////////////////////////
//                                          //
//                                          //
//     *******     *******     *******      //
//    /**////**   **/////**   **/////**     //
//    /**   /**  **     //** **     //**    //
//    /*******  /**      /**/**      /**    //
//    /**///**  /**      /**/**      /**    //
//    /**  //** //**     ** //**     **     //
//    /**   //** //*******   //*******      //
//    //     //   ///////     ///////       //
//                                          //
//                                          //
//                                          //
//                                          //
//                                          //
//                                          //
//                                          //
//                                          //
//                                          //
//                                          //
//////////////////////////////////////////////


contract ROO is ERC1155Creator {
    constructor() ERC1155Creator("Roo's Editions", "ROO") {}
}