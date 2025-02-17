// SPDX-License-Identifier: MIT

pragma solidity ^0.8.9;

// name: EinsZweiSwines
// contract by: buildship.xyz

import "./ERC721Community.sol";

//////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                  //
//                                                                                                  //
//                                                                                                  //
//                                                                                                  //
//                                                                                                  //
//                                                                                                  //
//                                                                                                  //
//                                                                                                  //
//                                                                                                  //
//                                                                                                  //
//                                                                                                  //
//                                                         .                                        //
//                                                        . .                                       //
//                                                 ...::..  :                                       //
//                                            :-====-==+++++-.                                      //
//                                        ..:---::----====++++=.                                    //
//                                    :-::::::::::::::::-==+++++:                                   //
//                                     :::::::::::::::::::-==++++.                                  //
//                                    :-::::::::::::::::::::-=+++-                                  //
//                                   ::-::::::::::::::::------+++=                                  //
//                                   =***+=:::-:::::::--::::--=++=                                  //
//                                   :**##*::+#**+=--::::::::--++-                                  //
//                                   :-===:::+#***+-::::::::---++.                                  //
//                              .:-=+-::::::::-=+=:::::::::---=+==-:.                               //
//                          .-=+++++-::::::::::::::::::::-----+++++**+-:                            //
//                       .=++++++++------:::::::::::::------=++++++**++++=:                         //
//                     :+++*+++++++=-------::::::::-------===+++++++*+++++++:                       //
//                    =++*+**+++++++=----:---:-----------======+++++++*++*+++=.                     //
//                  .++++++++++++=+=====------===---::--=++=--=+++++++++*++++++.                    //
//                  =+++++++++++=::-==++++++++++=-----==+++++++++++++++++++++++=                    //
//                  +++++++++++++=-::++***+++++++=======+++++++++++++++++++++++=                    //
//                  =++++++++++++++=+++++++++++=---====++++++++++++++++++++++++-                    //
//                  :+++++++++++++++++++++++++-:...===+++++++++++++++++*+++++++.                    //
//                   -*++++++*++++++++++*+++++==---====+++++++++++++++++++++++:                     //
//                    .+++++++++++++++++*+++++++++++++++++++++++++++++++++++=                       //
//                      :+*+++++++++++++++++++++++++++++++++++++++++++++++-.                        //
//                         -+**+++++++++++++++*++++++++++++++++++++++++=:                           //
//                            .-=+*++++++++++++++++++++++++++++++++-:.                              //
//                                 .:--=+++*+++++++++++++++==-:.                                    //
//                                            ........                                              //
//                                                                                                  //
//                                                                                                  //
//                                                                                                  //
//                                                                                                  //
//                                                                                                  //
//                                                                                                  //
//                                                                                                  //
//                                                                                                  //
//                                                                                                  //
//////////////////////////////////////////////////////////////////////////////////////////////////////

contract EZS is ERC721Community {
    constructor() ERC721Community("EinsZweiSwines", "EZS", 1000, 1, START_FROM_ONE, "ipfs://bafybeicmqfavgo3c263d2d5ver7vliladsx2xs3ryb4uvyd6zvzcqolgka/",
                                  MintConfig(0.05 ether, 3, 3, 0, 0x6434c83b1029e059196fa36f4D8a0d4bc34f1828, true, false, false)) {}
}