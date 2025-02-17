// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Publishing Selina Traun
/// @author: manifold.xyz

import "./ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                        //
//                                                                                        //
//    "`^"░ '                                 '░░░░░░░░░░░░░░░░░░░░░░░░''  '   ''         //
//        ░                                  ' ░░░░░░░░░░░░░░░░░░░░░░░░░' ' '' .░  ..     //
//        ░                                  '.░░░░░░░░░░░░░░░░░░░░░░░░░''    ░' .'' ░    //
//       ]░                                   ''░░░░░░░░░░░░░░░░░░░░░░░░' .'''''.░░░░░    //
//       ░.                                   . ░░░░░░░░░░░░░░░░░░░░░░░░'' ░'░░.░░░░░░    //
//       ░                           .;░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░'░.░░░░░░░░░░    //
//       "                        '░╠╬╬╬╬╬╬░░╦╦φφ░░░░░░░░░░░░░░░░░░╠▒╬╬╬░ ░░░░░░░░░░░░    //
//       '                  ,╓╓▄▒▓▓▓▓▓▓▀▀▀▀▓▓▀▀▀▀▀▀▀╣▒▄░░░░░░░░╬╣▓▓▓▓▓▓▓▓▓▄,;░░░░░░░░░    //
//                  ,╓╗#▒▓▌╓╩╩▀░⌠░░░░░░░░░░╬╬╬╬╬╬╬╬╬╬░░░▀▀##╣╣▀▓▀▀░░░░░╬▓╬░╙▀▀▓▓▓µ░░░░    //
//          ,╔▄φ▒╣▀▀╩╩╨╨╙░░░""░░░░░░░░░░░░▒▒▓▓▓▓▓╬╬╬░░░░░░░░╠▓░╬▓▓▓▓▄░░░╠▓▒▒▀▀▀▀╨░░░░░    //
//    ░░≥≥╔╠▀▀╙'              '░!░'''╓▄▓▓▓▓▓▌░╣▓▓╬╬░░╟#░╠░░░░╫▐▓▓▓▓▓▌╬▓▒░' ░  ░░░░░░░░    //
//    ╬φ░░░░░                 .░.,╔φ▀▀░╠▀▀▀░╬╬╬╬╬╬░░╠╬╬╬░ ░░░╠╬╬╬╬▀▀╬╬╬▀░░░░ ░░░░░░░░░    //
//    ╬░░░░░                   '░░░  ░░░░░░░░╬╬╬░░░░░╠╩░   ░░░░╬╬╬╬░░░░░░░░░╓░░░░░░░░░    //
//    ╬░;░░░╠╦                '  ░░░░░░░░░░░░╬░░░░░░░░ ░░░.░░░░╬░░░░░░░░░░░░░░░░░░░░░░    //
//    ╬ ;░╬╬╬╬Γ                    ░░░░░░░░░░░░░░░░░       ░░░░░░░░░░░░░░░░░░░░░░░░░░░    //
//    ╠ ░╠╬╬╬░                ''  ' ░░░░░░░░░░░░░░░░░░░░  .░░░░░░░░░░░░░░░░░░░░░░░░░░░    //
//    ░⌐'░╫▓╬⌐                 . .░ '░'░░░░░░░░░╬╬░        '░░░░░░░░░░░░░░░░░░░░░░░░░░    //
//     ░░ ^'└╚╕           '    '    '  ░'░░░░░░╬╬╬░.,░╓╓;░,░░░░░φ╬░░░░░░░░░░░░░░░░░░░░    //
//      ░░                 ''.  .    ' '' '░░░░░░░░φ╟╣╬░░╬╬╬╬╬╣╬╬░░░░░░░░░░░░░░░░░░░░░    //
//              ;          '.  .          ░░░░░░░░░░░░░░░░░╬╬╬░░░░░░░░░░░░░░░░░░░░░░░░    //
//              ░⌐            . '    '  .░░░░' .░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░░╬╬    //
//             ░░               ░     .░░░░' .░░░░░░░░░░░░░╬░░░░░░░░░░░░░░░░░░░░░░░╬╬╬    //
//                              ░     ;'. . :░░░░░░░░░░φ╦╠░░░╬╬╬╬╬╬░░░░░░░░░░░░░;╠╠╬╬▓    //
//                                        ░░░▄▄▄▄▒╣╣╣▓╣╣╫╣▒▒▓▓▓▓▓▓▓╬░░░░░░░░░░░░╬╬╬╬╬╬    //
//                                      '░░░░░░░░░░░╨╩╩╩╬╬╬╬╬╬╬░░░╬░░░╬░░░░░░░░╬╠╬░░╣▓    //
//                             '      ..░░░░░░░░░░.░░░░░φ╬░╣╬╬╬╬░╬╬░╬╬░░░░░░░░╬░╬╬░╠▒▓    //
//                                     ░░░░░░░░░░░░░░░░░░░╬░░░░░╬╬░░╬░░░░░░░░╬░╬╬╬╠╬▓▓    //
//                ,     ░  '       '.'░░░░░░░░░░░░░░░░░░░╠░░░░░╬╬░░╬╬░░░░░░░░░╬╬╬░╣▓▓▓    //
//              ╓▓▓      '░      '     ░░'░░░░░░ ~░░░░░░░░░░░░░░░░╬╬░░░░░░░░░╬╣╬░╣╬▓▓▓    //
//            ╓▓▓▓▓        '░░.'  .    '.  '     .░░░░░░░░░░░░░░░╬▓▓▓▄▄░░░░░░╬╬░╣▓▓▓▓▓    //
//           ▄▓▓▓▓▌           '''░..░░.░░      .░¡░░░░░░░░░░░░╬╬╬▓▓▓▓▓▓▓▓▄▄▄╬╬╬╣▓▓▓▓▓▓    //
//         ╓▓▓▓▓▓▓░              '░░░░░░░░;░░░░░░░░░░░░░░░░░╬╬╬▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓    //
//    ╓╦▒▓▓▓▓▓▓▓▓▓░               ' '░░░░░░░░░░░░░φ╠╬╬╬╬╬╬▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓    //
//    ▀▀▀▀▀▀▀▀▀▀▀▀╨┘-          ' ''--░░░░=╚╚╜╜╜╜╨╨╨╨╨╨╨╨▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀▀    //
//                                                                                        //
//                                                                                        //
//                                                                                        //
//                                                                                        //
////////////////////////////////////////////////////////////////////////////////////////////


contract PAT is ERC721Creator {
    constructor() ERC721Creator("Publishing Selina Traun", "PAT") {}
}