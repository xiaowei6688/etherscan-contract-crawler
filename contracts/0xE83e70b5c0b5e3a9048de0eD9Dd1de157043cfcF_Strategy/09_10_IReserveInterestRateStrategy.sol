// SPDX-License-Identifier: agpl-3.0
pragma solidity 0.8.14;

/**
 * @title IReserveInterestRateStrategyInterface interface
 * @dev Interface for the calculation of the interest rates
 * @author Aave
 */
interface IReserveInterestRateStrategy {
    function OPTIMAL_UTILIZATION_RATE() external view returns (uint256);

    function EXCESS_UTILIZATION_RATE() external view returns (uint256);

    function variableRateSlope1() external view returns (uint256);

    function variableRateSlope2() external view returns (uint256);

    function baseVariableBorrowRate() external view returns (uint256);

    function getMaxVariableBorrowRate() external view returns (uint256);

    function calculateInterestRates(
        address reserve,
        uint256 utilizationRate,
        uint256 totalStableDebt,
        uint256 totalVariableDebt,
        uint256 averageStableBorrowRate,
        uint256 reserveFactor
    )
        external
        view
        returns (
            uint256 liquidityRate,
            uint256 stableBorrowRate,
            uint256 variableBorrowRate
        );
}