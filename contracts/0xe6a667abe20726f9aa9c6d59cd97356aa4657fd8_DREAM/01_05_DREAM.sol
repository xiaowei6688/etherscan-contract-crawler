// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

/// @title: Dream Gallery
/// @author: manifold.xyz

import "./ERC721Creator.sol";

//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//                                                                                                                                                                                                                          //
//                                                                                                                                                                                                                          //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMK:.cKWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWO:,xNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMXd,c0WMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMXc.cKMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMWNKOkxxxdxkOKXXNWMMMMMMMMMMMMMNd'cXMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMNx,.....   ...'';cdk0NMMMMMMMMWx,lXMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMWO:. 'dkdlc;,'.'.....,cd0XWMWXk;cXMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMNOd0WMMMWWNXXXXK0Oxoc,',:odc':0WMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWX0xc,..,xXWMMMMMMMMMMMWX00KNMMMMMMMMMMMMMWWNXKOxod0WMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWXOo:';xNMMMMMMMMMXd,...;d0XWWMWNXK0xoc:,'.  .:OWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNKOkxkxl;lKWMMMMMMNo. 'cc;,',;loolllclodo, .;d0NMMMMMMMMMMMMMMMMMMMMMMMMMMMMWWNNNNNWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMWKOxoc:'...,;:;.:KMMMMMW0; .kWWWX0kdlc:;;:lxOK0c.'xNMMMMMMMMMMMMMMMMMMMMMMWNXXKOxlc:;;::lONMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMWXOdlc:;cldk00KKXK0o..lNMMMMNo..cKMMMMMMMMWWXK0kdol:.  .;d0NWMMMMMMMMMMMMMMWXOxl,''...  ..',,,,xNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMN0kdollodOKNWWMMMMMMMMMNo..cKWMM0,'dXMMMMMMMMMMMMMMMMWNX0xl;. .'ckKNMMMMMMMWKkdc'...  ...;lc,'..',.:KMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMWKxl;,lx0NWMMMMMMMMMMMMMMMMMXdc':OWXl,kWMMMMMMMMMMMMMMMMMMMMMMMW0o'  ':clxOKX0xc,. ....;cdxkKNWWKkl;'...dWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMN0o;...,kNMMMMMMMMMMMMMMMMMMMMMMMWk''do.:XMMMMMMMMMMMMMMMMMMMMMMMMMMW0:.;dkdl,.'....';:ok0XWMMMMMMMMMWNKx:.,xNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMWXx:.  .,dKWMMMMMMMMMMMMMMMMMMMMMMMMMNd....;0MMMMMMMMMMMMMMMMMMMMMMMMMMMWX0xdxo,..,cldkKNWMMMMMMMMMMMMMMMMMMNKo,;xXWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMNx,.  .;o0WMMMMMMMMMMMMMMMMMMMMMMMMMMMMXc  .l0WMMMMMMMMMMMMMMMMMMMMMMMMMMMWXx:,;cokXWWMMMMMMMMMMMMMMMMMMMMMMMMMNx'.'oKWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMNd'..;x0NMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM0, 'dOXMMMMMMMMMMMMMMMMMMMMMMMMMWKd:cd0NWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNx,..'lONMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMK: .'kWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWk. .'kWMMMMMMMMMMMMMMMMMMMMMMMXd:lONMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWk,....:OWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMWk'.;0WMMMMMMMMMMMMMMMMMMMMMMMMMMMWWNNX0Oxc.   cXMMMMMMMMMMMMMMMMMMMMMXx::OWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWO;....'l0WMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMW0x0WMMMMMMMMMMMMMMMMMMMMMMMWNKOdl:,''';ldd;  .xWMMMMMMMMMMMMMMMMMMWO:.lXMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWKl'','.,dXWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWNKkdlc;'.  .,lx0NWMMKx:.,OWMMMMMMMMMMMMMMMWXd'.lXMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNx,,;'.'lKWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMMWN0kdc,..  ..';cd0NMMMMMMMMMWO,'xWMMMMMMMMMMMMMWO:..cXMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMW0o;'..:kNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMWX0ko:;,;,..',:lx0XNWMMMMMMMMMMMMMW0:,xWMMMMMMMMMMMNx,..;0WMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNk:..,kWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMWXkl,.   'oKNXKXNWWMMMMMMMMMMMMMMMMMMMMXo;xNMMMMMMMMMNd'..:0WMMMMMMMMMMMMMMMMMWWWWWWMMMMMMMMMMMMMMMMMMMMMMMMMMMWKd, .kWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMW0ol:.. ..,OWMMMMMMMMMMMMMMMMMMMMMMMMMMMNd;dNMMMMMMMWx,..'xWMMMMMMMMMMMMMWNOdlc;;;:clxk0XNMMMMMMMMMMMMMMMMMMMMMNklc;.:KMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMWWNX0l..:KMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNx,oNMMMMMMKc..'oXMMMMMMMMMMMMNOc,...''..... ..';d0WMMMMMMMMMMMMMMMMMMWKlcc;,lKWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMMO'.dWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNd,lXMMMMWO;.'lXMMMMMMMMMMMNOc..;okKXXXK00xl,....'ckNMMMMMMMMMMMMMMMMMNkc;ll,;kWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMWx.;KMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNd'cKMMMNx;';OWMMMMMMMMMWKc..cONWMMMMMMMMMWXOxo'  .:0WMMMMMMMMMMMMMMMWKo:llc:,oKWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMMX:'kWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNo.:0WMWk,'dNMMMMMMMMMWO;.;OWMMMMMMMMMMMMMMMMWO;...,xNMMMMMMMMMMMMMMMKo;;lddc;dNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMNd'oNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMXc.;0WMO'.xWMMMMMMMMNx''dXMMMMMMMMMMMMMMMMMMMWO;...'dNMMMMMMMMMMMMMMNd''codl:dXMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMMO;cXMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMKc.;0WK;.xWMMMMMMWKl':0WMMMMMMMMMMMMMMMMMMMMMWO;...,dNMMMMMMMMMMMMMWx,.,llcoKWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMMMXc;0MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMK; ,OXl.dWMMMMMWO:;xNMMMMMMMMMMMMMMMMMMMMMMMMWk,...,xNMMMMMMMMMMMMWk'.':;c0WMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMWKc;kWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWO, ,kd'lNMMMW0l:dXWMMMMMMMMMMMMMMMMMMMMMMMMMMNd;,..:OWMMMMMMMMMMMMK:.'':0WMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMMMMK:,kWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWk' ,l,:XMWKo,c0WMMMMMMMMMMMMMMMMMMMMMMMMMMMMMKc...'cKMMMMMMMMMMMMX:..;kWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMMWNO:'xNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWWNXKx,..':KWk;,xNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWx'.',;kWMMMMMMMMMMMX: 'kWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMMN0c..xWMMMMMMMMMMMMMMMMMMMMMMMMMMWNNNNXXXXKOkdlc;,'.:l'..,xo.;0WMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMKc.,;,lXMMMMMMMMMMMXc.lXMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMMXo. .oNMMMMMMMMMMMMMMMMMMMMMMWNOoc:;;:loodddollooool'..:l;...cKMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNd..'.,kWMMMMMMMMMMXc,0MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMWk. .dNMMMMMMMMMMMMMMMMMMMNKOdl;..cxO0KXNNWWWMMMMMMMWKxl:'.  :KMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMO,.',,xWMMMMMMMMMWk':XMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMNc .dWMMMMMMMMMMMMMMMMMN0dc;,,;:,;0MMMMMMMMMMMMMMMMMMMMMK:.  ;0WMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMXl..,;oXMMMMMMMMW0;.lWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMMO'.oNMMMMMMMMMMMMMMMMWXx:;:codoc:l0MMMMMMMMMMMMMMMMMMMMMWN0x, 'kNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWx..,;oXMMMMMMMMXl. oWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMNo,dNMMMMMMMMMMMMMMMMNOoccllclllcoONMMMMMMMMMMMMMMMMMMMMMMMMWKc..oXMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMk'.,':0MMMMMMMNx'..dWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMMO,cXMMMMMMMMMMMMMMMMWOc:cc;'.;coONWMMMMMMMMMMMMMMMMMMMMMMMMMMMNx'.lXMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM0,.'':0MMMMMMM0:..'OMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMMNc.xMMMMMMMMMMMMMMMMMKl:c:'..,oKNWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMW0:.lXWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWO,.'.;0MMMMMMXo,'.'kWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMWx.,0MMMMMMMMMMMMMMMMWO,';'.,o0NMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNd;:xXWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWk'.'':0MMMMMWk,,,.'kWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMXc.dWMMMMMMMMMMMMMMMMNo...;dKWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWO,.:KMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNo..',dNMMMMMNx:;,.;0MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMWk.,KMMMMMMMMMMMMMMMMMK;.:kNWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNd..cXMMMMMMMMMMMMMMMMMMMMMMMMMMMMO,..,;kWMMMMWOooc''dNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMNl.cNMMMMMMMMMMMMMMMWKc'oNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMKc .oNMMMMMMMMMMMMMMMMMMMMMMMMMMXc..'';OWMMMMXd:lc''xWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMM0;'OWMMMMMMMMMMMMMMW0;.;KMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM0; .dNMMMMMMMMMMMMMMMMMMMMMMMMWx'..,,lXMMMMW0l:c;..xWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMWd.cNMMMMMMMMMMMMMMMXc  lNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWk' '0MMMMMMMMMMMMMMMMMMMMMMMWO,..';;xWMMMMNd;cc;';0MMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMN:.xWMMMMMMMMMMMMMMWx. .oWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWNX0kxxxo; .oWMMMMMMMMMMMMMMMMMMMMMNx;.',;;lKMMMMW0lll:;,lXMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMO,;KMMMMMMMMMMMMMMMNo. ,OMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMN0dc,.':ldxkd:.,0MMMMMMMMMMMMMMMMMMMWKd;,;;:;;kWMMMMXdclc;;:kWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMWd'oNMMMMMMMMMMMMMMMNo..;KMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWKx;. .;o0NWMMMMNd,dNMMMMMMMMMMMMMMMMWXxlccllc::dNMMMMWOclc'.'c0WMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMXc;0MMMMMMMMMMMMMMMMNl..cXMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMWKd,.,cd0NMMMMMMMMMNo,kWMMMMMMMMMMMMMMNKklc:;:c:,cKMMMMXx;,c;',ckNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMK:lNMMMMMMMMMMMMMMMMWd..xWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMXo';d0NWMMMMMMMMMMMMMK:,kWMMMMMMMMMMMWKdclccc;:c:o0WMMMM0;....;d0NMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMk,dWMMMMMMMMMMMMMMMMMO'.xWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMW0:..kMMMMMMMMMMMMMMMMMWd.,KMMMMWXKKKNMNo'';::llccoKWMMMMWx.   'xNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMNl.oWMMMMMMMMMMMMMMMMMK:.xWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM0;. ,OMMMMMMMMMMMMMMMMMM0''OMMMMXkxxooxd;,::ccl::dXWMMMMMNl.   .OWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMM0;.xMMMMMMMMMMMMMMMMMMNl.lNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMNl. .oXMMMMMMMMMMMMMMMMMMXc.dWMMMXdlol:..':cccc;;dXMMMMMMMXc... ;KMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMNo.,0MMMMMMMMMMMMMMMMMMNl.'OWMMMMMMMMMMMMMMMMMMMMMMMMMMMWk. .oXMMMMMMMMMMMMMMMMMMMWO,cXMMMNx::cl:;ccc:;co0WMMMMMMMM0;.;..oNMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMK,.lNMMMMMMMMMMMMMMMMMMWo..cXMMMMMMMMMMMMMMMMMMMMMMMMMWNO:.:ONMMMMMMMMMMMMMMMMMMMMMNl:KMMMMNk:;:cc;,,:dKWMMMMMMMMMWd..'..kWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMWx..kMMMMMMMMMMMMMMMMMMMWd..,kNMMMMMMMMMMMMMMMMMMMMMMMKl,.,kNMMMMMMMMMMMMMMMMMMMMMMMMk;xWMMMMWKOxxkOO0XWMMMMMMMMMMMNc  ..;KMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMXc.lNMMMMMMMMMMMMMMMMMMMWd...lXMMMMMMMMMMMMMMMMMMMMMMMK; .xWMMMMMMMMMMMMMMMMMMMMMMMMMK:;0WMMMMMMMMMMMMMMMMMMMMMMMMMK;  ..dWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMWO''OWMMMMMMMMMMMMMMMMMMMNo..'c0WMMMMMMMMMMMMMMMMMMMMMMXc ;KMMMMMMMMMMMMMMMMMMMMMMMMMMNo.oNMMMMMMMMMMMMMMMMMMMMMMMMM0,  .,OMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMWd.cXMMMMMMMMMMMMMMMMMMMMNo...'xNMMMMMMMMMMMMMMMMMMMMMMX: :KNWMMMMMMMMMMMMMMMMMMMMMMMMM0,,0MMMMMMMMMMMMMMMMMMMMMMMMWk'','lXMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMNl.,lxXMMMMMMMMMMMMMMMMMMNo....cKMMMMMMMMMMMMMMMMMMMMWNK: .:dKWMMMMMMMMMMMMMMMMMMMMMMMMNl.oNMMMMMMMMMMMMMMMMMMMMMMMWd,d0OKWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMW0;...lKWMMMMMMMMMMMMMMMMWx'...:KMMMMMMMMMMMMMMMMMMMXd;.   ,OWMMMMMMMMMMMMMMMMMMMMMMMMMWk',OWMMMMMMMMMMMMMMMMMMMMMMW0kXMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMWXkxl;c0WMMMMMMMMMMMMMMMWk,...;0MMMMMMMMMMMMMMMMMNOc.     ,KMMMMMMMMMMMMMMMMMMMMMMMMMMMNd',xXNXXXNNNNNNNNNNXKKKKXXX0OOOOOOOkxkkkkkkk0NMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMW0ccKMMMMMMMMMMMMMMMM0c;'.;0MMMMMMMMMMMMMMWNOc... .ol..dWMMMMMMMMMMMMMMMMMMMMMMMMMMMWd..'',::cloooodoolc;,,,;;;,'''',;::;,'''...,kWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMWk,lNMMMMMMMMMMMMMMMXo;,.:KMMMMMMMMMMMWNOo:,....;OWXl.,OWMMMMMMMMMMMMMMMMMMMMMMMMMMMXc  ,x0KKXXXNNNNNXXXKKKK00KXXKKXNWWNNXXKx,..;xXWMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMXc,OMMMMMMMMMMMMMMMWx,'.;0NNNWWWWWWN0o;.....,ckXWMMXl.;OWMMMMMMMMMMMMMMMMMMMMMMMMMMMx. ,0WMMMMMMMMMMMMMMMMMMMMMMMMMMMMMW0do:''''c0WMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMMM    //
//    MMMMMMMMMMNl.lNMMMM                                                                                                                                                                                                   //
//                                                                                                                                                                                                                          //
//                                                                                                                                                                                                                          //
//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////


contract DREAM is ERC721Creator {
    constructor() ERC721Creator("Dream Gallery", "DREAM") {}
}