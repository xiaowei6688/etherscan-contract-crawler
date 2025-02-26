// SPDX-License-Identifier: GPL-3.0-or-later
pragma solidity 0.8.17;

import "@openzeppelin/contracts/utils/cryptography/ECDSA.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@uniswap/v2-periphery/contracts/interfaces/IUniswapV2Router02.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "./interfaces/ILeechTransporter.sol";
import "./interfaces/ILeechStrategy.sol";
import "@openzeppelin/contracts-upgradeable/access/AccessControlUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/security/PausableUpgradeable.sol";

contract LeechRouter is AccessControlUpgradeable, PausableUpgradeable {
    using SafeERC20 for IERC20;
    using ECDSA for bytes32;

    ///@dev Struct for the strategy instance
    struct Strategy {
        uint256 id;
        uint256 poolId;
        uint256 chainId;
        address strategyAddress;
        bool isLp;
        uint256 withdrawalFee;
    }

    ///@dev Struct for the Vault instance
    struct Pool {
        uint256 id;
        string name;
    }

    ///@dev Struct for the Router instance
    struct Router {
        uint256 id;
        uint256 chainId;
        address routerAddress;
    }

    ILeechTransporter public transporter;

    IERC20 public baseToken;

    uint256 public chainId;

    uint256 public constant FEE_MAX = 2000;
    uint256 public constant FEE_DECIMALS = 10000;

    bytes32 public constant SERVER_ROLE = keccak256("SERVER_ROLE");
    bytes32 public constant ADMIN_ROLE = keccak256("ADMIN_ROLE");
    bytes32 public constant PAUSER_ROLE = keccak256("PAUSER_ROLE");
    bytes32 public constant UNPAUSER_ROLE = keccak256("UNPAUSER_ROLE");

    mapping(address => bool) private _banned;

    mapping(uint256 => Strategy) public poolIdtoActiveStrategy;

    mapping(uint256 => Router) public chainIdToRouter;

    address public signer;
    address public treasury;
    address public uniV2;

    bool whitelistEnabled;

    modifier enabled(address user) {
        if (_banned[user]) revert("Banned");
        _;
    }

    event BaseBridged(
        address user,
        uint256 amountOfBase,
        uint256 poolId,
        uint256 strategyId,
        uint256 destinationChainId,
        uint256 fromChainId
    );

    event Deposited(
        address user,
        uint256 poolId,
        uint256 strategyId,
        uint256 chainId,
        uint256 wantAmountDeposited
    );
    event WithdrawalRequested(
        address user,
        uint256 poolId,
        uint256 amount,
        uint256 chainId,
        address tokenOut
    );
    event WithdrawCompleted(
        address user,
        uint256 poolId,
        uint256 strategyId,
        uint256 targetChainId,
        uint256 wantAmount
    );
    event CrosschainWithdrawCompleted(
        address user,
        uint256 poolId,
        uint256 strategyId,
        uint256 targetChainId,
        uint256 wantAmount
    );
    event FinalizedCrosschainMigration(
        uint256 poolId,
        uint256 strategyId,
        uint256 chainId
    );
    event Migration(uint256 poolId, uint256 strategyId, uint256 chainId);

    function initialize(
        address _baseToken,
        address _uniV2Address
    ) external initializer {
        _grantRole(DEFAULT_ADMIN_ROLE, msg.sender);
        _grantRole(ADMIN_ROLE, msg.sender);
        _grantRole(SERVER_ROLE, msg.sender);
        _grantRole(PAUSER_ROLE, msg.sender);
        _grantRole(UNPAUSER_ROLE, msg.sender);

        baseToken = IERC20(_baseToken);
        uniV2 = _uniV2Address;

        uint256 _chainId;
        assembly {
            _chainId := chainid()
        }
        chainId = _chainId;

        whitelistEnabled = true;
        treasury = msg.sender;
        signer = msg.sender;
    }

    //path parameter can have two options:
    //tokenInToToken0 if current chain is active strategy
    //tokenInToBase if cerrent chain isn't active and bridging reqiured
    function deposit(
        bytes calldata signature,
        uint16 poolId,
        IERC20 depositToken,
        uint256 amount,
        uint256 maxBlockNumber,
        address[] calldata path
    ) external enabled(msg.sender) whenNotPaused {
        if (whitelistEnabled) {
            // Signature verification
            bytes32 msgHash = keccak256(abi.encode(msg.sender, maxBlockNumber, amount, chainId));
            require(
                msgHash.toEthSignedMessageHash().recover(signature) == signer,
                "not allowed"
            );
        }

        //Need custom revert for safeERC20
        if (
            depositToken.balanceOf(msg.sender) < amount ||
            depositToken.allowance(msg.sender, address(this)) < amount
        ) revert("Wrong balance or allowance");

        //init strategy struct
        Strategy storage activeStrat = poolIdtoActiveStrategy[poolId];

        if (chainId == activeStrat.chainId) {
            // if current chain active, deposit to strategy
            depositToken.safeTransferFrom(
                msg.sender,
                activeStrat.strategyAddress,
                amount
            );
            uint256 deposited = ILeechStrategy(activeStrat.strategyAddress)
                .deposit(path);

            emit Deposited(
                msg.sender,
                poolId,
                activeStrat.id,
                chainId,
                deposited
            );
            return;
        } else {
            depositToken.safeTransferFrom(msg.sender, address(this), amount);

            //swap to base if needed
            if (address(depositToken) != address(baseToken)) {
                uint256[] memory swapedAmounts = _swap(amount, path);

                amount = swapedAmounts[swapedAmounts.length - 1];
            }

            baseToken.safeTransfer(address(transporter), amount);

            Router memory router = chainIdToRouter[activeStrat.chainId];

            transporter.bridgeOut(
                address(baseToken),
                amount,
                activeStrat.chainId,
                router.routerAddress
            );

            emit BaseBridged(
                msg.sender,
                amount,
                poolId,
                activeStrat.id,
                activeStrat.chainId,
                chainId
            );
            return;
        }
    }

    //amount in base token
    function withdraw(
        bytes calldata signature,
        uint16 poolId,
        address tokenOut,
        uint256 amount,
        uint256 maxBlockNumber
    ) external enabled(msg.sender) whenNotPaused {
        if (whitelistEnabled) {
            //share tokens are located in the DB
            // Signature verification
            bytes32 msgHash = keccak256(abi.encode(msg.sender, maxBlockNumber, amount));

            require(
                msgHash.toEthSignedMessageHash().recover(signature) == signer,
                "not allowed"
            );
        }

        emit WithdrawalRequested(msg.sender, poolId, amount, chainId, tokenOut);
    }

    //After bridging completed we need to place tokens to farm
    //
    function placeToFarm(
        address user,
        uint256 amount,
        uint256 poolId,
        address[] calldata pathBaseToToken0
    ) external onlyRole(SERVER_ROLE) whenNotPaused {
        Strategy storage activeStrat = poolIdtoActiveStrategy[poolId];
        baseToken.safeTransfer(activeStrat.strategyAddress, amount);
        uint256 deposited = ILeechStrategy(activeStrat.strategyAddress).deposit(
            pathBaseToToken0
        );

        emit Deposited(user, poolId, activeStrat.id, chainId, deposited);
    }

    //BE calls after WithdrawalRequested event was catched
    //Should be called on chain with active strategy
    //amount - amount in want token on strategy: LP or single token
    // Paths for underlying strategy tokens to tokenOur (requested by user)
    // token1ToTokenOut is relevant when withdrawing from farms.
    function initWithdrawal(
        uint256 poolId,
        uint256 amount,
        address user,
        address[] calldata token0ToTokenOut,
        address[] calldata token1ToTokenOut,
        uint256 targetChainId
    ) external onlyRole(SERVER_ROLE) whenNotPaused {
        //Take strat instance by pool id
        Strategy storage activeStrat = poolIdtoActiveStrategy[poolId];
        address tokenOut = token0ToTokenOut[token0ToTokenOut.length - 1];

        //Withdraw tokenOut token from strategy and receive uint256 amount of received token
        uint256 tokenOutAmount = ILeechStrategy(activeStrat.strategyAddress)
            .withdraw(amount, token0ToTokenOut, token1ToTokenOut);

        //Minus fee if needed
        if (activeStrat.withdrawalFee > 0) {
            IERC20(tokenOut).safeTransfer(
                treasury,
                (tokenOutAmount * activeStrat.withdrawalFee) / FEE_DECIMALS
            );

            tokenOutAmount =
                tokenOutAmount -
                (tokenOutAmount * activeStrat.withdrawalFee) /
                FEE_DECIMALS;
        }

        //sending tokens to user directly or via bridge
        if (targetChainId == chainId) {
            //if requested on current chain, send tokens
            IERC20(tokenOut).safeTransfer(user, tokenOutAmount);
            emit WithdrawCompleted(
                user,
                poolId,
                activeStrat.id,
                targetChainId,
                amount
            );
            return;
        } else {
            //if requested on another chain, use bridge
            IERC20(tokenOut).safeTransfer(address(transporter), tokenOutAmount);

            transporter.bridgeOut(
                tokenOut,
                tokenOutAmount,
                targetChainId,
                user
            );
            emit CrosschainWithdrawCompleted(
                user,
                poolId,
                activeStrat.id,
                targetChainId,
                amount
            );
            return;
        }
    }

    //1st step for change strategy
    //Should be called only on active strategy chain
    //If new strategy in the same chain, this function is complete
    //If new strategy in another network, finalizeCrosschainMigration should be call after bridging
    // Path from Base token to Want of the new strategy
    function initMigration(
        uint256 poolId,
        Strategy calldata _strategy,
        address[] calldata path
    ) external onlyRole(SERVER_ROLE) whenNotPaused {
        require(_strategy.poolId == poolId, "wrong parameters");
        require(_strategy.strategyAddress != address(0), "empty strategy");

        Strategy memory _currentStrategy = poolIdtoActiveStrategy[poolId];

        require(_currentStrategy.chainId == chainId, "wrong chain");

        uint256 balanceBefore = baseToken.balanceOf(address(this));
        ILeechStrategy(_currentStrategy.strategyAddress).withdrawAll();
        uint256 withdrawAmount = baseToken.balanceOf(address(this)) -
            balanceBefore;

        if (_strategy.chainId == chainId) {
            baseToken.safeTransfer(_strategy.strategyAddress, withdrawAmount);
            ILeechStrategy(_strategy.strategyAddress).deposit(path);
        } else {
            Router memory _router = chainIdToRouter[_strategy.chainId];
            baseToken.safeTransfer(address(transporter), withdrawAmount);

            transporter.bridgeOut(
                address(baseToken),
                withdrawAmount,
                _strategy.chainId,
                _router.routerAddress
            );
        }

        poolIdtoActiveStrategy[poolId] = _strategy;

        emit Migration(poolId, _strategy.id, chainId);
    }

    //2nd additional step for change strategy
    function finalizeCrosschainMigration(
        uint256 poolId,
        Strategy calldata _strategy,
        uint256 baseAmount,
        address[] calldata path
    ) external onlyRole(ADMIN_ROLE) whenNotPaused {
        require(_strategy.poolId == poolId, "wrong parameters");
        require(_strategy.strategyAddress != address(0), "empty strategy");
        require(_strategy.chainId == chainId, "wrong chain");

        baseToken.safeTransfer(_strategy.strategyAddress, baseAmount);
        ILeechStrategy(_strategy.strategyAddress).deposit(path);

        poolIdtoActiveStrategy[poolId] = _strategy;

        emit FinalizedCrosschainMigration(poolId, _strategy.id, chainId);
    }

    function setSigner(address _signer) external onlyRole(ADMIN_ROLE) {
        require(_signer != address(0), "Zero address");
        signer = _signer;
    }

    function setStrategy(
        uint256 poolId,
        Strategy calldata _strategy
    ) external onlyRole(ADMIN_ROLE) {
        require(poolId == _strategy.poolId, "different pools");
        require(_strategy.withdrawalFee <= FEE_MAX, "different pools");
        poolIdtoActiveStrategy[poolId] = _strategy;
    }

    function setRouter(
        uint256 _chainId,
        Router calldata _router
    ) external onlyRole(ADMIN_ROLE) {
        chainIdToRouter[_chainId] = _router;
    }

    function setTransporter(
        address _transporter
    ) external onlyRole(ADMIN_ROLE) {
        require(_transporter != address(0), "Zero address");
        transporter = ILeechTransporter(_transporter);
    }

    function setPause() external onlyRole(PAUSER_ROLE) {
        _pause();
    }

    function setUnpause() external onlyRole(UNPAUSER_ROLE) {
        _unpause();
    }

    function switchWhitelistStatus() external onlyRole(ADMIN_ROLE) {
        if (whitelistEnabled) whitelistEnabled = false;
        if (!whitelistEnabled) whitelistEnabled = true;
    }

    function rescueERC20(address _token) external onlyRole(ADMIN_ROLE) {
        IERC20(_token).safeTransfer(
            msg.sender,
            IERC20(_token).balanceOf(address(this))
        );
    }

    function rescueNative() external onlyRole(ADMIN_ROLE) {
        payable(msg.sender).transfer(address(this).balance);
    }

    function setUniV2(address _uniV2Address) external onlyRole(ADMIN_ROLE) {
        require(_uniV2Address != address(0), "Zero address");
        uniV2 = _uniV2Address;
    }

    function setTreasury(address _treasury) external onlyRole(ADMIN_ROLE) {
        require(_treasury != address(0), "Zero address");
        treasury = _treasury;
    }

    function isBanned(address user) external view returns (bool) {
        return _banned[user];
    }

    function _swap(
        uint256 _amount,
        address[] calldata path
    ) private returns (uint256[] memory swapedAmounts) {
        _approveIfNeeded(IERC20(path[0]), uniV2);
        swapedAmounts = IUniswapV2Router02(uniV2).swapExactTokensForTokens(
            _amount,
            0,
            path,
            address(this),
            block.timestamp
        );
    }

    function _approveIfNeeded(IERC20 token, address to) private {
        if (token.allowance(address(this), to) == 0) {
            token.safeApprove(address(to), type(uint256).max);
        }
    }
}