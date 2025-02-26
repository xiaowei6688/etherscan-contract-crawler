// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Whatcha Say?!!
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                        //
//                                                                                        //
//                                                                                        //
//                             @@                    @@                                   //
//                            @@@@@@               @@@ @@@                                //
//                           @@@@@@@@@         @   @@@@@@@@@@                             //
//                          @@@@@  @@@@   %      @  *@@@ @  @@                            //
//                          @@@ @@@** **                 ([email protected]@@                            //
//                           @@@@**                         .                             //
//                             @*                             @                           //
//                            **     ******             *@@                               //
//                          @*    *@@@@@@@@*          *@@@@@@                             //
//                          **    @@@     @@@        *@@ @@@@@                            //
//                         @*.  *@@@@@@@@@  @@    * *@@     @@    @                       //
//                         **  ** @@@@     @@@*@ **@@@@@@   @   @ @                       //
//                         */     @@@ @@@@@@@ @***   @@@@@@*   *  @                       //
//                         @****    %@@   @@@@@**@@@@ @@@@                                //
//                          @**          @@@@&@   *    @@*       @                        //
//                           @**           **@*   @     @*                                //
//                             @**          *@  *(**  &  @*   @                           //
//                                @@*      *@*           @ @                              //
//                                       @@@@***@@@@@@                                    //
//                                                                                        //
//                                                                                        //
//                                                                                        //
////////////////////////////////////////////////////////////////////////////////////////////


contract ws is ERC721Creator {
    constructor() ERC721Creator("Whatcha Say?!!", "ws") {}
}