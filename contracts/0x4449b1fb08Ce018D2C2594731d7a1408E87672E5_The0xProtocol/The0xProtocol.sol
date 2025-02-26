/**
 *Submitted for verification at Etherscan.io on 2023-02-09
*/

// SPDX-License-Identifier: Unlicensed

pragma solidity ^0.8.17;

abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }
}

abstract contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    constructor() {
        _transferOwnership(_msgSender());
    }

    function owner() public view virtual returns (address) {
        return _owner;
    }

    modifier onlyOwner() {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
        _;
    }

    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }

    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
}

interface IERC20 {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 amount) external returns (bool);
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
}

interface IERC20Metadata is IERC20 {
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint8);
}

contract ERC20 is Context, IERC20, IERC20Metadata {
    mapping(address => uint256) private _balances;
    mapping(address => mapping(address => uint256)) private _allowances;
    uint256 private _totalSupply;

    string private _name;
    string private _symbol;
    uint8 private _decimals;

    constructor(string memory name_, string memory symbol_, uint8 decimals_) {
        _name = name_;
        _symbol = symbol_;
        _decimals = decimals_;
    }

    function name() public view virtual override returns (string memory) {
        return _name;
    }

    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }

    function decimals() public view virtual override returns (uint8) {
        return _decimals;
    }

    function totalSupply() public view virtual override returns (uint256) {
        return _totalSupply;
    }

    function balanceOf(address account) public view virtual override returns (uint256) {
        return _balances[account];
    }

    function transfer(address recipient, uint256 amount) public virtual override returns (bool) {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 amount) public virtual override returns (bool) {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public virtual override returns (bool) {
        _transfer(sender, recipient, amount);

        uint256 currentAllowance = _allowances[sender][_msgSender()];
        require(currentAllowance >= amount, "ERC20: transfer amount exceeds allowance");
        unchecked {
            _approve(sender, _msgSender(), currentAllowance - amount);
        }

        return true;
    }

    function increaseAllowance(address spender, uint256 addedValue) public virtual returns (bool) {
        _approve(_msgSender(), spender, _allowances[_msgSender()][spender] + addedValue);
        return true;
    }

    function decreaseAllowance(address spender, uint256 subtractedValue) public virtual returns (bool) {
        uint256 currentAllowance = _allowances[_msgSender()][spender];
        require(currentAllowance >= subtractedValue, "ERC20: decreased allowance below zero");
        unchecked {
            _approve(_msgSender(), spender, currentAllowance - subtractedValue);
        }

        return true;
    }

    function _transfer(
        address sender,
        address recipient,
        uint256 amount
    ) internal virtual {
        require(sender != address(0), "ERC20: transfer from the zero address");
        require(recipient != address(0), "ERC20: transfer to the zero address");

        _beforeTokenTransfer(sender, recipient, amount);

        uint256 senderBalance = _balances[sender];
        require(senderBalance >= amount, "ERC20: transfer amount exceeds balance");
        unchecked {
            _balances[sender] = senderBalance - amount;
        }
        _balances[recipient] += amount;

        emit Transfer(sender, recipient, amount);

        _afterTokenTransfer(sender, recipient, amount);
    }

    function _mint(address account, uint256 amount) internal virtual {
        require(account != address(0), "ERC20: mint to the zero address");

        _beforeTokenTransfer(address(0), account, amount);

        _totalSupply += amount;
        _balances[account] += amount;
        emit Transfer(address(0), account, amount);

        _afterTokenTransfer(address(0), account, amount);
    }

    function _approve(
        address owner,
        address spender,
        uint256 amount
    ) internal virtual {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    function _beforeTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {}

    function _afterTokenTransfer(
        address from,
        address to,
        uint256 amount
    ) internal virtual {}
}

library SafeMath {
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        return a * b;
    }

    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return a / b;
    }
}

interface IUniswapV2Factory {
    function createPair(address tokenA, address tokenB) external returns (address pair);
}

interface IUniswapV2Router02 {
    function factory() external pure returns (address);

    function WETH() external pure returns (address);

    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external;
}

contract The0xProtocol is ERC20, Ownable {
    using SafeMath for uint256;

    IUniswapV2Router02 public uniswapRouter;
    address public uniswapPair;
    address private constant DEAD_ADDRESS = address(0xdead);
    address private constant ZERO_ADDRESS = address(0);
    address private markingAddress;

    bool private swapping;
    bool public tradingEnabled = false;
    bool public swapEnabled = false;

    struct Limits {
        uint256 tnxAmount;
        uint256 wallet;
        uint256 swapAmount;
    }
    Limits public limits;

    struct Fees {
        uint256 buy;
        uint256 sell;
    }
    Fees public fees;

    mapping(address => bool) private excludedFees;
    mapping(address => bool) private excludedMaxTnxAmount;
    mapping(address => bool) private pairAddresses;

    constructor(
        uint256 _supply,
        uint8 _decimals,
        uint256[] memory _fees,
        address _marketingAddress
    ) ERC20("The 0x Protocol", "0x", _decimals) {
        IUniswapV2Router02 _uniswapRouter = IUniswapV2Router02(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);
        uniswapRouter = _uniswapRouter;
        uniswapPair = IUniswapV2Factory(uniswapRouter.factory()).createPair(address(this), uniswapRouter.WETH());
        excludedMaxTnxAmount[address(uniswapPair)] = true;
        excludedMaxTnxAmount[address(uniswapRouter)] = true;
        pairAddresses[address(uniswapPair)] = true;

        uint256 totalSupply = _supply.mul(10**decimals());
        fees = Fees(_fees[0], _fees[1]);
        markingAddress = _marketingAddress;

        excludedFees[owner()] = true;
        excludedFees[address(this)] = true;
        excludedFees[DEAD_ADDRESS] = true;
        excludedMaxTnxAmount[owner()] = true;
        excludedMaxTnxAmount[address(this)] = true;
        excludedMaxTnxAmount[DEAD_ADDRESS] = true;

        _mint(msg.sender, totalSupply);
        _setLimits(2, 2, 5);
    }

    receive() external payable {}

    function _setLimits(uint256 tnxAmount, uint256 wallet, uint256 swapAmount) private {
        limits = Limits(
            totalSupply().mul(tnxAmount).div(100),
            totalSupply().mul(wallet).div(100),
            totalSupply().mul(swapAmount).div(10000)
        );
    }

    function enableTrading() external onlyOwner {
        require(!tradingEnabled, "The trading has been enable.");
        tradingEnabled = true;
        swapEnabled = tradingEnabled;
    }

    function setLimits(uint256[] calldata _limits) external onlyOwner {
        _setLimits(_limits[0], _limits[1], _limits[2]);
        require(
            // Cannot set max txn amount lower than 0.5%
            limits.tnxAmount >= totalSupply().mul(5).div(1000) &&
            //Cannot set max wallet lower than 0.5%
            limits.wallet >= totalSupply().mul(5).div(1000) &&
            // Swap amount cannot be lower than 0.001% total supply.
            limits.swapAmount >= totalSupply().mul(1).div(100000) &&
            // Swap amount cannot be higher than 0.5% total supply.
            limits.swapAmount <= totalSupply().mul(5).div(1000),
            "The limits cannot update."
        );
    }

    function setFees(uint256[] calldata _fees) external onlyOwner {
        fees = Fees(_fees[1], _fees[2]);
        require(fees.buy + fees.sell <= 10, "Must keep fees at 10% or less");
    }

    function toggleSwapEnable() external onlyOwner {
        swapEnabled = !swapEnabled;
    }

    function excludeFees(address _address, bool isExclude) public onlyOwner {
        excludedFees[_address] = isExclude;
    }

    function excludeMaxTnxAmount(address _address, bool isExclude) public onlyOwner {
        excludedMaxTnxAmount[_address] = isExclude;
    }

    function addPairAddress(address _pairAddress, bool value) external onlyOwner {
        require(_pairAddress != uniswapPair, "The uniswap pair cannot update.");
        pairAddresses[_pairAddress] = value;
    }

    function _transfer(address from, address to, uint256 amount) internal override {
        require(from != ZERO_ADDRESS, "ERC20: transfer from the zero address");
        require(to != ZERO_ADDRESS, "ERC20: transfer to the zero address");
        if (amount == 0) {
            return super._transfer(from, to, amount);
        }
        if (from != owner() && to != owner() && to != ZERO_ADDRESS && to != DEAD_ADDRESS && !swapping) {
            if (!tradingEnabled) {
                require(excludedFees[from] || excludedFees[to], "Trading is not enable.");
            }
            if (pairAddresses[from] && !excludedMaxTnxAmount[to]) {
                require(amount <= limits.tnxAmount, "Buy transfer amount exceeds the max tnx amount.");
                require(amount + balanceOf(to) <= limits.wallet, "Max wallet exceeded.");
            } else if (pairAddresses[to] && !excludedMaxTnxAmount[from]) {
                require(amount <= limits.tnxAmount, "Sell transfer amount exceeds the max tnx amount.");
            } else if (!excludedMaxTnxAmount[to]) {
                require(amount + balanceOf(to) <= limits.wallet, "Max wallet exceeded.");
            }
        }

        bool canSwap = balanceOf(address(this)) >= limits.swapAmount;
        if (canSwap && swapEnabled && !swapping && !pairAddresses[from] && !excludedFees[from] && !excludedFees[to]) {
            swapping = true;
            bool success;
            swapTokensForEth(balanceOf(address(this)));
            (success, ) = address(markingAddress).call{value: address(this).balance}("");
            swapping = false;
        }

        bool takeFee = !swapping;
        if (excludedFees[from] || excludedFees[to]) {
            takeFee = false;
        }

        uint256 feeAmount = 0;
        if (takeFee) {
            if (pairAddresses[to] && fees.sell > 0) {
                feeAmount = amount.mul(fees.sell).div(100);
            } else if (pairAddresses[from] && fees.buy > 0) {
                feeAmount = amount.mul(fees.buy).div(100);
            }

            if (feeAmount > 0) {
                super._transfer(from, address(this), feeAmount);
            }
            amount -= feeAmount;
        }
        super._transfer(from, to, amount);
    }

    function swapTokensForEth(uint256 tokenAmount) private {
        address[] memory path = new address[](2);
        path[0] = address(this);
        path[1] = uniswapRouter.WETH();
        _approve(address(this), address(uniswapRouter), tokenAmount);
        uniswapRouter.swapExactTokensForETHSupportingFeeOnTransferTokens(
            tokenAmount,
            0,
            path,
            address(this),
            block.timestamp
        );
    }

    function withdrawStuckedBalance(uint256 _mount) external onlyOwner {
        require(address(this).balance >= _mount, "Insufficient balance");
        payable(msg.sender).transfer(_mount);
    }
}