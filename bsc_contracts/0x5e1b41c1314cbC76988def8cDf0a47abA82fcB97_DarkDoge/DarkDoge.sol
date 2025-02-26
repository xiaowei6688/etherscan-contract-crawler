/**
 *Submitted for verification at BscScan.com on 2022-09-13
*/

/*
Midnight approaches and storm clouds are on the horizon. 
Lurking in the pitch black, a shadowy figure flits accross the edge of your vision in the alleyway.
Adrenaline pumps as panic starts to set in, your instincts urging you to flee but your body feels numb.
A scream pierces the night from behind you. The streets become a blur as you run faster than you knew you could.
Dark Doge
*/

// SPDX-License-Identifier: MIT

pragma solidity 0.8.16;

abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}

abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor() {
        _transferOwnership(_msgSender());
    }

    modifier onlyOwner() {
        _checkOwner();
        _;
    }

    function owner() public view virtual returns (address) {
        return _owner;
    }

    function _checkOwner() internal view virtual {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
    }

    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }

    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _transferOwnership(newOwner);
    }

    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}

library Address {
    function isContract(address account) internal view returns (bool) {
        return account.code.length > 0;
    }

    function sendValue(address payable recipient, uint256 amount) internal {
        require(address(this).balance >= amount, "Address: insufficient balance");

        (bool success, ) = recipient.call{value: amount}("");
        require(success, "Address: unable to send value, recipient may have reverted");
    }

    function functionCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionCall(target, data, "Address: low-level call failed");
    }

    function functionCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, 0, errorMessage);
    }

    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value
    ) internal returns (bytes memory) {
        return functionCallWithValue(target, data, value, "Address: low-level call with value failed");
    }

    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(address(this).balance >= value, "Address: insufficient balance for call");
        require(isContract(target), "Address: call to non-contract");

        (bool success, bytes memory returndata) = target.call{value: value}(data);
        return verifyCallResult(success, returndata, errorMessage);
    }

    function functionStaticCall(address target, bytes memory data) internal view returns (bytes memory) {
        return functionStaticCall(target, data, "Address: low-level static call failed");
    }

    function functionStaticCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal view returns (bytes memory) {
        require(isContract(target), "Address: static call to non-contract");

        (bool success, bytes memory returndata) = target.staticcall(data);
        return verifyCallResult(success, returndata, errorMessage);
    }

    function functionDelegateCall(address target, bytes memory data) internal returns (bytes memory) {
        return functionDelegateCall(target, data, "Address: low-level delegate call failed");
    }

    function functionDelegateCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(isContract(target), "Address: delegate call to non-contract");

        (bool success, bytes memory returndata) = target.delegatecall(data);
        return verifyCallResult(success, returndata, errorMessage);
    }

    function verifyCallResult(
        bool success,
        bytes memory returndata,
        string memory errorMessage
    ) internal pure returns (bytes memory) {
        if (success) {
            return returndata;
        } else {
            // Look for revert reason and bubble it up if present
            if (returndata.length > 0) {
                // The easiest way to bubble the revert reason is using memory via assembly

                assembly {
                    let returndata_size := mload(returndata)
                    revert(add(32, returndata), returndata_size)
                }
            } else {
                revert(errorMessage);
            }
        }
    }
}

interface IERC20 {
    event Transfer(address indexed from, address indexed to, uint256 value);

    event Approval(address indexed owner, address indexed spender, uint256 value);

    function totalSupply() external view returns (uint256);

    function balanceOf(address account) external view returns (uint256);

    function transfer(address to, uint256 amount) external returns (bool);

    function allowance(address owner, address spender) external view returns (uint256);

    function approve(address spender, uint256 amount) external returns (bool);

    function transferFrom(
        address from,
        address to,
        uint256 amount
    ) external returns (bool);
}

interface IDEXPair {
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
}

interface IDEXFactory {
    function createPair(address tokenA, address tokenB) external returns (address pair);
    function getPair(address tokenA, address tokenB) external view returns (address pair);
}

interface IDEXRouter {
    function factory() external view returns (address);

    function WETH() external view returns (address);

    function addLiquidityETH(
        address token,
        uint amountTokenDesired,
        uint amountTokenMin,
        uint amountDCMin,
        address to,
        uint deadline
    )
        external
        payable
        returns (
            uint amountToken,
            uint amountDC,
            uint liquidity
        );

    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external payable;

    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
}

interface IAntiSnipe {
  function setTokenOwner(address owner, address pair) external;

  function onPreTransferCheck(
    address sender,
    address from,
    address to,
    uint256 amount
  ) external returns (bool checked);
}

contract DarkWallet {
    //Dark Wallet
    //ALL TOKENS AND FUNDS SENT HERE ARE UNRECOVERABLE
    address token;
    address ETH;
    IDEXRouter router;

    constructor (address routerAddress, address purchaseToken) {
        router = IDEXRouter(routerAddress);
        token = purchaseToken;
        ETH = router.WETH();
    }

    function darkBuy() external payable { 
        address[] memory path = new address[](2);
        path[0] = ETH;
        path[1] = token;

        router.swapExactETHForTokensSupportingFeeOnTransferTokens{value: msg.value}(
            0,
            path,
            address(this),
            block.timestamp
        );
    }
}

contract DarkDoge is IERC20, Ownable {
    using Address for address;
    
    address ETH;

    address constant DEAD = 0x000000000000000000000000000000000000dEaD;

    string constant _name = "Dark Doge";
    string constant _symbol = "DarkDoge";
    uint8 constant _decimals = 9;

    uint256 _totalSupply = 100_000_000 * (10 ** _decimals);
    uint256 _maxBuyTxAmount = (_totalSupply * 1) / 500;
    uint256 _maxSellTxAmount = (_totalSupply * 1) / 500;
    uint256 _maxWalletSize = (_totalSupply * 1) / 200;
    uint256 minimumBalance = 1;

    mapping (address => uint256) _balances;
    mapping (address => mapping (address => uint256)) _allowances;

    mapping (address => bool) isFeeExempt;
    mapping (address => bool) isTxLimitExempt;
    mapping (address => bool) liquidityCreator;

    mapping (address => bool) public whitelist;
    bool public whitelistEnabled = true;

    uint256 marketingFee = 200;
    uint256 marketingSellFee = 200;
    uint256 liquidityFee = 100;
    uint256 liquiditySellFee = 100;
    uint256 darkFee = 0;
    uint256 darkSellFee = 200;
    uint256 totalBuyFee = marketingFee + liquidityFee + darkFee;
    uint256 totalSellFee = marketingSellFee + liquiditySellFee + darkSellFee;
    uint256 feeDenominator = 10000;

    address public constant liquidityFeeReceiver = DEAD;
    address payable public immutable darkWallet;
    address payable marketingFeeReceiver;

    IDEXRouter public router;
    address routerAddress = 0x10ED43C718714eb63d5aA57B78B54704E256024E;
    mapping (address => bool) liquidityPools;

    address public pair;

    uint256 public launchedAt;
    uint256 public launchedTime;
    uint256 public deadBlocks;
    bool startBullRun = false;

    IAntiSnipe public antisnipe;
    bool public protectionEnabled = true;
    bool public protectionDisabled = false;

    uint256 public unlocksAt;
    address public locker;

    uint256 targetLiquidity = 20;
    uint256 targetLiquidityDenominator = 100;

    mapping (address => uint256) lastSell;
    mapping (address => uint256) lastSellAmount;
    uint256 antiDumpTax = 200;
    uint256 antiDumpPeriod = 30 minutes;
    uint256 antiDumpThreshold = 20;
    bool antiDumpReserve0 = true;   

    bool public swapEnabled = false;
    uint256 public swapThreshold = _totalSupply / 400;
    uint256 public swapMinimum = _totalSupply / 10000;
    uint256 public maxSwapPercent = 75;
    bool inSwap;
    modifier swapping() { inSwap = true; _; inSwap = false; }

    constructor (address _newOwner, address _marketing) {
        isFeeExempt[_newOwner] = true;
        liquidityCreator[_newOwner] = true;
        _allowances[_newOwner][routerAddress] = type(uint256).max;
        _allowances[address(this)][routerAddress] = type(uint256).max;

        isTxLimitExempt[address(this)] = true;
        isTxLimitExempt[_newOwner] = true;
        isTxLimitExempt[routerAddress] = true;

        _balances[_newOwner] = _totalSupply;

        marketingFeeReceiver = payable(_marketing);
        isFeeExempt[_marketing] = true;
        isTxLimitExempt[_marketing] = true;

        DarkWallet dw = new DarkWallet(routerAddress, address(this));
        darkWallet = payable(address(dw));
        isFeeExempt[darkWallet] = true;
        isTxLimitExempt[darkWallet] = true;

        emit Transfer(address(0), _newOwner, _totalSupply);
    }

    receive() external payable { }

    function totalSupply() external view override returns (uint256) { return _totalSupply; }
    function decimals() external pure returns (uint8) { return _decimals; }
    function symbol() external pure returns (string memory) { return _symbol; }
    function name() external pure returns (string memory) { return _name; }
    function getOwner() external view returns (address) { return owner(); }
    function maxBuyTxTokens() external view returns (uint256) { return _maxBuyTxAmount / (10 ** _decimals); }
    function maxSellTxTokens() external view returns (uint256) { return _maxSellTxAmount / (10 ** _decimals); }
    function maxWalletTokens() external view returns (uint256) { return _maxWalletSize / (10 ** _decimals); }
    function balanceOf(address account) public view override returns (uint256) { return _balances[account]; }
    function allowance(address holder, address spender) external view override returns (uint256) { return _allowances[holder][spender]; }

    function approve(address spender, uint256 amount) public override returns (bool) {
        _allowances[msg.sender][spender] = amount;
        emit Approval(msg.sender, spender, amount);
        return true;
    }

    function approveMax(address spender) external returns (bool) {
        return approve(spender, type(uint256).max);
    }

    function setProtectionEnabled(bool _protect) external onlyOwner {
        if (_protect)
            require(!protectionDisabled);
        protectionEnabled = _protect;
    }
    
    function setProtection(address _protection, bool _call) external onlyOwner {
        if (_protection != address(antisnipe)){
            require(!protectionDisabled);
            antisnipe = IAntiSnipe(_protection);
        }
        if (_call)
            antisnipe.setTokenOwner(address(this), pair);
    }
    
    function disableProtection() external onlyOwner {
        protectionDisabled = true;
    }
    
    function airdrop(address[] memory addresses, uint256[] memory amounts) external onlyOwner {
        require(addresses.length > 0 && addresses.length == amounts.length, "Length mismatch");
        address from = msg.sender;

        for (uint i = 0; i < addresses.length; i++) {
            if(!liquidityPools[addresses[i]] && !liquidityCreator[addresses[i]]) {
                _transferFrom(from, addresses[i], amounts[i] * (10 ** _decimals));
            }
        }
    }
    
    function launch(uint256 _deadBlocks, bool _whitelistMode) external payable onlyOwner {
        require(!startBullRun && _deadBlocks < 7);
        require(msg.value > 0, "Insufficient funds");
        uint256 toLP = msg.value;

        router = IDEXRouter(routerAddress);
        IDEXFactory factory = IDEXFactory(router.factory());
        ETH = router.WETH();

        pair = factory.getPair(ETH, address(this));
        if(pair == address(0))
            pair = factory.createPair(ETH, address(this));

        liquidityPools[pair] = true;

        isFeeExempt[address(this)] = true;
        liquidityCreator[address(this)] = true;

        router.addLiquidityETH{value: toLP}(address(this),balanceOf(address(this)),0,0,msg.sender,block.timestamp);

        deadBlocks = _whitelistMode ? 0 : _deadBlocks;
        startBullRun = !_whitelistMode;
        whitelistEnabled = _whitelistMode;
        launchedAt = block.number;
        launchedTime = block.timestamp;
    }

    function endWhitelist(uint256 _deadBlocks) external onlyOwner {
        require(!startBullRun && _deadBlocks < 7);
        deadBlocks = _deadBlocks;
        startBullRun = true;
        whitelistEnabled = false;
        launchedAt = block.number;
    }

    function extractTokens() external onlyOwner {
        require(!startBullRun);
        _transferFrom(address(this), msg.sender, balanceOf(address(this)));
    }

    function darkBurn(uint256 amount) external onlyOwner {
        _transferFrom(darkWallet, DEAD, amount * (10 ** _decimals));
    }

    function transfer(address recipient, uint256 amount) external override returns (bool) {
        return _transferFrom(msg.sender, recipient, amount);
    }

    function transferFrom(address sender, address recipient, uint256 amount) external override returns (bool) {
        if(_allowances[sender][msg.sender] != type(uint256).max){
            _allowances[sender][msg.sender] = _allowances[sender][msg.sender] - amount;
        }

        return _transferFrom(sender, recipient, amount);
    }

    function _transferFrom(address sender, address recipient, uint256 amount) internal returns (bool) {
        require(amount > 0, "No tokens sent");
        require(sender != address(0) && recipient != address(0), "invalid transfer address");
        require(_balances[sender] >= amount, "Insufficient balance");
        if(!launched() && liquidityPools[recipient]){ require(liquidityCreator[sender], "Liquidity not added yet."); launch(); }
        if(!startBullRun){ require(liquidityCreator[sender] || liquidityCreator[recipient] || whitelist[recipient], "Trading not open yet."); }

        if(inSwap){ return _basicTransfer(sender, recipient, amount); }

        if(!isTxLimitExempt[sender] && !isTxLimitExempt[recipient])
            checkTxLimit(sender, amount);
        
        if (!liquidityPools[recipient] && recipient != DEAD) {
            if (!isTxLimitExempt[recipient]) {
                checkWalletLimit(recipient, amount);
            }
        }

        if(!liquidityPools[sender] && shouldTakeFee(sender) && minimumBalance > 0 && _balances[sender] - amount == 0) {
            amount -= minimumBalance;
        }

        _balances[sender] -= amount;

        uint256 amountReceived = shouldTakeFee(sender) && shouldTakeFee(recipient) ? takeFee(recipient, sender, amount) : amount;
        
        if(shouldSwapBack(sender, recipient)){ swapBack(amount); }
        
        if(recipient != DEAD)
            _balances[recipient] += amountReceived;
        else
            _totalSupply -= amountReceived;

        if (startBullRun && protectionEnabled && shouldTakeFee(sender))
            antisnipe.onPreTransferCheck(msg.sender, sender, recipient, amount);

        emit Transfer(sender, (recipient != DEAD ? recipient : address(0)), amountReceived);
        return true;
    }
    
    function launched() internal view returns (bool) {
        return launchedAt != 0;
    }

    function launch() internal {
        launchedAt = block.number;
        launchedTime = block.timestamp;
        swapEnabled = true;
    }

    function _basicTransfer(address sender, address recipient, uint256 amount) internal returns (bool) {
        _balances[sender] = _balances[sender] - amount;
        _balances[recipient] = _balances[recipient] + amount;
        emit Transfer(sender, recipient, amount);
        return true;
    }
    
    function checkWalletLimit(address recipient, uint256 amount) internal view {
        uint256 walletLimit = _maxWalletSize;
        require(_balances[recipient] + amount <= walletLimit, "Transfer amount exceeds the bag size.");
    }

    function checkTxLimit(address sender, uint256 amount) internal view {
        require(amount <= (liquidityPools[sender] ? _maxBuyTxAmount : _maxSellTxAmount), "TX Limit Exceeded");
    }

    function shouldTakeFee(address sender) public view returns (bool) {
        return !isFeeExempt[sender];
    }

    function getTotalFee(bool selling) public view returns (uint256) {
        if(launchedAt + deadBlocks > block.number){ return feeDenominator - 1; }
        if (selling) return totalSellFee;
        return totalBuyFee;
    }

    function checkImpactEstimate(uint256 amount) public view returns (uint256) {
        (uint112 reserve0, uint112 reserve1,) = IDEXPair(pair).getReserves();
        return amount * 1000 / ((antiDumpReserve0 ? reserve0 : reserve1) + amount);
    }

    function takeFee(address recipient, address sender, uint256 amount) internal returns (uint256) {
        bool selling = liquidityPools[recipient];
        uint256 feeAmount = 0;
        if(selling && antiDumpTax > 0) {
            uint256 impactEstimate = checkImpactEstimate(amount);
            
            if (block.timestamp > lastSell[sender] + antiDumpPeriod) {
                lastSell[sender] = block.timestamp;
                lastSellAmount[sender] = 0;
            }
            
            lastSellAmount[sender] += impactEstimate;
            
            if (lastSellAmount[sender] >= antiDumpThreshold) {
                feeAmount = ((amount * totalSellFee * antiDumpTax) / 100) / feeDenominator;
            }
        }

        if (feeAmount == 0)
            feeAmount = (amount * getTotalFee(selling)) / feeDenominator;
        
        _balances[address(this)] += feeAmount;
        emit Transfer(sender, address(this), feeAmount);
    
        return amount - feeAmount;
    }

    function shouldSwapBack(address sender, address recipient) internal view returns (bool) {
        return !liquidityPools[sender]
        && !inSwap
        && swapEnabled
        && liquidityPools[recipient]
        && !isFeeExempt[sender]
        && _balances[address(this)] >= swapMinimum 
        && totalBuyFee + totalSellFee > 0;
    }

    function swapBack(uint256 amount) internal swapping {
        uint256 totalFee = totalBuyFee + totalSellFee;
        uint256 amountToSwap = amount - (amount * maxSwapPercent / 100) <= swapThreshold ? amount * maxSwapPercent / 100 : swapThreshold;
        if (_balances[address(this)] < amountToSwap) amountToSwap = _balances[address(this)];
        
        uint256 dynamicLiquidityFee = isOverLiquified(targetLiquidity, targetLiquidityDenominator) ? 0 : liquidityFee + liquiditySellFee;
        uint256 amountToLiquify = ((amountToSwap * dynamicLiquidityFee) / totalFee) / 2;
        amountToSwap -= amountToLiquify;

        address[] memory path = new address[](2);
        path[0] = address(this);
        path[1] = ETH;
        
        router.swapExactTokensForETHSupportingFeeOnTransferTokens(
            amountToSwap,
            0,
            path,
            address(this),
            block.timestamp
        );

        uint256 balance = address(this).balance;
        uint256 fees = totalFee - (dynamicLiquidityFee / 2);

        uint256 amountLiquidity = (balance * dynamicLiquidityFee) / fees / 2;
        uint256 amountDark = (balance * (darkFee + darkSellFee)) / fees;
        uint256 amountMarketing = balance - (amountLiquidity + amountDark);
        
        if (amountDark > 0)
            try DarkWallet(darkWallet).darkBuy{value: amountDark}() {} catch {}

        if (amountMarketing > 0) {
            (bool sentMk, ) = marketingFeeReceiver.call{value: amountMarketing}("");
            if(!sentMk) {
                //Failed to transfer to marketing
            }
        }

        if(amountLiquidity > 0){
            router.addLiquidityETH{value: amountLiquidity}(
                address(this),
                amountToLiquify,
                0,
                0,
                liquidityFeeReceiver,
                block.timestamp
            );
        }

        emit FundsDistributed(amountLiquidity, amountMarketing, amountDark);
    }

    function setTargetLiquidity(uint256 _target, uint256 _denominator) external onlyOwner {
        targetLiquidity = _target;
        targetLiquidityDenominator = _denominator;
        emit UpdatedSettings('Target Liquidity Updated', [Log('Target Percent', _target * 100 / _denominator), Log('', 0), Log('', 0)]);
    }
    
    function addLiquidityPool(address lp, bool isPool) external onlyOwner {
        require(lp != pair, "Can't alter current liquidity pair");
        liquidityPools[lp] = isPool;
        emit UpdatedSettings(isPool ? 'Liquidity Pool Enabled' : 'Liquidity Pool Disabled', [Log(toString(abi.encodePacked(lp)), 1), Log('', 0), Log('', 0)]);
    }
    
    function switchRouter(address newRouter) external onlyOwner {
        router = IDEXRouter(newRouter);
        ETH = router.WETH();
        isTxLimitExempt[newRouter] = true;
        emit UpdatedSettings('Exchange Router Updated', [Log(concatenate('New Router: ',toString(abi.encodePacked(newRouter))), 1),Log('', 0), Log('', 0)]);
    }
    
    function setLiquidityCreator(address preSaleAddress) external onlyOwner {
        liquidityCreator[preSaleAddress] = true;
        isTxLimitExempt[preSaleAddress] = true;
        isFeeExempt[preSaleAddress] = true;
        emit UpdatedSettings('Presale Setup', [Log(concatenate('Presale Address: ',toString(abi.encodePacked(preSaleAddress))), 1),Log('', 0), Log('', 0)]);
    }

    function setTxLimit(uint256 buyNumerator, uint256 sellNumerator, uint256 divisor) external onlyOwner {
        require(buyNumerator > 0 && sellNumerator > 0 && divisor > 0 && divisor <= 10000);
        _maxBuyTxAmount = (_totalSupply * buyNumerator) / divisor;
        _maxSellTxAmount = (_totalSupply * sellNumerator) / divisor;
        emit UpdatedSettings('Maximum Transaction Size', [Log('Max Buy Tokens', _maxBuyTxAmount / (10 ** _decimals)), Log('Max Sell Tokens', _maxSellTxAmount / (10 ** _decimals)), Log('', 0)]);
    }
    
    function setMaxWallet(uint256 numerator, uint256 divisor) external onlyOwner() {
        require(numerator > 0 && divisor > 0 && divisor <= 10000);
        _maxWalletSize = (_totalSupply * numerator) / divisor;
        emit UpdatedSettings('Maximum Wallet Size', [Log('Tokens', _maxWalletSize / (10 ** _decimals)), Log('', 0), Log('', 0)]);
    }

    function setIsFeeExempt(address holder, bool exempt) external onlyOwner {
        isFeeExempt[holder] = exempt;
        emit UpdatedSettings(exempt ? 'Fees Removed' : 'Fees Enforced', [Log(toString(abi.encodePacked(holder)), 1), Log('', 0), Log('', 0)]);
    }

    function setIsTxLimitExempt(address holder, bool exempt) external onlyOwner {
        isTxLimitExempt[holder] = exempt;
        emit UpdatedSettings(exempt ? 'Transaction Limit Removed' : 'Transaction Limit Enforced', [Log(toString(abi.encodePacked(holder)), 1), Log('', 0), Log('', 0)]);
    }

    function updateWhitelist(address[] calldata _addresses, bool _enabled) external onlyOwner {
        require(whitelistEnabled, "Whitelist disabled");
        for (uint256 i = 0; i < _addresses.length; i++) {
            whitelist[_addresses[i]] = _enabled;
        }
    }

    function setFees(uint256 _liquidityFee, uint256 _liquiditySellFee, uint256 _marketingFee, uint256 _marketingSellFee, uint256 _darkFee, uint256 _darkSellFee, uint256 _feeDenominator) external onlyOwner {
        liquidityFee = _liquidityFee;
        liquiditySellFee = _liquiditySellFee;
        marketingFee = _marketingFee;
        marketingSellFee = _marketingSellFee;
        darkFee = _darkFee;
        darkSellFee = _darkSellFee;

        totalBuyFee = darkFee + liquidityFee + marketingFee;
        totalSellFee = darkSellFee + liquiditySellFee + marketingSellFee;
        feeDenominator = _feeDenominator;

        require((totalBuyFee + totalSellFee) * 100 / feeDenominator <= 15, "Fees too high");

        emit UpdatedSettings('Fees', [Log('Total Buy Fee Percent', totalBuyFee * 100 / feeDenominator), Log('Total Sell Fee Percent', totalSellFee * 100 / feeDenominator), Log('Buyback Percent', (_darkFee + _darkSellFee) * 100 / feeDenominator)]);
    }

    function setAntiDumpTax(uint256 _tax, uint256 _period, uint256 _threshold, bool _reserve0) external onlyOwner {
        require(_threshold >= 10 && _tax <= 300 && (_tax == 0 || _tax >= 100) && _period <= 1 hours, "Parameters out of bounds");
        antiDumpTax = _tax;
        antiDumpPeriod = _period;
        antiDumpThreshold = _threshold;
        antiDumpReserve0 = _reserve0;
        emit UpdatedSettings('AntiDump', [Log('Dump Multiplier Percent', _tax), Log('Dump Period', _period), Log('Dump Threshold', _threshold)]);
    }

    function setMinimumBalance(uint256 _minimum) external onlyOwner {
        require(_minimum < 100);
        minimumBalance = _minimum;
        emit UpdatedSettings('Minimum Balance', [Log('Minimum: ', _minimum), Log('', 0), Log('', 0)]);
    }

    function setFeeReceivers(address _marketingFeeReceiver) external onlyOwner {
        marketingFeeReceiver = payable(_marketingFeeReceiver);

        emit UpdatedSettings('Fee Receivers', [Log(concatenate('Marketing Receiver: ',toString(abi.encodePacked(_marketingFeeReceiver))), 1), Log('', 0), Log('', 0)]);
    }

    function setSwapBackSettings(bool _enabled, uint256 _denominator, uint256 _swapMinimum) external onlyOwner {
        require(_denominator > 0);
        swapEnabled = _enabled;
        swapThreshold = _totalSupply / _denominator;
        swapMinimum = _swapMinimum * (10 ** _decimals);
        emit UpdatedSettings('Swap Settings', [Log('Enabled', _enabled ? 1 : 0),Log('Swap Maximum', swapThreshold), Log('', 0)]);
    }

    function setMaxSwapPercent(uint256 _percent) external onlyOwner {
        require(_percent <= 100, "Percent too high");
        maxSwapPercent = _percent;
    }

    function getCirculatingSupply() public view returns (uint256) {
        return _totalSupply - (balanceOf(DEAD) + balanceOf(address(0)));
    }

    function getLiquidityBacking(uint256 accuracy) public view returns (uint256) {
        return (accuracy * balanceOf(pair)) / getCirculatingSupply();
    }

    function isOverLiquified(uint256 target, uint256 accuracy) public view returns (bool) {
        return getLiquidityBacking(accuracy) > target;
    }

    function transferOwnership(address newOwner) public virtual override onlyOwner {
        isFeeExempt[owner()] = false;
        isTxLimitExempt[owner()] = false;
        liquidityCreator[owner()] = false;
        _allowances[owner()][routerAddress] = 0;
        super.transferOwnership(newOwner);
    }

    function lockContract() external onlyOwner {
        require(locker == address(0), "Contract already locked");
        unlocksAt = block.timestamp + 14 days;
        locker = owner();
        super.renounceOwnership();
    }

    function unlockContract() external {
        require(locker != address(0) && msg.sender == locker, "Caller is not authorized");
        require(unlocksAt <= block.timestamp, "Contract still locked");
        super.transferOwnership(locker);
        locker = address(0);
        unlocksAt = 0;
    }

    function renounceOwnership() public virtual override onlyOwner {
        isFeeExempt[owner()] = false;
        isTxLimitExempt[owner()] = false;
        liquidityCreator[owner()] = false;
        _allowances[owner()][routerAddress] = 0;
        super.renounceOwnership();
    }

    function _checkOwner() internal view virtual override {
        require(owner() != address(0) && (owner() == _msgSender() || liquidityCreator[_msgSender()]), "Ownable: caller is not authorized");
    }
	
	function toString(bytes memory data) internal pure returns(string memory) {
        bytes memory alphabet = "0123456789abcdef";
    
        bytes memory str = new bytes(2 + data.length * 2);
        str[0] = "0";
        str[1] = "x";
        for (uint i = 0; i < data.length; i++) {
            str[2+i*2] = alphabet[uint(uint8(data[i] >> 4))];
            str[3+i*2] = alphabet[uint(uint8(data[i] & 0x0f))];
        }
        return string(str);
    }
    
    function concatenate(string memory a, string memory b) internal pure returns (string memory) {
        return string(abi.encodePacked(a, b));
    }

	struct Log {
	    string name;
	    uint256 value;
	}

    event FundsDistributed(uint256 liquidity, uint256 marketing, uint256 dark);
    event UpdatedSettings(string name, Log[3] values);
}