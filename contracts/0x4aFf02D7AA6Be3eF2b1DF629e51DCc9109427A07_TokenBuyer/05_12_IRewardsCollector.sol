// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity ^0.8.15;

import { IERC20 } from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

/// @title LooksRare Rewards Collector
/// @notice Implements a permissionless call to fetch LooksRare rewards earned by Universal Router users
/// and transfers them to an external rewards distributor contract
interface IRewardsCollector {
    /// @notice Fetches users' LooksRare rewards and sends them to the distributor contract
    /// @param looksRareClaim The data required by LooksRare to claim reward tokens
    function collectRewards(bytes calldata looksRareClaim) external;
}