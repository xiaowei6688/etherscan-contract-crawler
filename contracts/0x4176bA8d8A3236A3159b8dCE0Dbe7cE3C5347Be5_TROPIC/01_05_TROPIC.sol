// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: TROPICAL PARADISE
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                        //
//                                                                                        //
//    (&@&@&@&@@@&%&%&%&@@&@@(@&@@@&@&%#&@&@@%%@@&&@@@@@&@&@#@&%@%@&@&&&%&%@%&&%@&&%(&    //
//    @@@@&%@&%#&%&&@%&&&&/%&@%@@&&&@%&%%%&@@@@&%%&((&#%%&@&@@&&&@&#&&@&&@@@@&&@#@%&&%    //
//    &#&&@&&&@@&&#&&@@@&&%&&@&@&&@@@@&&&&&@@&@&#%@@%&&@&@@#&#@&@&#&@&%@@%&&@&@@&&%@@&    //
//    %%(&#&&&&/(&%&&%@%@&&&&@@&@(&#&((&%&#&&%#&@@%&&@@&(&%%&@&#@&%#(@&@&@@@@&&%&&&&&&    //
//    &@#%(@&#&%%@&&&%@%@%&@%&&@&@&@#@@@&&@&/%&(%&@&@&@&&%&&&@%&&&%%##@&&&@&&@%%&%(%%&    //
//    %%&@%@&&%%&#%@##&@@@&@&@%%&@&&@&@&%&@%#%@&&@&%&#@(%#&@@@@@@%&&%&&@(%@&&&&%&&%#@%    //
//    %(&%%&@%@&&&&@&&%%#%(&&&&&&%&&%&%@&&#@@@@%@@%&%&&&&#%&(@&&##@&@&&&%&&&@&@%&&&@&&    //
//    &%&%&&&&&@##%@&&@%%&&%&&&&%%@@&#%##@%@&&@%&#@&%&&&(%&%#&@&%&&&#%&%&###(@%((&%%%#    //
//    %%%%&&%%%#&&#&#%%%#(@&%%&&&%&%&&&%#%#*/(#&&%%%%&#%##&&&%%%%&(&%#@@%%##%%(#/#***(    //
//    /*##((((##%&%##/(/*,//*((,/*,*......./#(#//,/*,(%#%,....*#%%%%(%%%((...,........    //
//    .........*.*,................../..,........,.,.*,*,.,*,,.,*,,/****,,,,*,,,.,,,,.    //
//    ,,,*,.,,,*,**,*,,,*,***,,,,*,****,,.,,/,,,,,,/,,*****,*,,,*,**,*,*,,****,,,***,*    //
//    **/******,*****,*****/********//****/*****,*,***,***************************,**,    //
//    /*/****/****/********************************,,****,*,***,*,********,***********    //
//    ,*********//**********/***/***********,******/*,**,****/****,***,********//**/**    //
//    ,,,********,,,,****,,,,,,***,************,**,*******,,************,**,**********    //
//    **,***,******,,,,.,,,,..,,,,*..,,*,.,*..,,,,,*,,,,.,,...,**.,******,,,,*******,.    //
//    *,/***********/***********/*,****,,.*.*..,...,,,.,,.,,.,.....,,.....*******,****    //
//    ************,*********************,.,*,,,,,,,,,,..,.*,.,,,..*,*.,***********/***    //
//    **************************/**************,*****.,*,**,*,******/***********/*//**    //
//    *.**.*....******.****/*************/*********************************/*****/****    //
//    /**//***///**//****,*//*/***....,,**/*******/***********************************    //
//    /********/*/*///***///**/*********//**///**//**,,*************************/*****    //
//    **///*/***//***/***//***//******/***********************//*////*****/****///*///    //
//    ////***//*////////////***///////*/**/**/*/*/*/////*//////*///(//((/(*//(/*//(///    //
//    (/((//(//////(/(//(//**/(/(//(((((/(//(/(/(//((///////#//(//(///(//#/(#/(/((/#/#    //
//    (((((#((//(/##((//((((((//(((/(/(#(((((/((//////(//(#((//(//(((((#/((##/##/(/###    //
//    ##(#(##(#(###(((((((((((((((((##((#(/(((((#(((((((((#(((((##(((#((((#(##((/(###(    //
//    ######(#(((((##((#(#(##(#########((###((((##((#(##((((#(##(((((#((#(####(##(##(#    //
//    ###(#(((#(##((#((##((((##(#((((#(((#(((##(#(##(((((##(#(##((((##(#(##((##(###(##    //
//    #(###(#(######((###(##((##(((((#(#(#((##((###(#(#####(###(#(#(####(####(########    //
//    ###########(######(########(#(##(######(##########(###########(#(###############    //
//    ##%########%%##%##########(##(##(%##(##########(#####(########(##(######%##%####    //
//    #%#####%#####%##%##%#%#############%#%%%##%####%#%%%#%%%#%%%%#%%#%%%#%#%%#%##%%%    //
//    %&%%%%%%%%%%&&%%%%%%&%%%#%%&%%%%%#%%%%%%&%&%%%&%%%%%&&%%%%%%%%%%%%%%&%&%%%&&&%%%    //
//    &&&&&&&&&%%%%%&%%&&&&%&%%%&&&%&%%&&&%&%&&%%%%%%&%%%%&%%&&&&%&&&%%&%&&&%%%&%&&&&&    //
//    @&&&&&&&&&%%&&&%%%&&&&&%&&&&&&&&&%%&&%&&&&&&%&&&&&&&&&&&&%&&&&&&&&&&&&&&@&&&&@@&    //
//    &&&&&&&@&@&&&&&@&&&@@&&&&&&@@&@@@&@&@&&&&@&&&&&&&@&&&&&&&@&&&@&&@@@@@@@@&@&&@@&&    //
//    @@@@@@@@@@&@@@@@@@@@@@&&@&@@@@&@@@&@@@@@@@@@@@@@@&@@@@&&&@@@&&&&@@@@@@@@@@@@@@@@    //
//    &@@@@@@@@@@@@@@@@@@@@@@@@@@@@@&@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@@    //
//                                                                                        //
//                                                                                        //
////////////////////////////////////////////////////////////////////////////////////////////


contract TROPIC is ERC721Creator {
    constructor() ERC721Creator("TROPICAL PARADISE", "TROPIC") {}
}