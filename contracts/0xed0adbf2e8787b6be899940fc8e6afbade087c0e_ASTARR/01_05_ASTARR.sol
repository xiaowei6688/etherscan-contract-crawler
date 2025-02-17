// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Adam Starr
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                //
//                                                                                                                                //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMX00XMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWkcckWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM0c,,c0MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMXo,,,;oXMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWk;,,,,;kWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM0c,,,,,,c0MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMXo,,,,,,,,oXMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWx;,,,,,,,,;xWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMW0c,,,,,,,,,,c0WMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMXo,,,,;::;,,,,oXMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWx;,,,;okko;,,,;xWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMW0c,,,,cOXXOc,,,,c0WMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMXo,,,,;xXXXXx;,,,,oXMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNx;,,,;o0XXXX0o;,,,;xNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWOc,,,,cOXXXXXXOc,,,,cOWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMXl,,,,:xXXXXXXXXx;,,,,lXMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNx;,,,;oKXXXXXXXXKo;,,,;xNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWO:,,,,cOXXXXXXXXXXOc,,,,:OWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMKl,,,,:xXXXXXXXXXXXXx:,,,,lKMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNx;,,,;oKXXXXXXXXXXXXKo;,,,;xNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMWXOxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxo:,,,,cOXXXXXXXXXXXXXXOc,,,,:oxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxOXWMM    //
//    MMMWXko:,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,:xXXXXXXXXXXXXXXXXx:,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,:lkXWMMM    //
//    MMMMMMNKxl;,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,;oKXXXXXXXXXXXXXXXXKo;,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,;lxKNMMMMMM    //
//    MMMMMMMMWNOd:,,,,,,,,:odxxxxxxxxxxxxxxxxxxxxxxxxxx0XXXXXXXXXXXXXXXXXX0xxxxxxxxxxxxxxxxxxxxxxxxxxdo:,,,,,,,,:dONMMMMMMMMM    //
//    MMMMMMMMMMMWXko:,,,,,;cdOKXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXKOdc;,,,,,:okXWMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMWKxc;,,,,,;lx0XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX0xl;,,,,,;cxKNMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMWNOdc;,,,,,:ok0XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX0ko:,,,,,;cdONWMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMWXko:,,,,,;cdOKXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXKOdc;,,,,,:okXWMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMWKxc;,,,,,;lx0XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX0xl;,,,,,;cxKWMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMWNOd:,,,,,;:ok0XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXKko:,,,,,,:dONWMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMWXkl:,,,,,;cdOKXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXKOdc;,,,,,:lkXWMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWKxc;,,,,,;lx0XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX0xl;,,,,,;cxKNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNOd:;,,,,;o0XXXXXXXXXXXXXXXXXXXXXXXXXXXXXX0o;,,,,;:dONMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWOc,,,,:xXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXx:,,,,cOWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWk;,,,;o0XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX0o;,,,;kWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM0c,,,,ckXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXkc,,,,c0MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNd;,,,;dKXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXKd;,,,;dNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWO:,,,,l0XXXXXXXXXXXXXXXXXKKXXXXXXXXXXXXXXXXX0l,,,,:OWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMXl,,,,:xXXXXXXXXXXXXXXX0xoccox0XXXXXXXXXXXXXXXx:,,,,lXMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWx;,,,;o0XXXXXXXXXXXX0ko:;,,,,;:ok0XXXXXXXXXXXX0o;,,,;xWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM0c,,,,ckXXXXXXXXXXKkoc;,,,,,,,,,,;cokKXXXXXXXXXXkc,,,,c0MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNd;,,,;dKXXXXXXXKOdc;,,,,,;cooc;,,,,,;cdkKXXXXXXXKd;,,,;dNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWO:,,,,l0XXXXXKOdc;,,,,,;cd0NWWN0dc;,,,,,;cdOKXXXXX0l,,,,:OWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMKl,,,,:xXXXKOdc;,,,,,;:dOXWMMMMMMWXOdc;,,,,,;cdOKXXXx:,,,,lKMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMWx;,,,;oKX0xl;,,,,,,:oOXWMMMMMMMMMMMMWXOo:,,,,,,;lx0XKo;,,,;xWMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMM0c,,,,:dxl:,,,,,,:okKWMMMMMMMMMMMMMMMMMMWKko:,,,,,,:lxd:,,,,c0MMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMNd,,,,,;;;,,,,,:lkKWMMMMMMMMMMMMMMMMMMMMMMMMWKkl:,,,,,;;;,,,,;dNMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMWO:,,,,,,,,,,;lxKWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWKxl;,,,,,,,,,,:OWMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMKl,,,,,,,,;cx0NMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMN0xc;,,,,,,,,lKMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMNx;,,,,,;cd0NWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWN0dc;,,,,,;xNMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMM0c,,,;cdOXWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWXOdc;,,,c0MMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMXo;,:oOXWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWXOo:,;oXMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMWOlokXWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWXkolOWMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMWKKWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWKKWMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//                                                                                                                                //
//                                                                                                                                //
//                                                                                                                                //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract ASTARR is ERC721Creator {
    constructor() ERC721Creator("Adam Starr", "ASTARR") {}
}