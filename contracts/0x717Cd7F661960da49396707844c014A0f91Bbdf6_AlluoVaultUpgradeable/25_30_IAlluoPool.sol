//SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

interface IAlluoPool {
    struct RewardData {
        address token;
        uint256 amount;
    }

    function farm() external;

    function withdraw(uint256 amount) external;

    function fundsLocked() external view returns (uint256);

    function claimRewardsFromPool() external;

    function rewardTokenBalance() external view returns (uint256);

    function accruedRewards() external view returns (RewardData[] memory);

    function balances(address) external view returns (uint256);

    function totalBalances() external view returns (uint256);

    function editVault(bool, address) external;

    function grantRole(bytes32 role, address account) external;

    function withdrawDelegate(
        address[] memory vaults,
        uint256[] memory amounts
    ) external returns (uint256 totalRewardsToWithdraw);
}