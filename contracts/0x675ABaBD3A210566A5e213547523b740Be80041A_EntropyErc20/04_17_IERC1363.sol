// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;


interface ERC1363 {
  /*
   * Note: the ERC-165 identifier for this interface is 0xb0202a11.
   * 0xb0202a11 ===
   *   bytes4(keccak256('transferAndCall(address,uint256)')) ^
   *   bytes4(keccak256('transferAndCall(address,uint256,bytes)')) ^
   *   bytes4(keccak256('transferFromAndCall(address,address,uint256)')) ^
   *   bytes4(keccak256('transferFromAndCall(address,address,uint256,bytes)')) ^
   *   bytes4(keccak256('approveAndCall(address,uint256)')) ^
   *   bytes4(keccak256('approveAndCall(address,uint256,bytes)'))
   */

  /**
   * @notice Transfer tokens from `msg.sender` to another address and then call `onTransferReceived` on receiver
   * @param to address The address which you want to transfer to
   * @param amount uint256 The amount of tokens to be transferred
   * @return true unless throwing
   */
  function transferAndCall(address to, uint256 amount) external returns (bool);

  /**
   * @notice Transfer tokens from `msg.sender` to another address and then call `onTransferReceived` on receiver
   * @param to address The address which you want to transfer to
   * @param amount uint256 The amount of tokens to be transferred
   * @param data bytes Additional data with no specified format, sent in call to `to`
   * @return true unless throwing
   */
  function transferAndCall(address to, uint256 amount, bytes memory data) external returns (bool);

  /**
   * @notice Transfer tokens from one address to another and then call `onTransferReceived` on receiver
   * @param sender address The address which you want to send tokens from
   * @param to address The address which you want to transfer to
   * @param amount uint256 The amount of tokens to be transferred
   * @return true unless throwing
   */
  function transferFromAndCall(address sender, address to, uint256 amount) external returns (bool);


  /**
   * @notice Transfer tokens from one address to another and then call `onTransferReceived` on receiver
   * @param sender address The address which you want to send tokens from
   * @param to address The address which you want to transfer to
   * @param amount uint256 The amount of tokens to be transferred
   * @param data bytes Additional data with no specified format, sent in call to `to`
   * @return true unless throwing
   */
  function transferFromAndCall(address sender, address to, uint256 amount, bytes memory data) external returns (bool);

  /**
   * @notice Approve the passed address to spend the specified amount of tokens on behalf of msg.sender
   * and then call `onApprovalReceived` on spender.
   * @param spender address The address which will spend the funds
   * @param amount uint256 The amount of tokens to be spent
   */
  function approveAndCall(address spender, uint256 amount) external returns (bool);

  /**
   * @notice Approve the passed address to spend the specified amount of tokens on behalf of msg.sender
   * and then call `onApprovalReceived` on spender.
   * @param spender address The address which will spend the funds
   * @param amount uint256 The amount of tokens to be spent
   * @param data bytes Additional data with no specified format, sent in call to `spender`
   */
  function approveAndCall(address spender, uint256 amount, bytes memory data) external returns (bool);
}