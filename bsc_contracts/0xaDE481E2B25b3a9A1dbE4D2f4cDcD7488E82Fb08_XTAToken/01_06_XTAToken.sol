// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract XTAToken is ERC20, Ownable {
    constructor(string memory _name, string memory _symbol, uint256 totalBalance) ERC20(_name, _symbol) {
        _mint(msg.sender, totalBalance);
    }
}