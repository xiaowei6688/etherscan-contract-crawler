// SPDX-License-Identifier: ISC

pragma solidity ^0.8.13;

import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/utils/math/Math.sol";

import "../interface/IController.sol";
import "../utility/SCompAccessControl.sol";

/*
    ===== Badger Base Strategy =====
    Common base class for all Sett strategies

    Changelog
    V1.1
    - Verify amount unrolled from strategy positions on withdraw() is within a threshold relative to the requested amount as a sanity check
    - Add version number which is displayed with baseStrategyVersion(). If a strategy does not implement this function, it can be assumed to be 1.0

    V1.2
    - Remove idle want handling from base withdraw() function. This should be handled as the strategy sees fit in _withdrawSome()

    sComp updated:
    V1.0
    - Remove keeper
    - Remove guardian
*/
abstract contract BaseStrategy is Pausable, SCompAccessControl {
    using SafeERC20 for IERC20;
    using Address for address;
    using SafeMath for uint256;

    event SetController(address controller);
    event SetWithdrawalFee(uint256 withdrawalFee);
    event SetPerformanceFeeStrategist(uint256 performanceFeeStrategist);
    event SetPerformanceFeeGovernance(uint256 performanceFeeGovernance);
    event Harvest(uint256 harvested, uint256 indexed blockNumber);
    event Tend(uint256 tended);

    address public want;

    uint256 public performanceFeeGovernance;
    uint256 public performanceFeeStrategist;
    uint256 public withdrawalFee;

    uint256 public constant PRECISION = 10000;

    address public controller;

    uint256 public withdrawalMaxDeviationThreshold;

    constructor(
        address _governance,
        address _strategist,
        address _controller
    ){
        governance = _governance;
        strategist = _strategist;
        controller = _controller;
        withdrawalMaxDeviationThreshold = 50;
    }

    // ===== Modifiers =====

    function _onlyController() internal view {
        require(msg.sender == controller, "onlyController");
    }

    function _onlyAuthorizedActorsOrController() internal view {
        require(
            msg.sender == governance ||
            msg.sender == controller,
            "onlyAuthorizedActorsOrController"
        );
    }

    function _onlyAuthorizedPausers() internal view {
        require(
            msg.sender == governance,
            "onlyPausers"
        );
    }

    /// ===== View Functions =====
    function baseStrategyVersion() public pure returns (string memory) {
        return "1.0";
    }

    /// @notice Get the balance of want held idle in the Strategy
    function balanceOfWant() public view returns (uint256) {
        return IERC20(want).balanceOf(address(this));
    }

    /// @notice Get the total balance of want realized in the strategy, whether idle or active in Strategy positions.
    function balanceOf() public view virtual returns (uint256) {
        return balanceOfWant().add(balanceOfPool());
    }

    function isTendable() public pure virtual returns (bool) {
        return false;
    }

    function isProtectedToken(address token) public view returns (bool) {
        address[] memory protectedTokens = getProtectedTokens();
        for (uint256 i = 0; i < protectedTokens.length; i++) {
            if (token == protectedTokens[i]) {
                return true;
            }
        }
        return false;
    }

    /// ===== Permissioned Actions: TimeLockController =====

    function setWithdrawalFee(uint256 _withdrawalFee) external {
        _onlyTimeLockController();
        require(_withdrawalFee <= PRECISION, "excessive-fee");
        withdrawalFee = _withdrawalFee;
        emit SetWithdrawalFee(_withdrawalFee);
    }

    function setPerformanceFeeStrategist(uint256 _performanceFeeStrategist)
    external
    {
        _onlyTimeLockController();
        require(_performanceFeeStrategist <= PRECISION, "excessive-fee");
        performanceFeeStrategist = _performanceFeeStrategist;
        emit SetPerformanceFeeStrategist(_performanceFeeStrategist);
    }

    function setPerformanceFeeGovernance(uint256 _performanceFeeGovernance)
    external
    {
        _onlyTimeLockController();
        require(_performanceFeeGovernance <= PRECISION, "excessive-fee");
        performanceFeeGovernance = _performanceFeeGovernance;
        emit SetPerformanceFeeGovernance(_performanceFeeGovernance);
    }

    /// ===== Permissioned Actions: Governance =====

    function setController(address _controller) external {
        _onlyGovernance();
        controller = _controller;
        emit SetController(_controller);
    }

    function setWithdrawalMaxDeviationThreshold(uint256 _threshold) external {
        _onlyGovernance();
        require(_threshold <= PRECISION, "excessive-threshold");
        withdrawalMaxDeviationThreshold = _threshold;
    }

    function deposit() public virtual whenNotPaused {
        _onlyAuthorizedActorsOrController();
        uint256 _want = IERC20(want).balanceOf(address(this));
        if (_want > 0) {
            _deposit(_want);
        }
        _postDeposit();
    }

    // ===== Permissioned Actions: Controller =====

    /// @notice Controller-only function to Withdraw partial funds, normally used with a vault withdrawal
    function withdrawAll()
    external
    virtual
    whenNotPaused
    {
        _onlyController();

        _withdrawAll();

        _transferToVault(IERC20(want).balanceOf(address(this)));
    }

    /// @notice Withdraw partial funds from the strategy, unrolling from strategy positions as necessary
    /// @notice Processes withdrawal fee if present
    /// @dev If it fails to recover sufficient funds (defined by withdrawalMaxDeviationThreshold), the withdrawal should fail so that this unexpected behavior can be investigated
    function withdraw(uint256 _amount) external virtual whenNotPaused {
        _onlyController();

        // Withdraw from strategy positions, typically taking from any idle want first.
        _withdrawSome(_amount);
        uint256 _postWithdraw =
        IERC20(want).balanceOf(address(this));

        // Sanity check: Ensure we were able to retrieve sufficent want from strategy positions
        // If we end up with less than the amount requested, make sure it does not deviate beyond a maximum threshold
        if (_postWithdraw < _amount) {
            uint256 diff = _diff(_amount, _postWithdraw);

            // Require that difference between expected and actual values is less than the deviation threshold percentage
            require(
                diff <=
                _amount.mul(withdrawalMaxDeviationThreshold).div(PRECISION),
                "withdraw-exceed-max-deviation-threshold"
            );
        }

        // Return the amount actually withdrawn if less than amount requested
        uint256 _toWithdraw = Math.min(_postWithdraw, _amount);

        // Process withdrawal fee
        uint256 _fee = _processWithdrawalFee(_toWithdraw);

        // Transfer remaining to Vault to handle withdrawal
        _transferToVault(_toWithdraw.sub(_fee));
    }

    // NOTE: must exclude any tokens used in the yield
    // Controller role - withdraw should return to Controller
    function withdrawOther(address _asset)
    external
    virtual
    whenNotPaused
    returns (uint256 balance)
    {
        _onlyController();
        _onlyNotProtectedTokens(_asset);

        balance = IERC20(_asset).balanceOf(address(this));
        IERC20(_asset).safeTransfer(controller, balance);
    }

    /// ===== Permissioned Actions: Authoized Contract Pausers =====

    function pause() external {
        _onlyAuthorizedPausers();
        _pause();
    }

    function unpause() external {
        _onlyGovernance();
        _unpause();
    }

    /// ===== Internal Helper Functions =====

    /// @notice If withdrawal fee is active, take the appropriate amount from the given value and transfer to rewards recipient
    /// @return The withdrawal fee that was taken
    function _processWithdrawalFee(uint256 _amount) internal returns (uint256) {
        if (withdrawalFee == 0) {
            return 0;
        }

        uint256 fee = _amount.mul(withdrawalFee).div(PRECISION);
        IERC20(want).safeTransfer(
            IController(controller).rewards(),
            fee
        );
        return fee;
    }

    /// @dev Helper function to process an arbitrary fee
    /// @dev If the fee is active, transfers a given portion in basis points of the specified value to the recipient
    /// @return The fee that was taken
    function _processFee(
        address token,
        uint256 amount,
        uint256 feeBps,
        address recipient
    ) internal returns (uint256) {
        if (feeBps == 0) {
            return 0;
        }
        uint256 fee = amount.mul(feeBps).div(PRECISION);
        IERC20(token).safeTransfer(recipient, fee);
        return fee;
    }

    function _transferToVault(uint256 _amount) internal {
        address _vault = IController(controller).vaults(address(want));
        require(_vault != address(0), "!vault"); // additional protection so we don't burn the funds
        IERC20(want).safeTransfer(_vault, _amount);
    }

    /// @notice Utility function to diff two numbers, expects higher value in first position
    function _diff(uint256 a, uint256 b) internal pure returns (uint256) {
        require(a >= b, "diff/expected-higher-number-in-first-position");
        return a.sub(b);
    }

    // ===== Abstract Functions: To be implemented by specific Strategies =====

    /// @dev Internal deposit logic to be implemented by Stratgies
    function _deposit(uint256 _want) internal virtual;

    function _postDeposit() internal virtual {
        //no-op by default
    }

    /// @notice Specify tokens used in yield process, should not be available to withdraw via withdrawOther()
    function _onlyNotProtectedTokens(address _asset) internal virtual;

    function getProtectedTokens()
    public
    view
    virtual
    returns (address[] memory)
    {
        return new address[](0);
    }

    /// @dev Internal logic for strategy migration. Should exit positions as efficiently as possible
    function _withdrawAll() internal virtual;

    /// @dev Internal logic for partial withdrawals. Should exit positions as efficiently as possible.
    /// @dev The withdraw() function shell automatically uses idle want in the strategy before attempting to withdraw more using this
    function _withdrawSome(uint256 _amount) internal virtual returns (uint256);

    /// @dev Realize returns from positions
    /// @dev Returns can be reinvested into positions, or distributed in another fashion
    /// @dev Performance fees should also be implemented in this function
    /// @dev Override function stub is removed as each strategy can have it's own return signature for STATICCALL
    // function harvest() external virtual;

    /// @dev User-friendly name for this strategy for purposes of convenient reading
    function getName() external virtual returns (string memory);

    /// @dev Balance of want currently held in strategy positions
    function balanceOfPool() public view virtual returns (uint256);


}