// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: The Clown..
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                        //
//                                                                                                        //
//    Photograph -                                                                                        //
//    A blend of movements, symmetries and lights                                                         //
//                                                                                                        //
//                                                                                                        //
//                                                                                                        //
//    ////////////////////////////////////////////////////////////////////////////////////////////////    //
//    //                                                                                            //    //
//    //                                                                                            //    //
//    //                             _                                                              //    //
//    //      __         _           _                                 _             _              //    //
//    //      \ \   ___ | |_   __ _ (_) _ __ ___    ___  _ __   _ __  | |__    ___  | |_   ___      //    //
//    //       \ \ / _ \| __| / _` || || '_ ` _ \  / _ \| '_ \ | '_ \ | '_ \  / _ \ | __| / _ \     //    //
//    //    /\_/ /|  __/| |_ | (_| || || | | | | ||  __/| | | || |_) || | | || (_) || |_ | (_) |    //    //
//    //    \___/  \___| \__| \__,_||_||_| |_| |_| \___||_| |_|| .__/ |_| |_| \___/  \__| \___/     //    //
//    //                                                       |_|                                  //    //
//    //                                                                                            //    //
//    //                                                                                            //    //
//    //                                                                                            //    //
//    //                                                                                            //    //
//    ////////////////////////////////////////////////////////////////////////////////////////////////    //
//                                                                                                        //
//                                                                                                        //
////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract JTM is ERC1155Creator {
    constructor() ERC1155Creator("The Clown..", "JTM") {}
}