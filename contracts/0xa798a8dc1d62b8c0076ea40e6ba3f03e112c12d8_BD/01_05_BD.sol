// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: B1rd Droppings
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

/////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                         //
//                                                                                         //
//                                                                                         //
//                                             @@@@@                                       //
//                                         @@     @#                                       //
//                                       @         @@                                      //
//                                     @             @                                     //
//                                   &@        (     @                                     //
//                                   @                  @@                                 //
//                                &@@@@                    @%                              //
//                              @         @                 @                              //
//                             @    %@@@       @#  [email protected]@   @  @                              //
//                             @@     @@    @       @@.   @ @@@                            //
//                          @&      @@    @     @   @@     &    @                          //
//                        @@       @@  @@  *     @  @@@@    &     @                        //
//                        @      @  @@@@   @  @@  @ @@@@#, @      @                        //
//                         @             ,          @    @&@@@@@@%@@@                      //
//                       @@%(                         (@              @@                   //
//                     @       @                       @                @                  //
//                   #@            @#    %          @                   @                  //
//                   #@                  #@&                            @                  //
//                     @*                           &@@@(            @@(                   //
//                        &@@@@@@*. .,%@@@@@@@@@(                                          //
//                                                                                         //
//                                                                                         //
/////////////////////////////////////////////////////////////////////////////////////////////


contract BD is ERC1155Creator {
    constructor() ERC1155Creator("B1rd Droppings", "BD") {}
}