// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Crow
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

//////////////////////////////////////////////////////////////////////////////////////////
//                                                                                      //
//                                                                                      //
//                                                                                      //
//                                                                                      //
//                          ▐▓⌐   ,                                                     //
//                      ▐▓,  ▓▓   ▓⌐                                                    //
//                       ▀▓▄  ▓▓µ ▓▌                                                    //
//                    ,   ▀▓▓▄ ▓▓▄╙▓▌                                                   //
//                    ^▓▓▄ "▓▓▓▄▀▓▓╙▓µ                                                  //
//                      ▓▓▓▓▓▓▓▓▓▓▓▓▄▓µ  [                                              //
//                     ╟▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▄ ╚                                              //
//                      ▀▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓ ┐                                             //
//                      ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓µ                                            //
//                      ▐▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓Ç                                           //
//                      ▀▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓                                          //
//                       ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▄                                        //
//                       ╙▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▄                             ▄  ╓     //
//                        ▐▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓                        ▄▄ ▓▓ ▓▓     //
//                         ▀▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▄                     ▓▓▓▓▓▓▓▓▌     //
//                          ▐▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓µ                )▓▓j▓▓▓▓▓▓▓▓      //
//                           ▀▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓⌐             ▄▄▓▓▓▓▓▓▓▓▓▓▓▓▓~    //
//                           '▀▓▀▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓⌐         ▄▄▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓'     //
//                             ▀▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▄    ╓▄▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▀¬       //
//                               ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▄▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓∩         //
//                                ▀▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▒░╬▓╬╬╬╬▀▓▓▀▀▀▀▀└.          //
//                                 .▀▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░░╚░╬░░╙░╫▓▓                //
//                                    ▀█▀▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓░╬≤░░░▒╠╠▓▓▓▓               //
//                                         ▄▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▌              //
//                                      ▄▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▀▀▀▀▀█▓▓▓▓▄             //
//                                 ▄▄▄▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█▀.         ~▀█             //
//                    ,,╓▄▄▄▄▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▀`                             //
//                 ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▀`                                //
//                 ▀▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▀                                   //
//                  .▀█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓,^▓▓▓▌                                     //
//                      ^▀▀▀▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▌ ╓▓▓▓▓▓                                    //
//                             ,▀▀▀▀▀██▀▀▀█▓.▐▀┌ ▐▀▀▌                                   //
//                                                  ^                                   //
//                                                                                      //
//                                                                                      //
//////////////////////////////////////////////////////////////////////////////////////////


contract x0 is ERC721Creator {
    constructor() ERC721Creator("Crow", "x0") {}
}