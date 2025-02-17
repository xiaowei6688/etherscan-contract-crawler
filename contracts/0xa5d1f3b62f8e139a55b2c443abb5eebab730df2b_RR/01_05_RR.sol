// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: NFVT Pass
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                        //
//                                                                                        //
//    /////////////////////////////////////////////////////////////&&&&&&&&&&&&&&&&&&&    //
//    //////////******/////*****//////////////////////////////////&&&&&&&&&&&&&&&&&&&&    //
//    //////////*****/////*****//////////////////////////////////&&&&&&&&&&&&&&&&&&&&&    //
//    /////***********************//////////////////////////////&&&&&&&&&&&&&&&&&&&&&&    //
//    ////////*****////////////////////////////////////////////&&&&&&&&&&&&&&&&&&&&&&&    //
//    ///***********************//////////////////////////////&&&&&&&&&&&&&&&&&&&&&&&&    //
//    //***********************//////////////////////////////&&&&&&&&&&&&&&&&&&&&&&&&&    //
//    /////*****/////*****//////////////////////////////////&&&&&&&&&&&&&&&&&&&&&&&&&&    //
//    ////*****/////*****//////////////////////////////////&&&&&&&&&&&&&&&&&&&&&&&&&&&    //
//    ////////////////////////////////////////////////////#&&&&&&&&&&&&&&&&&&&&&&&&&&&    //
//    ////////********************///////////////////////*&&&&&&&&&&&&&&&&&&&&&&&&&&&&    //
//    ///////*******///////////////,.,..,&&####&@,..,////&&&&&&&&&&&&&&&&&&&&&&&&&&&&&    //
//    ////////////////////*****,,,&#%%%%%%%%%%%%%%%%%%%&,#&&&&&&&&&&&&&&&&&&&&&&&&&&&&    //
//    /////////////*********,.,%%%%%%%%%%%%%%%%%%%%%%%%%%%#%&&&&&&&&&&&&&&&&&&&&&&&&&&    //
//    //////////////////**.**%%%%%%%%%%%%%%%%.%.%%%%%%%%%%%%%%*&&&&&&&&&&&&&&&&&&&&&&&    //
//    ////******///////*/,,&%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%##(&*&&&&&&&&&&&&&&&&&&&&&    //
//    ///**************,*&%%%%%%%%%/**#@@&&&&@@@&&&&&&%,*/####(/(&#&&&&&&&&&&&&&&&&&&&    //
//    ////////////////,,[email protected]%%%/@@%#####(((#((((#(////////////&&*/%&&&(&&&&&&&&&&&&&&&&&    //
//    ///////////////*&&,@&(&%%######%%%%%%%%%%%%%%#///////////&,&&&&&&&&&&&&&&&&&&&&&    //
//    ////////*******(#@,@(&%%#####%%%%%%%%*(@@@*,%%%//////////#&%&&&&*&&&&&&&&&&&&&&&    //
//    //////////////@&&@@@(%%######%%%%%&@@@@@@@@@@@,//////////*&*&&/&#(&&&&&&&&&&&&&&    //
//    //////******/,%@%@@&/&(######%%%%@@@@@@@@@@@@@@(##/////.,,(%%(%*(,&&&&&&&&&&&&&&    //
//    /////********,%&&&@&/&((#####%&&&&@@@@@@@@@@@@@@#(/(,,,,,.(&&#(,,&&&&&&&&&&&&&&&    //
//    ////******///%&&@&&&@&#,*#%%&(#(#&&@@@@@@@@@@@%%###((,,,,.%,%#((&,&&&&&&&&&&&&&&    //
//    ///******////%&&&&&@&#&#*%%%&&&#&&&&%&&@@@&%########***,,%&@##/@&,&&&&&&&&&&&&&&    //
//    //************%&&&&&@@@(&#,#%&&&&&&&&&/(###*######***,#@&/@&#@@@&*&&&&&&&&&&&&&&    //
//    //////////////%&&&&&@@@@@@(/%@&&@%####&@&&@@##&@&&&@/*@@@@&&@#@&&&&&&&&&&&&&&&&&    //
//    ////////////////&@@@&@@@@@@@%%%%%&&&&&&%#&%&&&&&&%,,/@&&&@@@@&&%&&&&&&&&&&&&&&&&    //
//    ///////*************(@@%&&&@%&#####%%%%%%,,,,,,,,,,@&&&&&@@&&&&&&&&&&&&&&&&&&&&&    //
//    ///////******///////**(@%%&@&@&((((##@&&,,,,%,,,,,&@@@&&&&&&&&&&&&&&&&&&&&&&&&&&    //
//    //////******/////////(&&@%%&@@&&&&((####%%#,,,,,#%&&%,,,&&&&&&&&&&&&&&&&&&&&&&&&    //
//    /////***************((&@@&%%@@&&&&&&&#%%%,,,,#&,,,&&&@#,&(.&&&&&&&&&&&&&&&&&&&&&    //
//    /////////////////***&((#&%%%@&@&&&&&&&&&&&&&&%**,&%%%&,,,&#/&&&&&&&&&&&&&&&&&&&&    //
//    ///******//////.,,#@@@@@((&%%&@@@@&&&&&&&&&%%*,#%%&@&,,.%*,&&&&&&&&&&&&&&&&&&&&&    //
//    //*******,,,,,,,(##@@@@@@@&@(##%&@@@@@@@&@&@&&%%&&@@,,,,&%%,..&&&&&&&&&&&&&&&&&&    //
//    //////,,,,,,,,,((##%&@@@@@@@@@@@@@@@@@@&@&@@@&@&@&&&&&&%%%%,((.....,&&&&&&&&&&&&    //
//    ////,,,,,,,,,..,(##%%%@@@@@@@&&&&&@&&&&&&&&&&&&&&&&&@%%%%%.,............&&&&&&&&    //
//    //*,,,,,,,,,,#%,,,%%%%%&&@@&@&&&&&&&&&@@&&&&@&@@@@%&&&&&,,,,...%..........&&&&&&    //
//    /,,,,,,,,,,,#%%,,,#%%%%%%&&@@@@@@@@@@@@@@@@@@@@@@@&&@%%,,,,....&%........,,/&&&&    //
//    /,,,,,,,%,,##%%,,,%%%%%%%%%%&&&@@@@@@&@&@@@@@@@@@&%&&(,,,,,,,..%%%,,,.,#.,,.&&&&    //
//    ,,,,,,,,,#/#%%%,,,,%%%%%%%%%%%&&&&&&&&%&&&&&&&&&&&%,,,,,,,,....(&%#,,.(,,,,..&&&    //
//    ,,,,,,,,,,#%%%%,,,,%%%%%%%%%&%,,,%%&&&%@&%%%%#,,,,,,,,,,,,,,,..(&%%,,,,,,,,..,&&    //
//    ,,,,,,,,,,,%%%##,,,,%%%%#,,,%%%%%,,,,,/,%,,,,,,,,,,,/%#*,,,,,..(&%%*,,*#,,,...&&    //
//    ,,,,,,,(%#**%&%#,,,,/%%%#,,,,,,,*%%,,,*%#,,,,,,,,,,,,,,,,,,,,..(&%%,,#%#,,,...#&    //
//    ,,,,,,,,(,,**%#%,,%#,*%%%#,,,,,,,,,,#,*@#,,,,,,,,,,,,,,,,,,,,,.#&&%,,#%,,,.....&    //
//                                                                                        //
//                                                                                        //
//                                                                                        //
////////////////////////////////////////////////////////////////////////////////////////////


contract RR is ERC721Creator {
    constructor() ERC721Creator("NFVT Pass", "RR") {}
}