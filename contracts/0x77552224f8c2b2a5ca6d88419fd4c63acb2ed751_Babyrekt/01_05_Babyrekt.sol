// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Babyrekt
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

//////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                  //
//                                                                                                  //
//    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@####SSSSSSSS##@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@##SS%%%%%%%??????%SS##@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@##S%?*??%%?*******????%SS#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@@@@@@@@#SS%?**?**+***?%??*+**+*??%%S#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@@@@@@@#S%?????+*%###SSS#@@@@S*;;*??%S#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@@@@@@#S%???%%;%#%SS###SS#SSS*?S*;????S#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@@@@@@#S%??%S+?S%S#SS#@@@@#S%?*+%*;***?S#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@@@@@@##S%%SS+#@#S?#@##@@@#@@@%?S%:***?%#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@@@@@@@#S%%SS+#%#?##;::#@;:[email protected]@@*S?:*?*?%#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@@@@@@@#S%%%S+S?%%@S:*;#S:[email protected]@@*S%:????S#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@@@@@@@#S%?%S*?*%[email protected]@%%SSS%%#@@%%@*:?*?%S#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@@@@@@@#S%??%[email protected]@@@%;[email protected]@@@%%#?:*???S#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@@@@@@##S%??%%:?%%[email protected]@@S#@@@@%S#%:*%??%S#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@@@@##S%%??%%+;S#@#%#@#@S##%[email protected]#;*%?*?%S#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@@##S%%%%%?++?#@@#@@?%S###%*[email protected];;??**?%SS##@@@@@@@@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@##S%%%%*++?%[email protected]@##@S%SSS##S%##SS#?;+*?????%%SS#@@@@@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@##S%??*+;[email protected]@@#SS%#@#S#@#??#@#@@@@SS%*****?????%S#@@@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@##S%%%*;;**%@@@#SS#####@#%?%####@@@#%%%#%SS?***???%S#@@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@#S%?%*:?#SS#@@#[email protected]@@?+S#S%?%%[email protected]@##[email protected]%?S#[email protected]##S%+*??%S#@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@#S%???:[email protected]##@@@@###@@%%#@@#S#[email protected]@@S##@#**%#S*%@@#@%;%%%S#@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@#S%??*:[email protected]@##SS#@@@@@@@@@#?*?%%%%%%??%S#@#?S####@%;SSS##@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@#S%%%+;[email protected]@#S#[email protected]####@@#@S;........,%#%%#@@#@@@@%+%###@@@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@####%*+?%S####[email protected]@#@#%;,...,,.:#S%S##S##[email protected]#@@@@@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@@@@#S%???????%@@@@@#*,.....,*#@@@SS#SS##@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@#%???%#@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    //
//    @@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    //
//                                                                                                  //
//                                                                                                  //
//////////////////////////////////////////////////////////////////////////////////////////////////////


contract Babyrekt is ERC721Creator {
    constructor() ERC721Creator("Babyrekt", "Babyrekt") {}
}