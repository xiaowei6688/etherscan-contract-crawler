// SPDX-License-Identifier: MIT
pragma solidity =0.8.16;

interface IWETH {
    function deposit() external payable;

    function withdraw(uint256 wad) external;

    function transfer(address to, uint value) external returns (bool);

    function transferFrom(
        address src,
        address dst,
        uint256 wad
    ) external returns (bool);

    function approve(address guy, uint256 wad) external returns (bool);

    function balanceOf(address guy) external returns (uint256);
}