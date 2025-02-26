/*
Website: https://www.mega-verse.tech/
Telegram: https://t.me/MegaverseETH
Twitter: https://twitter.com/MegaverseETH
*/

//SPDX-License-Identifier: MIT

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

pragma solidity ^0.8.17;

interface DexFactory {
    function createPair(
        address tokenA,
        address tokenB
    ) external returns (address pair);
}

interface DexRouter {
    function factory() external pure returns (address);

    function WETH() external pure returns (address);

    function addLiquidityETH(
        address token,
        uint256 amountTokenDesired,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    )
        external
        payable
        returns (uint256 amountToken, uint256 amountETH, uint256 liquidity);

    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external;
}

contract Megaverse is ERC20, Ownable {
    struct Tax {
        uint256 marketingTax;
        uint256 devTax;
    }

    uint256 private constant _totalSupply = 10000000 * 1e18;
    mapping(address => uint256) private _balances;

    //Router
    DexRouter public uniswapRouter;
    address public pairAddress;

    //Taxes
    Tax public buyTaxes = Tax(2, 3);
    Tax public sellTaxes = Tax(2, 3);
    uint256 public totalBuyFees = 5;
    uint256 public totalSellFees = 5;

    //Whitelisting from taxes/maxwallet/txlimit/etc
    mapping(address => bool) private whitelisted;

    //Swapping
    uint256 public swapTokensAtAmount = _totalSupply / 100000; //after 0.001% of total supply, swap them
    bool public swapAndLiquifyEnabled = true;
    bool public isSwapping = false;
    bool public tradingStatus = false;

    //Wallets
    address public MarketingWallet = 0x0713ddb237Dc607b5e949e9091A68b3B8F79161F;
    address public DevWallet = 0x41c61f5443F12a0ca1611c3dF58B5F7C30B7C06B;

    constructor() ERC20("Megaverse", "Mega") {
        //0x9fE46736679d2D9a65F0992F2272dE9f3c7fa6e0 test
        //0x10ED43C718714eb63d5aA57B78B54704E256024E Pancakeswap on mainnet
        //LFT swap on ETH 0x4f381d5fF61ad1D0eC355fEd2Ac4000eA1e67854
        //UniswapV2 on ETHMain net 0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D
        uniswapRouter = DexRouter(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);
        // do not whitelist liquidity pool, otherwise there wont be any taxes
        whitelisted[msg.sender] = true;
        whitelisted[address(uniswapRouter)] = true;
        whitelisted[address(this)] = true;

        _mint(msg.sender, _totalSupply);
    }

    function initializePair(address _pairAddress) external onlyOwner {
        pairAddress = _pairAddress;
        tradingStatus = true;
    }

    function setMarketingWallet(address _newMarketing) external onlyOwner {
        require(
            MarketingWallet != address(0),
            "new marketing wallet can not be dead address!"
        );
        MarketingWallet = _newMarketing;
    }

    function setDevWallet(address _newDev) external onlyOwner {
        require(
            _newDev != address(0),
            "new marketing wallet can not be dead address!"
        );
        DevWallet = _newDev;
    }

    function setBuyFees(
        uint256 _marketingTax,
        uint256 _devTax
    ) external onlyOwner {
        buyTaxes.marketingTax = _marketingTax;
        buyTaxes.devTax = _devTax;
        totalBuyFees = _marketingTax + _devTax;
    }

    function setSellFees(
        uint256 _marketingTax,
        uint256 _devTax
    ) external onlyOwner {
        sellTaxes.marketingTax = _marketingTax;
        sellTaxes.devTax = _devTax;
        totalSellFees = _marketingTax + _devTax;
    }

    function setSwapTokensAtAmount(uint256 _newAmount) external onlyOwner {
        require(
            _newAmount > 0,
            "Radiate : Minimum swap amount must be greater than 0!"
        );
        swapTokensAtAmount = _newAmount;
    }

    function toggleSwapping() external onlyOwner {
        swapAndLiquifyEnabled = (swapAndLiquifyEnabled == true) ? false : true;
    }

    function setWhitelistStatus(
        address _wallet,
        bool _status
    ) external onlyOwner {
        whitelisted[_wallet] = _status;
    }

    function checkWhitelist(address _wallet) external view returns (bool) {
        return whitelisted[_wallet];
    }

    function _takeTax(
        address _from,
        address _to,
        uint256 _amount
    ) internal returns (uint256) {
        if (whitelisted[_from] || whitelisted[_to]) {
            return _amount;
        }
        require(tradingStatus, "Trading is not enabled yet!");
        uint256 totalTax = 0;
        if (_to == pairAddress) {
            totalTax = totalSellFees;
        } else if (_from == pairAddress) {
            totalTax = totalBuyFees;
        }
        uint256 tax = (_amount * totalTax) / 100;
        super._transfer(_from, address(this), tax);
        return (_amount - tax);
    }

    function _transfer(
        address _from,
        address _to,
        uint256 _amount
    ) internal virtual override {
        require(_from != address(0), "transfer from address zero");
        require(_to != address(0), "transfer to address zero");
        uint256 toTransfer = _takeTax(_from, _to, _amount);

        bool canSwap = balanceOf(address(this)) >= swapTokensAtAmount;
        if (
            swapAndLiquifyEnabled &&
            pairAddress == _to &&
            canSwap &&
            !whitelisted[_from] &&
            !whitelisted[_to] &&
            !isSwapping
        ) {
            isSwapping = true;
            manageTaxes();
            isSwapping = false;
        }
        super._transfer(_from, _to, toTransfer);
    }

    function manageTaxes() internal {
        swapToETH(balanceOf(address(this)));
        if (address(this).balance > 0) {
            uint256 marketingShare = (address(this).balance * 2) / 5;
            uint256 devShare = address(this).balance - marketingShare;
            (bool success, ) = MarketingWallet.call{value: marketingShare}("");
            (success, ) = DevWallet.call{value: devShare}("");
        }
    }

    function swapToETH(uint256 _amount) internal {
        address[] memory path = new address[](2);
        path[0] = address(this);
        path[1] = uniswapRouter.WETH();
        _approve(address(this), address(uniswapRouter), _amount);
        uniswapRouter.swapExactTokensForETHSupportingFeeOnTransferTokens(
            _amount,
            0,
            path,
            address(this),
            block.timestamp
        );
    }

    function withdrawStuckETH() external onlyOwner {
        (bool success, ) = address(msg.sender).call{
            value: address(this).balance
        }("");
        require(success, "transfering ETH failed");
    }

    function withdrawStuckTokens(address erc20_token) external onlyOwner {
        bool success = IERC20(erc20_token).transfer(
            msg.sender,
            IERC20(erc20_token).balanceOf(address(this))
        );
        require(success, "trasfering tokens failed!");
    }

    receive() external payable {}
}