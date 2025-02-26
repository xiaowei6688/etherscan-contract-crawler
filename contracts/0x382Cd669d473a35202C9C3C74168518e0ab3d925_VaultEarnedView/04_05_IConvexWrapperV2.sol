// SPDX-License-Identifier: MIT
pragma solidity 0.8.10;

interface IConvexWrapperV2{

   struct EarnedData {
        address token;
        uint256 amount;
    }

  function collateralVault() external view returns(address vault);
  function convexPoolId() external view returns(uint256 _poolId);
  function curveToken() external view returns(address);
  function convexToken() external view returns(address);
  function balanceOf(address _account) external view returns(uint256);
  function totalBalanceOf(address _account) external view returns(uint256);
  function deposit(uint256 _amount, address _to) external;
  function stake(uint256 _amount, address _to) external;
  function withdraw(uint256 _amount) external;
  function withdrawAndUnwrap(uint256 _amount) external;
  function getReward(address _account) external;
  function getReward(address _account, address _forwardTo) external;
  function rewardLength() external view returns(uint256);
  function earned(address _account) external returns(EarnedData[] memory claimable);
  function earnedView(address _account) external view returns(EarnedData[] memory claimable);
  function setVault(address _vault) external;
  function user_checkpoint(address[2] calldata _accounts) external returns(bool);
}