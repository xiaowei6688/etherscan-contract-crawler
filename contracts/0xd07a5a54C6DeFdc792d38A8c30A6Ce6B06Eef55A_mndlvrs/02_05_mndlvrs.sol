// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Mandalaverse
/// @author: manifold.xyz

import "./manifold/ERC1155Creator.sol";

////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                            //
//                                                                                                            //
//    -----------                                                                                             //
//    ^^^^^^^^^^^^^^^^^^~!~::^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^:^5G!^^^^^^^^^^^^^^^^^^^^^^^^^              //
//    ^^^^^^^^^^^^^^^^^^^^^^^^^^^:?#GY!^:^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^:~P#PY:^^^^^^^^^^^^^^^^^^^^^^^^    //
//    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^~BGG#G?!^:^^^^^^^^^^^^^::^^^^^^^^^^^^^^:~JB#PY5^^^^^^^^^^^^^^^^^^^^^^^^^    //
//    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^PB5PGPBG?~::::^^^~~!!!!!!!!!~~^^^^::^!YGB#B5YP^^^^^^^^^^^^^^^^^^^^^^^^^    //
//    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^:Y&BP5P#BBBYJ5PGGGBBBBBGGGGGBBBGP5J?J5G&###BP5P~^^^^^^^^^^^^^^^^^^^^^^^^    //
//    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^:?&##BPP#BB#&###BBBGGP5YYJJJY5PGP5YJ??JG##BB#G5^^^^^^^^^^^^^^^^^^^^^^^^^    //
//    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^:?#&##B5BGG##BBBBGGP5YJ???7??JJYPY7!^::^75BBGPJ:^^^^^^^^^^^^^^^^^^^^^^^^    //
//    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^:?##B#B5BB##BBBBGGP5YJ??777???JJJPJ!^:.::~JGPP~^^^^^^^^^^^^^^^^^^^^^^^^^    //
//    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^:Y&GPGGG##BBBBBBBGP5Y?7!~~!!7??JJ5P?!^.  .:7G7:^^^^^^^^^^^^^^^^^^^^^^^^^    //
//    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^5B555G#BGGGBBBBGGP5YJJYJY55GPPPPBPP5Y?7!~~!YP~^^^^^^^^^^^^^^^^^^^^^^^^^    //
//    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^:JBPPGGGGGGGGGGPPG#GG5P#BGG5#GPG5GGGP555GBBGGBY:^^^^^^^^^^^^^^^^^^^^^^^^    //
//    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^5GPBBGPGGG555555PP555PBGP55GGP55555555PPP###P:^^^^^^^^^^^^^^^^^^^^^^^^    //
//    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^:?BBBGB#BP555PPP55555PP55555555555PPPGBGPPPPG?:^^^^^^^^^^^^^^^^^^^^^^^^    //
//    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^:7BGGB####B5PPYGGB#BGY5PP55555555G5JBG##BGJGP^^^^^^^^^^^^^^^^^^^^^^^^^^    //
//    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^:?BGP5GBBBGBG?^5GBBBG!7PB5555555GG?~?5PP5??G5^^^^^^^^^^^^^^^^^^^^^^^^^^    //
//    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^:5#G5PPGPY55P5J?YPP5??YPP5555555555YJ?JYYP###?:^^^^^^^^^^^^^^^^^^^^^^^^    //
//    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^B#PGPGGGGPP5PPP5555555555555555555555555B#&#G^^^^^^^^^^^^^^^^^^^^^^^^^    //
//    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^~BGGBBGGB&GG##GGGP555555555G55555PP5555G#BG##G^^^^^^^^^^^^^^^^^^^^^^^^^    //
//    ^^^^^^^^^^^^^^^^^^^^^^^^^^^^:!BBPGBGB##BB&BGBB#55555555GPPPYYPPG555#GG##GB?:^^^^^^^^^^^^^^^^^^^^^^^^    //
//    ^^^^^^^^^^^^^^^^^^^^^^^^^^^~JPBBGPPPBBBBB&###BBPY555555PPG#GPBBP555###B5?~^^^^^^^^^^^^^^^^^^^^^^^^^^    //
//    ^^^^^^^^^^^^^^^^^^^^^^^^^~?Y5PG5B&##BB#B####BGGPG5555555555PBP55555GY7~^:^^^^^^^^^^^^^^^^^^^^^^^^^^^    //
//    ^^^^^^^^^^^^^^^^^^^^^^^^7!!?5GPYG##BP#&#BBBBGPPPGG555555555PG555555Y::^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^    //
//    ^^^^^^^^^^^^^^^^^^^^^^^7!^^7Y5Y5BG#5:!YGGP55PPP5PB5555555PGGGGP555P?:^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^    //
//    ^^^^^^^^^^^^^^^^^^^^^^!Y!~!J?Y5GBGG!:^:^?GGPP5555GGP5555GGP#BPBP55Y~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^    //
//    ^^^^^^^^^^^^^^^^^^^^^:J5JJJJYPBBGG?:^^^^:?#P55G#BB####BBG5PPPYJ77!^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^    //
//    ^^^^^^^^^^^^^^^^^^^^^^5PPP5PGG#B5!::::::^P&#BPB######BBB~^^^^^:::^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^    //
//    ^^^^^^^^^^^^^^^^^^^^^~GGB#B5!^JY?JYYJ?JYB&&&&&&&#BPPB&&G~^^^^:::^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^    //
//    ^^^^^^^^^^^^^^^^^^^^:?GGGJ~::7P#&&&##BGGGBBB#&BGGGP5G##BGPYJJYJ7~:^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^    //
//    ^^^^^^^^^^^^^^^^^^^^^JJ!^::~YG###B#########BB#&#PJYB&BB#B55PG#&#B5!:^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^    //
//    ^^^^^^^^^^^^^^^^^^^^^^:^^^~PG5G##BGGBBB########PPBB##########BBBGB#J:^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^    //
//    ^^^^^^^^^^^^^^^^^^^^^^^^^^5GPPPBGBGGGG##GB&&&&&BGG5P#&&&&&B#BGGPB##G?:^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^    //
//    ^^^^^^^^^^^^^^^^^^^^^^^^:7&####GPPGGGG#&B5B&&####G5YP#&&#5G#BPGGGGB5P~^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^    //
//    ^^^^^^^^^^^^^^^^^^^^^^^^:P##BGB#BGPGPB#&&B5#&##PJYP&&&&B5B##BPGGGGP5GY:^^^^^^^^^^^^^^^^^^^^^^^^^^^^^    //
//    ^^^^^^^^^^^^^^^^^^^^^^^^~####BGG##BGB##&&&GP&&##GGGG#&GP#&BB#BGBGGB##B^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^    //
//    ^^^^^^^^^^^^^^^^^^^^^^^:J&&&#&####&#B#&&&&&PG&GPGB###BP#&&GGBPGGG#&&&&!:^^^^^^^^^^^^^^^^^^^^^^^^^^^^    //
//    ^^^^^^^^^^^^^^^^^^^^^^^^G&&&&######G55B&&#&#P#&#BGYJ#GB&#&G5555B#&&&&&?:^^^^^^^^^^^^^^^^^^^^^^^^^^^^    //
//    ^^^^^^^^^^^^^^^^^^^^^^^!GPB#####GPBPPGB&&&##P#&&#BGG#BG&&&G5555BG####&Y:^^^^^^^^^^^^^^^^^^^^^^^^^^^^    //
//                                                                                                            //
//                                                                                                            //
////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract mndlvrs is ERC1155Creator {
    constructor() ERC1155Creator("Mandalaverse", "mndlvrs") {}
}