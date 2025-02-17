// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: VISION Art
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                            //
//                                                                                                            //
//                                                                                                            //
//                                                                                                            //
//                                                                                                            //
//                                                                                                            //
//                                                                                                            //
//                                                                                                            //
//                                                                                                            //
//                                                                                                            //
//                                                                                                            //
//                        .::^:::..           .::^~!!7777!!~^::.           ..:::^::.                          //
//                    .^7??77!!77???7!^:..^!?Y5YYJ?77!!!!77?JYY5Y?!^..:^!7???77!!77??7^.                      //
//                   ^Y?^.         .:~JGGB&&BY!.              .75#@&BGGJ~:..        .^?Y^                     //
//                  :PP?^.         :7P#@@@@@@@#J              Y&@@@@@@@#P7:         .^?PP:                    //
//                  75.~5P7^.    ^[email protected]@@@@@@@@@5...::^^^:::[email protected]@@@@@@@@&5PJ^     ^7P5~.Y?                    //
//                  JY  ?G!JJ7::JGJ^.Y#&@@@@@&BYY55YYG#G#P55YYYG&@@@@@@&Y.^JGJ::!JJ!PJ  JY                    //
//                  !P. ~G!~?P#B5^    :~7JPBB5?!^:..?G?:JG7::^!?PB#GY?7^.   ^5B#P?~!G~  57                    //
//                  .P!  ^~~!P#7.     :7PG&BJ^.   :5P~   !GY: .:!5B&BY~.     .7#P!~~^  ~P:                    //
//                   ~P:   .5B~     :JG5!^#57Y5J!7BG7!777!?GBY5Y?~^#Y7PP!.     ~B5.   :P!                     //
//                    75: .Y#~    .7BG!. .BJ .!5#BPJ?7!!77JYG#G?^..BY .7G5^     ~#Y. :5?                      //
//                     75^!&?    .Y#G5J?!~#575P?~:          .:!JPP7GG~7?PBB!     7&7^57                       //
//                      ~5BG.   .Y#!..:~7JB&P!.     .:^::.      .!5&#J7~::J#!    .G#5~                        //
//                       !&?    7&7      !#Y.     ^J5YJJY5J!.     .!BY.   .Y#~    ?&!                         //
//                       7&~   .GG.     .GB:     ~B?:    :!PP!      ^B5.   :BP.   ~&?                         //
//                       ?&~   :#5      :#P      !#~       .?#7      !#?    ?&~   ^&?                         //
//                       !&!   :#5      .P#^     .75Y?7!.   .PG.     .GG.   ~&?   !&7                         //
//                       :#Y   .GG.      ^BG^      .^~!!.   .GG.      5B.   ^&J   Y#^                         //
//                        Y#^   ?&7       :5BJ^            .J#!      .GG.   !&7  :#5                          //
//                        ^B5.  .5B~        ^JP57~:.    .^7PP~       !#7    Y#^ .5B^                          //
//                         !#J.  :PB~         .~?Y55YYYY55J~.       ^B5.   ^#Y .J#!                           //
//                          !BY.  .JBJ:           .::^^:..         !G5.   :GG:.JB7                            //
//                           ~GP^   ~PG?:                        ^YG7.   :PG^^PG~                             //
//                            :JGJ:  .~5GY!:                  :!5P?:   .!G5~?GJ:                              //
//                              ^YG?^   ^75P5?!^:...  ...:^!?55Y!.    ^5GJJG5^                                //
//                                ^JPY!:   :~?Y55555555555YJ!^.    .!5BGPPJ^                                  //
//                                  :!YPY7^.    ..::::::..     .:!YB&#GY!:                                    //
//                                     .~?Y5YJ7~^:::::::::^~!?5G##BP?~:                                       //
//                                         .^~7JYY55PPPPPPPPP5J7~^.                                           //
//                                                ...::::...                                                  //
//                                                                                                            //
//                                                                                                            //
//                                                                                                            //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract VSN is ERC1155Creator {
    constructor() ERC1155Creator("VISION Art", "VSN") {}
}