// SPDX-License-Identifier: MIT

pragma solidity ^0.8.15;

import "@openzeppelin/contracts/utils/Address.sol";
import "./interfaces/IGasPrice.sol";

contract GasFeeThrottler {
  bool public shouldGasThrottle = true;

  address public gasprice = address(0xA43509661141F254F54D9A326E8Ec851A0b95307);

  modifier gasThrottle() {
    if (shouldGasThrottle && Address.isContract(gasprice)) {
      require(tx.gasprice <= IGasPrice(gasprice).maxGasPrice(), "gas is too high!");
    }
    _;
  }
}