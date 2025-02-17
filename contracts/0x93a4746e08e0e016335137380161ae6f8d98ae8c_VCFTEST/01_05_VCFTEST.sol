// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: VCFTEST
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                            //
//                                                                                            //
//                                                                                            //
//        ╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╢╢╣╣╣╣╣╢╢╢╣╣╣╣╣╣╣    //
//        ╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╢╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╢╣╣╣╣╣╣╣╣╣╢╢╣╣╣╣╣╣╣╢╢╣╣    //
//        ╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╢╣╣╣╣╣╣╣╣╢╢╣╣╣╣╣╣╣╣╢╣╣╢╢╢╣╣╢    //
//        ╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╢╣╣╣╣╢╢╣╣╣╣╢╢╢╣╢╣╣╣╢╣╣╣╣╢╣╢╢╢╢╢╣╣╢╣╣╣╢╢╢╣╣╢╣╣╢╣╢╢╢╢╢    //
//        ╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╢╣╢Ñ╩╙"              `╙╨╩╣╣╣╣╣╣╣╣╢╣╢╣╣╢╢╢╢╣╢╢▒╢╢╣╣╢╢╢╢    //
//        ╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╝"     ,╓╦╗@@@@Ñ@@@Mm╖,      ╙╣╣╣╣╢╢╣╢╢▒▒▒╢╣╢╣╢╢╣╣╣╣╢╢╢    //
//        ╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣Ñ"    ╓@╣▒╣╣╣╣╣╣╣╢╢╢╢╣╣╣╢╣╣╣╣╬@╗,   `╩╢╢╢╢╣╣╣╢╢╢╢╢╢╢╢╢╢╢╢╣╢    //
//        ╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╬╜   ╓@╣╣╣╣╣╣╣╣╣╢╢╣╣╣╣╣╣╣╣╣╣╣╣Ñ╬╣╬╣║║[~   "╣╣╣╣╣╢╢╣╢╢╢╢╣╣╢╢▒▒╢    //
//        ╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╢╬"  ,╦╣╣╣╣╣╝╠╣╟╣╢╣╣╣╣╣╢╣╣╣╣╣╣╣╩@╢╢╣╣╣╣╣╣╣▒Φ┐   ╩▒╢╢╢╣╣▒▒▒╢▒▒▒╢╢╢    //
//        ╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣┘  ,Ç╨╩╬╢╣▐▄█████║╣╣╣╣╢╢╣╣╢╢╢╢ÑU╟╬╣║║╚╬╣╢╣╣%╣╬╕   ╫╢╢╢╢▒▒▒╢╢╢╢╣╣╣    //
//        ╣╣╣╣╣╣╣╣╢╣╣╣╢Ñ   @╣╣@╦╣╬╢Ü▀████▐╢╣╢╢╢╢╢╢╢╢╣╣[╣╣╣╣╢╢╣╢[╣╣@▒╫╣╜▒╬,  ╙▒╢╢╣╣╣╣╣╣╣╣╣╣    //
//        ╣╣╣╣╢╣╣╣╣╣╣╣╜  ┌╣╣╬╬║,]╬╣╣╣╣╢▄██▄╬▒▒╣╣╣╢╢╢╣╣╢╣╣@╣╢╣╣╣@╢╢╣╣║╢h▒╢╣W   ╣╣╣╣╣╣╣╣╣╣╣╣    //
//        ╣╣╣╣╣╣╢╢╣╣╣╛  ╓╢╢╢╣╢╢╣╣ ║╣╢▒╢╢╣µ███▄╝╣▒╢╢╣╢╢╣╣╣╣╢╣╬╢╢╢╣╨╣╣╣%╣╣╣╣╣╬   ╣╣╣╣╣╣╣╣╣╣╣    //
//        ╢╢╣╣╣╣╣╣╣╣╝  /╣╣╣╢╢╢╣▒╦╬╢╢╢╣╢╢╢╢P██████▄╫╣╣╢▒Ñδ╣╩╢║╣╣╢╣╣╟╣╣[╢╢╣╣╣╣╬   ╣╢╣╣╣╣╣╣╣╣    //
//        ╣╣╢╣╣╣╣╣╣╬   ╣╢╢╢▒▒╢╣╢╣╢╢╢╣╣╣╢╣▒╬████████▄║╫║╟@╬╣╢╣╫╢╢╣▒╣╢║@╣╣╣╣╣╣╣K  ╚╣╣╣╣╣╣╢╣╣    //
//        ╢╢╣╣╢╢╢╣╢∩  ╫╢╢╢╢╢╣╢╢╣╢╣╢╢╢╢╢╣╣╢╣▀█████████▄╣╣╣╣╣╣╢╣@@╬╣╣╣╣╣╣╣╣╣╣╣╣╣   ╣╣╣╣╣╣╣╣╣    //
//        ╢╣╢╣╢╢▒╢╢   ╣╢╢╣@╣╢╢╢╢╢╢╢╣╢▒╢▒╢╢▒╣╫█████████▌╫╢╢╣╣╣╣╣╣╣╣╣╣╢╣╣╣╣╣╣╣╣╣Ç  ╟╣╣╣╣╣╣╢╢    //
//        ╢▒╢╢╣╣╢╣╣  j╣╢╢╢╢╩╢╣Ü╢╢╢╢▒▒▒╢╢╣╣╢╢╢@▀████▀@╣▀█▄╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╢╣╣  ]╢╣╣╣╣╣╢╢    //
//        ╣╢╢╢╣╣╢╢╢   ╙"``"╙╣╣╬╣╢╢▒╣╩╩╠▄▓▓▓▓▓▓▓▓▓██p▓▓▓▄▀█▄╬╢╣╣╣╣╣╣╣╣╢╣╣╣▓╩╨╨╨╨  ]╢╢╢╢╢╢╢╢    //
//        ╢╢╢╢╢╢╢╢╜ ,▄▄███▌ └╣╠▄▄æφ▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▄█▄▓▓▓▓▓██▌╩╢╣╣╣╣╣╣╢╢╢` ▄▄▄▄▄▄, ╚╣╢╣╢╢╢╢    //
//        ╣╢╣╣╢╢▒╢L ╙▐▀▌ ╙▐  ╫╬▓▓▓▓▓▓▓▓▓╣@@╬▓▓▓▓▓▓▓▓▀█▄▌▓▓▓▓▄▓▓╬╩╣╣╣╣╣╢[ ▐▄  ▐    ╫╢╢╢╢╢╢╢    //
//        ╢▒╢╢╢▒▒╢╣L ▐ ╙█▄█U ╚╣╣╣╣╣╣╢╝▓║╣╣╣╣▐▓▓▓▓▓▓▓▓███▐▓▓▓▓▓▓▓▓▄╟╢╢╢╣"  ████▄, ╚╢╢╢╢╢╢╢╢    //
//        ╢▒╢╢╣╣╣╣╣╬  █  ▀█▄▄ "╣╣╣╣Ñ╫╘▓▓╬╣╣╢▐▓▓▓▓▓▓▓▓▓@▓▓▓▓▓▓▓▓▓▓▓▓▓Ñ▓═ ▐██▄▀▀█` ╟╢╢╢╢╢╢╢╢    //
//        ╣╣╣╣╣╣╣╣╣╣╬   ▄██▀▀  ╩╬╣╣Ç▓▓▓▓▓▓Ä╩N╙▓╬@╬▓▓▓╬╬@╬╣▓▓▓▓▓▓▓▓▓▓▓W ▄███▀▀▀  ╬╣╢╢╢╢╢╢╢╢    //
//        ╣╣╣╣╣╣╣╣╣╣╣╬  █     ▄  ╙╬╣Q╩▓▓▓▓▓▓Æ╬╣╣╣╣╢╢╢╢╢╢╢╣╢╢╣╣▓╬▓▓▓▓▓▓▓   ▀▌  ╔▓╢╢╢╢╢╢╢╢╢╢    //
//        ╣╣╣╣╣╣╣╣╣╣╣╢╬  ▀∞4▀███▄▄  ╫╢╢▓▓N╠▓▓N╣╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╩` ▄▀▓▓▓W  ▌ ╠╣▓▐╢╢╢╢╢╢╢╢╢    //
//        ╣╣╣╣╣╣╣╣╣╣╣╣╣╢N   ▐█▀   █  ╝╜╨╬╣╢╢╢╢╣╢╢╢╢╢╢╢╢╢╢╢╢╢╢▓`  ▄█   "▓▓▓` ,$▓▓Q╢╢╢╢╢╢╢╢╣    //
//        ╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣▓╖  █ "▄     ▄▄   ╚╨╩▓╢╣▓▓▓▓╩╩▓╢▓`    ██▄██▄  █  ╠╟╫▓╬▓╣╣╢╢╢╢╢╣╢╢    //
//        ╣╣╢╣╣╣╣╣╣╣╢╣╣╢╢╣╢▓,  ▀▀    ██` ▀▄ ▄▄    ▄  ▄▄ ╚▓  ██▀"▀██▐▀▀╙ ,▓╢╢╢▓▓▓╣╣╣╣╣╣╣╣╣╣    //
//        ╣╣╣╢╣╣╣╢╢╢╣╣╢╣╢╣╢╣╢▓@,    █▀"▀▀▀▀██   ▐▐█  ██  ╢╕ ▀█▄   ▀  [email protected]▓╣╣╣╢╣╣╢╢╣╣╣╣╣╣╣╣╣╣    //
//        ╣╣╣╣╣╣╣╢╢╣╢╢╢╣╣╢╢╢╢╢╢╢╣@, `      ██  ,█¬█⌐ ▐█      ▐▀  ╓@▓╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣▓▓▓    //
//        ╣╣╣╢╢╢╢╢╣╢╣╣╢╢╢╢╢╢╢╢╢╢╢╢╢▓▓@╦╖,   ╙""   █∞ⁿ"▀▀╙   ,╥╦@▓╢╣╣╣╣╣╣╣╣╣╣╣╣╣╣▓▓▓▓▓▓▓▓▓▓    //
//        ╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢▓@@@gg╥,╓╥g╗╦@▓╢╢╣╣╣╣╣╣╣╣╣╣╣╣╣╣╣▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓    //
//        ╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╣╢╢╢╢╢╢╣╢╣╣╢╢╢╢╣╣╣╣╣╣╣╣╣╣╣╣╣▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓    //
//        ╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╣╣╢╣╣╢╢╢╣╣╣╣╣╣╣╣╣╣╣▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓    //
//        ╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╢╣╢╣╣╣╢╢╢╣╣╣╣╣╣╣╣╣╣╣╣▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓    //
//                                                                                            //
//                                                                                            //
////////////////////////////////////////////////////////////////////////////////////////////////


contract VCFTEST is ERC1155Creator {
    constructor() ERC1155Creator("VCFTEST", "VCFTEST") {}
}