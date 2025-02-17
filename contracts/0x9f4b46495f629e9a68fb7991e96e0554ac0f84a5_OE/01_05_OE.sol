// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: It's an OPEN EDITION frens
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                        //
//                                                                                                                        //
//     $$$$$$\  $$$$$$$\  $$$$$$$$\ $$\   $$\       $$$$$$$$\ $$$$$$$\  $$$$$$\ $$$$$$$$\ $$$$$$\  $$$$$$\  $$\   $$\     //
//    $$  __$$\ $$  __$$\ $$  _____|$$$\  $$ |      $$  _____|$$  __$$\ \_$$  _|\__$$  __|\_$$  _|$$  __$$\ $$$\  $$ |    //
//    $$ /  $$ |$$ |  $$ |$$ |      $$$$\ $$ |      $$ |      $$ |  $$ |  $$ |     $$ |     $$ |  $$ /  $$ |$$$$\ $$ |    //
//    $$ |  $$ |$$$$$$$  |$$$$$\    $$ $$\$$ |      $$$$$\    $$ |  $$ |  $$ |     $$ |     $$ |  $$ |  $$ |$$ $$\$$ |    //
//    $$ |  $$ |$$  ____/ $$  __|   $$ \$$$$ |      $$  __|   $$ |  $$ |  $$ |     $$ |     $$ |  $$ |  $$ |$$ \$$$$ |    //
//    $$ |  $$ |$$ |      $$ |      $$ |\$$$ |      $$ |      $$ |  $$ |  $$ |     $$ |     $$ |  $$ |  $$ |$$ |\$$$ |    //
//     $$$$$$  |$$ |      $$$$$$$$\ $$ | \$$ |      $$$$$$$$\ $$$$$$$  |$$$$$$\    $$ |   $$$$$$\  $$$$$$  |$$ | \$$ |    //
//     \______/ \__|      \________|\__|  \__|      \________|\_______/ \______|   \__|   \______| \______/ \__|  \__|    //
//                                                                                                                        //
//                                                                                                                        //
//                                                                                                                        //
//                                                                                                                        //
//                                                                                                                        //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract OE is ERC721Creator {
    constructor() ERC721Creator("It's an OPEN EDITION frens", "OE") {}
}