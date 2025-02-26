// SPDX-License-Identifier: agpl-3.0
pragma solidity ^0.8.0;
pragma abicoder v2;

import {VersionedInitializable} from '../libraries/sturdy-upgradeability/VersionedInitializable.sol';
import {InitializableImmutableAdminUpgradeabilityProxy} from '../libraries/sturdy-upgradeability/InitializableImmutableAdminUpgradeabilityProxy.sol';
import {ReserveConfiguration} from '../libraries/configuration/ReserveConfiguration.sol';
import {ILendingPoolAddressesProvider} from '../../interfaces/ILendingPoolAddressesProvider.sol';
import {ILendingPool} from '../../interfaces/ILendingPool.sol';
import {IERC20Detailed} from '../../dependencies/openzeppelin/contracts/IERC20Detailed.sol';
import {Errors} from '../libraries/helpers/Errors.sol';
import {PercentageMath} from '../libraries/math/PercentageMath.sol';
import {DataTypes} from '../libraries/types/DataTypes.sol';
import {IInitializableDebtToken} from '../../interfaces/IInitializableDebtToken.sol';
import {IInitializableAToken} from '../../interfaces/IInitializableAToken.sol';
import {ISturdyIncentivesController} from '../../interfaces/ISturdyIncentivesController.sol';
import {ILendingPoolConfigurator} from '../../interfaces/ILendingPoolConfigurator.sol';

/**
 * @title LendingPoolConfigurator contract
 * @author Sturdy, inspiration from Aave
 * @dev Implements the configuration methods for the Sturdy protocol
 **/

contract LendingPoolConfigurator is VersionedInitializable, ILendingPoolConfigurator {
  using PercentageMath for uint256;
  using ReserveConfiguration for DataTypes.ReserveConfigurationMap;

  ILendingPoolAddressesProvider internal addressesProvider;
  ILendingPool internal pool;

  modifier onlyPoolAdmin() {
    require(addressesProvider.getPoolAdmin() == msg.sender, Errors.CALLER_NOT_POOL_ADMIN);
    _;
  }

  modifier onlyEmergencyAdmin() {
    require(
      addressesProvider.getEmergencyAdmin() == msg.sender,
      Errors.LPC_CALLER_NOT_EMERGENCY_ADMIN
    );
    _;
  }

  uint256 internal constant CONFIGURATOR_REVISION = 0x1;

  function getRevision() internal pure override returns (uint256) {
    return CONFIGURATOR_REVISION;
  }

  /**
   * @dev Function is invoked by the proxy contract when the LendingPoolConfigurator contract is added to the
   * LendingPoolAddressesProvider of the market.
   * - Caching the address of the LendingPoolAddressesProvider in order to reduce gas consumption
   *   on subsequent operations
   * - Caller is initializer (LendingPoolAddressesProvider or deployer)
   * @param provider The address of the LendingPoolAddressesProvider
   **/
  function initialize(ILendingPoolAddressesProvider provider) external initializer {
    require(address(provider) != address(0), Errors.LPC_INVALID_CONFIGURATION);

    addressesProvider = provider;
    pool = ILendingPool(addressesProvider.getLendingPool());
  }

  /**
   * @dev register vault to pool
   * - Caller is only poolAdmin
   * @param _vaultAddress The address of vault
   **/
  function registerVault(address _vaultAddress) external payable override onlyPoolAdmin {
    pool.registerVault(_vaultAddress);
  }

  /**
   * @dev unregister vault from pool
   * - Caller is only poolAdmin
   * @param _vaultAddress The address of vault
   **/
  function unregisterVault(address _vaultAddress) external payable override onlyPoolAdmin {
    pool.unregisterVault(_vaultAddress);
  }

  /**
   * @dev Initializes reserves in batch
   * - Caller is only poolAdmin
   * @param input The init data of reserve
   **/
  function batchInitReserve(InitReserveInput[] calldata input)
    external
    payable
    override
    onlyPoolAdmin
  {
    ILendingPool cachedPool = pool;
    uint256 length = input.length;
    for (uint256 i; i < length; ++i) {
      _initReserve(cachedPool, input[i]);
    }
  }

  function _initReserve(ILendingPool _pool, InitReserveInput calldata input) internal {
    require(input.underlyingAssetDecimals <= 18, Errors.LPC_INVALID_CONFIGURATION);

    address aTokenProxyAddress = _initTokenWithProxy(
      input.aTokenImpl,
      abi.encodeWithSelector(
        IInitializableAToken.initialize.selector,
        _pool,
        input.treasury,
        input.underlyingAsset,
        ISturdyIncentivesController(input.incentivesController),
        input.underlyingAssetDecimals,
        input.aTokenName,
        input.aTokenSymbol,
        input.params
      )
    );

    address stableDebtTokenProxyAddress = _initTokenWithProxy(
      input.stableDebtTokenImpl,
      abi.encodeWithSelector(
        IInitializableDebtToken.initialize.selector,
        _pool,
        input.underlyingAsset,
        ISturdyIncentivesController(input.incentivesController),
        input.underlyingAssetDecimals,
        input.stableDebtTokenName,
        input.stableDebtTokenSymbol,
        input.params
      )
    );

    address variableDebtTokenProxyAddress = _initTokenWithProxy(
      input.variableDebtTokenImpl,
      abi.encodeWithSelector(
        IInitializableDebtToken.initialize.selector,
        _pool,
        input.underlyingAsset,
        ISturdyIncentivesController(input.incentivesController),
        input.underlyingAssetDecimals,
        input.variableDebtTokenName,
        input.variableDebtTokenSymbol,
        input.params
      )
    );

    _pool.initReserve(
      input.underlyingAsset,
      input.yieldAddress,
      aTokenProxyAddress,
      stableDebtTokenProxyAddress,
      variableDebtTokenProxyAddress,
      input.interestRateStrategyAddress
    );

    DataTypes.ReserveConfigurationMap memory currentConfig = _pool.getConfiguration(
      input.underlyingAsset
    );

    currentConfig.setDecimals(input.underlyingAssetDecimals);

    currentConfig.setActive(true);
    currentConfig.setFrozen(false);

    _pool.setConfiguration(input.underlyingAsset, currentConfig.data);

    emit ReserveInitialized(
      input.underlyingAsset,
      aTokenProxyAddress,
      stableDebtTokenProxyAddress,
      variableDebtTokenProxyAddress,
      input.interestRateStrategyAddress
    );
  }

  /**
   * @dev Updates the aToken implementation for the reserve
   * - Caller is only poolAdmin
   * @param input The init data to update the aToken implementation
   **/
  function updateAToken(UpdateATokenInput calldata input) external payable onlyPoolAdmin {
    ILendingPool cachedPool = pool;

    DataTypes.ReserveData memory reserveData = cachedPool.getReserveData(input.asset);

    (, , , uint256 decimals, ) = cachedPool.getConfiguration(input.asset).getParamsMemory();

    bytes memory encodedCall = abi.encodeWithSelector(
      IInitializableAToken.initialize.selector,
      cachedPool,
      input.treasury,
      input.asset,
      input.incentivesController,
      decimals,
      input.name,
      input.symbol,
      input.params
    );

    _upgradeTokenImplementation(reserveData.aTokenAddress, input.implementation, encodedCall);

    emit ATokenUpgraded(input.asset, reserveData.aTokenAddress, input.implementation);
  }

  /**
   * @dev Updates the stable debt token implementation for the reserve
   * - Caller is only poolAdmin
   * @param input The init data to update the stable debt implementation
   **/
  function updateStableDebtToken(UpdateDebtTokenInput calldata input)
    external
    payable
    onlyPoolAdmin
  {
    ILendingPool cachedPool = pool;

    DataTypes.ReserveData memory reserveData = cachedPool.getReserveData(input.asset);

    (, , , uint256 decimals, ) = cachedPool.getConfiguration(input.asset).getParamsMemory();

    bytes memory encodedCall = abi.encodeWithSelector(
      IInitializableDebtToken.initialize.selector,
      cachedPool,
      input.asset,
      input.incentivesController,
      decimals,
      input.name,
      input.symbol,
      input.params
    );

    _upgradeTokenImplementation(
      reserveData.stableDebtTokenAddress,
      input.implementation,
      encodedCall
    );

    emit StableDebtTokenUpgraded(
      input.asset,
      reserveData.stableDebtTokenAddress,
      input.implementation
    );
  }

  /**
   * @dev Updates the variable debt token implementation for the asset
   * - Caller is only poolAdmin
   * @param input The init data to update the variable debt implementation
   **/
  function updateVariableDebtToken(UpdateDebtTokenInput calldata input)
    external
    payable
    onlyPoolAdmin
  {
    ILendingPool cachedPool = pool;

    DataTypes.ReserveData memory reserveData = cachedPool.getReserveData(input.asset);

    (, , , uint256 decimals, ) = cachedPool.getConfiguration(input.asset).getParamsMemory();
    (, , , , bool isCollateral) = cachedPool.getConfiguration(input.asset).getFlagsMemory();
    require(!isCollateral, Errors.LPC_INVALID_CONFIGURATION);

    bytes memory encodedCall = abi.encodeWithSelector(
      IInitializableDebtToken.initialize.selector,
      cachedPool,
      input.asset,
      input.incentivesController,
      decimals,
      input.name,
      input.symbol,
      input.params
    );

    _upgradeTokenImplementation(
      reserveData.variableDebtTokenAddress,
      input.implementation,
      encodedCall
    );

    emit VariableDebtTokenUpgraded(
      input.asset,
      reserveData.variableDebtTokenAddress,
      input.implementation
    );
  }

  /**
   * @dev Enables borrowing on a reserve
   * - Caller is only poolAdmin
   * @param asset The address of the underlying asset of the reserve
   * @param stableBorrowRateEnabled True if stable borrow rate needs to be enabled by default on this reserve
   **/
  function enableBorrowingOnReserve(address asset, bool stableBorrowRateEnabled)
    external
    payable
    onlyPoolAdmin
  {
    DataTypes.ReserveConfigurationMap memory currentConfig = pool.getConfiguration(asset);
    (, , , , bool isCollateral) = currentConfig.getFlagsMemory();
    require(!isCollateral, Errors.LPC_INVALID_CONFIGURATION);

    currentConfig.setBorrowingEnabled(true);
    currentConfig.setStableRateBorrowingEnabled(stableBorrowRateEnabled);

    pool.setConfiguration(asset, currentConfig.data);

    emit BorrowingEnabledOnReserve(asset, stableBorrowRateEnabled);
  }

  /**
   * @dev Disables borrowing on a reserve
   * - Caller is only poolAdmin
   * @param asset The address of the underlying asset of the reserve
   **/
  function disableBorrowingOnReserve(address asset) external payable onlyPoolAdmin {
    DataTypes.ReserveConfigurationMap memory currentConfig = pool.getConfiguration(asset);

    currentConfig.setBorrowingEnabled(false);

    pool.setConfiguration(asset, currentConfig.data);
    emit BorrowingDisabledOnReserve(asset);
  }

  /**
   * @dev Enables collateral on a reserve
   * - Caller is only poolAdmin
   * @param asset The address of the underlying asset of the reserve
   * @param collateralEnabled True
   **/
  function enableCollateralOnReserve(address asset, bool collateralEnabled)
    external
    payable
    onlyPoolAdmin
  {
    DataTypes.ReserveConfigurationMap memory currentConfig = pool.getConfiguration(asset);
    (, , bool isBorrowing, , ) = currentConfig.getFlagsMemory();
    require(!isBorrowing, Errors.LPC_INVALID_CONFIGURATION);

    currentConfig.setCollateralEnabled(true);

    pool.setConfiguration(asset, currentConfig.data);

    emit CollateralEnabledOnReserve(asset, collateralEnabled);
  }

  /**
   * @dev Disables collateral on a reserve
   * - Caller is only poolAdmin
   * @param asset The address of the underlying asset of the reserve
   **/
  function disableCollateralOnReserve(address asset) external payable onlyPoolAdmin {
    DataTypes.ReserveConfigurationMap memory currentConfig = pool.getConfiguration(asset);

    currentConfig.setCollateralEnabled(false);

    pool.setConfiguration(asset, currentConfig.data);
    emit CollateralDisabledOnReserve(asset);
  }

  /**
   * @dev Configures the reserve collateralization parameters
   * all the values are expressed in percentages with two decimals of precision. A valid value is 10000, which means 100.00%
   * - Caller is only poolAdmin
   * @param asset The address of the underlying asset of the reserve
   * @param ltv The loan to value of the asset when used as collateral
   * @param liquidationThreshold The threshold at which loans using this asset as collateral will be considered undercollateralized
   * @param liquidationBonus The bonus liquidators receive to liquidate this asset. The values is always above 100%. A value of 105%
   * means the liquidator will receive a 5% bonus
   **/
  function configureReserveAsCollateral(
    address asset,
    uint256 ltv,
    uint256 liquidationThreshold,
    uint256 liquidationBonus
  ) external payable onlyPoolAdmin {
    DataTypes.ReserveConfigurationMap memory currentConfig = pool.getConfiguration(asset);
    (, , , , bool isCollateral) = currentConfig.getFlagsMemory();

    //validation of the parameters: the LTV can
    //only be lower or equal than the liquidation threshold
    //(otherwise a loan against the asset would cause instantaneous liquidation)
    require(ltv <= liquidationThreshold, Errors.LPC_INVALID_CONFIGURATION);

    if (liquidationThreshold != 0) {
      require(isCollateral, Errors.LPC_INVALID_CONFIGURATION);

      //liquidation bonus must be bigger than 100.00%, otherwise the liquidator would receive less
      //collateral than needed to cover the debt
      require(
        liquidationBonus > PercentageMath.PERCENTAGE_FACTOR,
        Errors.LPC_INVALID_CONFIGURATION
      );

      //if threshold * bonus is less than PERCENTAGE_FACTOR, it's guaranteed that at the moment
      //a loan is taken there is enough collateral available to cover the liquidation bonus
      require(
        liquidationThreshold.percentMul(liquidationBonus) <= PercentageMath.PERCENTAGE_FACTOR,
        Errors.LPC_INVALID_CONFIGURATION
      );
    } else {
      require(liquidationBonus == 0, Errors.LPC_INVALID_CONFIGURATION);
      require(ltv == 0, Errors.LPC_INVALID_CONFIGURATION);

      //if the liquidation threshold is being set to 0,
      // the reserve is being disabled as collateral. To do so,
      //we need to ensure no liquidity is deposited
      _checkNoLiquidity(asset);
    }

    currentConfig.setLtv(ltv);
    currentConfig.setLiquidationThreshold(liquidationThreshold);
    currentConfig.setLiquidationBonus(liquidationBonus);

    pool.setConfiguration(asset, currentConfig.data);

    emit CollateralConfigurationChanged(asset, ltv, liquidationThreshold, liquidationBonus);
  }

  /**
   * @dev Enable stable rate borrowing on a reserve
   * - Caller is only poolAdmin
   * @param asset The address of the underlying asset of the reserve
   **/
  function enableReserveStableRate(address asset) external payable onlyPoolAdmin {
    DataTypes.ReserveConfigurationMap memory currentConfig = pool.getConfiguration(asset);

    currentConfig.setStableRateBorrowingEnabled(true);

    pool.setConfiguration(asset, currentConfig.data);

    emit StableRateEnabledOnReserve(asset);
  }

  /**
   * @dev Disable stable rate borrowing on a reserve
   * - Caller is only poolAdmin
   * @param asset The address of the underlying asset of the reserve
   **/
  function disableReserveStableRate(address asset) external payable onlyPoolAdmin {
    DataTypes.ReserveConfigurationMap memory currentConfig = pool.getConfiguration(asset);

    currentConfig.setStableRateBorrowingEnabled(false);

    pool.setConfiguration(asset, currentConfig.data);

    emit StableRateDisabledOnReserve(asset);
  }

  /**
   * @dev Activates a reserve
   * - Caller is only poolAdmin
   * @param asset The address of the underlying asset of the reserve
   **/
  function activateReserve(address asset) external payable onlyPoolAdmin {
    DataTypes.ReserveConfigurationMap memory currentConfig = pool.getConfiguration(asset);

    currentConfig.setActive(true);

    pool.setConfiguration(asset, currentConfig.data);

    emit ReserveActivated(asset);
  }

  /**
   * @dev Deactivates a reserve
   * - Caller is only poolAdmin
   * @param asset The address of the underlying asset of the reserve
   **/
  function deactivateReserve(address asset) external payable onlyPoolAdmin {
    _checkNoLiquidity(asset);

    DataTypes.ReserveConfigurationMap memory currentConfig = pool.getConfiguration(asset);

    currentConfig.setActive(false);

    pool.setConfiguration(asset, currentConfig.data);

    emit ReserveDeactivated(asset);
  }

  /**
   * @dev Freezes a reserve. A frozen reserve doesn't allow any new deposit, borrow or rate swap
   *  but allows repayments, liquidations, rate rebalances and withdrawals
   * - Caller is only poolAdmin
   * @param asset The address of the underlying asset of the reserve
   **/
  function freezeReserve(address asset) external payable onlyPoolAdmin {
    DataTypes.ReserveConfigurationMap memory currentConfig = pool.getConfiguration(asset);

    currentConfig.setFrozen(true);

    pool.setConfiguration(asset, currentConfig.data);

    emit ReserveFrozen(asset);
  }

  /**
   * @dev Unfreezes a reserve
   * - Caller is only poolAdmin
   * @param asset The address of the underlying asset of the reserve
   **/
  function unfreezeReserve(address asset) external payable onlyPoolAdmin {
    DataTypes.ReserveConfigurationMap memory currentConfig = pool.getConfiguration(asset);

    currentConfig.setFrozen(false);

    pool.setConfiguration(asset, currentConfig.data);

    emit ReserveUnfrozen(asset);
  }

  /**
   * @dev Updates the reserve factor of a reserve
   * - Caller is only poolAdmin
   * @param asset The address of the underlying asset of the reserve
   * @param reserveFactor The new reserve factor of the reserve
   **/
  function setReserveFactor(address asset, uint256 reserveFactor) external payable onlyPoolAdmin {
    DataTypes.ReserveConfigurationMap memory currentConfig = pool.getConfiguration(asset);

    currentConfig.setReserveFactor(reserveFactor);

    pool.setConfiguration(asset, currentConfig.data);

    emit ReserveFactorChanged(asset, reserveFactor);
  }

  /**
   * @dev Sets the interest rate strategy of a reserve
   * - Caller is only poolAdmin
   * @param asset The address of the underlying asset of the reserve
   * @param rateStrategyAddress The new address of the interest strategy contract
   **/
  function setReserveInterestRateStrategyAddress(address asset, address rateStrategyAddress)
    external
    payable
    onlyPoolAdmin
  {
    pool.setReserveInterestRateStrategyAddress(asset, rateStrategyAddress);
    emit ReserveInterestRateStrategyChanged(asset, rateStrategyAddress);
  }

  /**
   * @dev pauses or unpauses all the actions of the protocol, including aToken transfers
   * - Caller is only emergencyAdmin
   * @param val true if protocol needs to be paused, false otherwise
   **/
  function setPoolPause(bool val) external payable onlyEmergencyAdmin {
    pool.setPause(val);
  }

  /**
   * @dev Initializes aToken/StableDebtToken/VariableDebtToken
   * @param implementation The address of the aToken/StableDebtToken/VariableDebtToken implementation
   * @param initParams The init data
   **/
  function _initTokenWithProxy(address implementation, bytes memory initParams)
    internal
    returns (address)
  {
    InitializableImmutableAdminUpgradeabilityProxy proxy = new InitializableImmutableAdminUpgradeabilityProxy(
        address(this)
      );

    proxy.initialize(implementation, initParams);

    return address(proxy);
  }

  /**
   * @dev Updates the aToken/StableDebtToken/VariableDebtToken implementation
   * @param proxyAddress The address of aToken/StableDebtToken/VariableDebtToken which is proxy contract to upgrade
   * @param implementation The address of implementation
   * @param initParams The init data to update
   **/
  function _upgradeTokenImplementation(
    address proxyAddress,
    address implementation,
    bytes memory initParams
  ) internal {
    InitializableImmutableAdminUpgradeabilityProxy proxy = InitializableImmutableAdminUpgradeabilityProxy(
        payable(proxyAddress)
      );

    proxy.upgradeToAndCall(implementation, initParams);
  }

  /**
   * @dev Check no liquidity is deposited
   * @param asset The address of reserve
   */
  function _checkNoLiquidity(address asset) internal view {
    DataTypes.ReserveData memory reserveData = pool.getReserveData(asset);

    uint256 availableLiquidity = IERC20Detailed(asset).balanceOf(reserveData.aTokenAddress);

    require(
      availableLiquidity == 0 && reserveData.currentLiquidityRate == 0,
      Errors.LPC_RESERVE_LIQUIDITY_NOT_0
    );
  }
}