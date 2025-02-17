// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Llama on a Balloon!
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                    //
//                                                                                                                    //
//                                                                                                                    //
//                                                                                @@@@@@@@,                           //
//                                          @@@@@@@@@                       @@@@@@////////&@@@@@                      //
//                                    @@@@@@/////////@@@@@#              @@@////////////////////@@@                   //
//                              #@@@@@////////////////////#@@@@@      @@@//////   /////////////////@@@                //
//                           *@@#///////////////////////////////@@@   @@@///   ////////////////////@@@                //
//                           *@@#///////////////////////////////@@@   @@@///   ////////////////////@@@                //
//                         @@&/////      //////////////////////////@@@////////////////////////////////@@@             //
//                         @@&//.  ////////////////////////////////@@@////////////////////////////////@@@             //
//                         @@&//.  ////////////////////////////////@@@////////////////////////////////@@@             //
//                      @@@//*  */////////////////////////////////////@@@/////////////////////////////@@@             //
//                      @@@//*  */////////////////////////////////////@@@/////////////////////////////@@@             //
//                      @@@///////////////////////////////////////////@@@//////////////////////////@@@                //
//                      @@@///////////////////////////////////////////@@@//////////////////////////@@@                //
//                      @@@///////////////////////////////////////////@@@///////////////////////(((@@@                //
//                      @@@///////////////////////////////////////////@@@///////////////////////(((@@@                //
//                      @@@///////////////////////////////////////////@@@@@@/////////////////(((@@@                   //
//                         @@&//////////////////////////////////(((@@@   @@@@@@@@@@@@@@@@@#//(((@@@                   //
//                         @@&//////////////////////////////////(((@@@@@@@@@//////////////&@@@@@                      //
//                         @@&//////////////////////////////////(((@@@//////////////////////////@@@                   //
//                         @@&//////////////////////////////////(((@@@//////////////////////////@@@                   //
//                         @@&//////////////////////////////////(((@@@//////   ////////////////////@@@                //
//                           *@@#////////////////////////////(((@@@//////   ///////////////////////@@@                //
//                              #@@///////////////////////(((&@@@@@//////   ///////////////////////@@@                //
//                              #@@///////////////////////(((&@@@@@////////////////////////////////@@@                //
//                                 @@@//////////////////((%@@,  @@@////////////////////////////////@@@                //
//                                    @@@////////////(((@@#        @@@///////////////////////(((@@@                   //
//                                    @@@////////////(((@@#        @@@///////////////////////(((@@@                   //
//                                    @@@////////////(((@@#        @@@///////////////////////(((@@@                   //
//                                       @@@//////(((@@@           @@@///////////////////////(((@@@                   //
//                                       @@@//////(((@@@              @@@/////////////////(((@@@                      //
//                                          @@@(((@@@                 @@@/////////////////(((@@@                      //
//                                          @@@(((@@@              @@@   @@@///////////(((&@@                         //
//                                          @@@(((@@@              @@@      @@@////////#@@,                           //
//                                          &&&###&&&              @@@      @@@////////#@@,                           //
//                                             @@@                 @@@      @@@//////((%@@,                           //
//                                                @@@              @@@         @@@((#@@#                              //
//                @@@                                @@@  *@@,        @@@      @@@((#@@#                              //
//             @@@@@@                                   @@&((&@@      @@@         @@@                                 //
//             @@@(((@@@        #@@@@@   @@@@@@         @@&((&@@      @@@      @@@                                    //
//             @@@(((@@@              @@@            @@@(((((&@@      @@@      @@@                                    //
//             @@@(((&&&***   ,,,.....%%%,,,,,,   ***&&&(((((&@@      @@@   ***###                                    //
//             @@@(((###@@@  ,%%(/////,,,######   @@@###(((((&@@      @@@   @@@                                       //
//             @@@((((((&&&%%#/////,,,,,,,,,#########@@@((#@@,  @@@   @@@   @@@                                       //
//             &&&&&&@@@&&&&&&&&@@@&&&@@@&&&&&&@@@&&&@@@&&&@@,  @@@   @@@   @@@                                       //
//                @@@&&&@@@@@@&&&&&@@@&&&@@@&&&&&&@@@&&&@@#     @@@   @@@      @@@                                    //
//             @@@@@@@@@(((&&%((%@@(((@@@(((@@@(((&&&(((@@@&&,  @@@      @@@   @@@                                    //
//                @@@(((((((((((((((((((((((((((((((((((@@#        @@@   @@@   @@@                                    //
//             (((%%%%%%%%%%%%%%((((((%%%%%%%%%%%%%%%(((%%#((.     @@@   (((((((((                                    //
//             @@@(((@@@@@@@@@@@#(((((@@@@@@@@@@@@@@@(((((#@@,     @@@      @@@                                       //
//                @@@      @@&(((((((((((      @@@((((((@@#           @@@   @@@                                       //
//                @@@(((   @@&((((((((((((((   @@@((((((@@#              @@@                                          //
//                @@@&&&&&&&&&&&&&&&&&((((((((((((((((((@@#              @@@                                          //
//             @@@&&&%%%%%%%%%%%%%%%%%&&&(((((((((((((((((#@@,           @@@                                          //
//             @@@@@@@@@@@@@@@@@&%%%%%&&&(((((((((((((((((#@@,        @@@                                             //
//             @@@&&&&&&@@@&&&&&%%%%%%%%%%%%((((((((((((((#@@,        @@@                                             //
//             @@@%%%%%%@@@%%%%%%%%%%%%%%&&&((((((((((((((#@@,        @@@                                             //
//             @@@%%%%%%%%%%%%%%@@@%%%%%%&&&(((((((((###(((((&@@   @@@                                                //
//                @@@%%%%%%@@@@@&%%%%%&&&((((((######((((((((###@@@                                                   //
//                   @@@&&&&&&&&&&&&&&(((((((((((((((((((((((&@@@@@                                                   //
//                      @@@###((((((((((((((@@@(((((((((((#@@#((@@@                                                   //
//                      @@@((((((((@@@((((((@@@(((((((((@@&(((((###@@@                                                //
//                      @@@(((((%@@[email protected]@@###@@@((((((@@@%%#((((((((@@@                                                //
//                      @@@(((((&@@   @@@###@@@((((((@@@##(((((((((@@@                                                //
//                      @@@(((((&@@   @@@@@@@@@((((((@@@(((((((((((@@@@@@                                             //
//                      @@@(((%%@@@   @@@(((@@@(((%%%@@@(((((((((((@@@###@@@                                          //
//                      @@@%%&@@*     @@@(((@@@%%%@@@###(((((((((((@@@(((@@@                                          //
//                         @@@@@*     @@@((((((@@@@@@((((((((((((((@@@(((@@@                                          //
//                                    @@@((((((######(((((((((((###@@@(((@@@                                          //
//                                    @@@(((((((((((((((((((((((@@@   @@@                                             //
//                                    @@@(((((((((((((((((((((((@@@   @@@                                             //
//                                    @@@((((((@@@((((((((((((((@@@                                                   //
//                                    @@@((((((@@@@@@@@@((((((((@@@                                                   //
//                                    @@@((((((@@@      @@&(((((@@@                                                   //
//                                    @@@((((((@@@      @@&(((((@@@                                                   //
//                                    @@@@@@(((@@@      @@@@@#((@@@                                                   //
//                                       @@@%%%@@@        *@@&%%@@@                                                   //
//                                       @@@%%%@@@        *@@&%%@@@                                                   //
//                                       @@@%%%@@@        *@@&%%@@@                                                   //
//                                          @@@              %@@                                                      //
//                                                                                                                    //
//    "Llama on a Balloon!" is an art remix of both @PRguitarman's Nyan Balloon & @Llamaverse's Llamas.               //
//                                                                                                                    //
//                                                                                                                    //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract LBLN is ERC1155Creator {
    constructor() ERC1155Creator("Llama on a Balloon!", "LBLN") {}
}