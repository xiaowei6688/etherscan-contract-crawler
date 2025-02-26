/**
 *Submitted for verification at BscScan.com on 2022-11-24
*/

// SPDX-License-Identifier: No

pragma solidity = 0.8.17;

//--- Context ---//
abstract contract Context {
    constructor() {
    }

    function _msgSender() internal view returns (address payable) {
        return payable(msg.sender);
    }

    function _msgData() internal view returns (bytes memory) {
        this;
        return msg.data;
    }
}

//--- Ownable ---//
abstract contract Ownable is Context {
    address private _owner;
    address public _safuDeployer;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    event SAFUDeployerTransferred(address indexed oldMultiSig, address indexed newMultiSig);

    constructor() {
        _setOwner(_msgSender());
        _setSafuDeployer(_msgSender());
    }

    function safuDeployer() public view virtual returns (address) {
        return _safuDeployer;
    }

    function owner() public view virtual returns (address) {
        return _owner;
    }

    modifier onlyOwner() {
        require(owner() == _msgSender() || safuDeployer() == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    modifier onlySafuDeveloper() {
        require(safuDeployer() == _msgSender(), "SAFU: caller is not the safu developer");
        _;
    }

    function renounceOwnership() external virtual onlyOwner {
        _setOwner(address(0));
    }

    function transferOwnership(address newOwner) external virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _setOwner(newOwner);
    }

    function transferSafuDeveloper(address newSafuDeployer) external virtual onlySafuDeveloper {
        require(newSafuDeployer != address(0), "SAFU: new owner is the zero address");
        _setSafuDeployer(newSafuDeployer);
    }

    function _setOwner(address newOwner) private {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }

    function _setSafuDeployer(address newSafuDeployer) private {
        address oldSafuDeployer = newSafuDeployer;
        _safuDeployer = oldSafuDeployer;
        emit SAFUDeployerTransferred(oldSafuDeployer, oldSafuDeployer);
    }
}

interface IFactoryV2 {
    event PairCreated(address indexed token0, address indexed token1, address lpPair, uint);
    function getPair(address tokenA, address tokenB) external view returns (address lpPair);
    function createPair(address tokenA, address tokenB) external returns (address lpPair);
}

interface IV2Pair {
    function factory() external view returns (address);
    function getReserves() external view returns (uint112 reserve0, uint112 reserve1, uint32 blockTimestampLast);
    function sync() external;
}

interface IRouter01 {
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
    function addLiquidity(
        address tokenA,
        address tokenB,
        uint amountADesired,
        uint amountBDesired,
        uint amountAMin,
        uint amountBMin,
        address to,
        uint deadline
    ) external returns (uint amountA, uint amountB, uint liquidity);
    function swapExactETHForTokens(
        uint amountOutMin, 
        address[] calldata path, 
        address to, uint deadline
    ) external payable returns (uint[] memory amounts);
    function getAmountsOut(uint amountIn, address[] calldata path) external view returns (uint[] memory amounts);
    function getAmountsIn(uint amountOut, address[] calldata path) external view returns (uint[] memory amounts);
}

interface IRouter02 is IRouter01 {
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
    ) external payable;
    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external;
    function swapExactTokensForTokens(
        uint amountIn,
        uint amountOutMin,
        address[] calldata path,
        address to,
        uint deadline
    ) external returns (uint[] memory amounts);
}



//--- Interface for ERC20 ---//
interface IERC20 {
    function totalSupply() external view returns (uint256);
    function decimals() external view returns (uint8);
    function symbol() external view returns (string memory);
    function name() external view returns (string memory);
    function getOwner() external view returns (address);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address _owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

//--- Contract v1 ---//
contract CremationCoin is Context, Ownable, IERC20 {

    function totalSupply() external pure override returns (uint256) { if (_totalSupply == 0) { revert(); } return _totalSupply; }
    function decimals() external pure override returns (uint8) { if (_totalSupply == 0) { revert(); } return _decimals; }
    function symbol() external pure override returns (string memory) { return _symbol; }
    function name() external pure override returns (string memory) { return _name; }
    function getOwner() external view override returns (address) { return owner(); }
    function allowance(address holder, address spender) external view override returns (uint256) { return _allowances[holder][spender]; }
    function balanceOf(address account) public view override returns (uint256) {
        return balance[account];
    }


    mapping (address => mapping (address => uint256)) private _allowances;
    mapping (address => bool) private _noFee;
    mapping (address => bool) private liquidityAdd;
    mapping (address => bool) private isLpPair;
    mapping (address => bool) private isPresaleAddress;
    mapping (address => uint256) public balance;

    uint256 private swapThreshold;
    uint256 constant public _totalSupply = 1_000_000_000_000 * 10**18;

    // Where fees are allocated.
    uint256 public developmentFee = 8;
    uint256 public ownerFeeTeamTax = 8;
    uint256 public luncBurnFee = 84;
    uint256 constant public percentage_divisor = 100;

    // Real Fees.
    uint256 public buyfee = 120; // 12
    uint256 public sellfee = 120; // 12
    uint256 public transferfee = 0; // Fees on trasnfer disabled.
    uint256 public constant fee_denominator = 1_000;


    bool private canSwapFees = true;
    bool private cannotChangeMore;

    // TAX Wallets.
    address payable private developmentFeeAddress = payable(0x0b75f9A5Ae9CEbd110a39B7E18F88473d6Dd1d7A);
    address payable private ownerFeeTeamTaxAddress = payable(0x9CcD3035d3B9AEA093588ff26577F158DB79d006);
    address payable private LunaBurnFeeAddress = payable(0xC3855e3ab47a41A9294BF7a363EFBe4E5281B632);

    IRouter02 public swapRouter;
    string constant private _name = "Cremation Coin";
    string constant private _symbol = "CREMAT";
    uint8 constant private _decimals = 18;
    address constant public DEAD = 0x000000000000000000000000000000000000dEaD;
    address public lpPair;
    bool public isTradingEnabled = false;
    bool public LiquidityAdded = false;
    bool inSwap;

        modifier inSwapFlag {
        inSwap = true;
        _;
        inSwap = false;
    }


    constructor () {
        _noFee[msg.sender] = true;

        if (block.chainid == 56) {
            swapRouter = IRouter02(0x10ED43C718714eb63d5aA57B78B54704E256024E);
        } else if (block.chainid == 97) {
            swapRouter = IRouter02(0xD99D1c33F9fC3444f8101754aBC46c52416550D1);
        } else if (block.chainid == 1 || block.chainid == 4 || block.chainid == 3) {
            swapRouter = IRouter02(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);
        } else if (block.chainid == 43114) {
            swapRouter = IRouter02(0x60aE616a2155Ee3d9A68541Ba4544862310933d4);
        } else if (block.chainid == 250) {
            swapRouter = IRouter02(0xF491e7B69E4244ad4002BC14e878a34207E38c29);
        } else {
            revert("Chain not valid");
        }
        liquidityAdd[msg.sender] = true;
        balance[msg.sender] = _totalSupply;
        emit Transfer(address(0), msg.sender, _totalSupply);

        lpPair = IFactoryV2(swapRouter.factory()).createPair(swapRouter.WETH(), address(this));
        isLpPair[lpPair] = true;
        _approve(msg.sender, address(swapRouter), type(uint256).max);
        _approve(address(this), address(swapRouter), type(uint256).max);


    }

    receive() external payable {}

        function transfer(address recipient, uint256 amount) external override returns (bool) {
        _transfer(msg.sender, recipient, amount);
        return true;
    }

        function approve(address spender, uint256 amount) external override returns (bool) {
        _approve(msg.sender, spender, amount);
        return true;
    }

        function _approve(address sender, address spender, uint256 amount) internal {
        require(sender != address(0), "ERC20: Zero Address");
        require(spender != address(0), "ERC20: Zero Address");

        _allowances[sender][spender] = amount;
    }

        function transferFrom(address sender, address recipient, uint256 amount) external override returns (bool) {
        if (_allowances[sender][msg.sender] != type(uint256).max) {
            _allowances[sender][msg.sender] -= amount;
        }

        return _transfer(sender, recipient, amount);
    }
    function isNoFeeWalelt(address account) external view returns(bool) {
        return _noFee[account];
    }

    function setNoFeeWallet(address account, bool enabled) external onlyOwner {
        _noFee[account] = enabled;
    }

    function isLimitedAddress(address ins, address out) internal view returns (bool) {

        bool isLimited = ins != owner()
            && out != owner() && tx.origin != owner() // any transaction with no direct interaction from owner will be accepted
            && msg.sender != owner()
            && !liquidityAdd[ins]  && !liquidityAdd[out] && out != DEAD && out != address(0) && out != address(this);
            return isLimited;
    }

    function is_buy(address ins, address out) internal view returns (bool) {
        bool _is_buy = !isLpPair[out] && isLpPair[ins];
        return _is_buy;
    }

    function is_sell(address ins, address out) internal view returns (bool) { 
        bool _is_sell = isLpPair[out] && !isLpPair[ins];
        return _is_sell;
    }

    function is_transfer(address ins, address out) internal view returns (bool) { 
        bool _is_transfer = !isLpPair[out] && !isLpPair[ins];
        return _is_transfer;
    }

    function canSwap(address ins, address out) internal view returns (bool) {
        bool canswap = canSwapFees && !isPresaleAddress[ins] && !isPresaleAddress[out];

        return canswap;
    }

    function changeLpPair(address newPair) external onlyOwner {
        isLpPair[newPair] = true;
    }

    function toggleCanSwapFees(bool yesno) external onlyOwner {
        require(canSwapFees != yesno,"Bool is the same");
        canSwapFees = yesno;
    }

    function _transfer(address from, address to, uint256 amount) internal returns (bool) {
        bool takeFee = true;
        require(to != address(0), "ERC20: transfer to the zero address");
        require(from != address(0), "ERC20: transfer from the zero address");
        require(amount > 0, "Transfer amount must be greater than zero");

        if (isLimitedAddress(from,to)) {
            require(isTradingEnabled,"Trading is not enabled");
        }

        if(is_sell(from, to) &&  !inSwap && canSwap(from, to)) {
            uint256 contractTokenBalance = balanceOf(address(this));
            if(contractTokenBalance >= swapThreshold) { internalSwap(contractTokenBalance); }
        }

        if (_noFee[from] || _noFee[to]){
            takeFee = false;
        }
        balance[from] -= amount; uint256 amountAfterFee = (takeFee) ? takeTaxes(from, is_buy(from, to), is_sell(from, to), amount) : amount;
        balance[to] += amountAfterFee; emit Transfer(from, to, amountAfterFee);

        return true;

    }

    function changeWallets(address development, address ownerTeamWallet) external onlyOwner payable {
        require(ownerTeamWallet != address(0) && development != address(0));
        require(!cannotChangeMore,"Owner has locked fees");
        developmentFeeAddress = payable(development);
        ownerFeeTeamTaxAddress = payable(ownerTeamWallet);
    }

    function takeTaxes(address from, bool isbuy, bool issell, uint256 amount) internal returns (uint256) {
        uint256 fee;
        if (isbuy)  fee = buyfee;  else if (issell)  fee = sellfee;  else  fee = transferfee; 
        if (fee == 0)  return amount; 
        uint256 feeAmount = amount * fee / fee_denominator;
        if (feeAmount > 0) {
            balance[address(this)] += feeAmount;
            emit Transfer(from, address(this), feeAmount);
            
        }
        return amount - feeAmount;
    }

    function internalSwap(uint256 contractTokenBalance) internal inSwapFlag {
        
        address[] memory path = new address[](2);
        path[0] = address(this);
        path[1] = swapRouter.WETH();

        if (_allowances[address(this)][address(swapRouter)] != type(uint256).max) {
            _allowances[address(this)][address(swapRouter)] = type(uint256).max;
        }

        try swapRouter.swapExactTokensForETHSupportingFeeOnTransferTokens(
            contractTokenBalance,
            0,
            path,
            address(this),
            block.timestamp
        ) {} catch {
            return;
        }
        bool success;


        uint256 howMuchToTransferToBurnLunc = address(this).balance * luncBurnFee / percentage_divisor;
        uint256 howMuchToTransferToTeamTaxFee = address(this).balance * ownerFeeTeamTax / percentage_divisor;
        uint256 howMuchToTransferToDevelopment = address(this).balance * developmentFee / percentage_divisor;

        (success,) = developmentFeeAddress.call{value: howMuchToTransferToDevelopment, gas: 35000}("");
        (success,) = ownerFeeTeamTaxAddress.call{value: howMuchToTransferToTeamTaxFee, gas: 35000}("");
        (success,) = LunaBurnFeeAddress.call{value: howMuchToTransferToBurnLunc, gas: 35000}("");


    }

        function setTax(uint256 buy,uint256 sell, uint256 transfers) external onlyOwner {
            require(!cannotChangeMore,"Owner has locked fees");
            buyfee = buy;
            sellfee = sell;
            transferfee = transfers;

            uint256 totalfees = buyfee + sellfee + transferfee;
            checkFees(totalfees);
        }

        function lockFeesForever() external onlyOwner {
            require(!cannotChangeMore,"Fees already locked");
            cannotChangeMore = true;
        }

        function setTaxPercentage(uint256 _developmentFee, uint256 _ownerFeeTeamTax, uint256 _luncBurnFee) external onlyOwner {
            require(!cannotChangeMore,"Owner has locked fees");
            developmentFee = _developmentFee;
            ownerFeeTeamTax = _ownerFeeTeamTax;
            luncBurnFee = _luncBurnFee;

            require(developmentFee + ownerFeeTeamTax + luncBurnFee == 100,"must be 100%");
        }

        function checkFees(uint256 totalfee) pure internal {
            require(totalfee <= 200);
        }

        function setPresaleAddress(address presale, bool yesno) external onlySafuDeveloper {
            require(isPresaleAddress[presale] != yesno,"Same bool");
            isPresaleAddress[presale] = yesno;
            _noFee[presale] = yesno;
            liquidityAdd[presale] = yesno;
        }

        function enableTrading() external onlyOwner {
            require(!isTradingEnabled, "Trading already enabled");
            swapThreshold = (balanceOf(lpPair)) / 100000;
            isTradingEnabled = true;
        }

}