// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Ru`do
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

/////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                     //
//                                                                                                     //
//                                                                                                     //
//                                                                                                     //
//                                                                                                     //
//                                                                                                     //
//                                                                                                     //
//                                                                                                     //
//                                                                                                     //
//                                                                                                     //
//                                                ,.                                                   //
//                                              ▐    ▀                                                 //
//                                              └╥  ╓µ▌            ▌  └                                //
//                                                   b▌        ^─▄▄  M▀                                //
//                                                 ,`╒   É └¼ ╟ ▐  ▌ ▌                                 //
//                                               ,∩ / @─└`╥  ▌▐ └  ╙ ╙                                 //
//                                    ,,       ," ,^AQ µ " ╟  ▄▌ └²^▄ ¼                                //
//                                   ─   ", ╓⌐└ ,^ ▌  µ▐  ▀ ▌  ╟▀═∞▀╟                                  //
//                                   ╙wx*  █W  "═      *▓  ▌ ²Γ  .─"   ⌐                               //
//                                        p ▀└¥   "─▀▄ a  ,µ⌐^,╓,µa┬⌐▄▓▌                               //
//                                         ╦ ╙▄ *,  ▐   ▄▀T`]█▀▀▀▀▀╙└  █                               //
//                                          ╥  ▀   └   ⌐─▐  █ ,,▄▄▄▄    ▌                              //
//                                           ▄*-═█▄▀▀▀╗└^└  █▄▄K══▌╓▌   ▌                              //
//                                           █└╙╙      ▀▌▄▀╙  ▄  █.█  ,█b                              //
//                                         ▐╙╙  ▄        ██▀╙▓▀,█╓█  ,█                                //
//                                         █    ╟╨▀¥▄    ▐─ ▐▌▄▀╓▀  ╓▌                                 //
//                                          ▌    █   █   ▐⌐▐▀█ ▄▀  ▄▌    ƒ                             //
//                                          ╙▄   ╙µ ▐─   ██▌█ █   ▄▀    ,                              //
//                                            ▀▌  █ █   ██▄█ █   ▄▀   ∩`                               //
//                                             ╟  ╙▄▌  ▐─▐▀██▀  █─   ,                                 //
//                                              ▀µ ▀  ╓▀ █▐b█  ▓▀   ,═.                                //
//                                          '▌└  ▀   █▄,▐─▐▄▌╒█▄▄▄▀█▀    ┐                             //
//                                        -  ╠ .⌐▐╙▄▀▓▀╙▀ ▐█▌    ,█│ⁿ~,   `                            //
//                                      ╒     \Q ⌡  ▀▓,    ██ ▄▄▀▀    `     b                          //
//                                      ▌      └W▌     ╙▀▀¥█ ╙      ¥`      ╘                          //
//                                    .^         └▄                ^         ".                        //
//                                   ▄             "             a         ─-   ⌐                      //
//                                   ▄⌐`  ─▄÷▄,     ╓\         ,`        Ö╒   '═,                      //
//                              ,-⌐`        ▀  ╙   █─█^       / ▌▐▀      /       └ "═,                 //
//                        .─Æ▀└               ². ▌⌐ ─╠  \    f  ▌╟    ═▀               `"≈.            //
//                   ,─^                          ¬-µ╟--.▄, Q,, ▌▐^`                        └'*╦       //
//                ,⌐└                               ▄╟    ▀┐    ▌▐                               "w    //
//                                                  ⌐╟   j▌█    ▌                                      //
//                                                  ⌐╟   ▐╩╟    ▌ b                                    //
//                                                 j ▌   ▐¬▐    ▌ ▄                                    //
//                                                 ▐ ▌   ▐¬╫    ╫ ▌                                    //
//                                                 ▐ ▌    ▄▐    █ ▌                                    //
//                                                        '▐    ^                                      //
//                                                        ▌å▌                                          //
//                                                        \ \                                          //
//                                                                                                     //
//                                                                                                     //
//                                                                                                     //
//                                                                                                     //
//                                                                                                     //
/////////////////////////////////////////////////////////////////////////////////////////////////////////


contract Rd is ERC1155Creator {
    constructor() ERC1155Creator("Ru`do", "Rd") {}
}