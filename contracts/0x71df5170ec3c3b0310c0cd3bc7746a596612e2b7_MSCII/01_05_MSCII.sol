// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: MASTERSCII
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

////////////////////////////////////////////////////////////
//                                                        //
//                                                        //
//    :::::::::  :::       :::  ::::::::      :::         //
//    :+:    :+: :+:       :+: :+:    :+:   :+: :+:       //
//    +:+    +:+ +:+       +:+ +:+         +:+   +:+      //
//    +#++:++#+  +#+  +:+  +#+ +#+        +#++:++#++:     //
//    +#+    +#+ +#+ +#+#+ +#+ +#+        +#+     +#+     //
//    #+#    #+#  #+#+# #+#+#  #+#    #+# #+#     #+#     //
//    #########    ###   ###    ########  ###     ###     //
//                                                        //
//                                                        //
////////////////////////////////////////////////////////////


contract MSCII is ERC721Creator {
    constructor() ERC721Creator("MASTERSCII", "MSCII") {}
}