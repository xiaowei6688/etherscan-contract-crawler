// SPDX-License-Identifier: MIT WITH AGPL-3.0-only

pragma solidity 0.6.12;

import "./PermissionlessSwap.sol";
import "./FlashLoanEnabled.sol";
import "../interfaces/IFlashLoanReceiver.sol";

/**
 * @title Swap - A StableSwap implementation in solidity.
 * @notice This contract is responsible for custody of closely pegged assets (eg. group of stablecoins)
 * and automatic market making system. Users become an LP (Liquidity Provider) by depositing their tokens
 * in desired ratios for an exchange of the pool token that represents their share of the pool.
 * Users can burn pool tokens and withdraw their share of token(s).
 *
 * Each time a swap between the pooled tokens happens, a set fee incurs which effectively gets
 * distributed to the LPs.
 *
 * In case of emergencies, admin can pause additional deposits, swaps, or single-asset withdraws - which
 * stops the ratio of the tokens in the pool from changing.
 * Users can always withdraw their tokens via multi-asset withdraws.
 *
 * @dev Most of the logic is stored as a library `SwapUtils` for the sake of reducing contract's
 * deployment size.
 */
contract PermissionlessSwapFlashLoan is PermissionlessSwap, FlashLoanEnabled {
    /**
     * @notice Constructor for the PermissionlessSwapFlashLoan contract.
     * @param _masterRegistry address of the MasterRegistry contract
     */
    constructor(IMasterRegistry _masterRegistry)
        public
        PermissionlessSwap(_masterRegistry)
    {}

    /**
     * @notice Initializes this Swap contract with the given parameters.
     * This will also clone a LPToken contract that represents users'
     * LP positions. The owner of LPToken will be this contract - which means
     * only this contract is allowed to mint/burn tokens.
     *
     * @param _pooledTokens an array of ERC20s this pool will accept
     * @param decimals the decimals to use for each pooled token,
     * eg 8 for WBTC. Cannot be larger than POOL_PRECISION_DECIMALS
     * @param lpTokenName the long-form name of the token to be deployed
     * @param lpTokenSymbol the short symbol for the token to be deployed
     * @param _a the amplification coefficient * n * (n - 1). See the
     * StableSwap paper for details
     * @param _fee default swap fee to be initialized with
     * @param _adminFee default adminFee to be initialized with
     * @param lpTokenTargetAddress the address of an existing LPToken contract to use as a target
     */
    function initialize(
        IERC20[] memory _pooledTokens,
        uint8[] memory decimals,
        string memory lpTokenName,
        string memory lpTokenSymbol,
        uint256 _a,
        uint256 _fee,
        uint256 _adminFee,
        address lpTokenTargetAddress
    ) public payable virtual override initializer {
        Swap.initialize(
            _pooledTokens,
            decimals,
            lpTokenName,
            lpTokenSymbol,
            _a,
            _fee,
            _adminFee,
            lpTokenTargetAddress
        );
        // Set flashLoanFeeBPS to 8 and protocolFeeShareBPS to 0
        _setFlashLoanFees(8, 0);
        _updateFeeCollectorCache(MASTER_REGISTRY);
    }

    /*** STATE MODIFYING FUNCTIONS ***/

    /// @inheritdoc FlashLoanEnabled
    function flashLoan(
        address receiver,
        IERC20 token,
        uint256 amount,
        bytes memory params
    ) external payable override nonReentrant {
        uint8 tokenIndex = getTokenIndex(address(token));
        uint256 availableLiquidityBefore = token.balanceOf(address(this));
        uint256 protocolBalanceBefore = availableLiquidityBefore.sub(
            swapStorage.balances[tokenIndex]
        );
        require(
            amount > 0 && availableLiquidityBefore >= amount,
            "invalid amount"
        );

        // Calculate the additional amount of tokens the pool should end up with
        uint256 amountFee = amount.mul(flashLoanFeeBPS).div(10000);
        // Calculate the portion of the fee that will go to the protocol
        uint256 protocolFee = amountFee.mul(protocolFeeShareBPS).div(10000);
        require(amountFee > 0, "amount is small for a flashLoan");

        // Transfer the requested amount of tokens
        token.safeTransfer(receiver, amount);

        // Execute callback function on receiver
        IFlashLoanReceiver(receiver).executeOperation(
            address(this),
            address(token),
            amount,
            amountFee,
            params
        );

        uint256 availableLiquidityAfter = token.balanceOf(address(this));
        require(
            availableLiquidityAfter >= availableLiquidityBefore.add(amountFee),
            "flashLoan fee is not met"
        );

        swapStorage.balances[tokenIndex] = availableLiquidityAfter
            .sub(protocolBalanceBefore)
            .sub(protocolFee);
        emit FlashLoan(receiver, tokenIndex, amount, amountFee, protocolFee);
    }

    /*** ADMIN FUNCTIONS ***/

    /**
     * @notice Updates the flash loan fee parameters. Only owner can call this function.
     * @dev This function should be overridden for permissions.
     * @param newFlashLoanFeeBPS the total fee in bps to be applied on future flash loans
     * @param newProtocolFeeShareBPS the protocol fee in bps to be applied on the total flash loan fee
     */
    function setFlashLoanFees(
        uint256 newFlashLoanFeeBPS,
        uint256 newProtocolFeeShareBPS
    ) external payable virtual onlyOwner {
        _setFlashLoanFees(newFlashLoanFeeBPS, newProtocolFeeShareBPS);
    }
}