// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: RASCALS GENESIS
/// @author: manifold.xyz

import "./ERC721Creator.sol";

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                           //
//                                                                                                                                           //
//    '  ================================================================================================================================    //
//    '  ___________==========_____====================_____==========_____=======_____=======_____========================_____=========    //
//    '  \==========\=======/======|_=============_____\====\====_____\====\_===/======|_====|\====\==================_____\====\========    //
//    '  =\====/\====\=====/=========\===========/====/=\====|==/=====/|=====|=/=========\====\\====\================/====/=\====|=======    //
//    '  ==|===\_\====|===|=====/\====\=========|====|==/___/|=/=====/=/____/||=====/\====\====\\====\==============|====|==/___/|=======    //
//    '  ==|======___/====|====|==|====\=====____\====\=|===|||=====|=|____|/=|====|==|====\====\|====|=______===____\====\=|===||=======    //
//    '  ==|======\==____=|=====\/======\===/====/\====\|___|/|=====|==_____==|=====\/======\====|====|/======\=/====/\====\|___|/=======    //
//    '  =/=====/\=\/====\|\======/\=====\=|====|/=\====\=====|\=====\|\====\=|\======/\=====\===/============||====|/=\====\============    //
//    '  /_____/=|\______||=\_____\=\_____\|\____\=/____/|====|=\_____\|====|=|=\_____\=\_____\=/_____/\_____/||\____\=/____/|===========    //
//    '  |=====|=|=|=====||=|=====|=|=====||=|===||====|=|====|=|=====/____/|=|=|=====|=|=====||======|=|====|||=|===||====|=|===========    //
//    '  |_____|/=\|_____|=\|_____|\|_____|=\|___||____|/======\|_____|====||==\|_____|\|_____||______|/|____|/=\|___||____|/============    //
//    '  =============================================================|____|/============================================================    //
//                                                                                                                                           //
//                                                                                                                                           //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract RSCLS is ERC721Creator {
    constructor() ERC721Creator("RASCALS GENESIS", "RSCLS") {}
}