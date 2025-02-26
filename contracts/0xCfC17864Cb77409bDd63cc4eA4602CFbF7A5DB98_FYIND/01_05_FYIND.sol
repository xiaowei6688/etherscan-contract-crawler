// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Free Your Mind
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                                                                                                                      //
//                                                                                                                                                                                                                                      //
//                                                                                                                                                                                                                                      //
//    //                                  #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@,                                                                                                                           //    //
//    //                                  #@                                                        *@,                                                                                                                           //    //
//    //                                  #@     @@@  @@@@@@@# @@@  @@@@@@@&  @@@@@@@@  @@@@  /@@   *@,                                                                                                                           //    //
//    //                                  #@     @@@  @@%      @@@  @@%  /@@ *@@*  #@@  @@@@@ /@@   *@,                                                                                                                           //    //
//    //                                  #@     @@@  @@%      @@@  @@@@     *@@*  #@@  @@@@@//@@   *@,                                                                                                                           //    //
//    //                                  #@     @@@  @@@@@@(  @@@    &@@@*  *@@*  #@@  @@@ @@/@@   ,@,                                                                                                                           //    //
//    //                                  #@     @@@  @@%      @@@      [email protected]@@ *@@*  #@@  @@@ (@@@@   *@,                                                                                                                           //    //
//    //                                  #@     @@@  @@%      @@@  @@/  @@@ *@@*  %@@  @@@  @@@@   *@,                                                                                                                           //    //
//    //                                  #@  %@@@@   @@@@@@@# @@@  ,@@@@@@*  #@@@@@@.  @@@   @@@   *@,                                                                                                                           //    //
//    //                                  #@                                                        *@,                                                                                                                           //    //
//    //                                  #@   @@@@@@@@    #@@@@    @@@@@@@@  (@@@@@@@&    @@@@#    *@,                                                                                                                           //    //
//    //                                  #@   @@@   @@@   @@#@@%   @@@   @@% (@@.  @@@   %@@@@@    *@,                                                                                                                           //    //
//    //                                  #@   @@@  (@@.  ,@@ @@@   @@@   @@( (@@.  @@&   @@#,@@.   *@,                                                                                                                           //    //
//    //                                  #@   @@@@@@@@   @@@ [email protected]@*  @@@@@@@   (@@@@@@@*  ,@@  @@@   ,@,                                                                                                                           //    //
//    //                                  #@   @@@   @@@  @@,  @@@  @@@   @@# (@@.  %@@  @@@  &@@   *@,                                                                                                                           //    //
//    //                                  #@   @@@   @@@ (@@@@@@@@  @@@   @@% (@@.  %@@  @@@@@@@@&  *@,                                                                                                                           //    //
//    //                                  #@   @@@@@@@@  @@@    @@& @@@   @@@ (@@@@@@@, #@@    @@@  *@,                                                                                                                           //    //
//    //                                  #@                                                        *@,                                                                                                                           //    //
//    //                                  #@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@,                                                                                                                                 //
//                                                                                                                                                                                                                                      //
//                                                                                                                                                                                                                                      //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract FYIND is ERC1155Creator {
    constructor() ERC1155Creator("Free Your Mind", "FYIND") {}
}