// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Miss Valentina
/// @author: manifold.xyz

import "./ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                            //
//                                                                                                            //
//                                                                                                            //
//    ,---.    ,---..-./`)    .-'''-.    .-'''-.                                                              //
//    |    \  /    |\ .-.')  / _     \  / _     \                                                             //
//    |  ,  \/  ,  |/ `-' \ (`' )/`--' (`' )/`--'                                                             //
//    |  |\_   /|  | `-'`"`(_ o _).   (_ o _).                                                                //
//    |  _( )_/ |  | .---.  (_,_). '.  (_,_). '.                                                              //
//    | (_ o _) |  | |   | .---.  \  :.---.  \  :                                                             //
//    |  (_,_)  |  | |   | \    `-'  |\    `-'  |                                                             //
//    |  |      |  | |   |  \       /  \       /                                                              //
//    '--'      '--' '---'   `-...-'    `-...-'                                                               //
//    ,---.  ,---.   ____      .---.       .-''-.  ,---.   .--.,---------. .-./`) ,---.   .--.   ____         //
//    |   /  |   | .'  __ `.   | ,_|     .'_ _   \ |    \  |  |\          \\ .-.')|    \  |  | .'  __ `.      //
//    |  |   |  .'/   '  \  \,-./  )    / ( ` )   '|  ,  \ |  | `--.  ,---'/ `-' \|  ,  \ |  |/   '  \  \     //
//    |  | _ |  | |___|  /  |\  '_ '`) . (_ o _)  ||  |\_ \|  |    |   \    `-'`"`|  |\_ \|  ||___|  /  |     //
//    |  _( )_  |    _.-`   | > (_)  ) |  (_,_)___||  _( )_\  |    :_ _:    .---. |  _( )_\  |   _.-`   |     //
//    \ (_ o._) / .'   _    |(  .  .-' '  \   .---.| (_ o _)  |    (_I_)    |   | | (_ o _)  |.'   _    |     //
//     \ (_,_) /  |  _( )_  | `-'`-'|___\  `-'    /|  (_,_)\  |   (_(=)_)   |   | |  (_,_)\  ||  _( )_  |     //
//      \     /   \ (_ o _) /  |        \\       / |  |    |  |    (_I_)    |   | |  |    |  |\ (_ o _) /     //
//       `---`     '.(_,_).'   `--------` `'-..-'  '--'    '--'    '---'    '---' '--'    '--' '.(_,_).'      //
//                                                                                                            //
//                                                                                                            //
//                                                                                                            //
//                                                                                                            //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract MISSV is ERC721Creator {
    constructor() ERC721Creator("Miss Valentina", "MISSV") {}
}