// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Methuselah
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                                                                  //
//                                                                                                                                                                                  //
//    ███╗   ███╗███████╗████████╗██╗  ██╗██╗   ██╗███████╗███████╗██╗      █████╗ ██╗  ██╗                                                                                         //
//    ████╗ ████║██╔════╝╚══██╔══╝██║  ██║██║   ██║██╔════╝██╔════╝██║     ██╔══██╗██║  ██║                                                                                         //
//    ██╔████╔██║█████╗     ██║   ███████║██║   ██║███████╗█████╗  ██║     ███████║███████║                                                                                         //
//    ██║╚██╔╝██║██╔══╝     ██║   ██╔══██║██║   ██║╚════██║██╔══╝  ██║     ██╔══██║██╔══██║                                                                                         //
//    ██║ ╚═╝ ██║███████╗   ██║   ██║  ██║╚██████╔╝███████║███████╗███████╗██║  ██║██║  ██║                                                                                         //
//    ╚═╝     ╚═╝╚══════╝   ╚═╝   ╚═╝  ╚═╝ ╚═════╝ ╚══════╝╚══════╝╚══════╝╚═╝  ╚═╝╚═╝  ╚═╝                                                                                         //
//                                                                                                                                                                                  //
//                                                                                                                                                                                  //
//                                                                                                                                                                                  //
//                                                                                                                                                                                  //
//                                                                                                                                                                                  //
//                                                                                                                                                                                  //
//                                                                                                                                                                                  //
//                                                                                                                                                                                  //
//                                                                                                                                                                                  //
//                                                                                                                                                                                  //
//                                                                                                                                                                                  //
//                                                                                                                                                                                  //
//     ▄▄▄       ██▓       █    ██   ▄████  ██▓   ▓██   ██▓    ▄▄▄       ██▀███  ▄▄▄█████▓                                                                                          //
//    ▒████▄    ▓██▒       ██  ▓██▒ ██▒ ▀█▒▓██▒    ▒██  ██▒   ▒████▄    ▓██ ▒ ██▒▓  ██▒ ▓▒                                                                                          //
//    ▒██  ▀█▄  ▒██▒      ▓██  ▒██░▒██░▄▄▄░▒██░     ▒██ ██░   ▒██  ▀█▄  ▓██ ░▄█ ▒▒ ▓██░ ▒░                                                                                          //
//    ░██▄▄▄▄██ ░██░      ▓▓█  ░██░░▓█  ██▓▒██░     ░ ▐██▓░   ░██▄▄▄▄██ ▒██▀▀█▄  ░ ▓██▓ ░                                                                                           //
//     ▓█   ▓██▒░██░      ▒▒█████▓ ░▒▓███▀▒░██████▒ ░ ██▒▓░    ▓█   ▓██▒░██▓ ▒██▒  ▒██▒ ░                                                                                           //
//     ▒▒   ▓▒█░░▓        ░▒▓▒ ▒ ▒  ░▒   ▒ ░ ▒░▓  ░  ██▒▒▒     ▒▒   ▓▒█░░ ▒▓ ░▒▓░  ▒ ░░                                                                                             //
//      ▒   ▒▒ ░ ▒ ░      ░░▒░ ░ ░   ░   ░ ░ ░ ▒  ░▓██ ░▒░      ▒   ▒▒ ░  ░▒ ░ ▒░    ░                                                                                              //
//      ░   ▒    ▒ ░       ░░░ ░ ░ ░ ░   ░   ░ ░   ▒ ▒ ░░       ░   ▒     ░░   ░   ░                                                                                                //
//          ░  ░ ░           ░           ░     ░  ░░ ░              ░  ░   ░                                                                                                        //
//                                                 ░ ░                                                                                                                              //
//                                                                                                                                                                                  //
//                                                                                                                                                                                  //
//                                                                                                                                                                                  //
//                                                                                                                                                                                  //
//                                                                                                                                                                                  //
//                                                                                                                                                                                  //
//                                                                                                                                                                                  //
//                                                                                                                                                                                  //
//    ┌─┐┬ ┬┌─┐ ┌─┐┬─┐                                                                                                                                                              //
//    ├─┘││││ │ ├─┤├┬┘                                                                                                                                                              //
//    ┴  └┴┘└─┘o┴ ┴┴└─                                                                                                                                                              //
//                                                                                                                                                                                  //
//                                                                                                                                                                                  //
//                                                                                                                                                                                  //
//                                                                                                                                                                                  //
//     ▄▄▄▄▄▄▄▄▄▄▄   ▄▄▄▄▄▄▄▄▄   ▄▄▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄▄▄                                                                                                                           //
//    ▐░░░░░░░░░░░▌ ▐░░░░░░░░░▌ ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌                                                                                                                          //
//     ▀▀▀▀▀▀▀▀▀█░▌▐░█░█▀▀▀▀▀█░▌ ▀▀▀▀▀▀▀▀▀█░▌ ▀▀▀▀▀▀▀▀▀█░▌                                                                                                                          //
//              ▐░▌▐░▌▐░▌    ▐░▌          ▐░▌          ▐░▌                                                                                                                          //
//              ▐░▌▐░▌ ▐░▌   ▐░▌          ▐░▌ ▄▄▄▄▄▄▄▄▄█░▌                                                                                                                          //
//     ▄▄▄▄▄▄▄▄▄█░▌▐░▌  ▐░▌  ▐░▌ ▄▄▄▄▄▄▄▄▄█░▌▐░░░░░░░░░░░▌                                                                                                                          //
//    ▐░░░░░░░░░░░▌▐░▌   ▐░▌ ▐░▌▐░░░░░░░░░░░▌ ▀▀▀▀▀▀▀▀▀█░▌                                                                                                                          //
//    ▐░█▀▀▀▀▀▀▀▀▀ ▐░▌    ▐░▌▐░▌▐░█▀▀▀▀▀▀▀▀▀           ▐░▌                                                                                                                          //
//    ▐░█▄▄▄▄▄▄▄▄▄ ▐░█▄▄▄▄▄█░█░▌▐░█▄▄▄▄▄▄▄▄▄  ▄▄▄▄▄▄▄▄▄█░▌                                                                                                                          //
//    ▐░░░░░░░░░░░▌ ▐░░░░░░░░░▌ ▐░░░░░░░░░░░▌▐░░░░░░░░░░░▌                                                                                                                          //
//     ▀▀▀▀▀▀▀▀▀▀▀   ▀▀▀▀▀▀▀▀▀   ▀▀▀▀▀▀▀▀▀▀▀  ▀▀▀▀▀▀▀▀▀▀▀                                                                                                                           //
//                                                                                                                                                                                  //
//                                                                                                                                                                                  //
//                                                                                                                                                                                  //
//                                                                                                                                                                                  //
//                                                                                                                                                                                  //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract MLH is ERC721Creator {
    constructor() ERC721Creator("Methuselah", "MLH") {}
}