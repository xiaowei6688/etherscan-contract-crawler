// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: MEMEBOOK
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                        //
//                                                                                        //
//    ..............................................................................      //
//    .* .  ..............................*#*.........................................    //
//    ..,############################################################################.    //
//    . ,###########################(((((((#((((((((((((((((((((//(#(################.    //
//    . ,#######################(((/#(***********.,,**((%&.%%%%%%%%%%%#//(###########.    //
//     .,####################((((((((************..,     *(#%%(/((/(((%#/#((#########.    //
//     .,###################(/////(*******#****/*,., @# .#%*%(/(((((((/(///(#(#######.    //
//    ...#################(//,///*(( *********&**,,   , * ( %(/((((((#/(///(((#######.    //
//    ...###############((***.***//(.***(**&%%%*,,(  #  (,/#%%%((#/((%/#////(((######.    //
//    ...##############(///******/,,**(****/#(,,,,,(  ,#.*(%%%%%#&,/@@@,/////(((#####.    //
//     ..#############(////*************/,(./ (/,.,(.%#//,./.%%%%%%%%%,////////((####.    //
//      .#############/////*/*******,,,**,, ,/.((/*.,//,*(*(*(#%@%%%&#(*/////(((#(###.    //
//     . ###############//////****,,**,,**,,(%(*%/.,,/,(*(. ,,.,,,,,,,,//////(#(((###.    //
//     ..###############(///**/**,,,,//**,*****/////*/****************///(#(#(((#####.    //
//     ..###############(////////*/****///*//////,,* ///***////******/((#(((#########.    //
//     ..################((//////////********/***,*********/#*/**/*(//((#############.    //
//     ..######%((((#(((.###(////***/**/*/*********/#/####%&&%/(%/((/(###############.    //
//     ..######((((((((((#####(//////**//**/*****#%%&&&&&&#%##%%&&###################.    //
//     ..######(((*%, #%(/(#####//////*//***//**(#//%/,***&&&&&&&&%##################.    //
//     ..#####((%((((#((#(*##########///////////##/,,,,,*////%#(#/###################.    //
//     ..#(##((((###(((##((###########//////////###(#*(%%**/////*/###################.    //
//     ..#####((((((((,(*#(##############((/(//####/(**/////////#####################.    //
//     ..##&%%%(%#(((%(((*##########################(%,,**///((**#(##################.    //
//     ..(###%%%%%%%%%%(( ############################%/,*/(#**//,,(**,(#############.    //
//     ..(*,...../...,,..######################%(((/*/**####**/,,,,/....,,.,/########.    //
//     ..#******.....,....####################(#**////(#/((/,###,,,,,,,,.....,***####.    //
//     ..###((((*,....,...,################(/(##/////****#(***/,,*((,,,*..../***/,###.    //
//     ..###/**////,.,/**(##############((/(##,...****/**,*,/,,,,,,,,*,/,..(((//***##.    //
//     ..###/****/**...../#((#########(/####..*@#..../*(/,,,,,,,,,,,,**/,,.(///(/***#.    //
//     ..###**,*/**/.......,,.,,.(%#(/###../....(.,..../(*,*,,,,,*/*,*/((#.((//////**.    //
//     ..,,,/**/****.......,,,........(((/./@............/*,*,,,,,.,,.,*((((/**((*///.    //
//     ..#(#&***(,,*....(.,,//#%//////*/##(#..............#///**,,,,**,*(##((((#((((/.    //
//     ..((/((//(((%(,....,,#((#((#///////###(#***,....*#*###///,,,***,*##/,.*/*/*((#.    //
//     ..(//((((((**..*...#....,****#((((((((#%##(.#/******(/.,,(,,/**.,///((((((#((#.    //
//     ..((/((/**(#*..,,.,...,,,...***//*****/#####(/((//////*,,,*,*//(###########((#.    //
//     ..(/////*/***,...%#,...,............,*******%%####&%&#**//,###,((####%%%%%##/#.    //
//     ..#((//////*/.,....(((#%//,..................*//%%%%%%%#%&&&&&&&%(/////*(%%%%%.    //
//     ..(###((/((//,,....((#((((((%%/*......///%%#((((((((#//%%(/////////(#/////***/.    //
//     ..(((((####((*/****#(##(((#((((((%%%##(((///(((((((..//////#%%#////*/////*/(((.    //
//     ..%%%%%/,,,,,,,,*%/%%%%%%%%%######(((######((((#%##%/.....///////(#%######%%&%.    //
//     ..%%%%%,%%#,%%%%%%%%%%%%%%%%%%%##%#####(######(#%*..#%%%#*....##%%%%&&%%%%%&&&.    //
//    ...................................,..,....................,....................    //
//    ............#.####...*(.*#....(/.#.,../######...#,.#,....#,####,.*######........    //
//    ............#(#/.#../#.,*(,..,,.,#,,..,#,./....,##(#.#..,###*,#..*(.#..#........    //
//    ............#///.#*..#,((#(*..(((#((,.,(..#....,##(//#...#./##/..*######........    //
//    ...................................,..,....................,....................    //
//    ...................................,..,....................,....................    //
//                                                                                        //
//                                                                                        //
////////////////////////////////////////////////////////////////////////////////////////////


contract MEMEBOOK is ERC721Creator {
    constructor() ERC721Creator("MEMEBOOK", "MEMEBOOK") {}
}