// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Still Lives
/// @author: manifold.xyz

import "./ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                        //
//                                                                                        //
//    ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,**,,,,,,,,,,,,,    //
//    ,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,    //
//    ,,,,,,,,,,,,,,,,,,,,,,,,,,,*(%%%%%%(*%,,,,,,,,,,,,,,,gremlin,,,,,,,,,,,,,,,,,,,,    //
//    ,,**,***,*,,,,,,,,,/%%%%%%%%%%%%%%%%%%%%%%#%*,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,    //
//    **,,,,,,,,,,,,,#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%###(,,,,,,,,,,,,,,,,,,,&,,,,,,,,,,,    //
//    ,,,,,,,,,,,,%%%%%%%%%%%%%%%%%&&&&&&&&&%%%%%%%%%%###(,,,,,,,,,,,,,,,,,,,,,,,,,,,,    //
//    ,,,,,,,,,,%%%%%%%%%%%&@@@&&%%(/*,,,**/(&&@@&%%%%%%####,,,,,,,,,,,,,,,,,,,,,,,,,,    //
//    *..,,,,,%%%%%%%%%%&@%(****/**/%&#%&&#(/*,,,(&@&%%%%%%###,,,,,,,,,,,,,,,,,,,,,,,,    //
//    *..,,,*%%%%%%%%&&%(/(##(/***,*#&@@%******/*,.,#@@&%%%%%##,,,,,,,,,,,,,,,,,,,,,,,    //
//    *..,,%%%%%%%&&%(//%&&%(*,,*,   ,/*...****,*(((**(&&%%%%%##/,,,,,,,,,,,,,,,,bb,,,    //
//    ,,..(%%%%%%%&#**(&@@&#/*,...  *'.     **.*(%@@@@%//%&%%%%%%#,,,,,,,,,,,,,,,,,,,,    //
//    ,,,,%%%%%%&&(***,  .((/,..,****/****,.'   .,,,,(&((%&&%%%#%%,,,,,,,,,,,,,,,,,,,     //
//    ,,,#%%%%%%%#*,******,,,,*/(((/******//,.   ,...,/(*/%&%%%#%#*,,,,,,,,,,,,,,,,,,,    //
//    ,,,**%%%%%%%%(*/(/*,,,***/((//*,,******//*...,,,,*****#&%%%%%,,,,,,**,,,,,,,,,,,    //
//    ,,,*%%%%%%%%#//#&%(***,,////****///****//,..,,,*//**/#&&%%%%%(,,,,**,,,,,,,,,,,,    //
//    ,,.*%%%%%%%#/*(&@@&#/*.,*///****,,,,,*//*,,*(&@&%#//#&&%%%%%,,,,,,,,,,,,,,,,,,,,    //
//    **,,%%%%%%%%#/,. ,(//**,.,***,,*,,,****,,,,*//(%&#//#&%%%%%%,,,,,,,,,,,,,,,,,,,,    //
//    *****%%%%%###/*,,**/**/*,,,.,,,,*****,,,****,,.*##(#%%%%%%%/////////////////////    //
//    ******%%%%%###(/*,,**////*/*,,*,,,,*//((/,*******(%%%%%%%%********//////////////    //
//    *******%%%%%%%##(////(#&@@@&#/*/*//(%@&&&#*****/%&%%%%%%%***********************    //
//    *********%%%%%%%%%#(/*, .*/(/*****///#&%(*,*(%%%%%%%%%%*************************    //
//    *****//////%%%%%%##%%##(/*********,,,*//(#%%%%%%%%%%%***************************    //
//    *************/%%%%%%%#################%%%%%%%%%%%%******************************    //
//    *****************%%%%%%%%%%%%%%%%%%%%%%%%%%%%%#*********************************    //
//    **********************(%%%%%%%%%%%%%%%%%%/**************************************    //
//    ********************************************************************************    //
//                                                                                        //
//                                                                                        //
////////////////////////////////////////////////////////////////////////////////////////////


contract WHEEL is ERC721Creator {
    constructor() ERC721Creator("Still Lives", "WHEEL") {}
}