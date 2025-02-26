// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: prisvisuals.eth - open editions
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

//////////////////////////////////////////////////////////////////////////////////
//                                                                              //
//                                                                              //
//    ...............,,,..................................,.................    //
//    ..............:*?*:...............................:***,...............    //
//    ..........,;+:;???*;**:.......................:+*;+%?%;:;;,...........    //
//    ..........*%??+???*????,.....................,????*???+??%*...........    //
//    ..........????*???*???%,.....................,????*???*????...........    //
//    .......,:,*???+???*????,.....................,????*???*???*,:,........    //
//    ......:??**???+???*???%,.....................,????*???+???**??:.......    //
//    ......+%??*???+???*????,.....................,????*???+???*??%+.......    //
//    ......+%??+???*???????%,.....................,????????*???*??%+.......    //
//    ......+%??*???????????%:...:+***+:.,;+*+;,...:%???????????*??%+.......    //
//    ......+%???????????????*;;+???%%S?,?S%%???+::*???????????????%+.......    //
//    ......;%????????????????????%%*;:,.,:+?%%????????????????????%+.......    //
//    ......:%??????????????????%%+,.........,+%???????????????????%:.......    //
//    ......,??????????????????%%:.............:%%??????????????????,.......    //
//    .......+%???????????????%?,...............:?%???????????????%+........    //
//    .......,*%%???????????%%+,.................,*%%???????????%%*,........    //
//    .........;S%%%%????%%S?:.....................:%S%%????%%%%S+..........    //
//    .........,%S%%?????%%S*.......................*S%%?????%%S%,..........    //
//    .........,%%?????????%+.......................+%?????????%%,..........    //
//    .........,%%?????????%+.......................+%?????????%%,..........    //
//    .........,%%%???????%S*.......................*S%???????%%%,..........    //
//    .........,+++++;;;++++;.......................;*+++++++++++,..........    //
//    ......................................................................    //
//    ........+SSSSSS%+,.......?SSSSSS?;........;%?,.......:*SSSS%+,........    //
//    ........*@#****[email protected],[email protected]****#@%,[email protected]#,......*@@?++*%*,........    //
//    ........*@S....,@@;[email protected]*....;@@:[email protected]#,......%@%,..............    //
//    ........*@#???%#@%,[email protected]???%#@*[email protected]#,......:%@@S?*;,.........    //
//    ........*@#????*:[email protected]??#@#:[email protected]#,........,;*%#@#+........    //
//    ........*@[email protected]*..,[email protected]?,[email protected]#,......,,,....;@@:.......    //
//    ........*@[email protected]?...,[email protected]%,[email protected]#,......+##?*+?#@%,.......    //
//    ........+%?..............*%+....,?S+......;%?,.......:*%SSS?;.........    //
//    ......................................................................    //
//                                                                              //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////


contract PRIS is ERC1155Creator {
    constructor() ERC1155Creator("prisvisuals.eth - open editions", "PRIS") {}
}