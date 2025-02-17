// SPDX-License-Identifier: MIT
pragma solidity >=0.8.16;

interface INftProfileHelper {
    function _validURI(string memory _name) external view returns (bool);
}