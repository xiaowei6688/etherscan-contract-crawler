// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Daydream
/// @author: manifold.xyz

import "./ERC721Creator.sol";

//////////////////////////////////////////////////////////////////////
//                                                                  //
//                                                                  //
//                                         ','. '. ; : ,','         //
//                                          '..'.,',..'             //
//                                             ';.'  ,'             //
//                                              ;;                  //
//                                              ;'                  //
//                                :._   _.------------.___          //
//                        __      :__:-'                  '--.      //
//                 __   ,' .'    .'             ______________'.    //
//               /__ '.-  _\___.'          0  .' .'  .'  _.-_.'     //
//                  '._                     .-': .' _.' _.'_.'      //
//                     '----'._____________.'_'._:_:_.-'--'         //
//                                                                  //
//                                                                  //
//////////////////////////////////////////////////////////////////////


contract DREAM is ERC721Creator {
    constructor() ERC721Creator("Daydream", "DREAM") {}
}