// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Jake Zelinger CCO
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

//////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                      //
//                                                                                                      //
//          #    #    #    # #######    ####### ####### #       ### #     #  #####  ####### ######      //
//          #   # #   #   #  #               #  #       #        #  ##    # #     # #       #     #     //
//          #  #   #  #  #   #              #   #       #        #  # #   # #       #       #     #     //
//          # #     # ###    #####         #    #####   #        #  #  #  # #  #### #####   ######      //
//    #     # ####### #  #   #            #     #       #        #  #   # # #     # #       #   #       //
//    #     # #     # #   #  #           #      #       #        #  #    ## #     # #       #    #      //
//     #####  #     # #    # #######    ####### ####### ####### ### #     #  #####  ####### #     #     //
//                                                                                                      //
//                                                                                                      //
//////////////////////////////////////////////////////////////////////////////////////////////////////////


contract JZCCO is ERC721Creator {
    constructor() ERC721Creator("Jake Zelinger CCO", "JZCCO") {}
}