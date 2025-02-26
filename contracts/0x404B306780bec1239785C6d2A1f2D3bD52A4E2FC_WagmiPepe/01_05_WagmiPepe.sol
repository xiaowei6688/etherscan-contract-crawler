// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract WagmiPepe is ERC20 {
    constructor() ERC20("WagmiPepe", "WAGMIPEPE") {
        _mint(msg.sender, 420690000000 ether);
    }
}