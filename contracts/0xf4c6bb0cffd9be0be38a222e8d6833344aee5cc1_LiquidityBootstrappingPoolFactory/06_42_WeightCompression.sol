// SPDX-License-Identifier: GPL-3.0-or-later
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.

// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.

// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

pragma solidity ^0.7.0;

import "./FixedPoint.sol";

/**
 * @dev Library for compressing and uncompresing numbers by using smaller types.
 * All values are 18 decimal fixed-point numbers in the [0.0, 1.0] range,
 * so heavier compression (fewer bits) results in fewer decimals.
 */
library WeightCompression {
    uint256 private constant _UINT31_MAX = 2**(31) - 1;

    using FixedPoint for uint256;

    /**
     * @dev Convert a 16-bit value to full FixedPoint
     */
    function uncompress16(uint256 value) internal pure returns (uint256) {
        return value.mulUp(FixedPoint.ONE).divUp(type(uint16).max);
    }

    /**
     * @dev Compress a FixedPoint value to 16 bits
     */
    function compress16(uint256 value) internal pure returns (uint256) {
        return value.mulUp(type(uint16).max).divUp(FixedPoint.ONE);
    }

    /**
     * @dev Convert a 31-bit value to full FixedPoint
     */
    function uncompress31(uint256 value) internal pure returns (uint256) {
        return value.mulUp(FixedPoint.ONE).divUp(_UINT31_MAX);
    }

    /**
     * @dev Compress a FixedPoint value to 31 bits
     */
    function compress31(uint256 value) internal pure returns (uint256) {
        return value.mulUp(_UINT31_MAX).divUp(FixedPoint.ONE);
    }
}