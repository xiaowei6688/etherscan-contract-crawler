// SPDX-License-Identifier: GNU AGPLv3
pragma solidity >=0.5.0;

interface IWETH {
    function deposit() external payable;

    function withdraw(uint256) external;
}