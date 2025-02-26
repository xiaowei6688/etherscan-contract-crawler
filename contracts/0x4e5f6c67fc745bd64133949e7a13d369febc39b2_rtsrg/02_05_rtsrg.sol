// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Artserge
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

/////////////////////////////////////////////////////////////////////
//                                                                 //
//                                                                 //
//                                                                 //
//             ))   (o)__(o) oo_          ))       \/              //
//        /)  (Oo)-.(__  __)/  _)-<  wWw (Oo)-.   (OO)   wWw       //
//      (o)(O) | (_)) (  )  \__ `.   (O)_ | (_)),'.--.)  (O)_      //
//       //\\  |  .'   )(      `. | .' __)|  .'/ /|_|_\ .' __)     //
//      |(__)| )|\\   (  )     _| |(  _)  )|\\ | \_.--.(  _)       //
//      /,-. |(/  \)   )/   ,-'   | `.__)(/  \)'.   \) \`.__)      //
//     -'   '' )      (    (_..--'        )      `-.(_.'           //
//                                                                 //
//                                                                 //
//                                                                 //
/////////////////////////////////////////////////////////////////////


contract rtsrg is ERC1155Creator {
    constructor() ERC1155Creator("Artserge", "rtsrg") {}
}