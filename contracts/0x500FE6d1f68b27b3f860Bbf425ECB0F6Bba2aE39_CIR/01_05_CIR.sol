// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Infinite Realities by Silvio Vieira
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                                                   //
//                                                                                                                                                                   //
//            _           _          _    _          _        _          _        _          _        _          _             _          _           _              //
//           / /\        /\ \       _\ \ /\ \    _ / /\      /\ \       /\ \     /\ \    _ / /\      /\ \       /\ \          /\ \       /\ \        / /\            //
//          / /  \       \ \ \     /\__ \\ \ \  /_/ / /      \ \ \     /  \ \    \ \ \  /_/ / /      \ \ \     /  \ \         \ \ \     /  \ \      / /  \           //
//         / / /\ \__    /\ \_\   / /_ \_\\ \ \ \___\/       /\ \_\   / /\ \ \    \ \ \ \___\/       /\ \_\   / /\ \ \        /\ \_\   / /\ \ \    / / /\ \          //
//        / / /\ \___\  / /\/_/  / / /\/_// / /  \ \ \      / /\/_/  / / /\ \ \   / / /  \ \ \      / /\/_/  / / /\ \_\      / /\/_/  / / /\ \_\  / / /\ \ \         //
//        \ \ \ \/___/ / / /    / / /     \ \ \   \_\ \    / / /    / / /  \ \_\  \ \ \   \_\ \    / / /    / /_/_ \/_/     / / /    / / /_/ / / / / /  \ \ \        //
//         \ \ \      / / /    / / /       \ \ \  / / /   / / /    / / /   / / /   \ \ \  / / /   / / /    / /____/\       / / /    / / /__\/ / / / /___/ /\ \       //
//     _    \ \ \    / / /    / / / ____    \ \ \/ / /   / / /    / / /   / / /     \ \ \/ / /   / / /    / /\____\/      / / /    / / /_____/ / / /_____/ /\ \      //
//    /_/\__/ / /___/ / /__  / /_/_/ ___/\   \ \ \/ /___/ / /__  / / /___/ / /       \ \ \/ /___/ / /__  / / /______  ___/ / /__  / / /\ \ \  / /_________/\ \ \     //
//    \ \/___/ //\__\/_/___\/_______/\__\/    \ \  //\__\/_/___\/ / /____\/ /         \ \  //\__\/_/___\/ / /_______\/\__\/_/___\/ / /  \ \ \/ / /_       __\ \_\    //
//     \_____\/ \/_________/\_______\/         \_\/ \/_________/\/_________/           \_\/ \/_________/\/__________/\/_________/\/_/    \_\/\_\___\     /____/_/    //
//                                                                                                                                                                   //
//                                                                                                                                                                   //
//                                                                                                                                                                   //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract CIR is ERC1155Creator {
    constructor() ERC1155Creator("Infinite Realities by Silvio Vieira", "CIR") {}
}