// SPDX-License-Identifier: MIT

pragma solidity 0.8.10;

import '@openzeppelin/contracts/utils/Context.sol';
import './BaseRelayRecipientStorage.sol';

/**
 * A base contract to be inherited by any contract that want to receive relayed transactions
 * A subclass must use "_msgSender()" instead of "msg.sender"
 */

abstract contract BaseRelayRecipient is Context {
  /*
   * require a function to be called through GSN only
   */
  //  modifier trustedForwarderOnly() {
  //    require(msg.sender == address(s.trustedForwarder), "Function can only be called through the trusted Forwarder");
  //    _;
  //  }

  function isTrustedForwarder(address forwarder) public view returns (bool) {
    return forwarder == BaseRelayRecipientStorage.layout().trustedForwarder;
  }

  /**
   * return the sender of this call.
   * if the call came through our trusted forwarder, return the original sender.
   * otherwise, return `msg.sender`.
   * should be used in the contract anywhere instead of msg.sender
   */
  function _msgSender() internal view virtual override returns (address ret) {
    if (msg.data.length >= 24 && isTrustedForwarder(msg.sender)) {
      // At this point we know that the sender is a trusted forwarder,
      // so we trust that the last bytes of msg.data are the verified sender address.
      // extract sender address from the end of msg.data
      assembly {
        ret := shr(96, calldataload(sub(calldatasize(), 20)))
      }
    } else {
      return msg.sender;
    }
  }
}