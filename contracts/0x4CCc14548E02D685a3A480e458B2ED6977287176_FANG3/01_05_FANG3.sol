// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Cryptofangs Anemic Royalty
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                            //
//                                                                                                            //
//                                                                                                            //
//    ░█████╗░██████╗░██╗░░░██╗██████╗░████████╗░█████╗░███████╗░█████╗░███╗░░██╗░██████╗░░██████╗            //
//    ██╔══██╗██╔══██╗╚██╗░██╔╝██╔══██╗╚══██╔══╝██╔══██╗██╔════╝██╔══██╗████╗░██║██╔════╝░██╔════╝            //
//    ██║░░╚═╝██████╔╝░╚████╔╝░██████╔╝░░░██║░░░██║░░██║█████╗░░███████║██╔██╗██║██║░░██╗░╚█████╗░            //
//    ██║░░██╗██╔══██╗░░╚██╔╝░░██╔═══╝░░░░██║░░░██║░░██║██╔══╝░░██╔══██║██║╚████║██║░░╚██╗░╚═══██╗            //
//    ╚█████╔╝██║░░██║░░░██║░░░██║░░░░░░░░██║░░░╚█████╔╝██║░░░░░██║░░██║██║░╚███║╚██████╔╝██████╔╝            //
//    ░╚════╝░╚═╝░░╚═╝░░░╚═╝░░░╚═╝░░░░░░░░╚═╝░░░░╚════╝░╚═╝░░░░░╚═╝░░╚═╝╚═╝░░╚══╝░╚═════╝░╚═════╝░            //
//                                                                                                            //
//                                                                                                            //
//                                                                                                            //
//    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    //
//    ,,,,,,,,,,,,,,,,,,,,,,*,,******/////////****//////////////////////////////////////////////////////((    //
//    ,,,,,,,,,,,,,,,,,,.............,,,,,,,,,,********************************///////////////////////////    //
//    ,,,,,,,,,,,,,,,,,,,,,,,,,.......,,,,,,,,,,,.,..,,************************************/////////////#%    //
//    ,,,,,,,,,,,,,,,,,,,,,,,,,,,,...,..,,,,,,,....,,,,,,,,,,,,,,,,,,,,,,,,,********************///#(%#%&%    //
//    **,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,*,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,*************(//(###(    //
//    ***********,,,,,,*******,,,,,,,,,,,,,,,,,,,,,,**,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,***/*/(%%%%    //
//    **///////*********************,,,,,,,,,,,,,,,,*/.,,,,,,...............,.,,.,,,,,,,,,,,,,,,*/#(/#(##%    //
//    ////////////******************,*,,,,,,,.....,**,........................................,(*(((#%%(#%    //
//    **///////******************************,,,,,*/(,,,.............. .........................,,,*(&%%(%    //
//    ......,,,,,.........,,****,,,##,...,***/(/*****,,,...........................,,,,...   .,,(,//%%#/%%    //
//    ,,,,,..,,,,,,,,,,,,..........*/(*,./((####(****/*,.......,,...................,,,,/,,/...**####%%#/,    //
//    *******,,,,,,,,,,,,,,......,..,(***###%%%%/***(##(,,,,,**(/,,,,,,,,,,,,,,,,,,,**,,,,,,*(*#(%(#/((##%    //
//    ,,...............,,,,,,,,.,.,,,(#(*,,,.,,,,,,,,,,..,,,/#**,,,,*,,,,.......,(*/,/,,,..,,,*/##/(##((##    //
//    #(##((((((////**/*******,,,,,,*%(,,,//*&%*/**,,,,,,,##%#%#(%*.,...........,....,/..,,**,,//###/*,,*(    //
//    %%%%%%%%%#%%##%%#%########(((#%#*****,**/*/*,,,,,,,,..*&%%%&%#%/(///////////*,***/#/(*///(**(#*/(*/(    //
//    %%%%%%%##(#####%#######%#####%%********,,,,,,,,,,,,,,,,...#%%#%####(((((((((##%######(%%####%%((%###    //
//    ###%%#####(#####(((##(((#(###%**********///****,,,,,,,,,,,,,*%%%(#(((((#############(#%%%%%#%%#%%%%&    //
//    %%%%#%#%#%%%#%####((/(#((####**********/*///((/***,,***,**%%%%,*(####(######%%####%%%%%%#%%%%%%%%%%%    //
//    %%%%%%########(##//(%%#%##%%***///**/***/////////*,,***(#((((/(/*,##########%%%%%%%%%%%%%%%&%%%%%%%%    //
//    ##%#########(##((###(#%%#%%#*****/////***//(//////*,*((/////*******,%########%%%%%#%%#%#%%%%%%%%%%%%    //
//    ###((((((((#%%%%%%%%#%%##%#**,******/(####(((((((((#((//,(#%%%%%%%%##%###%%%%%%%%%%%####(%%%%%%%%%%&    //
//    &&&&%%&&&%####%%%%%%%%%%&%&***,,*****//(#%%%%%#%%%%%%%%/****//%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    //
//    %&&%%%%%&%%%#%%%%%%%%%%&&&&&&&&%,**/(///((((((//&&&&&&&%%%%#/*/%%%%%%%%%&%%%%%%%%%%%%%%%%%%&&&&%%&%%    //
//    ########%%%%%%%%%%%%&&@&@@@&&&&&&&&@&@&@%###%@@@@@@@@@&&&&&%&&%&%&&&%%%%%%%%%%%%%%%&%%%%%%&%%&&&&&%%    //
//    ###%##%&&&%%&%%%&&&@@@@&&&@&&@@&@@&&&@&%(((##@@@@@@@@@@@@&%%%%&&&&%%&%%%%%%&%%%%&%%%&%%&%&%%&&&&%&&&    //
//    &&%&&&&&%##&&%%&&@@@@@&@@&@@@@@@@@@@&&&&@%(#%@@@@&&@@@&@&&&&&&&&&%&&&&%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%    //
//                                                                                                            //
//                                                                                                            //
//                                                                                                            //
//                                                                                                            //
//    ░█████╗░███╗░░██╗███████╗███╗░░░███╗██╗░█████╗░                                                         //
//    ██╔══██╗████╗░██║██╔════╝████╗░████║██║██╔══██╗                                                         //
//    ███████║██╔██╗██║█████╗░░██╔████╔██║██║██║░░╚═╝                                                         //
//    ██╔══██║██║╚████║██╔══╝░░██║╚██╔╝██║██║██║░░██╗                                                         //
//    ██║░░██║██║░╚███║███████╗██║░╚═╝░██║██║╚█████╔╝                                                         //
//    ╚═╝░░╚═╝╚═╝░░╚══╝╚══════╝╚═╝░░░░░╚═╝╚═╝░╚════╝░                                                         //
//                                                                                                            //
//    ██████╗░░█████╗░██╗░░░██╗░█████╗░██╗░░░░░████████╗██╗░░░██╗                                             //
//    ██╔══██╗██╔══██╗╚██╗░██╔╝██╔══██╗██║░░░░░╚══██╔══╝╚██╗░██╔╝                                             //
//    ██████╔╝██║░░██║░╚████╔╝░███████║██║░░░░░░░░██║░░░░╚████╔╝░                                             //
//    ██╔══██╗██║░░██║░░╚██╔╝░░██╔══██║██║░░░░░░░░██║░░░░░╚██╔╝░░                                             //
//    ██║░░██║╚█████╔╝░░░██║░░░██║░░██║███████╗░░░██║░░░░░░██║░░░                                             //
//    ╚═╝░░╚═╝░╚════╝░░░░╚═╝░░░╚═╝░░╚═╝╚══════╝░░░╚═╝░░░░░░╚═╝░░░                                             //
//                                                                                                            //
//                                                                                                            //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract FANG3 is ERC721Creator {
    constructor() ERC721Creator("Cryptofangs Anemic Royalty", "FANG3") {}
}