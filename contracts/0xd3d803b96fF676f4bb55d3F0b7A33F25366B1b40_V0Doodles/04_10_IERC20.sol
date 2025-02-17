// SPDX-License-Identifier: Unlicense
// Creatoor: Scroungy Labs
// BurningZeppelin Contracts (last updated v0.0.1) (token/ERC20/IERC20.sol)

pragma solidity 0.8.9;

//   ____                                                          ________                                        ___
//  /\  _`\                              __                       /\_____  \                                      /\_ \      __
//  \ \ \L\ \   __  __   _ __    ___    /\_\     ___       __     \/____//'/'      __    _____    _____      __   \//\ \    /\_\     ___
//   \ \  _ <' /\ \/\ \ /\`'__\/' _ `\  \/\ \  /' _ `\   /'_ `\        //'/'     /'__`\ /\ '__`\ /\ '__`\  /'__`\   \ \ \   \/\ \  /' _ `\
//    \ \ \L\ \\ \ \_\ \\ \ \/ /\ \/\ \  \ \ \ /\ \/\ \ /\ \L\ \      //'/'___  /\  __/ \ \ \L\ \\ \ \L\ \/\  __/    \_\ \_  \ \ \ /\ \/\ \
//     \ \____/ \ \____/ \ \_\ \ \_\ \_\  \ \_\\ \_\ \_\\ \____ \     /\_______\\ \____\ \ \ ,__/ \ \ ,__/\ \____\   /\____\  \ \_\\ \_\ \_\
//      \/___/   \/___/   \/_/  \/_/\/_/   \/_/ \/_/\/_/ \/___L\ \    \/_______/ \/____/  \ \ \/   \ \ \/  \/____/   \/____/   \/_/ \/_/\/_/
//                                                         /\____/                         \ \_\    \ \_\
//                                                         \_/__/                           \/_/     \/_/
//   ____                                      __                  ____                        __                                __
//  /\  _`\                                   /\ \__              /\  _`\                     /\ \__                            /\ \__
//  \ \,\L\_\     ___ ___       __      _ __  \ \ ,_\             \ \ \/\_\    ___     ___    \ \ ,_\   _ __     __       ___   \ \ ,_\    ____
//   \/_\__ \   /' __` __`\   /'__`\   /\`'__\ \ \ \/              \ \ \/_/_  / __`\ /' _ `\   \ \ \/  /\`'__\ /'__`\    /'___\  \ \ \/   /',__\
//     /\ \L\ \ /\ \/\ \/\ \ /\ \L\.\_ \ \ \/   \ \ \_              \ \ \L\ \/\ \L\ \/\ \/\ \   \ \ \_ \ \ \/ /\ \L\.\_ /\ \__/   \ \ \_ /\__, `\
//     \ `\____\\ \_\ \_\ \_\\ \__/.\_\ \ \_\    \ \__\              \ \____/\ \____/\ \_\ \_\   \ \__\ \ \_\ \ \__/.\_\\ \____\   \ \__\\/\____/
//      \/_____/ \/_/\/_/\/_/ \/__/\/_/  \/_/     \/__/               \/___/  \/___/  \/_/\/_/    \/__/  \/_/  \/__/\/_/ \/____/    \/__/ \/___/

interface IERC20 {
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);

    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address to, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
}