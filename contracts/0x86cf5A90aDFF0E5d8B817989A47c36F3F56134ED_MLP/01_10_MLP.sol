/**
https://linktr.ee/minmaxdex
*/

// SPDX-License-Identifier: MIT

pragma solidity 0.6.12;

import "../tokens/MintableBaseToken.sol";

contract MLP is MintableBaseToken {
    constructor() public MintableBaseToken("Minmax LP", "MLP", 0) {
    }

    function id() external pure returns (string memory _name) {
        return "MLP";
    }
}