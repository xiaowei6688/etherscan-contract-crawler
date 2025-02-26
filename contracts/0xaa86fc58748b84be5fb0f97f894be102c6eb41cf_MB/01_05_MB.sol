// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Meat Block
/// @author: manifold.xyz

import "./ERC1155Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                            //
//                                                                                                            //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMWMMMMMMWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMWKXNWNNXKNWNNWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMWNKXWWN0kkOkdkXMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMWNNWKOkOOxdxkOO0000XWMWWWWWWWNWNNNNNNNXXXXNWWWWWWWWWWWWWWWMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMWWWKkdoxooxxO0K0OxkXWMWWWWWN0kddddxxxxxxxkKNWNNNWWWWWWWNXNWWWMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMWWWWWN0xxkdOXOddkOxkNMMMMMMWWMNOkkO000KKKXXXWMWWWNWWWWMMNOxOKXWMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMWKO0XNWWXNXXXNNXKNNNWMMMMWWWWMMNKKXKXXXXXXXNWMMWWMWWWWWWMW0ood0WMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMNKXNNNNNXXNWWWWMWWMMMWWWWWWMMMNXKKKKKKKXXKNMMMMMMWWWMMMMNOocd0WMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMWWNWMWWMWMMMWWWX0OKNMMWX0OkkkkkkxdOWMMMMWWWMMMMXdccokKNMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMWWWWWMMMMMMWOlldOKNMWOlc::::;cd0NMWMWNNWMMMWO;,co0NNMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMWWWMWWMMMMMWXX0ockNMN0kxddllOWMMMMWWNNWMMMMN0kdkNNNMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMWWWWWWMMMMMMMXxcxNMMMMMMMWWWWMMMMWNXXNWWWWWWWNNWXNMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMWWWWNWWMMMWMMWNNWMMMMMMMMMMMWWNX0OOkOXWWMMMWNWNXNWMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMWWWNXNWMMMNKKXNNNWWWWWWWNNXXKKK0KNNKKNMMMWNNWXXNWMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWWWXKNMMWKkOXWWNNNNNNNNXXNNWWMWNNNNXKNWWWWWNXXNNMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNKXWWKKXNMMMMMMMMMMMMMMMMMWNXKXXKKNWWWNNKKKXMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWOxKNXNNWMMMMMMMMMMMMMMMMMMMWNWWXXNNWMWNKKKNMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM0d0NNWWWMMMMMMMMMMMMMMMMMMMWNWNXWMWWWWNXKKWMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM0kXWNWWWMMMMMMMMMMMMMMMMMMMWWWNWMMMWWWNWXNMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNXNWWWWWWMMMMMMMMMMMMMMMMMWWWWWMMMMWWWWWMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWWWWWWWWNMMMMMMMMMMMMMMMMWWWNWMMMMMWWWWWMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWWWWNNWWNNMMMMMMMMMMMMMMMNNWNNWMMMMMWWWNNMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWNXXNNNNNNMMMMMMMMMMMMMMMNXXXWMMMMMMNXXXXWMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWNXNWMWWWMMMMMMMMMMMMMMMMMWWMMMMMMMMWNNNWMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//                                                                                                            //
//                                                                                                            //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract MB is ERC1155Creator {
    constructor() ERC1155Creator() {}
}