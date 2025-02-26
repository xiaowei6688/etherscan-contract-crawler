// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import './MixinErrors.sol';
import '@openzeppelin/contracts-upgradeable/token/ERC20/IERC20Upgradeable.sol';
import '@openzeppelin/contracts-upgradeable/utils/AddressUpgradeable.sol';
import '@openzeppelin/contracts-upgradeable/token/ERC20/utils/SafeERC20Upgradeable.sol';

/**
 * @title An implementation of the money related functions.
 * @author HardlyDifficult (unlock-protocol.com)
 */
contract MixinFunds is MixinErrors
{
  using AddressUpgradeable for address payable;
  using SafeERC20Upgradeable for IERC20Upgradeable;

  /**
   * The token-type that this Lock is priced in.  If 0, then use ETH, else this is
   * a ERC20 token address.
   */
  address public tokenAddress;

  function _initializeMixinFunds(
    address _tokenAddress
  ) internal
  {
    _isValidToken(_tokenAddress);
    tokenAddress = _tokenAddress;
  }

  function _isValidToken(
    address _tokenAddress
  ) 
  internal 
  view
  {
    if(
      _tokenAddress != address(0) 
      && 
      IERC20Upgradeable(_tokenAddress).totalSupply() < 0
    ) {
      revert INVALID_TOKEN();
    }
  }

  /**
   * Transfers funds from the contract to the account provided.
   *
   * Security: be wary of re-entrancy when calling this function.
   */
  function _transfer(
    address _tokenAddress,
    address payable _to,
    uint _amount
  ) internal
  {
    if(_amount > 0) {
      if(_tokenAddress == address(0)) {
        // https://diligence.consensys.net/blog/2019/09/stop-using-soliditys-transfer-now/
        _to.sendValue(_amount);
      } else {
        IERC20Upgradeable token = IERC20Upgradeable(_tokenAddress);
        token.safeTransfer(_to, _amount);
      }
    }
  }

  uint256[1000] private __safe_upgrade_gap;
}