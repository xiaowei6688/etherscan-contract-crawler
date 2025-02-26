// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Editions
/// @author: manifold.xyz

import "./ERC1155Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                            //
//                                                                                                            //
//               ............          ..   .                                                                 //
//                 .  .........       ..                                                                      //
//                 ...  .......           .......    .                                                        //
//             ... ...  .......         ........  ..                                                          //
//            ................          ..  .........                                                         //
//             .... ..........         ...............           .                                            //
//           .. ..... ........... .    ................      ..  ....                           .   ....      //
//      ..   ........................     ................  ... ..... ..     ..        .   ...  ... .. .      //
//     .. ..  ................... ....    .............................  .   ..     ........ . ....... ..     //
//       .............................  .... .............................      .   ... ..................    //
//      ..  .........................  .....  ............................. ..............................    //
//    . ..................................................................................................    //
//    ....................................................................................................    //
//    ....................................................................................................    //
//    ....................................................'...............................................    //
//     ..................................................;oc'.............................................    //
//    ................................................',;lxo:'............................................    //
//    ............................................  ..cxkkxddc............................................    //
//    ...........................................  .'',oOOkxkd,...........................................    //
//    ..........................................   ..,,cdxOkkx:...........................................    //
//    .........................................    ...';cdOOkxc...........................................    //
//    .........................................     ....';xOOxl'..........................................    //
//    .........................................       ....:k0xl;..........................................    //
//    .........................................       ....'oOko:'.........................................    //
//    ................................''...'...        ....:kOdc;.........................................    //
//    ...............................''''',,''.        .....o0kc:,........................................    //
//    ..............................''''''','..          ...;k0d;,'.......................................    //
//    ..............................'''''''''..             .cOOl''.................................''''''    //
//    ..............................''''''''.',;,'.          .cOOd:'.................'....''''''''''''''''    //
//    ...............................''''''''..';::;,'...     .lO0x:'''''.''''''''''''''''''''''''''''''''    //
//    ...........................''''''''''''',;:;;;;;;;;,'... .lkxd;'''''''''''''''''''''''''''''''''''''    //
//    .....................''.'''''''''''''''....,;;;::cccl:,.  ,c;::,''''''''''''''''''''''''''''''''''''    //
//    ..................''.''''''''''''''''',,.........',,::,''...  .'''''''''''''''''''''''',,,,,,,,,',,,    //
//    ...............'..'''''''''''''''',,,,,coddolcc:;;;:ldxxkd,    .',,''',,,,,,,,,,,,,,,,,,,,,,,,,,,,,,    //
//    ...........''''''''''''''''''''',,,,,,,;cloolcc:;;,,;:llc;'.    .,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,    //
//    ........''''''''''''''''''',,,,,,,,,,'..'....          ';,'..',..,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,    //
//    .....'.'''''''''''''''',,,,,,,,,,,,,'.                  ...;dOOxc..',,,,,,,,,,,,,,,,,,,,,,,,,,,,,;;;    //
//    ..''''''''''''''''',,',,,,,,,,,,,,,,.                    .,:::ldl;...',;,,,,,,;;;;;;;;;;;;;;;;;;;;;;    //
//    '''''''''''''''''',,,,,,,,,,,,,,,,;,....''.                   ..,lol:'',;;;;;;;;;;;;;;;;;;;;;;;;;;;;    //
//    ''''''''''''',,,,,,,,,,,,,,,,,,,,;;,.',,....                   ..:xxdoc;;;;;;;;;;;;;;;;;;;;;;;;;;;;;    //
//    ''''''''',,,,,,,,,,,,,,,,,,,,,;;;;;'...   ...               ..  .,dxdxdc;;;;;;;;;;;;;;;;;;;;;;;;;;;;    //
//    '''''''',,,,,,,,,,,,,,,,,;,,,;;;;;,.      ...           ..,:cc;. ,oxxxdc;;;;;;;;;;;;;;:;;;::::::::::    //
//    '''',,,,,,,,,,,,,,,,,,,;;;;;;;;;;;'       ....       ..,;ccc::l, .lxxxdc;;;;;;::::::::::::::::::::::    //
//    .''',,,,,,,,,,,,,,;;;;;;;;;;;;;;;,.        ..     ..';:::;;,,,lc..ckkkd:;:::::::::::::::::::::::::::    //
//      .,,,,,,,,,,,,,,;;;;;;;;;;;;;;;;'               ...',,,'....'ld, 'dOxl::::::::::::::::::::::::::ccc    //
//       .,,,,,,,,,,,;;;;;;;;;;;;;;;;;,.                ...........,cko..lko::::::::::::::cccccccccccccccc    //
//       .',,,,,,,,;;;;;;;;;;;;;;;;;;;.                   ...    .';:dOc.:o:::::::::cccccccccccccccccccccc    //
//        ',,,,,,;;;;;;;;;;;;;;;:::::,.                          .,;:lO0l:c::::cccccccccccccccccllllllllll    //
//        .,,,,,;;;;;;;;;;;;;;;::::::'                            ';:cxK0xoc:ccccccccccccccclllllllllooooo    //
//         .,,,,;;;;;;;;;;:::::::::::'       .....                .;ccok00Oc...;cccccccclllllllooooooddddd    //
//          ';,;;;;;;;;;::::::::::::;.    .........        ..    ..':cldO00l.  .:cccllllllllll:,,coddxxxxx    //
//          .,;;;;;;;;;;;:::::::::::,   ............        ........;cldxO0x'   .:lllllllllool'  .lxxkkOOO    //
//           .';;;;;;;;..,::::::::::. ......'','....................'codddxk:.   .cllllllooooo,...:xkO00KK    //
//            .,;;;;;;.  .;::::::::;. .',,'';;;;'''..................,lddxodl.    'clllooooooo,...:kO0KXNN    //
//             .;;;;;'    '::::::::,  .,;;,;:cc:;;,,''',,,,,,''''''''':oxkxl:..    ':loooooodo,...'lO0KXNW    //
//             .,;;;,     .::::::::'   ,cccccoolcc::;;;:::::;;,;::;;;;:okkko'...    .:oooooodl.  ..;x00KXN    //
//              .,;,.     .;::::::;.   .;oooodxxdoollllloollcccclllccclldkOd'...    .:oooooodc.   .'dOO00K    //
//               .;.      .;::::::,      'codxkkkkkxdddxxxxddddooddoollloxOo'...    .:ooooool'     .lkkkOO    //
//                .       .;::::::'        .';:coxOOOOO00OOkkkxxdxxdoddddoo:...     .;oooooo;      .;dxxkk    //
//                        .,::::;.          .....',,;cldxxkkkOOkkkOkxdlol'..        .:oooo;..       .lxxxx    //
//    ...  .               ,::::'           ............'''',,;;;:lc:,...            'looc.         .;l:;'    //
//    ..............  .    .;::;.            ...''''',,;;;'....'','.           ..,cc'.,cc:,''.     ....  .    //
//    ...................   '::,            .:cclool:;;clllccc:;''.        ....';d00o;,,,;;'.. ..'..'..;;:    //
//    ............'...',,'..'..             .lkxxdl;,:ooolc:;;'....       .,:::ccd0Kd:;;,.   .,;;,,;;:oxdl    //
//    .....',.........';,,,,.                ,xOkxllol:'.',,,,..',.   .,llodxkkkkkdxd:;'. .',;;;;;;;;::odl    //
//    .''...''''...'',;::cl:;;.              .lOOko;..  ..';;::coo..:ldkOOOkxdoolc;:o;....,,,,''....',,cxd    //
//    '''..',;,'.....';::clcloo;.             'oxl'        .,ldxOk:;clcc::::c:;;;,',;...''''.. ..',,,,;cxk    //
//    ','''..'.......',,,,;:oxkx:              ..           .:kOOd:,'',,''',,''',,,'............',,,;:::ok    //
//    ',,'''''''..'',;:ccc:;;okOk;                           .ldkxc;:::::::;:;,,:c,.,'.......'''':c:::;:cd    //
//    .'',,',,,''...,::::lodxdxdkk:.                          .'ldolollloodxdc:cl;';:,.''...',::;:ccc:cccl    //
//    .''''''''''.';clcccloodOKK0K0:                           .oxdxxxxkkkdooooc,;loc,'...',,;::;:lllccccc    //
//    ..''..'.',,,;:oolllllloxk0kdxo.             ....         .dOkk0Okxolloxxl;codo:'..',,;;;:cc:ldddolcl    //
//    .'''''..,;,;;:cloooolodddddodxl'          .:ccc:,,;'.    .;dddxxl:,;cll::oxkdl;..,;;:::::locldxxxdod    //
//    ..''''.',,,,:codocloddxddddddxxo.      ..,:oddolloxd:.  .'lkkkxl;';:;,,:dxxdddc,,;;:::::clooloxkkOOO    //
//    ,'.'.',;::,:loddlcollodxdxddxkkd,     .cOOxddddddO0Oko..'oO0KOl;;;lxxc,cdddxkxc;;;:cccclcclocd0XXXXK    //
//                                                                                                            //
//                                                                                                            //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract JRW is ERC1155Creator {
    constructor() ERC1155Creator() {}
}