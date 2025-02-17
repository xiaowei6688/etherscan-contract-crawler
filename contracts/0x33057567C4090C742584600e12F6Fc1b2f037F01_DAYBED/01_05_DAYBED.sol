// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Daybed 6328
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

//////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                  //
//                                                                                                  //
//                                                                                                  //
//    ██████╗░░█████╗░██╗░░░██╗██████╗░███████╗██████╗░███╗░░██╗███████╗████████╗                   //
//    ██╔══██╗██╔══██╗╚██╗░██╔╝██╔══██╗██╔════╝██╔══██╗████╗░██║██╔════╝╚══██╔══╝                   //
//    ██║░░██║███████║░╚████╔╝░██████╦╝█████╗░░██║░░██║██╔██╗██║█████╗░░░░░██║░░░                   //
//    ██║░░██║██╔══██║░░╚██╔╝░░██╔══██╗██╔══╝░░██║░░██║██║╚████║██╔══╝░░░░░██║░░░                   //
//    ██████╔╝██║░░██║░░░██║░░░██████╦╝███████╗██████╔╝██║░╚███║██║░░░░░░░░██║░░░                   //
//    ╚═════╝░╚═╝░░╚═╝░░░╚═╝░░░╚═════╝░╚══════╝╚═════╝░╚═╝░░╚══╝╚═╝░░░░░░░░╚═╝░░░                   //
//                                                                                                  //
//    ░█████╗░██████╗░██████╗░░█████╗░                                                              //
//    ██╔═══╝░╚════██╗╚════██╗██╔══██╗                                                              //
//    ██████╗░░█████╔╝░░███╔═╝╚█████╔╝                                                              //
//    ██╔══██╗░╚═══██╗██╔══╝░░██╔══██╗                                                              //
//    ╚█████╔╝██████╔╝███████╗╚█████╔╝                                                              //
//    ░╚════╝░╚═════╝░╚══════╝░╚════╝░                                                              //
//                                                                                                  //
//    ---------------------------------------------------------------------                         //
//    ---------------------------------------------------------------------                         //
//    -------------------------------==++***####*+=------------------------                         //
//    --------------------------==+*#%%%%%%%%%%%%%#+-----------------------                         //
//    ----------------------=+*#%%%%%%%%%%%%%%%%%%%%=----------------------                         //
//    ------------------=+*#%%%%%%%%%%%%%%%%%%%%%%%@+----------------------                         //
//    ---------------=+*%%%%%%%%%%%%%%%%%%%%%%%%%%%+-----------------------                         //
//    -------------=*%%%%%%%%%%%%%%%%%@@@@@@@@@@@#=------------------------                         //
//    -----------+#%%%%%%%%%%%@@@@@@@@@%%%%%%%%%%+=------------------------                         //
//    ---------=#@@%%@@@@@@@@@@@@%%%%%%%%##%%%%%%%=------------------------                         //
//    ---------*@@@@@@@@@@@@@@%@%%%%%%@@@@@@@@@%@%*+=----------------------                         //
//    ---------=#@@@@@@@@@@%%#%%@@@@@%%%%%%%%%%%%%%%%*+=-------------------                         //
//    -------=*+*#%%%@@@%%%%@@@@@%%%%%%%%%%%%%%%%%%%%%%#*=-----------------                         //
//    ------+*#%%##%#%%%%%@%#%@@@@@@@@@@%%@@@@%%%@@%%%%%%+=----------------                         //
//    -----+##*+****#@@%@@@%@####%%%%%#@###@##%%#%##@%##%%+----------------                         //
//    ----+#@***++***#%%###%@##%%%%%%%*@%*%@#%%%#%#*@#***##----------------                         //
//    [email protected]@#++++**+++#@**##@%%%%##%%#%@#*%@%%%%%#**%+*+*%*----------------                         //
//    ---=#%%++++*[email protected]@%%%@@###%%%#%%####%%######%**+*%*=----------------                         //
//    ----*%@*+++*++++*#@%%%@@%%*####*++++*#+###*#*++*#@*=-----------------                         //
//    ----=#*##+++++**+##+**#%#***%%%%%#++##%%%#*#***#*=-------------------                         //
//    -----=+*%%******%%#@@@#**%#%%##*++*+#+++*%%###*=---------------------                         //
//    -------=+*+++**++%#%#@*+*%%*+++**+++#+++++##==-----------------------                         //
//    ----------------+%@#%%%##@#+++++++++#++****%=------------------------                         //
//    ----------------#%%#@%@#*#***********#*****#+------------------------                         //
//    ---------------=#@@@#*%##************###*****+-----------------------                         //
//    ---------------+%%##*#%#**************##*****#=----------------------                         //
//    ---------------**@%@#@#******#********##*#*****----------------------                         //
//    [email protected]#@@@*****************#%****##----------------------                         //
//    ----------------=*#@@@#*****************##**##*----------------------                         //
//    ------------------==*#%%#*******#***###*##***#=----------------------                         //
//    ----------------------+*%@%####*********#####*-----------------------                         //
//    ------------------------=====++++++*++++++++=------------------------                         //
//                                                                                                  //
//    ░█████╗░██╗░░██╗███████╗███████╗████████╗░█████╗░██╗░░██╗                                     //
//    ██╔══██╗██║░░██║██╔════╝██╔════╝╚══██╔══╝██╔══██╗██║░░██║                                     //
//    ██║░░╚═╝███████║█████╗░░█████╗░░░░░██║░░░███████║███████║                                     //
//    ██║░░██╗██╔══██║██╔══╝░░██╔══╝░░░░░██║░░░██╔══██║██╔══██║                                     //
//    ╚█████╔╝██║░░██║███████╗███████╗░░░██║░░░██║░░██║██║░░██║                                     //
//    ░╚════╝░╚═╝░░╚═╝╚══════╝╚══════╝░░░╚═╝░░░╚═╝░░╚═╝╚═╝░░╚═╝                                     //
//                                                                                                  //
//    ░██████╗░░█████╗░███╗░░██╗░██████╗░                                                           //
//    ██╔════╝░██╔══██╗████╗░██║██╔════╝░                                                           //
//    ██║░░██╗░███████║██╔██╗██║██║░░██╗░                                                           //
//    ██║░░╚██╗██╔══██║██║╚████║██║░░╚██╗                                                           //
//    ╚██████╔╝██║░░██║██║░╚███║╚██████╔╝                                                           //
//    ░╚═════╝░╚═╝░░╚═╝╚═╝░░╚══╝░╚═════╝░                                                           //
//                                                                                                  //
//                                                                                                  //
//                                                                                                  //
//////////////////////////////////////////////////////////////////////////////////////////////////////


contract DAYBED is ERC1155Creator {
    constructor() ERC1155Creator("Daybed 6328", "DAYBED") {}
}