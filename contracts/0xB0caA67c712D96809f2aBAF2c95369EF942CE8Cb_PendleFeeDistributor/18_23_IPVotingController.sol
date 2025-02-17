pragma solidity 0.8.17;

import "../LiquidityMining/libraries/VeBalanceLib.sol";
import "../LiquidityMining/libraries/VeHistoryLib.sol";

interface IPVotingController {
    event AddPool(uint64 indexed chainId, address indexed pool);

    event RemovePool(uint64 indexed chainId, address indexed pool);

    event Vote(address indexed user, address indexed pool, uint64 weight, VeBalance vote);

    event PoolVoteChange(address indexed pool, VeBalance vote);

    event SetPendlePerSec(uint256 newPendlePerSec);

    event BroadcastResults(
        uint64 indexed chainId,
        uint128 indexed wTime,
        uint128 totalPendlePerSec
    );

    function applyPoolSlopeChanges(address pool) external;

    function getUserPoolHistoryLength(address user, address pool) external view returns (uint256);

    function getUserPoolHistoryAt(
        address user,
        address pool,
        uint256 index
    ) external view returns (Checkpoint memory);

    function getWeekData(uint128 wTime, address[] calldata pools)
        external
        view
        returns (
            bool isEpochFinalized,
            uint128 totalVotes,
            uint128[] memory poolVotes
        );

    function getPoolTotalVoteAt(address pool, uint128 wTime) external view returns (uint128);
}