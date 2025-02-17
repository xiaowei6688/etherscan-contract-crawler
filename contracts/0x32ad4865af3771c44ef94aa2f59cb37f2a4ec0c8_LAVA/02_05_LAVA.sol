// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: LAVA ETERNAL WORD
/// @author: manifold.xyz

import "./ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                                                                                                    //
//                                                                                                                                                                                                                    //
//                                                                                                                                                                                                                    //
//       ,--,                                                                      ,----,                                                   ,--,                                                                      //
//    ,---.'|                                                                    ,/   .`|                             ,--.               ,---.'|                               ,----..                                //
//    |   | :      ,---,                     ,---,                   ,---,.    ,`   .'  :   ,---,.,-.----.          ,--.'|   ,---,       |   | :                      .---.   /   /   \  ,-.----.       ,---,         //
//    :   : |     '  .' \            ,---.  '  .' \                ,'  .' |  ;    ;     / ,'  .' |\    /  \     ,--,:  : |  '  .' \      :   : |                     /. ./|  /   .     : \    /  \    .'  .' `\       //
//    |   ' :    /  ;    '.         /__./| /  ;    '.            ,---.'   |.'___,/    ,',---.'   |;   :    \ ,`--.'`|  ' : /  ;    '.    |   ' :                 .--'.  ' ; .   /   ;.  \;   :    \ ,---.'     \      //
//    ;   ; '   :  :       \   ,---.;  ; |:  :       \           |   |   .'|    :     | |   |   .'|   | .\ : |   :  :  | |:  :       \   ;   ; '                /__./ \ : |.   ;   /  ` ;|   | .\ : |   |  .`\  |     //
//    '   | |__ :  |   /\   \ /___/ \  | |:  |   /\   \          :   :  |-,;    |.';  ; :   :  |-,.   : |: | :   |   \ | ::  |   /\   \  '   | |__          .--'.  '   \' .;   |  ; \ ; |.   : |: | :   : |  '  |     //
//    |   | :.'||  :  ' ;.   :\   ;  \ ' ||  :  ' ;.   :         :   |  ;/|`----'  |  | :   |  ;/||   |  \ : |   : '  '; ||  :  ' ;.   : |   | :.'|        /___/ \ |    ' '|   :  | ; | '|   |  \ : |   ' '  ;  :     //
//    '   :    ;|  |  ;/  \   \\   \  \: ||  |  ;/  \   \        |   :   .'    '   :  ; |   :   .'|   : .  / '   ' ;.    ;|  |  ;/  \   \'   :    ;        ;   \  \;      :.   |  ' ' ' :|   : .  / '   | ;  .  |     //
//    |   |  ./ '  :  | \  \ ,' ;   \  ' .'  :  | \  \ ,'        |   |  |-,    |   |  ' |   |  |-,;   | |  \ |   | | \   |'  :  | \  \ ,'|   |  ./          \   ;  `      |'   ;  \; /  |;   | |  \ |   | :  |  '     //
//    ;   : ;   |  |  '  '--'    \   \   '|  |  '  '--'          '   :  ;/|    '   :  | '   :  ;/||   | ;\  \'   : |  ; .'|  |  '  '--'  ;   : ;             .   \    .\  ; \   \  ',  / |   | ;\  \'   : | /  ;      //
//    |   ,/    |  :  :           \   `  ;|  :  :                |   |    \    ;   |.'  |   |    \:   ' | \.'|   | '`--'  |  :  :        |   ,/               \   \   ' \ |  ;   :    /  :   ' | \.'|   | '` ,/       //
//    '---'     |  | ,'            :   \ ||  | ,'                |   :   .'    '---'    |   :   .':   : :-'  '   : |      |  | ,'        '---'                 :   '  |--"    \   \ .'   :   : :-'  ;   :  .'         //
//              `--''               '---" `--''                  |   | ,'               |   | ,'  |   |.'    ;   |.'      `--''                                 \   \ ;        `---`     |   |.'    |   ,.'           //
//                                                               `----'                 `----'    `---'      '---'                                               '---"                   `---'      '---'             //
//                                                                                                                                                                                                                    //
//                                                                                                                                                                                                                    //
//                                                                                                                                                                                                                    //
//                                                                                                                                                                                                                    //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract LAVA is ERC721Creator {
    constructor() ERC721Creator("LAVA ETERNAL WORD", "LAVA") {}
}