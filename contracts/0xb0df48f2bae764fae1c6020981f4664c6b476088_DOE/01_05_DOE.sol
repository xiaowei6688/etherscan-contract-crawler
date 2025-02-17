// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Destopic Open Editions
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

//////////////////////////////////////////////////////////////////////////////////
//                                                                              //
//                                                                              //
//                                              .""--..__                       //
//                        _                      []       ``-.._                //
//                      .'` `'.                  ||__           `-._            //
//                     /    ,-.\                 ||_ ```---..__     `-.         //
//                    /    /:::\\               /|//}          ``--._  `.       //
//                    |    |:::||              |////}                `-. \      //
//                    |    |:::||             //'///                    `.\     //
//                    |    |:::||            //  ||'                      `|    //
//                    /    |:::|/        _,-//\  ||                             //
//                   /`    |:::|`-,__,-'`  |/  \ ||                             //
//                 /`  |   |'' ||           \   |||                             //
//               /`    \   |   ||            |  /||                             //
//             |`       |  |   |)            \ | ||                             //
//            |          \ |   /      ,.__    \| ||                             //
//            /           `         /`    `\   | ||                             //
//           |                     /        \  / ||                             //
//           |                     |        | /  ||                             //
//           /         /           |        `(   ||                             //
//          /          .           /          )  ||                             //
//         |            \          |     ________||                             //
//        /             |          /     `-------.|                             //
//       |\            /          |              ||                             //
//       \/`-._       |           /              ||                             //
//        //   `.    /`           |              ||                             //
//       //`.    `. |             \              ||                             //
//      ///\ `-._  )/             |              ||                             //
//     //// )   .(/               |              ||                             //
//     ||||   ,'` )               /              //                             //
//     ||||  /                    /             ||                              //
//     `\\` /`                    |             //                              //
//         |`                     \            ||                               //
//        /                        |           //                               //
//      /`                          \         //                                //
//    /`                            |        ||                                 //
//    `-.___,-.      .-.        ___,'        (/                                 //
//             `---'`   `'----'`                                                //
//                                                                              //
//    DESTOPIC.COM | ADAM WILLIAM H.                                            //
//                                                                              //
//                                                                              //
//////////////////////////////////////////////////////////////////////////////////


contract DOE is ERC1155Creator {
    constructor() ERC1155Creator("Destopic Open Editions", "DOE") {}
}