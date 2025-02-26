// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: DEEP BLUE
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

//////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                  //
//                                                                                                  //
//    .:.::::::----------============-----:---:::-------------::--==--=====--:..    ..:--:::----    //
//    ----::::.::::------------==========---::::::-::----------:---======----:.        .::---::-    //
//    ==------=--:::...::::---------------:-----:::-:--=======-----------------:..  .   ..::::--    //
//    ===========-----::..:-------========--------:::::::::::--::...:::-----:----:::::::::.  .:-    //
//    ==================-:.::--===================----::..::::---:::::::::..........:::...::..::    //
//    ===================--:::::-========================-:::::::--::---===--:.... ....   ..::::    //
//    =====================-----::========================----------.:---=====---:.......   ..::    //
//    ========================---::--==-----============-=====----------=-========-------:...::-    //
//    ==------=----=============--=--======------==-=====-=====-=---::..:..:::-----------:----::    //
//    --------==============---===-======---==--=====================---........:--=========----    //
//    ========----------======-----:-====================================:.:.... ..::--======-:.    //
//    ==---=====-::---::::---=======================================--====-:::::::--:::::--=====    //
//    ===========---===--:::::--====================-------------=----::-==-::.::..::::---------    //
//    =============---====--::::::------=========-----==-==----::--=-=-::---:..::-----::--===---    //
//    ===============-==-----=-------==================--====================---::..:....::-=--=    //
//    -====================-::-==-===================================--------=---:--::.    .:---    //
//    =---===================:::------======================================--=======-::: ......    //
//    ---------------=========-:-------=========================================-==---------==::    //
//    ---------::::--==========-::::::-============-=---=------=====================-:::.....:==    //
//    =--========---==========:.:---:.:================-..--:...========--================-----=    //
//    ========================-..::::.-================: .:---..========-::-----===============-    //
//    =============---==========-----===================-:...::=====-====---====--====-:------==    //
//    ===========----::-----==============================================-:---=========----=--=    //
//    ==========------::--::-----=-========================================-::::---::------:....    //
//    --============-----=--=----=======================---================-========---==:---:..    //
//    =---============--=--:--=============================-:---=======++====--::--==-::==::-::.    //
//    =================-:....:====================-============---======++==++===============-:.    //
//    ==================-.....-================-=========--==-:.::-:---==================--:-===    //
//    ===================-. ...:-======-=======---=========-:.....:.::::--::----==-----===-::---    //
//    ====================-:  ...:-=======================-:...:----::::--::--:..============---    //
//    ======================-:.   ..::---=======--==---::....:======--=================+++===--=    //
//    =========================-::. .......::::::.........:-=============--===---======-====--:.    //
//    ===============++++=======-==:..................::----=======--====-:::::....:::-====----:    //
//    +++++++++++++++++++===+=======-------------========---=---:-==--:===-==--=--:::::-=+++====    //
//    ====++++++++++=++=====+===+++++========+=====----=========---=-==-=----======++=====+=====    //
//    ===++++=++++++++=+====++==+=====================---==========================---::-=++==--    //
//    ++++++++====++++=++===========++===========================+++=========-::-===-----=======    //
//    ++++++++=====+++++=====+++++++++++==+++++++=======----==========+++==+++==---====--==+++==    //
//    +++++++++++++++++++===+++=====++++++++++++++======---:::-------:-==++=========+++====+++++    //
//    =++++++++++++++++++++++++++++++++++++++++++++++++=+++==:.::-----=-----==================++    //
//    =====+++++++++++++++++++++++++++++======++++++++++++++++======-----=======================    //
//    =======++++++++++++++++++++++++++++=====++========+++++++++====--:.::-===+=+==============    //
//    -========+++++++++++++++++++++++++++++=============+++++++++++++++====++++++==============    //
//    :::--------------------::::::::::::::::::::::::::::::::::::::::::::::::::::::.:.::::::::::    //
//    ......................................................................................:-=-    //
//                                                                                                  //
//                                                                                                  //
//                                                                                                  //
//////////////////////////////////////////////////////////////////////////////////////////////////////


contract BLUE is ERC1155Creator {
    constructor() ERC1155Creator("DEEP BLUE", "BLUE") {}
}