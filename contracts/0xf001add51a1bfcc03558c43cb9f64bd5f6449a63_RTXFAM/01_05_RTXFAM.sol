// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: RTX fam
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                            //
//                                                                                            //
//                                                                                            //
//        ╬╣██████████╬╬╬╬╬██████╬╬╬╬╬╬╬╬█████████▓╬╬███████████╬╬╬╬╬██████╬╬╬╬╬╬╬╬▓██████    //
//        ╬╣████████▓╬╬██▓╬╬╬████╬╬████╬╬╬████████▓╬╬█████████╬╬╬██▒╬╬█████╬╬╣███▒╬╬██████    //
//        ╬╣███████╬╬╬█████╬╬╬███╬╬█████▒╬╬███████▓╬╬████████╬╬▓█████╬╬╬███╬╬╣████▒╬╬█████    //
//        ╬╬╬╬█████╬╬╬╬╬╬╬╬╬╬╬╣██▒╬╬██████╬╬╬████╬╬╬╬╬╬╬╬█████╬╬╬╬╬╬╬╬╬╬╬╣██╬╬╬██████╬╬╬██    //
//        ███╬╬╬███████╬╬╬█████████╬╬╬███╬╬╣████▓╬╬█████╬╬╬███████╬╬╬█████████╬╬╬███╬╬╣███    //
//        ████╬╬╫██████▒╬╬██████████╬╬╬▓╬╬██████▓╬╬██████╬╬╣██████╬╬╬██████████▒╬╬█╬╬█████    //
//        ╬╬╬╬╬▓███████▒╬╬███████████╬╬╬╬███████▓╬╬╬╬╬╬╬╬╬▓███████╬╬╬███████████╬╬╬╬██████    //
//        █▒╬╬█████████▒╬╬██████████╬╬╬▒╬╬██████▓╬╬▓██▒╬╬█████████╬╬╬██████████╬╬╬▒╬╬█████    //
//        ██▒╬╬████████▒╬╬█████████╬╬▓███╬╬╬████▓╬╬████▓╬╬████████╬╬╬█████████╬╬▓███╬╬╬███    //
//        ███╬╬╬███████╬╬╬███████╬╬╬██████╬╬╬████╬╬█████╬╬╬███████╬╬╬███████▒╬╬██████╬╬╬██    //
//        ▒╬╬████╬╬╬╬╬╬╬╬╬╬████╬╬╬╬╬╬╬╬╬╬╬███▓╬╬╣████╬╬╬████╬╬╬╬╬╬╬╬╬╬████╬╬╬╬╬╬╬╬╬╬╬███▓╬    //
//        ╬╣█████╬╬╬█████╬╬╬███████╬╬╬█████████╬╬╬██╬╬╬█████╬╬╬█████╬╬╬███████╬╬╬█████████    //
//        ███████╬╬╬█████╬╬╬███████╬╬╬██████████▒╬╬╬╬███████╬╬╬█████╬╬╬███████╬╬╬█████████    //
//        ███████╬╬╬╬╬╬╬╬╬▓████████╬╬╬██████████▓╬╬╬╬███████╬╬╬╬╬╬╬╬╬▓████████╬╬╬█████████    //
//        ╬██████╬╬╬███▒╬╬█████████╬╬╬█████████╬╬╬█▓╬╬██████╬╬╬███▒╬╬█████████╬╬╬█████████    //
//        ╬╬╬████╬╬╬████▓╬╬████████╬╬╬████████╬╬▓████╬╬╬████╬╬╬████▓╬╬╣███████╬╬╬████████╬    //
//        ██▓╬██████████████╙▀▀▀▀▀▀╙╨▓████▀▀╙╙╙╙▀▀▀▀▀██▌╙▀▀██████▀▀▀▓██╬██████╬╣███████╬╬╬    //
//        ████╬╬╬████╬╬╬████   ▄▄▄▄   ╙███▄▄▄▄   ▄▄▄▄████   ████   ████╬╬╬▓▓▓▓▒╬╬╬███▓▓▓▓╬    //
//        █████▓╬╬██╬╬▓█████   █████   ╟██████   █████████µ  ╙▀  ▄█████╬╬╬█████▒╬╬███████╬    //
//        ███████╬╬╬╬███████   ▀▀▀▀▀   ███████   ██████████▌    ███████╬╬╬█████╬╬╬███████╬    //
//        ██████╬╬╬╬╬╬██████   ,╓,   ▓████████   ██████████     ╙██████╬╬╬▓▓▓╬╬╬█████████╬    //
//        █████╬╬▓██▒╬╬█████   ███▌   ████████   ████████▀  ╓██   ▀████╬╬╬████╬╬╬████████╬    //
//        ███▒╬╬█████▓╬╬╣███   █████   ███████   ███████─  ▄████▄  ╙███╬╬╬█████╬╬╬███████╬    //
//        ╬╬╬╬╬╬╬╬╬█████╬╬╬╬▓▓▓╬╬╬╬███▓▓╬██████▓▓╬█████╬▓▓╬╬╬╬╬█████╬╬╬╬╬╬╬╬╬╬╬╣██▓╬╬╣████    //
//        ╬╬╬█████╬╬╬███████╬╬╬████████▓╬╬╣███╬╬██████▓╬╬▓████▒╬╬███████▒╬╬█████████╬╬╬███    //
//        ╬╬╬█████╬╬╬███████╬╬╬██████████╬╬╬▒╬╬███████▓╬╬██████╬╬╫██████▒╬╬██████████▒╬╬▓╬    //
//        ╬╬╬╬╬╬╬╬╬╬████████╬╬╬███████████╬╬╬╬████████▓╬╬╬╬╬╬╬╬╬▓███████▒╬╬███████████╬╬╬╬    //
//        ╬╬╬███╬╬╬█████████╬╬╬██████████╬╬▓▒╬╬███████▓╬╬▓██▒╬╬█████████▒╬╬██████████╬╬╬▓╬    //
//        ╬╬╬████▒╬╬████████╬╬╬████████▒╬╬███▓╬╬╬█████▓╬╬████▓╬╬╣███████▒╬╬████████▓╬╬████    //
//        ╬╬╬█████╬╬╬███████╬╬▓███████╬╬╣██████╬╬╬████▓╬╬█████╬╬▓███████▒╬▓███████╬╬╬█████    //
//        ╬╬╬╬╬███▓╬╬╣████╬╬╬████╬╬╬╬╬╬╬╬╬╬████╬╬╬╬╬╬╬╬╬╬╬███▓╬╬╣████▒╬╬█████╬╬╬╬╬╬╬╬╬╬███    //
//        ╣█████████╬╬╬██╬╬▓█████╬╬╬█████╬╬╬███████╬╬╣█████████╬╬╬██╬╬▓██████╬╬█████▓╬╬╢██    //
//        ╣██████████▒╬╬╬╬███████╬╬╬█████╬╬╬███████╬╬╣██████████▒╬╬╬╬████████╬╬█████▒╬╬███    //
//        ╣██████████▒╬╬╬╬███████╬╬╬╬╬╬╬╬╬█████████╬╬╣██████████▒╬╬╬╬████████╬╬╬╬╬╬╬╬▓████    //
//        ╣█████████╬╬╣█▓╬╬██████╬╬╬███▒╬╬█████████╬╬╣█████████╬╬╬█▓╬╬╣██████╬╬████╬╬╬████    //
//        ╣███████▓╬╬█████╬╬╬████╬╬╬████▓╬╬████████╬╬╣███████▓╬╬█████╬╬╬█████╬╬█████╬╬╬███    //
//                                                                                            //
//                                                                                            //
//                                                                                            //
//                                                                                            //
//                                                                                            //
////////////////////////////////////////////////////////////////////////////////////////////////


contract RTXFAM is ERC1155Creator {
    constructor() ERC1155Creator("RTX fam", "RTXFAM") {}
}