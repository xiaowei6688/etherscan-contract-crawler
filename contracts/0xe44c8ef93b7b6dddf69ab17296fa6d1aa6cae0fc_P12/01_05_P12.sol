// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Punk12
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                //
//                                                                                                                                //
//                                                                             ,@@@@@@@@@@                                        //
//                                                                   /@@@@@@@@@@@@@@@@@@@@                                        //
//                                                           &@@@@@@@@@@@@@@@@&@@@@@@@@@                                          //
//                                                    @@@@@@@@@@@@@           @@@@@@@,       [email protected]@                                  //
//                                             @@@@@@@@@@@                *@@@@@@@        @@@@                     @@@            //
//                                       @@@@@@@@@@                   @@@@@@@@           @@@@               @@@@@@                //
//                                 @@@@@@@@@@                     @@@@@@@         @@   @@@@             @@@@@                     //
//                            @@@@@@@@@#                     @@@@@@@@           @@@   @@@@         @@@@@@                         //
//                       @@@@@@@@@@                     &@@@@@@             @@@@@    @@@,      @@@@@@@.                           //
//                     @@@@@@@@                      @@@@@                 @@@@@   @@@@    @@@@@@@%                               //
//                 @@@@@@                       &@@@@      @@             @@@@@   @@@@ @@@@@@@                                    //
//               @@@@        @              @@@@&      . @@@@@           @@@@#   @@@@@@@@                                         //
//             @@          @@          @@@@@         @@ @@@@@@@@        @@@@   @@@@@@.                                            //
//           *         @ @@@      @@@@@@/         @@@@ @@@@@@@@@@@     @@@@ @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@              //
//                   @@@@@ *@@@@@@@@@   *        @@@@ ,@@@@   #@@@@@  &@@@    @@                 &@@@@@@@@@@                      //
//                  @@@@@@@@@@@@@,    @@        @@@@  @@@@       @@@@/@@@    @@        @@@@@@@@@@@@@@@@@@@@@@                     //
//                &@@@@@@@@@@@      @@@        @@@@  @@@@.         @@@@@        @@@@@@@@          @@@@@@@@                        //
//                @@@@@@@@/       @@@         @@@@   @@@@               @# @@@@@%              @@@@@@@                            //
//               @@@@@(         @@@@       @@@@@@    @@@                @@@               @@@@@@@                                 //
//              /@@@@@         @@@@     @@@@@@@@@    ,@            @@                @@@@@@@                                      //
//              @@@@@         @@@@   [email protected]@@@@   @@                @@@@             @@@@@@        @@@@@@@@@@@@@@@@@@@@               //
//             @@@@@          @@@@@@@@@@                        @@@         @@@@@@ @@@@@@@@@@@@@@@@&                              //
//              @@@            @@@@@                           @@@,     @@@@@@@@@@@@@@@@@@                                        //
//             @@@@                                            @@@   @@@@@@@@@@@@@                                                //
//             @@@                                             @@  @@@@@@@@                                                       //
//              @                                              @                                                                  //
//             %                                                                                                                  //
//                                                                                                                                //
//                                                                                                                                //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract P12 is ERC721Creator {
    constructor() ERC721Creator("Punk12", "P12") {}
}