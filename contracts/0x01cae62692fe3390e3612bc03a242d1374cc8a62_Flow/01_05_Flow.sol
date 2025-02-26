// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Flow - Paul Wilson
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                    //
//                                                                                                                                    //
//                                                                                                                                    //
//        ________________________________________________________________________________________________________________________    //
//        ________________________________________________________________________________________________________________________    //
//        ________________________________________________________________________________________________________________________    //
//        ________________________________________________________________________________________________________________________    //
//        ________________________________________________________________________________________________________________________    //
//        ___________________________________________________________Æ█___________________________________________________________    //
//        __________________________________________________________▐▌▓█__________________________________________________________    //
//        __________________________________________________________▀░▓█▌_________________________________________________________    //
//        _________________________________________________________▌░├▓▓█µ________________________________________________________    //
//        ________________________________________________________Æ░░▓▓█▓█________________________________________________________    //
//        _______________________________________________________╒░░▒▌▓██▓█_______________________________________________________    //
//        _______________________________________________________░░░▒▌▓████▌______________________________________________________    //
//        ______________________________________________________╜▒▒▒▓▓▓█████______________________________________________________    //
//        _____________________________________________________(░▒▒▒▒▓▓██████_____________________________________________________    //
//        ____________________________________________________┌░░▒▒▒▒╟▓██████▌____________________________________________________    //
//        ____________________________________________________░▒░▒▒▒▒▐▓████▓██µ___________________________________________________    //
//        ___________________________________________________▒▒░▒▒▒░▒▐▓████████___________________________________________________    //
//        __________________________________________________ƒ▒░░░░░░░▐▓█████████__________________________________________________    //
//        _________________________________________________┌░░░░░░░░░├▓█████████▌_________________________________________________    //
//        _________________________________________________░░░░░░░░░▒├▓▓█████████_________________________________________________    //
//        ______________▀█▓▓▓▓▀███▓▓▓▓▓▓▒░░░░░░░░░░░░▒▒▒░░░▒░░░░░░░▒▒]▓▓▓▓▓▓████▌▒▒▒▒▒▒░░▀▀▀▀▀▀▀▀▀▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██`_____________    //
//        _________________▀█▓▓▓▓▓▄▒▒▒░░▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒▒░░▒░░░░░▒▒▒║▓▓▓▓▓▓▓▓█░▒▒▒▒▒▒░░░░░░░░▒▒▒░░░░▀░░▒▄▄█████▓▀________________    //
//        ___________________`▀████▓▓▓▓▓▓▒▒▒░░░▒▒▒▒▒▒▒▒▒▒▒░░░░▒░░▒▒▒▒▓▓▓▓▓▓▓█▀░░░░░░░░░░░░░░▒░▒▒▒░░▄▓▓██████▓▓▀___________________    //
//        ______________________`▀██▓█▓▓▓▓▓▓▓▓▓▄▒▒▒▒▒▒▒▒▒▒▒▒▒▒░▒▒▒▒▒▒▒▓▓▓▓▓▀░░░░▒▒░░░░░░░░░░▄▄███████████▓▓▀______________________    //
//        _________________________`▀█▓▓▓▓▓▓▓▓▓▓█▓▓▓▓▄▒▒▒▒▒▒▒▒▒▒▒▒░▒▒║▓███░░▒░░▒▒▒▒▒░▄▄▓███████████████▀╜_________________________    //
//        ____________________________`▀▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▄▒▒▒▒▒▒▒▒▒▓█▀▒▒░▒░▄▄▓██▓█████████████████▀____________________________    //
//        _______________________________'▀▓▓▓▓▓▓▓▓▓▓▓▓██▓▓▓▓▓▓▓▓▓▓▄▄▒▓▓▓▓███████████████████████▀▀_______________________________    //
//        __________________________________'▀▓▓▓▓▓▓██▓██▓▓▓▓▓▓▓██▓▓▓▓▓███▓▓▓▓████▓▓██████████▀"__________________________________    //
//        ______________________________________▀█▓▓████▓▓▓▓▓▓▒▒▓▓▓▓██▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█████▀▀_____________________________________    //
//        _________________________________________█▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓███▓▓█▓▓▓▓▓▓▓▓▓▓▓▓▓▓██"________________________________________    //
//        _________________________________________▒▓▓▓█▓▓▓▓▓▓▓▓▓█████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓████_________________________________________    //
//        ________________________________________]▒▓███▓▓▓▓▓▓▓▓██████▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓█▓▓█▌________________________________________    //
//        _______________________________________,▒▓▓▓▓▓▓▓▓▓▓▓▓▓██████▓▓▓▓▓▓▓╢▓▓▓▓▓▓▓▓▓▓▓▓r_______________________________________    //
//        _______________________________________▒▒╟▓▓▓▓▓▓▓▓▓▓▓▓▓▓████▓▓▓▓▓▓▓▓▓▓▓▓███████▓█_______________________________________    //
//        ______________________________________▒▒▒▒▒▒▒▒▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓██████▓▓█▌______________________________________    //
//        _____________________________________/░░░░░▒g▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓▓╣▓▓▓▓▓▓▓▓▓▓▓▓███████▄_____________________________________    //
//        ____________________________________╒░░░░░░▓▓▓▓▓▓▓▓▓▓▓██▓▀____▀█▓▓▓▓▓▓╣▓▓▓▓█▓██████_____________________________________    //
//        ____________________________________▒░░░░ä▓▓▓▓▓▓▓▓▓▓▓▓▀_________`▀▓▓╣▓▓╣▓▓▓▓▓▓▓▓███▌____________________________________    //
//        ___________________________________╢░░░░▓▓▓▓▓▓▓▓▓▓▓▀________________▀█▓▓╣▓▓▓▓▓▓█▓███▄___________________________________    //
//        __________________________________╒░░░▓▓▓▓▓▓▓▓▓▓▀______________________▀██▓▓▓▓▓▓█▓███___________________________________    //
//        __________________________________░░░█▓▓▓▓▓▓▓▀___________________________'▀████▓▓▓████__________________________________    //
//        _________________________________╢▒▄▓▓╣▓▓▓╜__________________________________▀█▄█▓▓▓█▓▌_________________________________    //
//        ________________________________╓▒█▓▓▓▓"________________________________________▀██▓▓██_________________________________    //
//        _______________________________┌▓██▀▀______________________________________________▀█▓██________________________________    //
//        _______________________________▓▀▀___________________________________________________`▀▓▌_______________________________    //
//        ________________________________________________________________________________________________________________________    //
//        ________________________________________________________________________________________________________________________    //
//        ________________________________________________________________________________________________________________________    //
//        ________________________________________________________________________________________________________________________    //
//        ________________________________________________________________________________________________________________________    //
//                                                                                                                                    //
//                                                                                                                                    //
//                                                                                                                                    //
//                                                                                                                                    //
//                                                                                                                                    //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract Flow is ERC721Creator {
    constructor() ERC721Creator("Flow - Paul Wilson", "Flow") {}
}