// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: SmoothColorator
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

///////////////////////////////////////////////////////////////////////////////////////
//                                                                                   //
//                                                                                   //
//                                                                                   //
//                                                                                   //
//      ^    ^    ^    ^    ^    ^    ^    ^    ^    ^    ^    ^    ^    ^    ^      //
//     /S\  /m\  /o\  /o\  /t\  /h\  /C\  /o\  /l\  /o\  /r\  /a\  /t\  /o\  /r\     //
//    <___><___><___><___><___><___><___><___><___><___><___><___><___><___><___>    //
//      ^    ^    ^    ^    ^    ^    ^    ^    ^    ^    ^    ^    ^    ^           //
//     /-\  /-\  /S\  /U\  /R\  /R\  /E\  /A\  /L\  /i\  /t\  /y\  /-\  /-\          //
//    <___><___><___><___><___><___><___><___><___><___><___><___><___><___>         //
//                                                                                   //
//                                                                                   //
//                                                                                   //
//                                                                                   //
///////////////////////////////////////////////////////////////////////////////////////


contract SUREL is ERC721Creator {
    constructor() ERC721Creator("SmoothColorator", "SUREL") {}
}