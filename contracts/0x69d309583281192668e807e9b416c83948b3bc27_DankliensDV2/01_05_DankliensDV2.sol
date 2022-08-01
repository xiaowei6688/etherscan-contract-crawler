// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Dankliens: Danklopedia (Vol 2)
/// @author: manifold.xyz

import "./ERC1155Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                        //
//                                                                                        //
//                                                                                        //
//    Text Preview:                                                                       //
//                                                                                        //
//    ████████████████████████████████████████████████████████████████████████████████    //
//    ████████████████████████████████████████████████████████████████████████████████    //
//    ████████████████████████████████████████████████████████████████████████████████    //
//    ████████████████████████████████████████████████████████████████████████████████    //
//    ████████████████████████████████████████████████████████████████████████████████    //
//    ████████████████████████████████████████████████████████████████████████████████    //
//    ███████████████████████░╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠░█████████████████████████    //
//    ██████████████████████░╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠████████████████████████    //
//    █████████████████████╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╣██████████████████████    //
//    ███████████████████▒╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╬█████████████████████    //
//    ██████████████████░╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠▒▒▒▒╬╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╬████████████████████    //
//    █████████████████╬╠╠╠╠╠╠╠╠╠╠╠╠╬╬▓█████████████▄╠╠╠╠╠╠╠╠╠╠╠╠╠╠███████████████████    //
//    ████████████████╠╠╠╠╠╠╠╠╠╠╠╠╬▓███████████████████░╠╠╠╠╠╠╠╠╠╠╠╠╬█████████████████    //
//    ██████████████▒╠╠╠╠╠╠╠╠╠╠╠╠║█▀▀▀▀▀▀▀▀▀▀▀███████████╠╠╠╠╠╠╠╠╠╠╠╠╬████████████████    //
//    █████████████░╠╠╠╠╠╠╠╠╠╠╠╠▓█▒▒▒╠╠╠╠╠▒╠▒▒╠╠╠╠╠░╚█████╠╠╠╠╠╠╠╠╠╠╠╠╬███████████████    //
//    ████████████╬╠╠╠╠╠╠╠╠╠╠╠╠╣█████╠╠╠╠║███████▌╠╠╠╠╬███▌╠╠╠╠╠╠╠╠╠╠╠╠╠╝█████████████    //
//    ███████████╠╠╠╠╠╠╠╠╠╠╠╠╠╠██████╠╠╠╠║████████▒╠╠╠╠╟███╠╠╠╠╠╠╠╠╠╠╠╠╠╠╬████████████    //
//    ██████████▌╠╠╠╠╠╠╠╠╠╠╠╠╠╠██████╠╠╠╠║████████▒╠╠╠╠╫███╠╠╠╠╠╠╠╠╠╠╠╠╠╠╬████████████    //
//    ████████████╠╠╠╠╠╠╠╠╠╠╠╠╠╬█████╠╠╠╠║███████▀╠╠╠╠▄███▌╠╠╠╠╠╠╠╠╠╠╠╠╠▓█████████████    //
//    █████████████▒╠╠╠╠╠╠╠╠╠╠╠╠╟█▌░░╠╠╠╠╠░░░░░░╠╠╠╠▄█████╠╠╠╠╠╠╠╠╠╠╠╠╠███████████████    //
//    ██████████████▒╠╠╠╠╠╠╠╠╠╠╠╠╬███████████████████████╬╠╠╠╠╠╠╠╠"╙╙╙████████████████    //
//    ███████████████▓╠╠╠╠╠╠╠╠╠╠╠╠╬████████████████████░╠╠╠╠╠╠╠╠╠╠    ███    ╫████████    //
//    █████████████████╠╠╠╠╠╠╠╠╠╠╠╠╠╠╬██████████████╬░╠╠╠╠╠╠╠╠╠╠╠▒    ███    █████████    //
//    ██████████████████▒╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╬╬╬╬╬╬╬╬╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠    ]██▌    █████████    //
//    ███████████████████▒╠╠╟█╫▓╠╠▓▌╠▓▓╫▓╫▓▓Φ╫▓╬╠▓▌▓▓╫╣▓▄▓▒▓▓▓╬╠╬    ╟██▌   ▐█████████    //
//    █████████████████████╠╟█╣█▒▓██▓█▌█▌╫██▓╫█▓▌█▌██▓▒█╬█▒███╠╣█    ███    ██████████    //
//    ██████████████████████╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠▓█▌    ███    ██████████    //
//    ███████████████████████▒╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠╠███▌   ▐██▌    ██████████    //
//    █████████████████████████▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▄▓██████████████████████████    //
//    ████████████████████████████████████████████████████████████████████████████████    //
//    ████████████████████████████████████████████████████████████████████████████████    //
//    ████████████████████████████████████████████████████████████████████████████████    //
//    ████████████████████████████████████████████████████████████████████████████████    //
//    ████████████████████████████████████████████████████████████████████████████████    //
//    ████████████████████████████████████████████████████████████████████████████████    //
//    ████████████████████████████████████████████████████████████████████████████████    //
//                                                                                        //
//                                                                                        //
////////////////////////////////////////////////////////////////////////////////////////////


contract DankliensDV2 is ERC1155Creator {
    constructor() ERC1155Creator() {}
}