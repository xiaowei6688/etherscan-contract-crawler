// SPDX-License-Identifier: Apache-2.0

/*
    Copyright 2020 Set Labs Inc.

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at

    http://www.apache.org/licenses/LICENSE-2.0

    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.

    SPDX-License-Identifier: Apache License, Version 2.0
*/

pragma solidity 0.7.6;

/**
 * @title AddressArrayUtils
 * @author Set Protocol
 *
 * Utility functions to handle Address Arrays
 */
library AddressArrayUtils {
    /**
     * Finds the index of the first occurrence of the given element.
     * @param A The input array to search
     * @param a The value to find
     * @return Returns (index and isIn) for the first occurrence starting from index 0
     */
    function indexOf(address[] memory A, address a) internal pure returns (uint256, bool) {
        uint256 length = A.length;
        for (uint256 i = 0; i < length; i++) {
            if (A[i] == a) {
                return (i, true);
            }
        }
        return (uint256(-1), false);
    }

    /**
     * Returns true if the value is present in the list. Uses indexOf internally.
     * @param A The input array to search
     * @param a The value to find
     * @return Returns isIn for the first occurrence starting from index 0
     */
    function contains(address[] memory A, address a) internal pure returns (bool) {
        (, bool isIn) = indexOf(A, a);
        return isIn;
    }

    /**
     * Returns true if there are 2 elements that are the same in an array
     * @param A The input array to search
     * @return Returns boolean for the first occurrence of a duplicate
     */
    function hasDuplicate(address[] memory A) internal pure returns (bool) {
        require(A.length > 0, 'A is empty');

        for (uint256 i = 0; i < A.length - 1; i++) {
            address current = A[i];
            for (uint256 j = i + 1; j < A.length; j++) {
                if (current == A[j]) {
                    return true;
                }
            }
        }
        return false;
    }

    /**
     * @param A The input array to search
     * @param a The address to remove
     * @return Returns the array with the object removed.
     */
    function remove(address[] memory A, address a) internal pure returns (address[] memory) {
        (uint256 index, bool isIn) = indexOf(A, a);
        if (!isIn) {
            revert('Address not in array.');
        } else {
            (address[] memory _A, ) = pop(A, index);
            return _A;
        }
    }

    /**
     * Removes specified index from array
     * @param A The input array to search
     * @param index The index to remove
     * @return Returns the new array and the removed entry
     */
    function pop(address[] memory A, uint256 index) internal pure returns (address[] memory, address) {
        uint256 length = A.length;
        require(index < A.length, 'Index must be < A length');
        address[] memory newAddresses = new address[](length - 1);
        for (uint256 i = 0; i < index; i++) {
            newAddresses[i] = A[i];
        }
        for (uint256 j = index + 1; j < length; j++) {
            newAddresses[j - 1] = A[j];
        }
        return (newAddresses, A[index]);
    }

    /**
     * Returns the combination of the two arrays
     * @param A The first array
     * @param B The second array
     * @return Returns A extended by B
     */
    function extend(address[] memory A, address[] memory B) internal pure returns (address[] memory) {
        uint256 aLength = A.length;
        uint256 bLength = B.length;
        address[] memory newAddresses = new address[](aLength + bLength);
        for (uint256 i = 0; i < aLength; i++) {
            newAddresses[i] = A[i];
        }
        for (uint256 j = 0; j < bLength; j++) {
            newAddresses[aLength + j] = B[j];
        }
        return newAddresses;
    }

    /*
      Unfortunately Solidity does not support convertion of the fixed array to dynamic array so these functions are
      required. This functionality would be supported in the future so these methods can be removed.
    */
    function toDynamic(address _one, address _two) internal pure returns (address[] memory) {
        address[] memory arr = new address[](2);
        arr[0] = _one;
        arr[1] = _two;
        return arr;
    }

    function toDynamic(
        address _one,
        address _two,
        address _three
    ) internal pure returns (address[] memory) {
        address[] memory arr = new address[](3);
        arr[0] = _one;
        arr[1] = _two;
        arr[2] = _three;
        return arr;
    }

    function toDynamic(
        address _one,
        address _two,
        address _three,
        address _four
    ) internal pure returns (address[] memory) {
        address[] memory arr = new address[](4);
        arr[0] = _one;
        arr[1] = _two;
        arr[2] = _three;
        arr[3] = _four;
        return arr;
    }
}