/**
 *Submitted for verification at BscScan.com on 2023-04-16
*/

// SPDX-License-Identifier: MIT

/*

CloudNet - CLN
Telegram : https://t.me/cloudNetofficiall |

Quality improvement from the launch of a more developed platform with the web3 system as well as the addition of features and utilities

**/

pragma solidity ^0.8.19;

interface IBEP20 {

    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

library SafeMath {
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        uint256 c = a + b;
        require(c >= a, "SafeMath: addition overflow");

        return c;
    }

    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return sub(a, b, "SafeMath: subtraction overflow");
    }

    function sub(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b <= a, errorMessage);
        uint256 c = a - b;

        return c;
    }

    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        if (a == 0) {
            return 0;
        }

        uint256 c = a * b;
        require(c / a == b, "SafeMath: multiplication overflow");

        return c;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return div(a, b, "SafeMath: division by zero");
    }

    function div(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;
        // assert(a == b * c + a % b); // There is no case in which this doesn't hold

        return c;
    }

    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    function mod(uint256 a, uint256 b, string memory errorMessage) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

abstract contract Context {
    function _msgSender() internal view virtual returns (address payable) {
        return payable(msg.sender);
    }

    function _msgData() internal view virtual returns (bytes memory) {
        this;
        return msg.data;
    }
}

contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor () {
        address msgSender = _msgSender();
        _owner = msgSender;
        emit OwnershipTransferred(address(0), msgSender);
    }

    function owner() public view returns (address) {
        return _owner;
    }

    modifier onlyOwner() {
        require(_owner == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    function renounceOwnership() public virtual onlyOwner {
        emit OwnershipTransferred(_owner, address(0));
        _owner = address(0);
    }

    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}

interface IUniswapV2Factory {
    event PairCreated(address indexed token0, address indexed token1, address pair, uint);

    function createPair(address tokenA, address tokenB) external returns (address pair);
}

interface IUniswapV2Router02 {
    function factory() external pure returns (address);
    function WETH() external pure returns (address);

    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountETHMin,
        address to,
        uint deadline
    ) external payable returns (uint amountToken, uint amountETH, uint liquidity);

    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;

    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    )
        external payable;
}

contract CLOUDNET  is Context, IBEP20, Ownable {
    using SafeMath for uint256;
    IUniswapV2Router02 public uniswapV2Router;

    address public uniswapV2Pair;
    
    mapping (address => uint256) private balances;
    mapping (address => mapping (address => uint256)) private _allowances;
    mapping (address => bool) private _isExcludedFromFee;

    string private constant _name = "CloudNet";
    string private constant _symbol = "CLN";
    uint8 private constant _decimals = 18;
    uint256 private _tTotal =  200000000  * 10**18;

    uint256 public _maxWalletAmount = 4000000 * 10**18;
    uint256 public _maxTxAmount = 4000000 * 10**18;
    uint256 public swapTokenAtAmount = 2000000 * 10**18;

    address public liquidityReceiver;
    address public marketingWallet;

    bool public limitsIsActive = true;

    struct BuyFees{
        uint256 liquidity;
        uint256 marketing;
    }

    struct SellFees{
        uint256 liquidity;
        uint256 marketing;
    }

    BuyFees public buyFee;
    SellFees public sellFee;

    uint256 private liquidityFee;
    uint256 private marketingFee;

    bool private swapping;
    event SwapAndLiquify(uint256 tokensSwapped, uint256 ethReceived, uint256 tokensIntoLiquidity);

    constructor (address marketingAddress) {
        marketingWallet = marketingAddress;
        liquidityReceiver = msg.sender;
        balances[address(liquidityReceiver)] = _tTotal;
        
        buyFee.liquidity = 2;
        buyFee.marketing = 8;

        sellFee.liquidity = 2;
        sellFee.marketing = 8;

        IUniswapV2Router02 _uniswapV2Router = IUniswapV2Router02(0x10ED43C718714eb63d5aA57B78B54704E256024E);
        address _uniswapV2Pair = IUniswapV2Factory(_uniswapV2Router.factory()).createPair(address(this), _uniswapV2Router.WETH());

        uniswapV2Router = _uniswapV2Router;
        uniswapV2Pair = _uniswapV2Pair;
        
        _isExcludedFromFee[msg.sender] = true;
        _isExcludedFromFee[address(this)] = true;
        _isExcludedFromFee[address(0x0000)] = true;
        _isExcludedFromFee[address(0xdead)] = true;

        
        emit Transfer(address(0), address(msg.sender), _tTotal);
    }

    function name() public pure returns (string memory) {
        return _name;
    }

    function symbol() public pure returns (string memory) {
        return _symbol;
    }

    function decimals() public pure returns (uint8) {
        return _decimals;
    }

    function totalSupply() public view override returns (uint256) {
        return _tTotal;
    }

    function balanceOf(address account) public view override returns (uint256) {
        return balances[account];
    }

    function transfer(address recipient, uint256 amount) public override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    function allowance(address owner, address spender) public view override returns (uint256) {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 amount) public override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    function transferFrom(address sender, address recipient, uint256 amount) public override returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(sender, _msgSender(), _allowances[sender][_msgSender()] - amount);
        return true;
    }

    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender] + addedValue);
        return true;
    }

    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender] - subtractedValue);
        return true;
    }
    
    function excludeFromFees(address account, bool excluded) public onlyOwner {
        _isExcludedFromFee[address(account)] = excluded;
    }

    receive() external payable {}
    
    function forceSwap() public onlyOwner {
        uint256 tokenBalance=balanceOf(address(this));
        if(tokenBalance>0){
          swapBack(tokenBalance);
        }
    }

    function removeLimits() public onlyOwner {
        limitsIsActive = false;
    }

    function setBuyFee(uint256 setLiquidityFee, uint256 setMarketingFee) public onlyOwner {
        require(setLiquidityFee + setMarketingFee <= 25, "Total buy fee cannot be set higher than 25%.");
        buyFee.liquidity = setLiquidityFee;
        buyFee.marketing = setMarketingFee;
    }

    function setSellFee(uint256 setLiquidityFee, uint256 setMarketingFee) public onlyOwner {
        require(setLiquidityFee + setMarketingFee <= 25, "Total sell fee cannot be set higher than 25%.");
        sellFee.liquidity = setLiquidityFee;
        sellFee.marketing = setMarketingFee;
    }

    function setMaxTransactionAmount(uint256 maxTransactionAmount) public onlyOwner {
        require(maxTransactionAmount >= 1000000, "Max Transaction cannot be set lower than 0.5%.");
        _maxTxAmount = maxTransactionAmount * 10**18;
    }

    function setMaxWalletAmount(uint256 maxWalletAmount) public onlyOwner {
        require(maxWalletAmount >= 2000000, "Max Wallet cannot be set lower than 1%.");
        _maxWalletAmount = maxWalletAmount * 10**18;
    }

    function setSwapAtAmount(uint256 swapAtAmount) public onlyOwner {
        require(swapAtAmount <= 8000000, "SwapTokenAtAmount cannot be set higher than 4%.");
        swapTokenAtAmount = swapAtAmount * 10**18;
    }

    function setLiquidityWallet(address newLiquidityWallet) public onlyOwner {
        liquidityReceiver = newLiquidityWallet;
    }

    function setMarketingWallet(address newMarketingWallet) public onlyOwner {
        marketingWallet = newMarketingWallet;
    }

    function takeBuyFees(uint256 amount, address from) private returns (uint256) {
        uint256 liquidityFeeToken = amount * buyFee.liquidity / 100; 
        uint256 marketingFeeTokens = amount * buyFee.marketing / 100;

        balances[address(this)] += liquidityFeeToken + marketingFeeTokens;
        emit Transfer (from, address(this), marketingFeeTokens + liquidityFeeToken);
        return (amount -liquidityFeeToken -marketingFeeTokens);
    }

    function takeSellFees(uint256 amount, address from) private returns (uint256) {
        uint256 liquidityFeeToken = amount * buyFee.liquidity / 100; 
        uint256 marketingFeeTokens = amount * buyFee.marketing / 100;

        balances[address(this)] += liquidityFeeToken + marketingFeeTokens;
        emit Transfer (from, address(this), marketingFeeTokens + liquidityFeeToken);
        return (amount -liquidityFeeToken -marketingFeeTokens);
    }

    function isExcludedFromFee(address account) public view returns(bool) {
        return _isExcludedFromFee[account];
    }

    function _approve(address owner, address spender, uint256 amount) private {
        require(owner != address(0), "BEP20: approve from the zero address");
        require(spender != address(0), "BEP20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    function _transfer(
        address from,
        address to,
        uint256 amount
    ) private {
        require(from != address(0), "BEP20: transfer from the zero address");
        require(to != address(0), "BEP20: transfer to the zero address");
        require(amount > 0, "Transfer amount must be greater than zero");
        
        balances[from] -= amount;
        uint256 transferAmount = amount;
        
        bool takeFee;

        if(!_isExcludedFromFee[from] && !_isExcludedFromFee[to]){
            takeFee = true;
        }

        if(takeFee){
            if(to != uniswapV2Pair && from == uniswapV2Pair){
                if(limitsIsActive) {
                    require(amount <= _maxTxAmount, "Transfer Amount exceeds the maxTxnsAmount");
                    require(balanceOf(to) + amount <= _maxWalletAmount, "Transfer amount exceeds the maxWalletAmount.");
                }
                transferAmount = takeBuyFees(amount, to);
            }

            if(from != uniswapV2Pair && to == uniswapV2Pair){
                if(limitsIsActive) {
                    require(amount <= _maxTxAmount, "Transfer Amount exceeds the maxTxnsAmount");
                }
                transferAmount = takeSellFees(amount, from);

               if (balanceOf(address(this)) >= swapTokenAtAmount && !swapping) {
                    swapping = true;
                    if(transferAmount >= swapTokenAtAmount) {
                        swapBack(swapTokenAtAmount);
                    } else {
                        swapBack(transferAmount);
                    }
                    swapping = false;
              }
            }

            if(to != uniswapV2Pair && from != uniswapV2Pair){
                if(limitsIsActive) {
                    require(amount <= _maxTxAmount, "Transfer Amount exceeds the maxTxnsAmount");
                    require(balanceOf(to) + amount <= _maxWalletAmount, "Transfer amount exceeds the maxWalletAmount.");
                }
            }
        }
        
        balances[to] += transferAmount;
        emit Transfer(from, to, transferAmount);
    }
   
    function swapBack(uint256 amount) private {
        uint256 contractBalance = amount;
        uint256 liquidityTokens = contractBalance * (buyFee.liquidity + sellFee.liquidity) / (buyFee.marketing + buyFee.liquidity + sellFee.marketing + sellFee.liquidity);
        uint256 marketingTokens = contractBalance * (buyFee.marketing + sellFee.marketing) / (buyFee.marketing + buyFee.liquidity + sellFee.marketing + sellFee.liquidity);
        uint256 totalTokensToSwap = liquidityTokens + marketingTokens;
        
        uint256 tokensForLiquidity = liquidityTokens.div(2);
        uint256 amountToSwapForETH = contractBalance.sub(tokensForLiquidity);
        
        uint256 initialETHBalance = address(this).balance;

        swapTokensForEth(amountToSwapForETH); 
        uint256 ethBalance = address(this).balance.sub(initialETHBalance); 
        uint256 ethForLiquidity = ethBalance.mul(liquidityTokens).div(totalTokensToSwap);

        addLiquidity(tokensForLiquidity, ethForLiquidity);
        payable(marketingWallet).transfer(address(this).balance);
    }

    function swapTokensForEth(uint256 tokenAmount) private {
        address[] memory path = new address[](2);
        path[0] = address(this);
        path[1] = uniswapV2Router.WETH();

        _approve(address(this), address(uniswapV2Router), tokenAmount);

        uniswapV2Router.swapExactTokensForETHSupportingFeeOnTransferTokens(
            tokenAmount,
            0,
            path,
            address(this),
            block.timestamp
        );
    }

    function addLiquidity(uint256 tokenAmount, uint256 ethAmount) private {
        _approve(address(this), address(uniswapV2Router), tokenAmount);

        uniswapV2Router.addLiquidityETH {value: ethAmount} (
            address(this),
            tokenAmount,
            0,
            0,
            liquidityReceiver,
            block.timestamp
        );
    }

    function withdrawForeignToken(address tokenContract) public onlyOwner {
        IBEP20(tokenContract).transfer(address(msg.sender), IBEP20(tokenContract).balanceOf(address(this)));
    }
}