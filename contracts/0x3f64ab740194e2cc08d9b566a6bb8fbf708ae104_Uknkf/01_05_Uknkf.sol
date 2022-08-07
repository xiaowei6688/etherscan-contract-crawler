// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Unknown Feelings
/// @author: manifold.xyz

import "./ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                //
//                                                                                                                                //
//    '........................                            ....                         ..   ..      .....  ..   .                //
//    '.......................                                                                               .                    //
//    .................. ....                                .                                .... ..                             //
//    '.................   ..                                            ..                     .   ..                            //
//    '........ ...................                                      .                                                        //
//    ''...... ....   ............                                                                                                //
//    '.....             ......                                          ....                                                     //
//    ,'....                                                            ....      ....                                            //
//    ,...                                ..                ...         .          ..,'.                                          //
//    ...                                 .                ...  .........  .         ..,'.                                        //
//    ....                              .                  ..............  ...        ...'.                                       //
//    ....                                           ..........................     .........                                     //
//    ......   .                                    ......'......   ...........            ..                                     //
//    .......  ..                       .           .......'''....................          ..     .....                          //
//    ...........                                .............................''''...       ...   ..''',,'..            ..        //
//    .        ....                .           .......''..'''''........,;;;,,'...''''..      .,. .''''',;:;'..        ........    //
//    .         ...                .         .............'''''',;;,'.....'..........'..     .;,','...'''''',.        ..',,'''    //
//    ....                        .         .........',;:;;;,''',;::,'................''.    ..;;....'',,'..,,.       .,'';;;;    //
//    ....                        .        .''....';clloollcc;..'''','..........'''....''.....;:'........,,..,.      .;,',,,;;    //
//    ......                      .        .,,'.'';looooooolcc;....................'.''..,,,;::;,..';;;,...'.,'      ';'....',    //
//    ....'''..                ...        .;;'.,,,coodddddoolc::;,'...','...........'''''',;:::,..'',;;;;'..'','....';'....',,    //
//    ',,,,',;:;.           .''..........;:;..',.;odddddddxxoc:::;;;'..;:'..........';,....'''....',,,,',:;...';;,,,,'...'''''    //
//    :;;,''..',:,.        .,'.....'''''''...',..;oodddddolc:;;;;;;;;'.',,'..........':;'..''''..'''......,,'..',,'.''........    //
//    ...........:,.       .'.....'',,''''',,,'..,;;:oxxl,'';:;,,,,;;;'''',..''.';:,...,,'..'.........''',,'.......','...'''..    //
//    .....'.....'c'       ........'''',,,,,,,'..',,'cxo;,,,,,c:'..';c;,'.'...,:lldd;....'............''.',;,...............'.    //
//    ''''',,,,...;c.      .........''''''',;,.....,;od:,:cc:cool;.'coc;,'..';ldlclo;..',,,'''.........',...,,............'',,    //
//    ........';,..,:'.  ...,;'...................',lxc,,coccodddl:,:ooc;,;;:ldl;;:;.....',,,''..'',;,...,'..''............'''    //
//    ....'',,,'','..,,''..';,.....,,'''.'..,,,'..';l:'',cdl:oxdddol;col:,,;:coc;;;. ................,,...,.................',    //
//    .........,;,',,'...',;,..'..';..'''';;;;,...',''',:lddlodddddolcll:,,,;:lc;,.. ............'....,'...'..................    //
//    ..........';;,'''..''...';'.''..,,';;;;;'...',;::cdxxxxxddddddl::c;,,,''....................,'...'..........''....','...    //
//    ;,......';;,,,;;,,'.....;'.'...,,.,',:;'.....',,,,:coxkxxdddddc::;,,''... .......''..........''.........''','......';;'.    //
//    ;.''''....,:c;''''''...,'.''.'...''',,''.........'...;lddddool::c;''...........''';..........................''.',...,:,    //
//    ..';:,'.....':::;,'......';..,..''''.''.. ..'...,;;;:lodoollcc;;;'...',..,,....,,':'.........'''''..''..''....',.',....,    //
//    ..::'.....''...'''......''.',...'''''...........:dxddoollc:;;,'.....,:;..;,.''.',',;..''''.''.',,;,,;:;,,''''..',..,.. .    //
//    ..;'....;;.......'''''''''''..'..'..............;cclcc::;,'.......';cc:..;,..;,....,,..'''',,,,'..','..........';,...'..    //
//    ..,,...,'.......''''''''...'''..''.................'''.........'',:cll:'..'..',,'...'...'....'',,,''..'''.......,,'.....    //
//    ..,;............'''';cc:;,''....''................  ..'.....'',::cloooc;. ........'..............''',,,'.........;,,'...    //
//    .';.......',.....',;::;,'.......'....'..,'......    .;:;;,,;;;:clloodol:,.  ..............''',,''''',,'.......'...,;;;,,    //
//    .'...''..',,.....';;,'.........''......;,......  ...;cllccccccclooddxdol:,.  .'..,...',..........';;;'........,.....''''    //
//    ....,',..;,,,....',,....'.... .',,'....',''''....',:loooooooooooodddxxdol:;'..'..,,'.':;.......',;,...........,,..',,'''    //
//    .'''.'.',,,.,;.....''..'....  .,:;'....',,,,,,,;:ccloooccooollccoooodxkxolcc:;;;;:c;,,;::;,''...............''',........    //
//    '.....';'.:'.,;....,'..'.... ..;;,,;;;;:::::cclllooc;;;;,;c:::,';;,,;coxdooolllllloollcccllc:;'..............,.......  .    //
//    ....';;...c;..:'...',..''....';:;;:::cccccllllooooolc:,,''',,,'.''''',loodddooddooooodddddol::;;'...................  ..    //
//    ',;;;'...'c,..'.....;,..''.';;:::::cccllooooooddddxxl;'''.........'',:lllloddddddddddddxxkOkocc:;,'.. ..        .     ..    //
//    ''... ...;,.....'....,'...'',;;::cllooodddddddddxxxd:',,......''.....',;;;:lodddddddddddddxkkdcc::;'..                ..    //
//    .............','.... .......,;::clool:;:coddddxkxdl:'......''''.....''''..',coooclodddddddoodo;,;::,..                      //
//    .........'''''....... ..   .';;;,;::,....'cooddol:;,'.......'''.............;llc,,loddddl;',:c;,;::,...                     //
//        ........  .....      ...............'':cllc:;,,,,'........';;;'.........;cc;';:clloc'...;lc,..'....                     //
//                 ...        ...   .. ......'',,,;;;,'.'''.........'.':lc;,'.....,::,'cl;;:::,..;c:,. ......                     //
//                             .           ......................',,....,ldoc;'....','.;l;',;;;,'''.. ......                      //
//                                          ..................''..........,coolc;,.....;ll;,;,,''''........                       //
//                                             .............;cccc:::;;,,'''':looolcc:;:loo:,;;'',,,;,'...       ..                //
//    ..      ..                    ...            .... .....,;;;:::::::ccclooolccclloooool;,,;,,..''''..           ..            //
//    ....    .......               ..                  ....',:cccccc:::;:cloodooolccllooolc,............           ...           //
//    ....    ....  .......         .                   .,:;'''',,,;;:::::clodoooooooooooolc:'.........      ..     ..            //
//    ...           ......  ....   ... ...             .cdc'','..........';coooooollllloooolc;'......                             //
//     ..  ..         .     ...... .......            .cd:. .....'',,;;:cccccccllllllllllooolc;'......                            //
//          .                 .    .......           .;oc'.    ..'''''''.......',,,;;:cclodoolc;'.....                            //
//                                .. ......          'oo:'.     .',,''.....',;;;,......',coxdolc;'. ..              ....          //
//                                      ..          .cooolc:,'',;:cclc;:cllc:,......    ..;lddol:;'.           ..                 //
//                                                 .;ooodddddoooooolc;,'.....',;,'..      ..,:cc:;;'..         ..            .    //
//                                                .,looooodooolloool:;,;;::ccc:,....        ..',;;:;,...               .. ....    //
//           ....                               ..':loooolcccccllooool:;,,'.....''.          ....,::;,...             .....'.     //
//       ..  ......          .               ....',,;:clccclllooooooc;'''''',,;,..              ..,;;'....          ....  ....    //
//         ... ...           ..  ..         ..',:,''..;looooddddoooolc::;;;,'..                 ...''..''.        ......   ...    //
//             ....                         ...;:,....':llccccccccccc;'....             .        .........      .  .....          //
//             .  ....      .  ..          ........',,,,''...'''',,,,'',,,;;;'...         .         ..   ..                       //
//               ......        .            ............         ...    ......    ..         ....    ....                         //
//                 .....                     ......                                          ...     .....                        //
//         ..       .....                                                                   .. .. .   .. ..                       //
//       ....     . ..          .....                                                                                             //
//      ........     .          ..          .             .                  .    ..                                              //
//      ............ ..                      .       ..                .    .      ...                ...  ..              .      //
//        ..  .....                                        ..          ..           ..                 .   ..          ..  ..     //
//    .          ....            ..  .  ...                                                          ..                           //
//                ..........                                                                          . ... .               ..    //
//                    ..    .       .        .....                                .                     . ...         ...         //
//    ...                                    ......                                                      ....          ...        //
//    ...  ..   ..                             .                                           ..           ...          ......  .    //
//    ..        ....                                                                       ..          ..            ...... ..    //
//                                                                                                                                //
//                                                                                                                                //
//                                                                                                                                //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract Uknkf is ERC721Creator {
    constructor() ERC721Creator("Unknown Feelings", "Uknkf") {}
}