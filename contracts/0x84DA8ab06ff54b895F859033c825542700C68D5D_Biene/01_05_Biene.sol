// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Biene
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                                    //
//                                                                                                                                                    //
//                                                                                                                                                    //
//                                                                                                                                                    //
//    .-. .-')              ('-.       .-') _   ('-.                               .-') _      .-') _             ('-.         .-') _  _ .-') _       //
//    \  ( OO )           _(  OO)     ( OO ) )_(  OO)                             ( OO ) )    ( OO ) )           ( OO ).-.    ( OO ) )( (  OO) )      //
//     ;-----.\   ,-.-') (,------.,--./ ,--,'(,------.         ,------.,-.-') ,--./ ,--,' ,--./ ,--,' ,--.       / . --. /,--./ ,--,'  \     .'_      //
//     | .-.  |   |  |OO) |  .---'|   \ |  |\ |  .---'      ('-| _.---'|  |OO)|   \ |  |\ |   \ |  |\ |  |.-')   | \-.  \ |   \ |  |\  ,`'--..._)     //
//     | '-' /_)  |  |  \ |  |    |    \|  | )|  |          (OO|(_\    |  |  \|    \|  | )|    \|  | )|  | OO ).-'-'  |  ||    \|  | ) |  |  \  '     //
//     | .-. `.   |  |(_/(|  '--. |  .     |/(|  '--.       /  |  '--. |  |(_/|  .     |/ |  .     |/ |  |`-' | \| |_.'  ||  .     |/  |  |   ' |     //
//     | |  \  | ,|  |_.' |  .--' |  |\    |  |  .--'       \_)|  .--',|  |_.'|  |\    |  |  |\    | (|  '---.'  |  .-.  ||  |\    |   |  |   / :     //
//     | '--'  /(_|  |    |  `---.|  | \   |  |  `---.        \|  |_)(_|  |   |  | \   |  |  | \   |  |      |   |  | |  ||  | \   |   |  '--'  /     //
//     `------'   `--'    `------'`--'  `--'  `------'         `--'    `--'   `--'  `--'  `--'  `--'  `------'   `--' `--'`--'  `--'   `-------'      //
//                                                                                                                                                    //
//                                                                                                                                                    //
//                                                                                                                                                    //
//                                                                                                                                                    //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract Biene is ERC721Creator {
    constructor() ERC721Creator("Biene", "Biene") {}
}