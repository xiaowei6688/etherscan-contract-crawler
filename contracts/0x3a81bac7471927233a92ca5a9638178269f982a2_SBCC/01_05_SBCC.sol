// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: A Christmas Carol
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                                                     //
//                                                                                                                                                                     //
//                 .     .  .      +     .      .          .                                                                                                           //
//         .       .      .     #       .           .                                                                                                                  //
//            .      .         ###            .      .      .                                                                                                          //
//          .      .   "#:. .:##"##:. .:#"  .      .                                                                                                                   //
//              .      . "####"###"####"  .                                                                                                                            //
//           .     "#:.    .:#"###"#:.    .:#"  .        .       .                                                                                                     //
//      .             "#########"#########"        .        .                                                                                                          //
//            .    "#:.  "####"###"####"  .:#"   .       .                                                                                                             //
//         .     .  "#######""##"##""#######"                  .                                                                                                       //
//                    ."##"#####"#####"##"           .      .                                                                                                          //
//        .   "#:. ...  .:##"###"###"##:.  ... .:#"     .                                                                                                              //
//          .     "#######"##"#####"##"#######"      .     .                                                                                                           //
//        .    .     "#####""#######""#####"    .      .                                                                                                               //
//                .     "      000      "    .     .                                                                                                                   //
//           .         .   .   000     .        .       .                                                                                                              //
//    .. .. ..................O000O........................ ......                                                                                                     //
//      ______   ______   ______   __   __   ______   ______   __   __   __   __   ______   ______                                                                     //
//     /\  ___\ /\  ___\ /\  __ \ /\ "-.\ \ /\  == \ /\  __ \ /\ "-.\ \ /\ "-.\ \ /\  ___\ /\  == \                                                                    //
//     \ \___  \\ \  __\ \ \  __ \\ \ \-.  \\ \  __< \ \ \/\ \\ \ \-.  \\ \ \-.  \\ \  __\ \ \  __<                                                                    //
//      \/\_____\\ \_____\\ \_\ \_\\ \_\\"\_\\ \_____\\ \_____\\ \_\\"\_\\ \_\\"\_\\ \_____\\ \_\ \_\                                                                  //
//       \/_____/ \/_____/ \/_/\/_/ \/_/ \/_/ \/_____/ \/_____/ \/_/ \/_/ \/_/ \/_/ \/_____/ \/_/ /_/                                                                  //
//                                                                                                                                                                     //
//                                                                                                                                                                     //
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract SBCC is ERC721Creator {
    constructor() ERC721Creator("A Christmas Carol", "SBCC") {}
}