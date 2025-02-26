// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/IERC721Receiver.sol";

interface IChamps {
  function transferFrom(address from, address to, uint256 tokenId) external;
  function registerChampion(uint tokenId) external;
}

contract HowlerzStake is IERC721Receiver {
  address constant public testnetHowlerz = 0x43DDbF4C51dA7e341120b723D446219e3F0CFd8C;

  mapping (address => uint[]) public stakedChamps;
  
  function stakeChamps (uint[] memory champIds) public {
    IChamps champs = IChamps(testnetHowlerz);
    for (uint i = 0; i < champIds.length; i++) {
      champs.transferFrom(msg.sender, address(this), champIds[i]);
      stakedChamps[msg.sender].push(champIds[i]);
      champs.registerChampion(champIds[i]);
    }
  }

  function returnChamps () public {
    IChamps champs = IChamps(testnetHowlerz);
    uint i = stakedChamps[msg.sender].length;
    while (i > 0) {
      champs.transferFrom(address(this), msg.sender, stakedChamps[msg.sender][i - 1]);
      stakedChamps[msg.sender].pop();
      i--;
    }
  }

  function onERC721Received(address operator, address from, uint256 tokenId, bytes memory data) public override returns (bytes4) {
    // stakedChamps[from].push(tokenId);
    return this.onERC721Received.selector;
  }
}