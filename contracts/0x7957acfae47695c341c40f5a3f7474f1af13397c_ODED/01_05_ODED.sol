// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: ODIOUS EDITIONS
/// @author: manifold.xyz

import "./ERC1155Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                        //
//                                                                                        //
//                                                                                        //
//    ████████████████████████████████████████████████████████████████████████████████    //
//    ████████████████████████████████████████████████████████████████████████████████    //
//    ██████████████████████████▀▀▀╙└      └╙╙╙╙╚╩▀███████████████████████████████████    //
//    ██████████████████████▀▀└                      ' "╙╙╚╩╩╬████████████████████████    //
//    ███████████████████▌╩"           ,,,                    "╙╚╠████████████████████    //
//    █████████████████╩╙           ≥░░░░░░░φ ▄▄▄▄▄▄▄             "╚╣█████████████████    //
//    ███████████████╩╙           «░░░░░░░░" "╙█████████▄▄          '╚╟███████████████    //
//    █████████████╩└        ,▄▄█▓░░░░░░░░░,,φ∩█████████████▄         `╚╠█████████████    //
//    ███████████╩'      @███████▌░░░░░░░░░░░'█████████████████▄         ╚╟███████████    //
//    █████████╩"    ,,∩╫▀╨███████░░░░░░░░░╚▄█████████████████████▄       "╠▓█████████    //
//    ███████╬╩    ,╓▓▓╬▀é╠████████▄ƒ░░Γ░▄███████████████████████████▄      ╚╣████████    //
//    ███████╩'   ≥▀╠█╬▀æ▀Æ╟███████████████████████████████████████████▄     ╚╟███████    //
//    ██████▌    "φ#▄█▀,é╚▒██████████████████████████████████████████████     ╚╣██████    //
//    ██████▒    .▓▀│▄▀▄⌐╚╙,A▐████████████████████████████████████████████     ╠██████    //
//    ██████⌐     █▄█▀▄▀▄Ö╙╓Å█████████████████████████████████████████████     "╠█████    //
//    ██████⌐    '█╬▓▀╚∩,e▌⌐ ██████████████████████████████████████▀└└└╙██      ╚╫████    //
//    ██████⌐    ]█∩░;▄█▀ ,⌐▓█████████████████████████████████████'░░░░░░█      ;╟████    //
//    ██████      █▓▀▀│▄Q▌"╙╩█▀Ä█████████████████████████████████░░░∩░╓█░`      :╟████    //
//    ███████    `╫▓░▓▀╙│░▄Q╨^,Φ████████████████████████████████▌░░░░░ │        ]╟████    //
//    ████████    ▐█▒φ▒▒▓▀╙,╦▌" j█████████████████████████████████▄▄▄▄█▀        φ╟████    //
//    █████████    █╠▓▀│╠▄█▀░ x▌⌐ ,╬╩▒████████████████████████████████▀         ░╫████    //
//    ██████████   ╟╬╬░#▒░╠▄▓▀  ▄▀` ▄██╬╬████████████████████████████`         'j█████    //
//    ███████████   ▀╬╬╬▒╝▀░≤▄▀╙ ,Q▀╞▓▀▄███████████████████████████`           ¡██████    //
//    ███████████⌐   ╚██▌.╓#╬░;▄█▀╓▀`,╬███████████████████████████            '▓██████    //
//    ████████████▄    ██╬▒╠░▄▀▒▄▀¬╓▓▀▄╬╨╠QA╟████╬███▀███████████            .████████    //
//    ██████████████    ╙█╬╫╬▒▄╩╙╦█▀▄▌^▄▌^ ▄╙,▓▀╟▀╓▀,∩█▀▓╨▄▌║██▀           ,▄█████████    //
//    ███████████████▄    ╙╫╬╬██▄└▄▀╙▓▀,]#╙,▓▀╓▀.é▄▀#▀╓▀,╬▀"╩`           ▄████████████    //
//    ████████████████▄     ╙╙█████▓▒,▄▀╙░▓╙▐█╚#▄▀▄▀,█└▄▀ -           ,███████████████    //
//    ███████████████████▄      ╙╙▀▀▓╬▓███╗▓▒▄█▌▄▀'Æ╙▄▌└            ╓█████████████████    //
//    ██████████████████████▄           ╙╙╙╙╝▀▀▀▀▀▀▀╙└            ,███████████████████    //
//    ███████████████████████████▄▄,                           .,▓████████████████████    //
//    ███████████████████████████████████▓▄▄▄▄    ,▄▄▄▓███████████████████████████████    //
//    ████████████████████████████████████████████████████████████████████████████████    //
//    ████████████████████████████████████████████████████████████████████████████████    //
//                                                                                        //
//                                                                                        //
//                                                                                        //
////////////////////////////////////////////////////////////////////////////////////////////


contract ODED is ERC1155Creator {
    constructor() ERC1155Creator() {}
}