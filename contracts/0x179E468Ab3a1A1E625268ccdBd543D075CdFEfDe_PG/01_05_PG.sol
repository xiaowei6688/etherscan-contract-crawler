// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: The Game
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                                                                              //
//                                                                                                                                                                                              //
//                                                                                                                                                                                              //
//    //                                                                         ░    ,                                                                                                   //    //
//    //                                                                   ,    ,                                                                                                         //    //
//    //                                                                      ,░  ,                                                                                                       //    //
//    //                                                                     ░   ░ ` ,                                                                                                    //    //
//    //                      ░   ░░                                   ;   ░ ` ░░                                                                                                         //    //
//    //                    ░░░  ░   ░                                    ░ `,░` .░                                                                                                       //    //
//    //                         └   ░                                 ░░░░. ░░` ░░`                                                                                                      //    //
//    //                      ░░      ░                                ░░░░ ,░░ ░░░  ,,                                                                                                   //    //
//    //                    ░ ░░'    :░ .                             ░░░░░░░`,░░  ─░                                                                                                     //    //
//    //                     ░░░  ░  ░` ░  ░                        ░░░░░▒░░░░░`,░░  ,─░                                                                                                  //    //
//    //                     ░░░░░ ░ ░`┌░ ░  ░                    ..░░░░░░▒░░`,░░`,░░                                                                                                     //    //
//    //                      ░ ░  ░░░ ░`░░,░ ░                  ¿ ░░░░░▒░░░░░`,░░░`  ░░                                                                                                  //    //
//    //                       ░░░ ░░░░░░░,░ ░░.░               ∩░░░░░░░░░░░░░░░`,─░░░░                                                                                                   //    //
//    //                       ░░░  ░░░░░░░ ░ ░░ .,           ,░░░░░░░░░░░░░░░░░░  .,░░                                                                                                   //    //
//    //                        ░░░░░░░░░░░░`░ ,░░        ─ ,░░░░░░░░░░░░░░░░`░░░░░░                                                                                                      //    //
//    //                         ░░░░░░░░░░░░`░░░ ,─`    ░,░▒░░░░░░░░░░░░░░░░░ ░░─░░░                                                                                                     //    //
//    //                       ░ ░░░░░░░░░░░░░░░.░░░░` .░▒▒░░░░░░░░░░░░░░░░░░░░  `                                                                                                        //    //
//    //                          ░░░░░░░░░░░░░░░░░░░░ ╓▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░                                                                                                       //    //
//    //                          ░░░░░░░░░░░░░░░░░░  ▒▒▒▒░░░░░░░░░░░░░░░░░░░░░   ░                                                                                                       //    //
//    //                       ,░ ░░░░░     ░░░░░░░  ▒▒▒▒▒░░░░░░░░░░░░░░░░░─░░░─ .,,                                                                                                      //    //
//    //                        ░ ░░      ░░░░░░░▒`,▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░`░░─░                                                                                                       //    //
//    //             .──░░░░;    ` ░░░░░░░░░░░░▒╜ ▒▒▒▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░░░░                                                                                                       //    //
//    //            ¿   ╔▄╖░░, ░,  `░░░░░░░░▒▒╜ ░▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░─. ░░░░░░                                                                                                         //    //
//    //            ░░░░└░░░░░░░░   ░  ``"░▒░░░▒▒▒▒▒▒▒▒▒░▒░░░░░░░░░░░░░   ░░  ░░                                                                                                          //    //
//    //           ,▒╣H▒▒▒▒░░░░░░░░░░░░░░░░░░░░░░░▒▒▒░░░░░░░░░░░░░░░░░. ░░   `                                                                                                            //    //
//    //          *`       `└▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░─░░░░░░░  ░░░ ░                                                                                                               //    //
//    //                       └▒░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░` ░  ░░░                                                                                                                   //    //
//    //                          ╨▒░▒▒▒░░░░░░░░░░░░░░░░░░░      ` ░░░                                                                                                                    //    //
//    //                            ╙▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░░┐ ░ ░─░ ░         ░                                                                                                           //    //
//    //                              └▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░░░░░░   ░                ─                                      ╨▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░░░░░░░░       ,,         .░░─,           //    //
//    //                                   `╨▒▒▒▒▒▒▒▒▒▒▒▒╫▒▒▒▒░░░░░░░     ░░░░░░░          ░                                                                                              //    //
//    //                                       `╙╨▒▒▒▒▒▒╣▓╢▒░░░░░░░░░░░░░░░░░░░░░░░       ░,                                            ╙╣▒╩╚╩╬▒╙***`````   `░░░░░░░░░░░         ░        //    //
//    //                                                                  `░░░░░░░                                                                                                        //    //
//    //                                                                                   ░                                                                                              //    //
//    //                                                                 ░               ░                                                                                                //    //
//    //                                                                     ░`     ░                                                                                                     //    //
//    //                                                                                                                                                                                  //    //
//                                                                                                                                                                                              //
//                                                                                                                                                                                              //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract PG is ERC721Creator {
    constructor() ERC721Creator("The Game", "PG") {}
}