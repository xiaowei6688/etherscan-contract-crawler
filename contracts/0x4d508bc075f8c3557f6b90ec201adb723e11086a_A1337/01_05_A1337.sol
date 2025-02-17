// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Symbiotic OE
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                                                                                                //
//                                                                                                                                                                                                                //
//    @@@@@@@@@@@@@&&&&&&&&&&&###P~::::~GBY7!!!!?PB#BBB##BGPPP55YYYJJ???777777!!!!?J5PGB##&&&&&&&&&&&&#P?!!777?????????????JJJJJJJJJJJYYYYYYYYY55555PPP?!~~~!!!!77?JJYYY555PPPGGGBBBB#####&&&&&&&&&@@@@@@@@@@@    //
//    @@@@@@@@@@@&&&&&&&&&&&#####5~:..:^GBJ!~~!!75BGYJJJPGP55YYYJJJ??7777!!!!!7JPB##&&&&&&&@@@@@@@@@@@@@@#P7!777??????????????JJJJJJJJJJYYYYYYYY5555PP5?!~~~!!!!!!77??JJYY555PPPGGGBBBB####&&&&&&&&&&@@@@@@@@@    //
//    @@@@@@@@@@&&&&&&&&&&#######5^:..:^GG?!~~~~7YPJ~~~~755YYYJJ???777!!!~!?5B#&&&&&&&@@@@@@@@@@@@@@@@@@@@@@P77???????JJJJJJJJJJYYYYYYYYYYY5555555PPPGP?!!~~!!!~~!!!7??JJYYY555PPGGGBBBB#####&&&&&&&&&@@@@@@@@    //
//    @@@@@@@@&&&&&&&&&&&######B#Y^...:^PG?~^^^^!Y57^:::~Y5YJJ???777!!~~!YB&&&&&&@@@@@@@@@@@@@@@@@@@@@@@@@@@@&7~!!!!!77777777777777777777777!!777777777~~~~!77!!!~!!!77??JJYY555PPPGGGBBB#####&&&&&&&&&@@@@@@@    //
//    @@@@@@@&&&&&&&&&&######BBBBJ^....^PP7~^^^^~J57^:::~YYJJ??777!!~~7G&&&&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&^.........................................::^!!!!!!!!!!77???JYYY55PPPGGGBBBB####&&&&&&&&@@@@@@@    //
//    @@@@@@&&&&&&&&&&######BBBBBJ^....^PP7^^^^^~JY!:..:~JYJ??77!!~~?G&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@: ........................................::::::^~!!!!7777??JJYY55PPPGGGBBBB####&&&&&&&&@@@@@@    //
//    @@@@@&&&&&&&&&&#####BBBBBBBJ^....^PP!^::::~?Y!:..:^JYJ?777!~7B&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&. .::^::::::::::::::::::^^^^^^^^^^^~~~^^:^^.....:^~!77777???JJYY555PPGGGBBBB####&&&&&&&&@@@@@    //
//    @@@@&&&&&&&&&&#####BBBBBGGBJ^:...^P5!^::::^?J!:...^JYJ?77!~?&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#...:^^^^^^^^^^^^^^^^^^^^~~~~~~~~~!!7!~^^^^:......:^~!7777???JJYY555PPGGGBBBB####&&&&&&&&@@@@    //
//    @@@@&&&&&&&&#####BBBBBGGGGGP7^:::^P5~:::::^?J!:...^JJJ?77!!&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#:..:::::::::::::::^^^^^^^^^^^^^^^^~^:::::^^:......::~!777???JJYY555PPGGGBBBB###&&&&&&&&@@@@    //
//    @@@&&&&&&&&#####BBBBGGGGPPGJ~:..:^5Y~:::::^?J~....^[email protected]@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@! .......................................:::::......:^!7???JJJYY555PPGGGBBB####&&&&&&&&@@@    //
//    @@&&&&&&&&#####BBBBGGGGPPPP!:....:55~:::::^7J~....^JJJ?7!~&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@Y................................:::.......:^^:......:~!7?JJJYYY555PPGGGBBB####&&&&&&&&@@    //
//    @&&&&&&&&#####BBBGGGGPPPPP5~..  .:5Y~:...:^[email protected]@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#^:^^^^~~~~~~~~~~~~~~~!!!!!!!!!!777!^:......:::::....::^!?JJJYYY55PPPGGGBBB####&&&&&&&@@    //
//    &&&&&&&&&####BBBBGGGPPP5555^.   .:5Y^:...:^7?~....^[email protected]@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@?:^^^^~~~~~~~~~!!!!!!!!!!!!!!!77777!~^:......:^^:....::~!?JYYY555PPPGGBBBB###&&&&&&&&@    //
//    &&&&&&&&####BBBGGGGPPP55555^.   .:5Y^:....^7?^....^[email protected]@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@G::^^^^^^~~~~~~~~~!!!!!!!!!!!!!!!!777!~:.....::^^^:::::^~7JYYY555PPGGGBBB####&&&&&&&@    //
//    &&&&&&&####BBBBGGGPP555555Y^.   ..YJ^:....:7?^[email protected]@@@@@@@@@@@@@@@@@@@@@@@&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&!.:^^^^^^~~~~~~~~~~~!~!!!!!!!!!!!!!777!~^:..::^~!~^:::^~?JYYY555PPGGGBBB####&&&&&&&    //
//    &&&&&&####BBBBGGGPP5555YYYY^.    .YJ^.....:7?^[email protected]@@@@@@@@@@@@@@@@@@@@@@@@&&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@5:::^^^^^^~~~~~~~~~~~~~~~~!!!!!!!!!777?77~^^^^~~!~^:::~?JJYYY55PPPGGGBBB####&&&&&&    //
//    &&&&&&###BBBBGGGPP555YYYYYJ:.    .YJ^.....:7?^[email protected]@@@@@@@@@@@@@@@@@@@@@@@@@@&&&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#~.:^^^^^^~~~~~~~~~~~~~~~!!!!!!!!!7777????7!~~~~^::::^7JJJYY555PPPGGGBBB###&&&&&&    //
//    &&&&&####BBBGGGPPP55YYYYYYJ:.    .YJ^.....^7?^....~JJ??7!^&@@@@@@@@@@@@@@@@@@@@@@@@@@@@&#&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@J:::^^^^^~~~~~~~~~~~~~~!!!!!!!!!!777777??7~^^::...:^7JJJJYY555PPGGGBBB####&&&&&    //
//    &&&&####BBBBGGPPP55YYYYYJYJ:.    .YJ^.....^7?^....~JJ??7!^[email protected]@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&##&&@@@@@@@@@@@@@@@@@@@@@@@@@@@@B^.:^^^^^~~~~~~~~~~~~~~!!!!!!!!!!!!!!!77!^::......^7?JJJYYY55PPPGGGBBB###&&&&&    //
//    &&&&####BBBGGGPP55YYYYJJJJ?:     .Y?^.....^7?^....!JJ??7!^[email protected]@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&#B##&@@@@@@@@@@@@@@@@@@@@@@@@@@?.:^^^^^~~~~~~~~~~~~~~!!!!!!!!!!!!!!!!~:........:7?JJJJYY555PPPGGGBB####&&&&    //
//    &&&####BBBGGGPPP55YYJJJJJJ?:     .Y?^.....^7?^[email protected]@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&#BBBB#&@@@@@@@@@&&@@@@@@@@@@@G::^^^^^~~~~~~~~~~~~~~~!!!!!!!!!!!!!!~:........:7?JJJJYYY55PPPGGGBBB###&&&&    //
//    &&&####BBBGGGPP55YYYJJJJJJ?:     .Y?^.....^7?^....!YJJ?7!~^&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&&&&#BGBB#&@@@@@@&&&&&@@@@@@@&~::^^^^~~~~~~~~~~~~~~~~~!!!!!!!!!!!~:........:7JJJJJYYY555PPPGGBBB###&&&&    //
//    &&&###BBBGGGPP555YYJJJJJJJ?:     .YJ^.....^77^....!YJJ?7!~^[email protected]@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&@@@@@&&#BGGB#&&@@@@&&&&&&@@@&J^:^^^^^~~~~~~~~~~~~~~~~~~~~~!!!!!~:........:7JJJJJYYY555PPPGGBBB####&&&    //
//    &&####BBBGGGPP55YYYJJJJ??J?:     .YJ^.....^77^....!YJJ?7!!~^#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&&@@@@@@@@@&#####&&&&&#####&&#Y~::^^^^^^^~~~~~~~~~~~~~~~~~!!!7~:........:7JJJJJYYY5555PPGGGBBB###&&&    //
//    &&####BBBGGPPP55YYJJJJ????7:     .YJ^.....^77^....~JJ??77!~^^&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&###&&@@@@@@@@@@@@@@@@@@&&&&&&#5!::::^^^^^^^^~~~~~~~~~~~~!!!7~:........:7JJJJJYYYY555PPGGGBBB###&&&    //
//    &&####BBBGGPPP55YYJJJ?????7:     .5J^.....^77^....~YJ??77!!~^^#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&&&&&&&&##BBBGGGGGGB##&&@@&G?^:::^^^^^^^^~~~~~~~~~!!!!~:........:7JJJJJYYYY555PPGGGBBB###&&&    //
//    &&####BBBGGPP555YYJJJ?????7:     .5J^.....^77^....!YJ??77!!~~^:[email protected]@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&&#BBBB##&&&&&&&&&&&@@@B7:::::^^^^^^^^~~~~~~!!!~:........:7JJJJJYYY5555PPGGGBBB###&&&    //
//    &&###BBBGGGPP55YYYJJJ?????7:     .5J:.....^77^....!YJJ?777!!~~^:^[email protected]@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&##BG5YJJ????JJY5PGBB#&&&@@@@@@#J:..:::^^^^^^^~~~~~!!~:........:7JJJJJYYYY555PPGGGBBB####&&    //
//    &&###BBBGGGPP55YYYJJ??????7.     .5?^.....:77^....!YJJ??77!!!~~^^:^J&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&#BPYJ???77777???JYY55PPGB##&&&&@@@&BJ^.:::^^^^^^~~~~!!~:........:7JJJJJYYYY555PPGGGBBB###&&&    //
//    &&###BBBGGGPP55YYJJJ??????7.     .5J^.....^77:....!YJJ??777!!!~~^^::.~G&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&BG5J???JYPGB#&&@@@@@@@@@@@@@@@@@@@@@@@@@@G~::::^^^^^~~~!!~:........:7JJJJYYYY5555PPGGGBBB###&&&    //
//    &&###BBBGGGPP55YYYJJ??????7.     .P?^.....^??:....!YJJ??777!!!~~~^^^::.:!G&@@@@@@@@@@@@@@@@@@@@@&&&#GP5YJY5PB#&@@@@@@@@@&&#######&&&&&@@@@@@@@@@@@@@~.:::^^^^^~~!!~:........:7JJJJYYYY5555PPGGGBBB###&&&    //
//    &&###BBBGGGPP55YYYJJJ?????7.     .P?^.....:??:....!YJ???777!!!!~~~^^^^::...~5&@@@@@@@@@@@@@@@@@&&##B#&&@@@@@@@@@@@@&&#GGGGBB####&&&&&&&&@@@@@@@@@@@@Y:.:::^^^^~~!!~:........:7JJJJYYYY555PPPGGGBBB###&&&    //
//    &&###BBBGGGPP555YYJJJ?????7.     .P?^.....:??:....!YJ???777!!!!~~~~~^^^:::....:!5&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&&&#GGGGBB##&&&&&&&@@@@&&@@@@@@@@@@@@@P^.::^^^~~~!~:........^7JJJYYYY5555PPPGGGBBB###&&&    //
//    &&####BBBGGPP555YYJJJ?????7.     .G?^.....:??:....!YJ???777!!!!~~~~~^^^^:::.... ^#&@@@@@@@@@@@@@@@@@@@@@@@@@@&##&@&BGGGGB#&&&&&&&@@@@@@@@&@@@@@@@@@@@@@@5::^^^~~~!~:.......:^7JJYYYY55555PPPGGBBB####&&&    //
//    &&&###BBBGGGPP55YYJJJ?????7.     .G?^.....:??.....!YJ??7777!!!!~~~~~~^^^::::.:!?P###&&&@@@@@@@@@@@@@@@@@@@&&&#&@@&BBGGGGB#&&&&&&&@@@@@@@@@&@@@@@@@@@@@@@@G::^^~~~!~::......:^?YYYYYY5555PPPGGGBBB####&&&    //
//    &&&###BBBGGGPP55YYYJJJ????7.     .G?:.....:??.....!Y???7777!!!!~~~~~~^^^^::::5GGGB&&@@@@@@@@@@@@@@@@@@@@@&&&#&@@@#BGPGGBB&&&&&&&@@@@@@@@@@@@@@@@@@@@@@@@@@?:^^~~~!~:::.....:^?YYYYY5555PPPPGGGBBB####&&&    //
//    &&&####BBBGGPPP55YYJJJJ??J7.     .G?:.....:JJ.....!Y???777!!!!!~~~~~~^^^^:::?##BGPG#&&@@@@@@@@@@@@@@@@@@@&&#@@@@&BPPGGBB#&&&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#:^^~~!!~^::::...:^?YYYY5555PPPPGGGBBBB###&&&&    //
//    &&&&###BBBGGGPP555YYJJJJJJ7:    ..G?^.....:??.....!Y??7777!!!!~~~~~~~^^^^:::G&&#GGGB##&&&&@@&&@@@@@@@@@@@&&@@@@&BPPGBBB##&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@~^^~~!!!^:::::.::^?YYY55555PPPGGGGBBB####&&&&    //
//    &&&&####BBBGGGPP55YYYJJJJJ?:.   ..G?^:....^??.....!J??777!!!!!!~~~~~^^^^^::~&@&#GGGB##&&&&&&#@@@&@@@@@@@&&@@@@&B5PGBBB###&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@7^~~~!!!^^:::::::~?YY55555PPPGGGGBBBB###&&&&&    //
//    &&&&&###BBBGGGPP555YYYJJJJ?:.   .:G?^:....^??:....!J???777!!!!!~~~~~^^^^^::#@@@#GBB##&&##@&#@@@&&@@@@@@&&@@@@@B5PGBBBB###&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@J:~!!!7!~^^^::::^~JYY5555PPPPGGGBBBB####&&&&&    //
//    &&&&&####BBBGGPPP555YYYJJJ?:.   .:G?^:....^?J:....7J???777!!!!!~~~~~^^^^^:[email protected]@@@#G###&@&B&@#@@@@&@@@@@@&@@@@@&B5PGBBB###&&&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@P:!7!77!~^^^^:::^!JY5555PPPPGGGGBBB####&&&&&&    //
//    &&&&&&####BBBGGPPP555YYYYY?:.   .^G?^:::::^?J^...:7J???777!!!!!~~~~~~^^^:^@@@@@#G&&#@@&#@&&@@@@@@@@@@&@@@@@&BPPGBB####&&&&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&^~77777!~~^^^::^!J5555PPPPGGGGBBBB####&&&&&&    //
//    &&&&&&####BBBGGGPP5555YYYY?:.   .^GJ~:::::~?J^...:7Y???7777!!!!!~~~~~^^^:[email protected]@@@@##@&&@@#&&&@@@@&@@@@@&@@@@@&BPPGBB####&&&&&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@J~777?7!!~~^^^^~!Y555PPPPGGGGBBBB####&&&&&&&    //
//    &&&&&&&####BBBGGGPPP555YY5J^.. ..^GJ~^::::~JY^...:7YJ???7777!!!!!~~~~~^^^&@@@@@#&@&&@@&&&@@@@@@@@@@&@@@@@&BPGGB#####&&&&&&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&!777??7!!~~^^^~7Y5PPPPPGGGGBBBB####&&&&&&&&    //
//    &&&&&&&#####BBBGGGPPP55555Y~:....~GY~^::::~JY^:.::7YJJ???7777!!!!!~~~~~^[email protected]@@@@@#@@&@@&&&@@@@@@@@@@&@@@@@&BPGGB###&&&&&&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@P!7??J?77!~~^^~7YPPPPGGGGGBBBB####&&&&&&&&@    //
//    &&&&&&&&#####BBBGGGPPP5555Y~:...:~BY!^^^^^~JY~:::^?YJJJ???7777!!!!!!~~~~&@@@@@@&@@&@@@&@@@@@@@@@@&@@@@@&BGGGB#&&&&&&&&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@77??JJJ?7!~^^~75PPPGGGGBBBBB#####&&&&&&&@@    //
//    &&&&&&&&&#####BBBGGGPPPPPPY~:...:!BY!~^^^^!Y5~:::^[email protected]@@@@@@@@@@@@&&@@@@@@@@@@@@@@@&BBBBB#&&&&&&&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@G7?JJYYYJ7!~~!?5PGGGGGBBBBB#####&&&&&&&&@@    //
//    &&&&&&&&&&#####BBBGGGPPPPP5~:...:7B5!~^^^^!Y5~^:^^J5YYJJJJ????77777!!!!&@@@@@@@@@@@@@&@@@@@@@@@@@@@@@&#BBB#&&&&&&&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@??JYY55Y?!~~!?5GGGGBBBBBB#####&&&&&&&&@@@    //
//    &&&&&&&&&&&#####BBBGGGGGPG5!:...^7#57~~~~~75P!^^^[email protected]@@@@@@@@@@@@@@@@@@@@@@@@@@@@&#####&&&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@B?JYY555J7!!7?PGGBBBBBB######&&&&&&&&&@@@    //
//    @&&&&&&&&&&&#####BBBBGGGGG5!^:.:^7#57!~~~~75P!^^^~YP55YYYYJJJJJ?????77&@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&####&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@YYY55PPY?777JPBBBBBBB######&&&&&&&&&@@@@    //
//    @@&&&&&&&&&&&#####BBBBGGGGP!^:::^?#57!~~~~75P7^^^[email protected]@@@@@@@@@@@@@@@@@@@@@@@@@@@&&&&&&&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@BY55PPP5J???YPBBBBB#######&&&&&&&&&@@@@@    //
//    @@@&&&&&&&&&&&#####BBBBBBBP!^:::^?#P?!!!!!?PP7~^~!5PPP5555YYYYYYJJJY#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&&&&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@?J5PGGG5YY5PBBBB#######&&&&&&&&&&&@@@@@    //
//    @@@@&&&&&&&&&&&######BBBBBP7^:::^?#[email protected]@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&&&&&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@P^7JPGBBGGGB##########&&&&&&&&&&@@@@@@@    //
//                                                                                                                                                                                                                //
//                                                                                                                                                                                                                //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract A1337 is ERC1155Creator {
    constructor() ERC1155Creator("Symbiotic OE", "A1337") {}
}