// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/presets/ERC20PresetFixedSupply.sol";

contract ERC20FixedSupply is ERC20 {
    constructor() ERC20("Tokenized Asset Solutions Platinum", "TASP") {
        _mint(msg.sender, 25000 * 1e18);
    }

}