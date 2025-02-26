// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Layer2
/// @author: manifold.xyz

import "./ERC721Creator.sol";

//////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                  //
//                                                                                                  //
//    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%###%%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@#=::-+#@@@@@@@%%%#=:......::-+#%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@#-.....:::------===:..............:-+*##%@@@@@@@@@@%*++*@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@*...........::::-=-:.....:::::::..........:=*%%##+=-::[email protected]@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@%:............:::=:.....::--------:::..........:::[email protected]@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@-:.............:--:.:::::--:......:---:::...................:[email protected]@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@%::::............:---:----:...........:---:::::.............:::[email protected]@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@#----::::::::......:::::................::-==---::::::::::::::::[email protected]@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@*===------:::..............................:-===--::::::::::::::%@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@%*+====---:::...............................:-==--:::::::::[email protected]@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@%#++==---::::...................:...........:-===----=+#%@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@CC0*++==---:::..................::::::......::-=++++#@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@@@@%*++==---::::....................::--:::::--=*#%[email protected]@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@@@@@@%*++==---:::.........:::..........:-=+=---=#@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@@@@@@@@+-::----:::..........:-=-:.......::-++==-#@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@@@@@@@%=-:::==--::::::::.......:-==-:::::--=+##%@@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@@@@@@@@*+=-=+++==-::::-==-::.....::-=======+%@@@@@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@@@@@@@@%*+++*+=-:..:-------=--:::::::-=*%##@@@@@@@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@*+=-:::-=-:::-----------==+#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#+==--++-:...-:..:::::=%%%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%%#@#=--::-=::::-##@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@[email protected]+=--=#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@%@@@@%#%@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    //
//                                                                                                  //
//                                                                                                  //
//                                                                                                  //
//////////////////////////////////////////////////////////////////////////////////////////////////////


contract L2 is ERC721Creator {
    constructor() ERC721Creator("Layer2", "L2") {}
}