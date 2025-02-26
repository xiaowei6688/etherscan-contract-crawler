/**
 *Submitted for verification at Etherscan.io on 2023-02-10
*/

// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.17;

contract CertificateOfAppreciation {
    uint256 private immutable _timestamp;

    constructor() {
        _timestamp = block.timestamp;
    }

    function sayThankYou() external pure returns (string memory) {
        return 
            "Dear Tobias Hagen, "
            "thank you for your generous support in sponsoring a portion of the DIVA Protocol "
            "audit costs. As a sign of our appreciation, we award you with 3000 $DIVA tokens, "
            "which give you governance power within the DIVA community and allows you to play "
            "an active role in shaping the future of decentralized finance.";
    }

    function getTimestampOfSponsorship() external view returns (uint256) {
        return _timestamp;
    }
}