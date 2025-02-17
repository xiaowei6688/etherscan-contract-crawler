// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Buddha's Delight
/// @author: manifold.xyz

import "./ERC721Creator.sol";

//////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                  //
//                                                                                                  //
//    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::    //
//    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::    //
//    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::    //
//    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::    //
//    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::    //
//    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::    //
//    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::    //
//    ::::::::::::::::::::::::::::::::::::-==*#*+*=:::::::::::::::::::::::::::::::::::::::::::::    //
//    :::::::::::::::::::::::::::::::::=*%@@@@@@@@@%#*::::::::::::::::::::::::::::::::::::::::::    //
//    :::::::::::::::::::::::::::::::-#@@@@@@@@@@@@@@@%#::::::::::::::::::::::::::::::::::::::::    //
//    ::::::::::::::::::::::::::::::[email protected]@@@@@@@@@@@@@@@@@@*-::::::::::::::::::::::::::::::::::::::    //
//    :::::::::::::::::::::::::::::[email protected]@@@@@@@@@@@@@@@@@@@@*::::::::::::::::::::::::::::::::::::::    //
//    :::::::::::::::::::::::::::::*@@@@@@@@@@@@@@@@@@@@@@-:::::::::::::::::::::::::::::::::::::    //
//    :::::::::::::::::::::::::::::*@@@@@@@@@@@@@@@@@@@@@@-:::::::::::::::::::::::::::::::::::::    //
//    :::::::::::::::::::::::::::::*@@@@@@@@@%@@@@@@@@@@@#::::::::::::::::::::::::::::::::::::::    //
//    ::::::::::::::::::::::::::::::[email protected]@@@@@@@@%@@@@@@@@@%-::::::::::::::::::::::::::::::::::::::    //
//    :::::::::::::::::::::::::::::::[email protected]@@@@@@@@@@@@@@@@@=:::::::::::::::::::::::::::::::::::::::    //
//    ::::::::::::::::::::::::::::::::[email protected]@@@@@@#*%@@@@@@-::::::::::::::::::::::::::::::::::::::::    //
//    :::::::::::::::::::::::::::::::::=*#*%@@@@@@%==-::::::::::::::::::::::::::::::::::::::::::    //
//    ::::::::::::::::::::::::::::::-=++****#@@@@#=--:::::::::::::::::::::::::::::::::::::::::::    //
//    :::::::::::::::::::::::::::::-=+******@@@@@@@***++==::::::::::::::::::::::::::::::::::::::    //
//    :::::::::::::::::::::::::::::    .-+**%@@@@@@%**+-...:::::::::::::::::::::::::::::::::::::    //
//    :::::::::::::::::::::::::::::.  .:-=+**%@@@@@@*=:...  ..::::::::::::::::::::::::::::::::::    //
//    :::::::::::::::::::::::::::::: .-=+*****%@@@@@*****-      .:::::::::::::::::::::::::::::::    //
//    ::::::::::::::::::::::::::::-#@.   +-=***%@@@@***=:::..     ..::::::::::::::::::::::::::::    //
//    :::::::::::::::::::::::::::[email protected]@@*   =%. :+*%@@@*+::::::::.      -+=-:::::::::::::::::::::::    //
//    ::::::::::::::::::::::::::[email protected]@@@@    @%.   -#@@= .::::-=:       :@@@@#=::::::::::::::::::::    //
//    ::::::::::::::::::::::::::@@@@@@-   [email protected]#     [email protected]   :+%@@#         . :+%@%-::::::::::::::::::    //
//    ::::::::::::::::::::::::::@@@@@@+    [email protected]=     :    *@@%         [email protected]@#- [email protected]@+:::::::::::::::::    //
//    ::::::::::::::::::::::::::[email protected]@@@@*     +%     .:    .:  [email protected]#=    [email protected]@@@+ *@@-::::::::::::::::    //
//    :::::::::::::::::::::::::::[email protected]@@@#      +              [email protected]@@@%-   @@@@% [email protected]@+::::::::::::::::    //
//    :::::::::::::::::::::::::-=+*@@@*         ..          *#@@@%*=  [email protected]@@: [email protected]@=::::::::::::::::    //
//    ::::::::::::::::::::::=#@@@@@@@@=  =       .+.    .   * @[email protected]@:   -:  [email protected]@%:::::::::::::::::    //
//    ::::::::::::::::::::-%@@@@@@@@@@. *-       [email protected]   =-  * #=+-:.     =%@@#::::::::::::::::::    //
//    :::::::::::::::::::[email protected]@@@@@@@@@@+ :@      .#@@@@-  [email protected]  @::.         :%#=:::::::::::::::::::    //
//    :::::::::::::::::::#@@@@@@@@@@+  [email protected]      [email protected]@@@@@: [email protected]# @@+:=#%%%###*=::::::::::::::::::::::    //
//    :::::::::::::::::::@@@@@@@@@@%%%@@@       [email protected]@@@@@[email protected]@*@@@@@@@#*@%=::::::::::::::::::::::::    //
//    :::::::::::::::::::#@@@@@@@@@@@@@@@:       [email protected]@@@@#[email protected]@@@@@@@@- [email protected]@@%+::::::::::::::::::::::    //
//    :::::::::::::::::::[email protected]@@@@@@@@@@@@@@-        [email protected]@@@@%@@@@@@@@@*[email protected]@@@@%-::::::::::::::::::::    //
//    :::::::::::::::::::::#@@@@@@@@@@@@@-         [email protected]@@@@@@@@@@@@@@@[email protected]@@@@%::::::::::::::::::::    //
//    ::::::::::::::::::::::-+%@@@@@@@@@@=          [email protected]@@@@@@@@@%%%@@@#%@@@@@::::::::::::::::::::    //
//    :::::::::::::::::::::::::-*@@@@@@@@-           %@@@@@#-      :*@@@@@@@::::::::::::::::::::    //
//    :::::::::::::::::::::::=#@@@@@@@@@@.      :+###@@@@@-    :-:   [email protected]@@@@+::::::::::::::::::::    //
//    :::::::::::::::::::::-%@*=--=+%@@@*      *@@@@@@@@@=   [email protected]@@@%.  *@@@+:::::::::::::::::::::    //
//    :::::::::::::::::::::%*        .**      [email protected]@@@@@@@@@.  :@@@@@@-  #@+:::::::::::::::::::::::    //
//    ::::::::::::::::::::=%  .#@@@#:         %@@@@@@@@@@+   +%@@#-  [email protected]::::::::::::::::::::::::    //
//    ::::::::::::::::::::+#  [email protected]@@@@@=   :. .*@@@@@@@@@@@@+.       .*%=:::::::::::::::::::::::::    //
//    ::::::::::::::::::::[email protected] .%@@@@@#   @@@=:#@@@@@@@@@@@@@#+===*%#=:::::::::::::::::::::::::::    //
//    :::::::::::::::::::::=%:  =#%%*.  :@@#  @@@@@@@@@@@@@@@@@@@@@=::::::::::::::::::::::::::::    //
//    ::::::::::::::::::::::-#*:       -%@@- *@@@@@@@@@@@@@@@@@@@@@+::::::::::::::::::::::::::::    //
//    ::::::::::::::::::::::::-*#*+++*@@%*+.#@@@@@@@@@@@@@@@@@@@@@@#::::::::::::::::::::::::::::    //
//    ::::::::::::::::::::::::::::-===-::+**[email protected]@@@@@@@@@@@@@@@@@@@@@@::::::::::::::::::::::::::::    //
//    :::::::::::::::::::::::::::::::::::=:::@@@@@@@@@@@@@@@@@@@@@@@-:::::::::::::::::::::::::::    //
//    :::::::::::::::::::::::::::::::::::::::%@@@@@@@@@@@@@@@@@@@@@@=:::::::::::::::::::::::::::    //
//    :::::::::::::::::::::::::::::::::::::::#@@@@@@@@@@@@@@@@@@@@@@*:::::::::::::::::::::::::::    //
//    :::::::::::::::::::::::::::::::::::::::[email protected]@@@@@@@@@@@@@@@@@@@@@#:::::::::::::::::::::::::::    //
//    :::::::::::::::::::::::::::::::::::::::[email protected]@@@@@@@@@@@@@@@@@@@@@%:::::::::::::::::::::::::::    //
//    ::::::::::::::::::::::::::::::::::::::::@@@@@@@@@@@@@@@@@@@@@@@:::::::::::::::::::::::::::    //
//    ::::::::::::::::::::::::::::::::::::::::*@@@@@@@@@@@@@@@@@@@@@@:::::::::::::::::::::::::::    //
//    ::::::::::::::::::::::::::::::::::::::::[email protected]@@@@@@@@@@@@@@@@@@@@=:::::::::::::::::::::::::::    //
//    :::::::::::::::::::::::::::::::::::::::::@@@@@@#@@@@@@@@@@@@@*::::::::::::::::::::::::::::    //
//    :::::::::::::::::::::::::::::::::::::::::*@@@@@[email protected]@@@@@@@@@@@+:::::::::::::::::::::::::::::    //
//    ::::::::::::::::::::::::::::::::::::::::::@@@@@[email protected]@@@@@@@@@=::::::::::::::::::::::::::::::    //
//    ::::::::::::::::::::::::::::::::::::::::::[email protected]@@@@#-=#@@@%%@=:::::::::::::::::::::::::::::::    //
//    :::::::::::::::::::::::::::::::::::::::::::[email protected]@@@@@@**##@@=::::::::::::::::::::::::::::::::    //
//    ::::::::::::::::::::::::::::::::::::::::::::[email protected]@@@@@@@@@@-:::::::::::::::::::::::::::::::::    //
//    :::::::::::::::::::::::::::::::::::::::::::::-%@@@@@@@@-::::::::::::::::::::::::::::::::::    //
//    :::::::::::::::::::::::::::::::::::::::::::::::*@@@@@@-:::::::::::::::::::::::::::::::::::    //
//    :::::::::::::::::::::::::::::::::::::::::::::::::+##+:::::::::::::::::::::::::::::::::::::    //
//    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::    //
//    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::    //
//    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::    //
//    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::    //
//    ::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::    //
//                                                                                                  //
//                                                                                                  //
//                                                                                                  //
//////////////////////////////////////////////////////////////////////////////////////////////////////


contract BD is ERC721Creator {
    constructor() ERC721Creator("Buddha's Delight", "BD") {}
}