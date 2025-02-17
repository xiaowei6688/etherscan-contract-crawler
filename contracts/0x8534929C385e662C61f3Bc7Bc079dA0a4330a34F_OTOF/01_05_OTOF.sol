// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Ordinal Tree Of Life
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                                                                                        //
//                                                                                                                                                                                                        //
//                                                                                                                                                                                                        //
//                                                                                             ,----,                                                              ,--,                                   //
//        ,----..                                                                            ,/   .`|                                                           ,---.'|                                   //
//       /   /   \                                                      ,--,               ,`   .'  :                                                           |   | :                                   //
//      /   .     :              ,---,  ,--,                          ,--.'|             ;    ;     /                                             .--.,         :   : |     ,--,     .--.,                //
//     .   /   ;.  \  __  ,-.  ,---.'|,--.'|         ,---,            |  | :           .'___,/    ,' __  ,-.                             ,---.  ,--.'  \        |   ' :   ,--.'|   ,--.'  \               //
//    .   ;   /  ` ;,' ,'/ /|  |   | :|  |,      ,-+-. /  |           :  : '           |    :     |,' ,'/ /|                            '   ,'\ |  | /\/        ;   ; '   |  |,    |  | /\/               //
//    ;   |  ; \ ; |'  | |' |  |   | |`--'_     ,--.'|'   |  ,--.--.  |  ' |           ;    |.';  ;'  | |' | ,---.     ,---.           /   /   |:  : :          '   | |__ `--'_    :  : :     ,---.       //
//    |   :  | ; | '|  |   ,',--.__| |,' ,'|   |   |  ,"' | /       \ '  | |           `----'  |  ||  |   ,'/     \   /     \         .   ; ,. ::  | |-,        |   | :.'|,' ,'|   :  | |-,  /     \      //
//    .   |  ' ' ' :'  :  / /   ,'   |'  | |   |   | /  | |.--.  .-. ||  | :               '   :  ;'  :  / /    /  | /    /  |        '   | |: :|  : :/|        '   :    ;'  | |   |  : :/| /    /  |     //
//    '   ;  \; /  ||  | ' .   '  /  ||  | :   |   | |  | | \__\/: . .'  : |__             |   |  '|  | ' .    ' / |.    ' / |        '   | .; :|  |  .'        |   |  ./ |  | :   |  |  .'.    ' / |     //
//     \   \  ',  / ;  : | '   ; |:  |'  : |__ |   | |  |/  ," .--.; ||  | '.'|            '   :  |;  : | '   ;   /|'   ;   /|        |   :    |'  : '          ;   : ;   '  : |__ '  : '  '   ;   /|     //
//      ;   :    /  |  , ; |   | '/  '|  | '.'||   | |--'  /  /  ,.  |;  :    ;            ;   |.' |  , ; '   |  / |'   |  / |         \   \  / |  | |          |   ,/    |  | '.'||  | |  '   |  / |     //
//       \   \ .'    ---'  |   :    :|;  :    ;|   |/     ;  :   .'   \  ,   /             '---'    ---'  |   :    ||   :    |          `----'  |  : \          '---'     ;  :    ;|  : \  |   :    |     //
//        `---`             \   \  /  |  ,   / '---'      |  ,     .-./---`-'                              \   \  /  \   \  /                   |  |,'                    |  ,   / |  |,'   \   \  /      //
//                           `----'    ---`-'              `--`---'                                         `----'    `----'                    `--'                       ---`-'  `--'      `----'       //
//                                                                                                                                                                                                        //
//                                                                                                                                                                                                        //
//                                                                                                                                                                                                        //
//                                                                                                                                                                                                        //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract OTOF is ERC721Creator {
    constructor() ERC721Creator("Ordinal Tree Of Life", "OTOF") {}
}