// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: DUARTΞ ART
/// @author: manifold.xyz

import "./ERC1155Creator.sol";

//////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                          //
//                                                                                          //
//                                                                                          //
//                                          ▄▀▀▄                                            //
//                                            ▄▀        █N▄▄▄▄                              //
//                                           ▐          █▒▒▒▒▒▀▄,                           //
//                                           ▄          ▐▒▒▒▒▒▒▒▒▀B▄▄▄                      //
//                                                      ▐▒▒▒▒▒▒▒▒▒▒▒▒░▀▌                    //
//                                      ,▄▀▀▀▀▀▌▄▄,     ▐▒▒▒▒▒▒░▒▒▒▒▒▒▒▒▀▄                  //
//                                     ▀           ▀▌   ▐▌▀▀▒░░▒▒░░▀░▒▒▒▒▒▀▀▀▀▀▀▀▀▀▀▀▀▀█    //
//                                   ,▀         ▄▄   █   ▌▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒█    //
//                                   █        █  ¬▀▌ ▐⌐  █▒▒▒▒▒▒▒▒▒▒▒▀░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▌    //
//                                   ▌        █  ▀▀ ▌ ▌  ▌▄█▄░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▐▌    //
//                                  J▌         ▀▀M▀▀  ▌  █ `▀█░▒▒▒▒▒▒▒▒▄▒▒▒▒▄▄▄▒▒▒▒▒▒▒▐     //
//                                   ▌         ,▄▄▄▄ ▐▄P"  ,▄██░▒▒▄▓▓█▄▀▒▄▓█▒▓▓█▒▒▒▒░▄█     //
//                                   ▀         █▓▓▓▓██  ,▄▀▓░░▄▓▓▒▓▓▓▓▓█▓▒▓▓▓▓▓▒█▓▓▀▒╢█     //
//                                    █µ        ▀▀▀▀█ ,▀-   ¬▀██▀██▓▓▓▓▌▓▓▓▓▓▓▓▓▓▓▓▓▓█`     //
//                                  ▄▀ `  ,    ,⌐ ▀▀▀▀`-- ¬---`   █▓▓▓▓▓█╣▓▓█╢▒█▓▓▓▓▓▌      //
//                                 █        `              ,▄▄M▀▀▀█▓▓▓▓▓▓▓▓╢███▓▓▓▓▓█       //
//                                ▐                  ,▄▄P▀▀        ▀█▌▓▓▓▓▓▀╣▓▓▓▓▓▓█        //
//                                ▌               ,▀¬                 ▀▓▓▓╢▓▓▓▓▓▓▓▓▌        //
//                               ▐▌              ▄▀                        ▀▀▀▀``           //
//                               ▐U             ▄▀                                          //
//                                ▌            ▄`             ▄▄▄                           //
//                               ███████▄▄▄,  ▐          ,▄▄▓█▓█▀`                          //
//                              ▐██████████████     ▐███▓▓▓▓▓▓█▄▄                           //
//                         ,▄▄▓█ ██████████████▄▄▄▄  ▀██▀▀▀▀█▓▓▓▓▓█▄,                       //
//              ▄▄████▄▄  ▐█▓▓▓▓████████████████████   ▄▄▓▓████▓▓▓▓▓▓▌                      //
//            ▄█▓▓▓▓▓▓▓▓█ █▓▓▓▓▓▓▓▓███████████████████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█                      //
//           ▐█▓▓▓▓▓█▓▓▓▓██▓▓▓▓▓▓▓▓▓▓▓▓███████████████▓▓▓▓▓▓▓▓▓████████▄,                   //
//           █▓▓▓▓▓▓▓██▓▓█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓███████████▓▓██▓▓▓▓▓▓▓▓▓█▄                  //
//           ▐█▓▓▓▓▓▓▓██████████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█████████▓▓▓██████▓▓▓▓▓▓█µ                 //
//            '▀██▓██████▓▓▓▓▓▓▓▓██▓▓▓▓▓▓▓██████████████▓▓▓▓▓▓▓▓██▓██▓▓▓▓█▌                 //
//                   █▓▓▓▓▓▓▓▓▓▓▓▓▓█▀▀▀`  ████ ,█▄████µ   ¬╙████▓▓▓▓▓▓▓▓▓█                  //
//                  █▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█          ▀▓▓▓▓██▀      ▀█▓▓▓▓▓▓▓▓█▀                   //
//                  █▓▓▓▓▓▓▓██▓▓▓▓▓▓▌           ██▀`           ▀▀▀▀▀▀▀-                     //
//                  ▀▓▓▓▓▓▓▓▓▓▓▓▓▓▓█                                                        //
//                   ▀█▓▓▓▓▓▓▓▓▓▓█▀                                                         //
//                     ▀▀██████▀▀                                                           //
//                                                                                          //
//                                                                                          //
//                                                                                          //
//////////////////////////////////////////////////////////////////////////////////////////////


contract DUART is ERC1155Creator {
    constructor() ERC1155Creator() {}
}