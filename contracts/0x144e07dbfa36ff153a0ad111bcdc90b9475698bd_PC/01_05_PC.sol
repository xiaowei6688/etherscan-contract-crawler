// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: 3PEACE Checks
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

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


contract PC is ERC1155Creator {
    constructor() ERC1155Creator("3PEACE Checks", "PC") {}
}