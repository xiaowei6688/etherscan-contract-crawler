// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Eli Leno Art - Editions
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                        //
//                                                                                        //
//    @@@@@&, ,(#%%#/%%#/#%#/*(#(%*#%#%**,/,,**,*%,*#*,***..***,(,##**(/(#,.#.*,*&%(%(    //
//    @@@@@@@/(*/#,*(###/###%#/(///(%&#@&(&#%*.,///*,/,,((,,.,,,*#(,**,**(%*./@@@@%/#(    //
//    @@@*,*@#@#(#(/%##,#(*,/&#(***(.**,,((/@***,//*//,.,,,..,,#(*(,,*,,//&/(@@@@@#@@@    //
//    @@@%/@@@//#/#/*#**(*/*/*#((//*,&&@(#@@@/#((*,*/,/,,,*,*#*#%&&/,***(,,#/%&.(,*#,&    //
//    @@@@%@(*#*/*,*//*(,,,/*(#(*/(%#/&@(%@&#&@@@@*(/(*(///*(,. .,%*/##/.#/*(%//((,(,#    //
//    @@&@%&**(*///,*#&##///*,/%**&&&%&@#,,.,&@@@@#@&@&&,/#(#*...,#*%(,/.%%%##/(/*#,(#    //
//    /,,@@%/&((*(//*#%,@@,,,*.&&@@@@&/&&&#,(&&@@@@@@@@&&%%@,%#,#&,(*/,,,#&%#*%/#/(/,,    //
//    @@@@%**&%,,%(%*%/@@,//***/&/@&&@&&##&&&@@@&@@@&#%&,,**%#%##*/#&**,*#(&*/##,.*%*#    //
//    @@@&./,,***,,,,*((@(&&&&&&&&@/*(#(&,&&&&,&@&&&,(%#&&@@*&/*(*(#/##%/*&(/%&,@@,%@@    //
//    @@@/****,*,,,,,.*&@&//&&&(%&@&*..(.,.%%.(&#..#(.(%@&@@&,/(#(,,.((/*(((//,,*,*&@@    //
//    @%,,***,,***,.,,(,*,////%&@&@&...  ..   .(   ,. .#&@@&#,(.,,(,%#./(#(,*,.....,,,    //
//    @,.,(,,*/,,***,.,,,/@@(*/&&&@&.....             .##.,(%,,(**#%#*,,/(,(&%,...,,**    //
//    @@/*.***/,***,,,,/,.,%(*%@&&&,(%&&&&&&   #&&&&&%%%%@*%*(%#*%(,(##((,(#((/%(%&&(/    //
//    @@///*****(*(*,.*#&#/***(..#&..,(#//... .,./%.* (,%,,.%/ ..,##/(&(*@&(/.**,*****    //
//    @@@@*,//.,(,,,,,.,#%*/###%/,#.........*.,.. .. ...,,.&((...%#***.,/(#/***,*//,[email protected]    //
//    @@@@@@@%%,,,%@@/,*,**/%#/%%,.,......,....... . ..#*(##*(#/,/#(/#(#(*,,,,,*/,//*@    //
//    @@@@@@@%*(*,,%*#%/((,(/&//&(//,......../.,.  ...,%#(%*%(#&###,**#*,(@*..,.,,,@@@    //
//    ##%%%##(%@&&&&/,,/##//#&@#/((#,,...............,,*#(.,****..(,,.*,*.,&,%@@@&@@@@    //
//    #((#,,*/%%#@@.//(/(#//*/#*%/,##......,,,,......,(/,*(,....#(/%/[email protected]@&((.,.,*/,.(@@    //
//    ##(//#%#(##/#((,//((/(,/((%((/#*(....,,,..*(,.,*#@&(,((((&%#,&@@..,*,[email protected]@&*(,.,*%    //
//    @@@@@%#(#&#/&/((/((((((#,.%%/#%**,(........./,/,#/,*,%@@&(*..,.%@@,%*[email protected]*.*,..,@    //
//    #@@(%%,#%(,*(*#(%#((((((.(#/***,,,.,**//**,,,*,/*(///&@@##(,/*,...,#@@&/(@@@@@@@    //
//    @@@@*@(@*#@@@(,,(((((((.#.../**,,,*..,.....,,,,,,,**..%@*&@/*,,....,#@.%.(@@@@@@    //
//    *,(&@@&@@%%/*#*&#%##%##,,.(**,,,,,,,,.....,,,...,,,**..,#/@&*,/****/@@@@@@@&@@@@    //
//    #@@&@@@@@@@@&/                                                     %/(%(,*(%&&@@    //
//    @@@@@@@@@#*,(*     @@ @( @@   @@/     *@@   @@ @( @@  @  @[email protected]%      @@@@#,..*%,,(    //
//    @@@@@@@%**////     @@,@  @@   @@,      @@   @@,@  (@@@  @@ *@@     .,@@*,*/(@@@@    //
//    @@,,,,,(***,**     @@ ,@ @@ @ @@(      @@ @ @@ ,@ @  @(  @ @@      (*.,&@&/(//@@    //
//    @,,,,,,/,**(//                                                     ///..,(@@((#(    //
//    &,,,,...*((/#((..*,......*@,,%@@*.*...**,....#@@@@(#,.*/.*#%*//(((((##....##@@@@    //
//    #,,,,,,....,#.,../,,///..(/,,.##.,(*,(%#(.,(#%,.,/*.,*/*..,/(/#(/(/(/(,#...#@@@@    //
//    (,,,,.,.....*..,,*/((/[email protected]@@@/.*((#/@*#*,,*( #@@&..*,..,*/*,..*((,..(,*****@@(@    //
//                                                                                        //
//                                                                                        //
////////////////////////////////////////////////////////////////////////////////////////////


contract elae is ERC1155Creator {
    constructor() ERC1155Creator("Eli Leno Art - Editions", "elae") {}
}