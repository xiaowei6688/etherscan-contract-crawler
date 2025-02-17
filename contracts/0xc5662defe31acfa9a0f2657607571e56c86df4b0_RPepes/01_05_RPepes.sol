// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: RoundedPepes
/// @author: manifold.xyz

import "./manifold/ERC721Creator.sol";

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                                           //
//                                                                                                                                                           //
//                                                                                                                                                           //
//        _  _  _  _             _  _  _  _         _            _       _           _        _  _  _  _           _  _  _  _  _        _  _  _  _           //
//       (_)(_)(_)(_) _        _(_)(_)(_)(_)_      (_)          (_)     (_) _       (_)      (_)(_)(_)(_)         (_)(_)(_)(_)(_)      (_)(_)(_)(_)          //
//       (_)         (_)      (_)          (_)     (_)          (_)     (_)(_)_     (_)       (_)      (_)_       (_)                   (_)      (_)_        //
//       (_) _  _  _ (_)      (_)          (_)     (_)          (_)     (_)  (_)_   (_)       (_)        (_)      (_) _  _              (_)        (_)       //
//       (_)(_)(_)(_)         (_)          (_)     (_)          (_)     (_)    (_)_ (_)       (_)        (_)      (_)(_)(_)             (_)        (_)       //
//       (_)   (_) _          (_)          (_)     (_)          (_)     (_)      (_)(_)       (_)       _(_)      (_)                   (_)       _(_)       //
//       (_)      (_) _       (_)_  _  _  _(_)     (_)_  _  _  _(_)     (_)         (_)       (_)_  _  (_)        (_) _  _  _  _        (_)_  _  (_)         //
//       (_)         (_)        (_)(_)(_)(_)         (_)(_)(_)(_)       (_)         (_)      (_)(_)(_)(_)         (_)(_)(_)(_)(_)      (_)(_)(_)(_)          //
//                                                                                                                                                           //
//                                                                                                                                                           //
//         _  _  _  _          _  _  _  _  _         _  _  _  _          _  _  _  _  _          _  _  _  _                                                   //
//        (_)(_)(_)(_)_       (_)(_)(_)(_)(_)       (_)(_)(_)(_)_       (_)(_)(_)(_)(_)       _(_)(_)(_)(_)_                                                 //
//        (_)        (_)      (_)                   (_)        (_)      (_)                  (_)          (_)                                                //
//        (_) _  _  _(_)      (_) _  _              (_) _  _  _(_)      (_) _  _             (_)_  _  _  _                                                   //
//        (_)(_)(_)(_)        (_)(_)(_)             (_)(_)(_)(_)        (_)(_)(_)              (_)(_)(_)(_)_                                                 //
//        (_)                 (_)                   (_)                 (_)                   _           (_)                                                //
//        (_)                 (_) _  _  _  _        (_)                 (_) _  _  _  _       (_)_  _  _  _(_)                                                //
//        (_)                 (_)(_)(_)(_)(_)       (_)                 (_)(_)(_)(_)(_)        (_)(_)(_)(_)                                                  //
//                                                                                                                                                           //
//                                                                                                                                                           //
//                                                                                                                                                           //
//                                                                                                                                                           //
//                                                                                                                                                           //
///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract RPepes is ERC721Creator {
    constructor() ERC721Creator("RoundedPepes", "RPepes") {}
}