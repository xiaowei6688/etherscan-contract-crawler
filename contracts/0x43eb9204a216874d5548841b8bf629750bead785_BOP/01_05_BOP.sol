// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Birds of Paradise
/// @author: manifold.xyz

import "./ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                //
//                                                                                                                //
//                                                                                                                //
//                                                                                            ,█▀                 //
//                                                                                          .██─                  //
//                                                                                         ▄█▌                    //
//                                                                                       ,██▀                     //
//                                                                                      ▄██└                      //
//                                                                                     ███ ,▄▄███▄                //
//                                                                                   ╓███████▀▀▀▀██µ              //
//                                                    ▄▄███▄                        ██████╙      ██▌              //
//                                                ,▄████▀▀██▌                     ,████╙        ]██▌              //
//                                              ▄███▀└  ▄██▀                     ▄███▌          ╟██               //
//                                           ,███▀    ▄██▀`                    ,████▌          ▐██╜               //
//                                          ███╜    ▄██▀                      ▄████▌          ▐██▀                //
//                                        ╓██▀   ,███╙                      ,██████          ▐██▀                 //
//                                       ▓██   ▄██▌└                       ▄██████`         ▓██▀                  //
//                                      ██▌ ,███▀                        ,███████▌        ,███┘                   //
//                                     ▓██▄██▌└                         ╓██▌.███▌        ╓███`                    //
//                                    ▄████▀                           ╔██▀ ╫███`       ████                      //
//                                   ████╙                            ▄██▀ ▐███▌      ╓███▀     ,▄▄▄███▄▄         //
//                                 ▄████░                            ▐██▀  ████¬     ████▌▄▄███████████████▄      //
//                              ,███╙ ██▌                           ▐██▀  ▐████    ▄██████████▀▀▀╙`     ╙▀███     //
//                            ,██▀┘    ███,                        ]██▌   ▓███▌  ,████████▌╙              ║███    //
//                          ╓██▌`       ╙▀████▄▄,                  ██▌   ]████⌐ ▄██████▀                  ▐███    //
//                        ╓██▀             '╙▀██████▄             ╟██    ▐████▄██████└                    ▐███    //
//                      ,██▌                      ╙███           ]██⌐    ╟████████▌                       ███▌    //
//                    ,██▀`                        ]██▌          ╫█▌     ▓███████└                       ███▌     //
//                   ▄██╙                         ╓██▌          ]██      ██████▀                        ███▌      //
//                 ╓██▀                         ,███▀           ▐█Γ      █████                        ┌███▌       //
//                ██▀                          ▄███▀             ╙       ████                        ╓███▌        //
//              ╓██╙                         ▄████  ,,▄▄███#             ████                       ████▀         //
//             ▄██                         ▄█████████▀▀╙└                ╫███▌                    ╓████▀          //
//            ██▀                       ,███████▀▀└                      ▐███▌                  ,█████`           //
//          .██╙                     ╓██████▀╜                           ⌠████                 █████▀             //
//         ,██                   ▄████████╜                               ▓███▄             ,██████─              //
//        ┌██                ,█████████▌`                                 ▐████           ,██████╙                //
//        ██              ,██████████▀                                     █████        ▄██████╜                  //
//                      ▄██████████▀                                        █████▄  ,▄██████▀╙                    //
//                     ████████▀▀                                            █████████████▀                       //
//                     ╙▀██▀▀┘                                                 ▀███████╙                          //
//                                                                                                                //
//                                                                                                                //
//                                                                                                                //
//                                                                                                                //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract BOP is ERC721Creator {
    constructor() ERC721Creator("Birds of Paradise", "BOP") {}
}