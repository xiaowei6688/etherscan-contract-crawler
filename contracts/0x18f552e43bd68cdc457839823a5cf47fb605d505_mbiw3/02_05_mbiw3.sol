// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: midibot - internet and web3
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                         //
//                                                                                                                                         //
//                                                                                                                                         //
//         :@@@@@@@@@@@@@@@@@@@@   :@@@@@  :@@@@@@@@@@@@@@@@   :@@@@@  :@@@@@@@@@@@@@@@@   :@@@@@@@@@@@@@@@@@  :@@@@@@@@@@@@@@@@@@@        //
//        ::@@@@@@@@@@@@@@@@@@@@@ ::@@@@@ ::@@@@@@@@@@@@@@@@@ ::@@@@@ ::@@@@@@@@@@@@@@@@@ ::@@@@@@@@@@@@@@@@@ ::@@@@@@@@@@@@@@@@@@@        //
//        ::@@@@@:::@@@@@:::@@@@@ ::@@@@@ ::::::::::::::@@@@@ ::@@@@@ ::::::::::::::@@@@@ ::@@@@@:::::::@@@@@ :::::::::@@@@@::::::'        //
//        ::@@@@@ ::@@@@@ ::@@@@@ ::@@@@@ ::@@@@@     ::@@@@@ ::@@@@@ ::@@@@@     ::@@@@@ ::@@@@@     ::@@@@@        ::@@@@@               //
//        ::@@@@@ ::@@@@@ ::@@@@@ ::@@@@@ ::@@@@@     ::@@@@@ ::@@@@@ ::@@@@@ :@@@@@@@@@@ ::@@@@@     ::@@@@@        ::@@@@@               //
//        ::@@@@@ ::@@@@@ ::@@@@@ ::@@@@@ ::@@@@@     ::@@@@@ ::@@@@@ ::@@@@@::@@@@@@@@@@ ::@@@@@     ::@@@@@        ::@@@@@               //
//        ::@@@@@ ::@@@@@ ::@@@@@ ::@@@@@ ::@@@@@     ::@@@@@ ::@@@@@ ::@@@@@:::::::@@@@@ ::@@@@@     ::@@@@@        ::@@@@@               //
//        ::@@@@@ ::@@@@@ ::@@@@@ ::@@@@@ ::@@@@@     ::@@@@@ ::@@@@@ ::@@@@@     ::@@@@@ ::@@@@@     ::@@@@@        ::@@@@@               //
//        ::@@@@@ ::@@@@@ ::@@@@@ ::@@@@@ ::@@@@@@@@@@@@@@@@@ ::@@@@@ ::@@@@@@@@@@@@@@@@@ ::@@@@@@@@@@@@@@@@@        ::@@@@@               //
//        ::@@@@@ ::@@@@@ ::@@@@@ ::@@@@@ ::@@@@@@@@@@@@@@@@  ::@@@@@ ::@@@@@@@@@@@@@@@@  ::@@@@@@@@@@@@@@@@@        ::@@@@@               //
//        ::::::' ::::::' ::::::' ::::::' :::::::::::::::::'  ::::::' ::::::::::::::::::' ::::::::::::::::::'        ::::::'               //
//                                                                                                                                         //
//                                                                                                                                         //
//                                                                                                                                         //
/////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract mbiw3 is ERC1155Creator {
    constructor() ERC1155Creator("midibot - internet and web3", "mbiw3") {}
}