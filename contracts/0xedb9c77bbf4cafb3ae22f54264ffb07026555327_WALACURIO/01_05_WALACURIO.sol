// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Wall of Savage Curiosities
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                        //
//                                                                                        //
//                                                                                        //
//                                         ZB_                                            //
//                                       )p  nQ                                           //
//                              'k[    <88   "*%<    xkk                                  //
//                            :mn "&UpU  YnU#mj |p [email protected]< t%/.                              //
//                          ;%C&B&1  xu      `   '%l  :@/  ^W-                            //
//                       .YJ.+"    I   ]< (        /0l<      -h!                          //
//                     `B?     ]             f       av   q    ;@*                        //
//               .u.'Qb'       !t                     i|          fB/   ;>                //
//               o$v    Jd  r> k$"   z$x    WBd.   ~%     M8  x^ u(  cf_$M                //
//             [email protected]  Xpv]    C8m. zbwta  tpaZ.  1oB/  ,8&@f  `b$Bc   [email protected]/               //
//          '|p<[email protected],[email protected]%,   Q$U  ^[email protected]  {B%Zl  'W%0x  }8B<, L>w&8, {OB|h~8n'           //
//        i*x  __.%"q+~q_zYI  iIo   rb$BJ ~v(m    .*BM0 ^}8&Bv i0k%@k.Y,W1#^  -*Y         //
//      Zm   .                        ;,          [ njC  ' M,w                  c`d#:     //
//                                                                                        //
//                             __                  __   ___  __        __  ___  __        //
//        |  |  /\  |     /\  /__`  /\  \  /  /\  / _` |__  |__) |__| /  \  |  /  \       //
//        |/\| /~~\ |___ /~~\ .__/ /~~\  \/  /~~\ \__> |___ |    |  | \__/  |  \__/       //
//                                                                                        //
//                                                                                        //
//                           The Wall of Savage Curiosities...                            //
//                           A place for all things unusual...                            //
//                           Trinkets, baubles, knick-knacks...                           //
//                           Bric-a-brac, flotsam, and jetsam...                          //
//                                                                                        //
//                           And occasionally, some treasures.                            //
//                                                                                        //
//                                                                                        //
////////////////////////////////////////////////////////////////////////////////////////////


contract WALACURIO is ERC1155Creator {
    constructor() ERC1155Creator("Wall of Savage Curiosities", "WALACURIO") {}
}