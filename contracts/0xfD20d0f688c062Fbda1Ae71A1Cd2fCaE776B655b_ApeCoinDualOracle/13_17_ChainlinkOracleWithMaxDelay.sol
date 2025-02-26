// SPDX-License-Identifier: ISC
pragma solidity ^0.8.18;

// ====================================================================
// |     ______                   _______                             |
// |    / _____________ __  __   / ____(_____  ____ _____  ________   |
// |   / /_  / ___/ __ `| |/_/  / /_  / / __ \/ __ `/ __ \/ ___/ _ \  |
// |  / __/ / /  / /_/ _>  <   / __/ / / / / / /_/ / / / / /__/  __/  |
// | /_/   /_/   \__,_/_/|_|  /_/   /_/_/ /_/\__,_/_/ /_/\___/\___/   |
// |                                                                  |
// ====================================================================
// =================== ChainlinkOracleWithMaxDelay ====================
// ====================================================================
// Frax Finance: https://github.com/FraxFinance

// Author
// Drake Evans: https://github.com/DrakeEvans

// Reviewers
// Dennis: https://github.com/denett

// ====================================================================

import "@openzeppelin/contracts/utils/introspection/ERC165Storage.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";
import "../../../interfaces/oracles/abstracts/IChainlinkOracleWithMaxDelay.sol";

struct ConstructorParams {
    address chainlinkFeedAddress;
    uint256 maximumOracleDelay;
}

/// @title ChainlinkOracleWithMaxDelay
/// @author Drake Evans (Frax Finance) https://github.com/drakeevans
/// @notice  An abstract oracle for getting prices from Chainlink
abstract contract ChainlinkOracleWithMaxDelay is ERC165Storage, IChainlinkOracleWithMaxDelay {
    /// @notice Chainlink aggregator
    address public immutable CHAINLINK_FEED_ADDRESS;

    /// @notice Decimals of ETH/USD chainlink feed
    uint8 public immutable CHAINLINK_FEED_DECIMALS;

    /// @notice Precision of ETH/USD chainlink feed
    uint256 public immutable CHAINLINK_FEED_PRECISION;

    /// @notice Maximum delay of Chainlink data, after which it is considered stale
    uint256 public maximumOracleDelay;

    constructor(ConstructorParams memory _params) {
        _registerInterface({ interfaceId: type(IChainlinkOracleWithMaxDelay).interfaceId });

        CHAINLINK_FEED_ADDRESS = _params.chainlinkFeedAddress;
        CHAINLINK_FEED_DECIMALS = AggregatorV3Interface(CHAINLINK_FEED_ADDRESS).decimals();
        CHAINLINK_FEED_PRECISION = 10 ** uint256(CHAINLINK_FEED_DECIMALS);
        maximumOracleDelay = _params.maximumOracleDelay;
    }

    /// @notice The ```SetMaximumOracleDelay``` event is emitted when the max oracle delay is set
    /// @param oldMaxOracleDelay The old max oracle delay
    /// @param newMaxOracleDelay The new max oracle delay
    event SetMaximumOracleDelay(uint256 oldMaxOracleDelay, uint256 newMaxOracleDelay);

    /// @notice The ```_setMaximumOracleDelay``` function sets the max oracle delay to determine if Chainlink data is stale
    /// @param _newMaxOracleDelay The new max oracle delay
    function _setMaximumOracleDelay(uint256 _newMaxOracleDelay) internal {
        emit SetMaximumOracleDelay({ oldMaxOracleDelay: maximumOracleDelay, newMaxOracleDelay: _newMaxOracleDelay });
        maximumOracleDelay = _newMaxOracleDelay;
    }

    function setMaximumOracleDelay(uint256 _newMaxOracleDelay) external virtual;

    function _getChainlinkPrice() internal view returns (bool _isBadData, uint256 _updatedAt, uint256 _price) {
        int256 _answer;
        (, _answer, , _updatedAt, ) = AggregatorV3Interface(CHAINLINK_FEED_ADDRESS).latestRoundData();

        // If data is stale or negative, set bad data to true and return
        if (_answer <= 0 || (block.timestamp - _updatedAt > maximumOracleDelay)) {
            _isBadData = true;
        }

        _price = uint256(_answer);
    }

    function getChainlinkPrice() external view virtual returns (bool _isBadData, uint256 _updatedAt, uint256 _price) {
        return _getChainlinkPrice();
    }
}