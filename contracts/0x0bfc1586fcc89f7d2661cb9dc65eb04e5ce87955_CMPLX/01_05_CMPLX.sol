// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: CMPLX
/// @author: manifold.xyz

import "./ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////
//                                                                    //
//                                                                    //
//     __________________________________________________________     //
//    |                                                          |    //
//    |   ______     __    __     ______   __         __  __     |    //
//    |  /\  ___\   /\ "-./  \   /\  == \ /\ \       /\_\_\_\    |    //
//    |  \ \ \____  \ \ \-./\ \  \ \  _-/ \ \ \____  \/_/\_\/_   |    //
//    |   \ \_____\  \ \_\ \ \_\  \ \_\    \ \_____\   /\_\/\_\  |    //
//    |    \/_____/   \/_/  \/_/   \/_/     \/_____/   \/_/\/_/  |    //
//    |                                                          |    //
//    |             A CMPLX original work | c. 2022              |    //
//    |__________________________________________________________|    //
//    |                                                          |    //
//    |MMMMMMMMMWWWNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNWWMMMMMMMM|    //
//    |MMMMWKkolc::;:;;;,;,'''''''''''''''''''''''''''',;cokKWMMM|    //
//    |MMXkc'...............                                .:ONM|    //
//    |W0:...................                                 .lX|    //
//    |O:......................                                 c|    //
//    |c........       ........                                 .|    //
//    |,.......         .......                                  |    //
//    |'.......         .......                                  |    //
//    |'.......         .......                                  |    //
//    |'.......         _________________________________________|    //
//    |'.......                                 |;dddddddddddddddO    //
//    |'.......                                 |xMMMMMMMMMMMMMMMM    //
//    |'.......                                 |xMMMMMMMMMMMMMMMM    //
//    |'.......                                 |xMMMMMMMMMMMMMMMM    //
//    |'.......                                 |xMMMMMMMMMMMMMMMM    //
//    |'.......                                 |xMMMMMMMMMMMMMMMM    //
//    |'.......                                 |xMMMMMMMMMMMMMMMM    //
//    |........                                 |dNNNNNNNNNNNNNNNW    //
//    |........         _________________________________________|    //
//    |'.......         .......                                  |    //
//    |'.......         .......                                  |    //
//    |'.......         .......                                  |    //
//    |,.......         .......                                  |    //
//    |:........       ........                                  |    //
//    |x,........ . ...........                                 '|    //
//    |Nx,....................                                 .k|    //
//    |MWk:'.................                                .:0W|    //
//    |MMMNOdc,'..........                               ..;o0WMM|    //
//    |MMMMMMWX0OkkkkxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxkOKXWMMMMM|    //
//    |MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM|    //
//    |__________________________________________________________|    //
//                                                                    //
//                                                                    //
////////////////////////////////////////////////////////////////////////


contract CMPLX is ERC721Creator {
    constructor() ERC721Creator("CMPLX", "CMPLX") {}
}