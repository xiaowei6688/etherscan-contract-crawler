// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Sun City Poms
/// @author: manifold.xyz

import "./ERC721Creator.sol";

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                                              //
//                                                                                                                                                              //
//    ......................................................................................................................................................    //
//    ......................................................................................................................................................    //
//    ......................................................................................................................................................    //
//    ................................................^7~.::................................................................................................    //
//    ...............................................::!YJ:7~:..............................................................................................    //
//    ...............................................^?YJ5YJ5?:.:........^::^~~^:...........................................................................    //
//    ................................................:?PG5PPY!?:......~J???7~^.............................................................................    //
//    ................................................:~7J55GP57....^JYPPPY?7^:.......::^~~!~:..............................................................    //
//    .............................:^~!7777!^:.......:^!JYYPPG5~7:7JGGPPGPJ~:^!7JJJYYY5PPJ?!:...............................................................    //
//    ...........................~?5GGGGGGGGPPYJ?7~^:.:!Y55PPGP5!7GGGPPP57~75GGGGGGGGGGP?^:.................................................................    //
//    ........................:!YPPP5Y5555Y55PPPPGPPPY7^?GGGPGGY!GPPPGP?~?PGGPPPPPP5YY7~:...................................................................    //
//    ......................~?5PP5YYYY5YYYYY5PP5555PPPP57~YP5PP!5P5PGY!^YGGGP5J??7~~:.......................................................................    //
//    ...................^75PGP5??YJ5Y??Y??Y5555P55Y55555JJ555?JP55PY~!PGPGGGGPP5Y7~:.......................................................................    //
//    .................~YPPJ5Y!^?5?5PJ?5J7YYJJ??7JPPPPPPPPPPPP5PP5Y!~YGGGP5PJ!!!77!~!!!!!~~^:...............................................................    //
//    ...............:!YY?!?J??YPPPPPPPPPPPPP555Y5P577YP555PPPPPY?7JP555PP55Y55PPGGGGGGGGGPYJ7^.............................................................    //
//    .........::^!7?YPPPPGGGGGGGGGGGGPGGGGPPPPPPPP555?77Y55PPY7?Y5YY55GGGGGGGGGGGGGGGGGGGPPPP57:........:~~:...............................................    //
//    .......:~7??YPBGGGGGGPPPP5PGG5YYPGGGGPGPPPGPPPPPP5J7J55Y?Y5Y5Y5JY?57JP55GPP5G5YGGGGGGGGPP5J!~^.....:~?5J!.............................................    //
//    ..........:!????JYJ?JYYJY55J7JPGGP5PPGPGGGGGGGGGPPP55555YJJJ?7J??!77!7!!YYYYJG?YBGPGGPGGGGGG5J7!...:?PPGP7::..........................................    //
//    ..............^~^:.~~^!7!^:!?PY77J55GGPPPGGPGPYJPPPPPP555555J~75YYYYYYJJJYYY?JY~5P5JG?5P55PPPPPPY:..~5GGGP!!..........................................    //
//    .....................::...^::::!J7~??77!77777?JPPGPP555PP55YP5J?Y555555YJYYY55YYJJ?7?7?PP5555555GP~:7YYPPP5!J^........................................    //
//    ..............................:^...:.....^7?5PGPP5Y5PPPPPPPYYPGYPYYPPP55Y55555PPPPP5Y!^YJ755YPP55GG~:YP5PPPPG^........::~^~~:.........................    //
//    .....................................:~?5PPPPPPYY5PGG5JGGPP555GPPYJJ55GPP55P5PPPPPP5P5?!?JYPJ5PP5PPP~7PPPPGG5:....:^~?Y5PY7:..........................    //
//    ...................................^?5GGPPPPPYYPPPGGG55YPGP5P5GGPPY~7~Y5GPPPPPPPGPPP5PG5J555PPPP555P5!YPP5P5~.:~:??5PGPY?~:...........................    //
//    ..................................~J5PPPPGPYYPGPPGPPG7~YGGPPP5GGGPP7:.:JPPP5?G55PP5PPPPPPPJYY5GGGGGPP5JPP5PJ.^Y?YPPPY?!:..............................    //
//    ................................:75PGGPGP5YPGG5PG55P?!PBBPPPYPPGGPPPJ^.:?7P!^GJ5JPJ5Y5PPPPYYY5PPPPPPPPP5555~^55555Y?^.:::::...........................    //
//    ...............................:75GGGPP5Y5GGP55PJJY5?JPGPPP5Y5P5PP5Y7?^.^!5??P5P5P555Y55555YYJJJ5PPPPPP5YYY7J5J?!~^~!?JJ?JJ!~^........................    //
//    ...............................~YPPPPP5YPGGGPPPJ?Y5J!YYPPPP5P5P5PPPPJ~?JJ7?JYPPPGPGGGP5555555?JY5555PPP55Y5Y?!7?77JY555555PPP5J?!~:...................    //
//    ..............................^YGGGGP55GBGG5GYP7Y5P7!!5BGPPGGGGPGGGPJ?~^^7YJJ5GGGGPPP555PPPPP55P5Y555PP5Y5YJJY5YYYJJY5P5J??5PPPYJJ7~:.................    //
//    .............................!PBGGGP5PGBP5PJ5:^?5PP^!PPP5PGGGGGPGGP5P!..:~:^Y5JJJ7?J77YP5555555YYJJJY5YY555555555YYJ??????7!?YY5YJ?!^:................    //
//    ............................:YGGGPPPPPPB7J77^.^Y5PY~!!7!5GGGGGPGGGGJY5:....:^^:::!JJY5PPPPPPPPPPP5YYYY5YJY5YY5PG5PPPPPP5Y?!!:^~~!^!!:.................    //
//    ...........................^5BGPPPGPB?PP.~....?Y5G7..::JPGGGPGPGGGGP:7?.......:!5PGGG5GP5GGGPGYYPP55555555P5JJ7YYJ5?GPGGGPPY7:........................    //
//    ..........................!5JP5PGGPJY~B~.....:YY5P^...~YBP?PGGGGGGGG~.!:...:~JPGGGGG?YYJJJPPPPP?JY5JJYP5PPPGGGG557?!PYPGGGP5YY?^......................    //
//    .........................^!:7575PG?!^?7......~YYP5:...?G?:?5GGGGGGP5:.....!JGBGGGJ5?^^^7YPGGPJJ!Y5?^75GPPGPPGPGGGGPJ?!5GPGGG5?JJ^.....................    //
//    ...........................^5!5!J5:..^.......?Y5PY...:7:.!!?PPGGGPP~......~5PYYJ~:^.~YGGBGG5YJ7J5?.:JGGP55P5PPGPGPPBGY7J!Y5GGPJ77:....................    //
//    ...........................~^!Y.7!..........:JYYP?......:.7G55PPPPP^......!7^:^...:7YGGBBJY???Y57.:JJ5P555555Y55PPPPPPP?^!?Y5GY7^:....................    //
//    .............................!!.^:..........^YY5P7.......~GPY55PG?P:.....::.....^?YPGBPPP~!~?Y5!..^!?GGPPY5?JJ?5GPGGGPPG5~^J?PY7~.....................    //
//    .............................::.............~YY5G!.......YB55G?!G~!............~?YGGGG???.~J55~....:YBP?P!YP7~:!YGGGGGGGBP7:^J?^:.....................    //
//    ............................................!YY5G~.......55JGP~.^^............^?YGB5?Y^::!Y5P~.....^5Y!YGY~5J~..~7YY5PGGGBP^.!:.......................    //
//    ............................................7YYPG~.......7~55~................!PGGY~:^..7Y5P~.....:!!7PGGG7~7~....7!Y?GGGGBJ..........................    //
//    ............................................7YYPG~........:Y^................:JPY7.....7Y5P!........!JYG5YY::::....^~?G5BGBP^.........................    //
//    ............................................7YYPG~.........^.................:~~^.....7Y5P7........^~JPG!?7!.........7JJGGGB7.........................    //
//    ............................................?YYPG!...................................7YYP?.........:!7?5:^:~.........::Y!JYP7.........................    //
//    ............................................7YYPG!..................................!YYPJ..........::.7~..............:~::^~:.........................    //
//    ............................................7YY5G7.................................~YY5Y:.............:...............................................    //
//    ............................................7YJY5J................................^JJY5^..............................................................    //
//    ............................................!YJYPY...............................:?YY5!...............................................................    //
//    ............................................~YY5PP:..............................7YYP?................................................................    //
//    ............................................^YYYPG~.............................~YYP5:................................................................    //
//    ............................................^YYYPG7............................:JY5P~.................................................................    //
//    ............................................:JYY5GY............................7Y5P?..................................................................    //
//    .............................................JYY5PP^..........................^Y5PY:..................................................................    //
//    .............................................7YY5PG7..........................?55P~...................................................................    //
//    .............................................!YYY5GY.........................!Y5P?....................................................................    //
//    .............................................^YYY5PP~.......................^Y555:....................................................................    //
//    .............................................:JJY55P?.......................?55P!.....................................................................    //
//    ..............................................7JJJY5Y^........^^...........~YY5Y.:^...................................................................    //
//    ..............................................~YJJYY57.......!?:..........^JYYP??!:...................................................................    //
//    ..............................................:JYYY55Y^.....7Y~..........:?YY5P?^.....................................................................    //
//    ...............................................7YYY555?....75?:..^:......7YY5P?!~.....................................................................    //
//    ...............................................:YYYY555!..!5J?:..^?^....!YYYPPY!......................................................................    //
//    ................................................7555Y55Y~J5JJ!.:77~5^..^YYYY5Y^.:.....:::.............................................................    //
//    ................................................:Y55YY5555YJ7:!JJ:.YY:^JYYY5J!!!^:^~!!^:..............................................................    //
//    .............................................:::.!5P555P5YJ?!JJ!!J775J7555Y5YJ77??7~:.................................................................    //
//    ..............................................:~?!JP5555JJYJ?7!7JYPJYYJ5P5Y55YY?~:....................................................................    //
//    .........................................:^~~~~~?555555J?YJ77?JY5555J5?Y5YY55Y?!^:....................................................................    //
//    ..........................................:^!777777777!!!!~~!77777!777!!777777~:......................................................................    //
//    ......................................................................................................................................................    //
//    ......................................................................................................................................................    //
//    ......................................................................................................................................................    //
//    ......................................................................................................................................................    //
//    ......................................................................................................................................................    //
//                                                                                                                                                              //
//                                                                                                                                                              //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract SCPTA is ERC721Creator {
    constructor() ERC721Creator("Sun City Poms", "SCPTA") {}
}