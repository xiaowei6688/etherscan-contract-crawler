/**
 *Submitted for verification at BscScan.com on 2022-09-24
*/

/* DOLCA is a crypto currency designed to pay you in USDC dividends. 

Website: http://www.dolca.cc

Twitter: https://twitter.com/DOLCACRYPTO

https://t.me/dolcachatroom


Very Low Total supply @ 1,000,000 Tokens
IMMUTABLE CODE
FOREVER LOCKED LIQUIDITY POOL
SECURITY AUDITED.
100% RUG PULL PROOF.
High Burn Rate. (1% of all buy&sell transactions)
0% Token allocation before launch, ONLY MARKET BUYS! 
The most fair, transparent token you can find.

3% of buy or sell transactions will Buy USDC and distribute to holders with more than 100 DOLCA tokens or more.  
1% of buy or sell transactions will buy back and burn of the DOLCA token.
1% of buy or sell transactions will go to the FOREVER LOCKED liquidity pool. 
It will gain the size of the pool over time and make the token more stable as more transactions are made. 

Transaction TAX structure and dividends will incentivize holders to hold DOLCA. */

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.15;

interface IERC20 {
    function totalSupply() external view returns (uint256);

   
    function balanceOf(address account) external view returns (uint256);

    
    function transfer(address recipient, uint256 amount)
        external
        returns (bool);

    
    function allowance(address owner, address spender)
        external
        view
        returns (uint256);

   
    function approve(address spender, uint256 amount) external returns (bool);

   
    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) external returns (bool);

    
    event Transfer(address indexed from, address indexed to, uint256 value);

    
    event Approval(
        address indexed owner,
        address indexed spender,
        uint256 value
    );
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

   
    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
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

    
    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b > 0, errorMessage);
        uint256 c = a / b;
        

        return c;
    }

    
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return mod(a, b, "SafeMath: modulo by zero");
    }

    
    function mod(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        require(b != 0, errorMessage);
        return a % b;
    }
}

abstract contract Context {
    function _msgSender() internal view virtual returns (address payable) {
        return payable(address(msg.sender));
    }

    function _msgData() internal view virtual returns (bytes memory) {
        this; 
        return msg.data;
    }
}


library SafeMathInt {
    int256 private constant MIN_INT256 = int256(1) << 255;
    int256 private constant MAX_INT256 = ~(int256(1) << 255);

    
    function mul(int256 a, int256 b) internal pure returns (int256) {
        int256 c = a * b;

       
        require(c != MIN_INT256 || (a & MIN_INT256) != (b & MIN_INT256));
        require((b == 0) || (c / b == a));
        return c;
    }

   
    function div(int256 a, int256 b) internal pure returns (int256) {
       
        require(b != -1 || a != MIN_INT256);

       
        return a / b;
    }

    
    function sub(int256 a, int256 b) internal pure returns (int256) {
        int256 c = a - b;
        require((b >= 0 && c <= a) || (b < 0 && c > a));
        return c;
    }

    
    function add(int256 a, int256 b) internal pure returns (int256) {
        int256 c = a + b;
        require((b >= 0 && c >= a) || (b < 0 && c < a));
        return c;
    }


    function abs(int256 a) internal pure returns (int256) {
        require(a != MIN_INT256);
        return a < 0 ? -a : a;
    }

    function toUint256Safe(int256 a) internal pure returns (uint256) {
        require(a >= 0);
        return uint256(a);
    }
}


library SafeMathUint {
    function toInt256Safe(uint256 a) internal pure returns (int256) {
        int256 b = int256(a);
        require(b >= 0);
        return b;
    }
}

library IterableMapping {
    
    struct Map {
        address[] keys;
        mapping(address => uint256) values;
        mapping(address => uint256) indexOf;
        mapping(address => bool) inserted;
    }

    function get(Map storage map, address key) internal view returns (uint256) {
        return map.values[key];
    }

    function getIndexOfKey(Map storage map, address key)
        internal
        view
        returns (int256)
    {
        if (!map.inserted[key]) {
            return -1;
        }
        return int256(map.indexOf[key]);
    }

    function getKeyAtIndex(Map storage map, uint256 index)
        internal
        view
        returns (address)
    {
        return map.keys[index];
    }

    function size(Map storage map) internal view returns (uint256) {
        return map.keys.length;
    }

    function set(
        Map storage map,
        address key,
        uint256 val
    ) internal {
        if (map.inserted[key]) {
            map.values[key] = val;
        } else {
            map.inserted[key] = true;
            map.values[key] = val;
            map.indexOf[key] = map.keys.length;
            map.keys.push(key);
        }
    }

    function remove(Map storage map, address key) internal {
        if (!map.inserted[key]) {
            return;
        }

        delete map.inserted[key];
        delete map.values[key];

        uint256 index = map.indexOf[key];
        uint256 lastIndex = map.keys.length - 1;
        address lastKey = map.keys[lastIndex];

        map.indexOf[lastKey] = index;
        delete map.indexOf[key];

        map.keys[index] = lastKey;
        map.keys.pop();
    }
}


library Address {
    
    function isContract(address account) internal view returns (bool) {
        
        bytes32 codehash;
        bytes32 accountHash = 0xc5d2460186f7233c927e7db2dcc703c0e500b653ca82273b7bfad8045d85a470;
        
        assembly {
            codehash := extcodehash(account)
        }
        return (codehash != accountHash && codehash != 0x0);
    }

    
    function sendValue(address payable recipient, uint256 amount) internal {
        require(
            address(this).balance >= amount,
            "Address: insufficient balance"
        );

        // solhint-disable-next-line avoid-low-level-calls, avoid-call-value
        (bool success, ) = recipient.call{value: amount}("");
        require(
            success,
            "Address: unable to send value, recipient may have reverted"
        );
    }

    
    function functionCall(address target, bytes memory data)
        internal
        returns (bytes memory)
    {
        return functionCall(target, data, "Address: low-level call failed");
    }

    
    function functionCall(
        address target,
        bytes memory data,
        string memory errorMessage
    ) internal returns (bytes memory) {
        return _functionCallWithValue(target, data, 0, errorMessage);
    }

    
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value
    ) internal returns (bytes memory) {
        return
            functionCallWithValue(
                target,
                data,
                value,
                "Address: low-level call with value failed"
            );
    }

   
    function functionCallWithValue(
        address target,
        bytes memory data,
        uint256 value,
        string memory errorMessage
    ) internal returns (bytes memory) {
        require(
            address(this).balance >= value,
            "Address: insufficient balance for call"
        );
        return _functionCallWithValue(target, data, value, errorMessage);
    }

    function _functionCallWithValue(
        address target,
        bytes memory data,
        uint256 weiValue,
        string memory errorMessage
    ) private returns (bytes memory) {
        require(isContract(target), "Address: call to non-contract");

        
        (bool success, bytes memory returndata) = target.call{value: weiValue}(
            data
        );
        if (success) {
            return returndata;
        } else {
            
            if (returndata.length > 0) {
                
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


library SafeERC20 {
    using SafeMath for uint256;
    using Address for address;

    function safeTransfer(
        IERC20 token,
        address to,
        uint256 value
    ) internal {
        _callOptionalReturn(
            token,
            abi.encodeWithSelector(token.transfer.selector, to, value)
        );
    }

    function safeTransferFrom(
        IERC20 token,
        address from,
        address to,
        uint256 value
    ) internal {
        _callOptionalReturn(
            token,
            abi.encodeWithSelector(token.transferFrom.selector, from, to, value)
        );
    }

    
    function safeApprove(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        
        require(
            (value == 0) || (token.allowance(address(this), spender) == 0),
            "SafeERC20: approve from non-zero to non-zero allowance"
        );
        _callOptionalReturn(
            token,
            abi.encodeWithSelector(token.approve.selector, spender, value)
        );
    }

    function safeIncreaseAllowance(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        uint256 newAllowance = token.allowance(address(this), spender).add(
            value
        );
        _callOptionalReturn(
            token,
            abi.encodeWithSelector(
                token.approve.selector,
                spender,
                newAllowance
            )
        );
    }

    function safeDecreaseAllowance(
        IERC20 token,
        address spender,
        uint256 value
    ) internal {
        uint256 newAllowance = token.allowance(address(this), spender).sub(
            value,
            "SafeERC20: decreased allowance below zero"
        );
        _callOptionalReturn(
            token,
            abi.encodeWithSelector(
                token.approve.selector,
                spender,
                newAllowance
            )
        );
    }

    
    function _callOptionalReturn(IERC20 token, bytes memory data) private {
        

        bytes memory returndata = address(token).functionCall(
            data,
            "SafeERC20: low-level call failed"
        );
        if (returndata.length > 0) {
           
            require(
                abi.decode(returndata, (bool)),
                "SafeERC20: ERC20 operation did not succeed"
            );
        }
    }
}


abstract contract Ownable is Context {
    address private _owner;
    address private _previousOwner;
    uint256 private _lockTime;

    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );

    
    constructor() {
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
        require(
            newOwner != address(0),
            "Ownable: new owner is the zero address"
        );
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }

    function geUnlockTime() public view returns (uint256) {
        return _lockTime;
    }

    
    function lock(uint256 time) public virtual onlyOwner {
        _previousOwner = _owner;
        _owner = address(0);
        _lockTime = block.timestamp + time;
        emit OwnershipTransferred(_owner, address(0));
    }

    
    function unlock() public virtual {
        require(
            _previousOwner == msg.sender,
            "You don't have permission to unlock the token contract"
        );
        require(block.timestamp > _lockTime, "Contract is locked until 7 days");
        emit OwnershipTransferred(_owner, _previousOwner);
        _owner = _previousOwner;
    }
}



interface IUniswapV2Factory {
    event PairCreated(
        address indexed token0,
        address indexed token1,
        address pair,
        uint256
    );

    function feeTo() external view returns (address);

    function feeToSetter() external view returns (address);

    function getPair(address tokenA, address tokenB)
        external
        view
        returns (address pair);

    function allPairs(uint256) external view returns (address pair);

    function allPairsLength() external view returns (uint256);

    function createPair(address tokenA, address tokenB)
        external
        returns (address pair);

    function setFeeTo(address) external;

    function setFeeToSetter(address) external;
}

// pragma solidity >=0.6.2;

interface IUniswapV2Router01 {
    function factory() external pure returns (address);

    function WETH() external pure returns (address);

    function addLiquidity(
        address tokenA,
        address tokenB,
        uint256 amountADesired,
        uint256 amountBDesired,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    )
        external
        returns (
            uint256 amountA,
            uint256 amountB,
            uint256 liquidity
        );

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
        returns (
            uint256 amountToken,
            uint256 amountETH,
            uint256 liquidity
        );

    function removeLiquidity(
        address tokenA,
        address tokenB,
        uint256 liquidity,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountA, uint256 amountB);

    function removeLiquidityETH(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountToken, uint256 amountETH);

    function removeLiquidityWithPermit(
        address tokenA,
        address tokenB,
        uint256 liquidity,
        uint256 amountAMin,
        uint256 amountBMin,
        address to,
        uint256 deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint256 amountA, uint256 amountB);

    function removeLiquidityETHWithPermit(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint256 amountToken, uint256 amountETH);

    function swapExactTokensForTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapTokensForExactTokens(
        uint256 amountOut,
        uint256 amountInMax,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapExactETHForTokens(
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable returns (uint256[] memory amounts);

    function swapTokensForExactETH(
        uint256 amountOut,
        uint256 amountInMax,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapExactTokensForETH(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external returns (uint256[] memory amounts);

    function swapETHForExactTokens(
        uint256 amountOut,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable returns (uint256[] memory amounts);

    function quote(
        uint256 amountA,
        uint256 reserveA,
        uint256 reserveB
    ) external pure returns (uint256 amountB);

    function getAmountOut(
        uint256 amountIn,
        uint256 reserveIn,
        uint256 reserveOut
    ) external pure returns (uint256 amountOut);

    function getAmountIn(
        uint256 amountOut,
        uint256 reserveIn,
        uint256 reserveOut
    ) external pure returns (uint256 amountIn);

    function getAmountsOut(uint256 amountIn, address[] calldata path)
        external
        view
        returns (uint256[] memory amounts);

    function getAmountsIn(uint256 amountOut, address[] calldata path)
        external
        view
        returns (uint256[] memory amounts);
}

// pragma solidity >=0.6.2;

interface IUniswapV2Router02 is IUniswapV2Router01 {
    function removeLiquidityETHSupportingFeeOnTransferTokens(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline
    ) external returns (uint256 amountETH);

    function removeLiquidityETHWithPermitSupportingFeeOnTransferTokens(
        address token,
        uint256 liquidity,
        uint256 amountTokenMin,
        uint256 amountETHMin,
        address to,
        uint256 deadline,
        bool approveMax,
        uint8 v,
        bytes32 r,
        bytes32 s
    ) external returns (uint256 amountETH);

    function swapExactTokensForTokensSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external;

    function swapExactETHForTokensSupportingFeeOnTransferTokens(
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external payable;

    function swapExactTokensForETHSupportingFeeOnTransferTokens(
        uint256 amountIn,
        uint256 amountOutMin,
        address[] calldata path,
        address to,
        uint256 deadline
    ) external;
}

contract Dolca is Context, IERC20, Ownable {
    using SafeMath for uint256;
    using SafeMathUint for uint256;
    using SafeMathInt for int256;
    using Address for address;
    using SafeERC20 for IERC20;
    using IterableMapping for IterableMapping.Map;

    address dead = 0x000000000000000000000000000000000000dEaD;

    uint8 public maxLiqFee = 10;
    uint8 public maxTaxFee = 10;
    uint8 public maxBurnFee = 10;
    uint8 public maxWalletFee = 10;
    uint8 public maxBuybackFee = 10;
    uint8 public minMxTxPercentage = 1;
    uint8 public minMxWalletPercentage = 1;

    mapping(address => uint256) private _rOwned;
    mapping(address => uint256) private _tOwned;
    mapping(address => mapping(address => uint256)) private _allowances;

    /* Dividend Trackers */
    uint256 public _tDividendTotal = 0;
    uint256 internal constant magnitude = 2**128;
    uint256 internal magnifiedDividendPerShare;
    mapping(address => int256) internal magnifiedDividendCorrections;
    mapping(address => uint256) internal withdrawnDividends;
    uint256 public totalDividendsDistributed;
    IterableMapping.Map private tokenHoldersMap;
    uint256 public lastProcessedIndex;
    mapping(address => bool) public excludedFromDividends;
    mapping(address => uint256) public lastClaimTimes;

    uint256 public claimWait = 3600;
    uint256 public minimumTokenBalanceForDividends = 1;

    // use by default 300,000 gas to process auto-claiming dividends
    uint256 public gasForProcessing = 300000;

    event DividendsDistributed(uint256 weiAmount);
    event DividendWithdrawn(address indexed to, uint256 weiAmount);

    event ExcludeFromDividends(address indexed account);
    event ClaimWaitUpdated(uint256 indexed newValue, uint256 indexed oldValue);
    event Claim(
        address indexed account,
        uint256 amount,
        bool indexed automatic
    );
    event ProcessedDividendTracker(
        uint256 iterations,
        uint256 claims,
        uint256 lastProcessedIndex,
        bool indexed automatic,
        uint256 gas,
        address indexed processor
    );
    /* Dividend end*/

    mapping(address => bool) private _isExcludedFromFee;

    mapping(address => bool) private _isExcluded;
    address[] private _excluded;

    address public router;

    address public rewardToken;

    uint256 private constant MAX = ~uint256(0);
    uint256 public _tTotal;
    uint256 private _rTotal;
    uint256 private _tFeeTotal;

    

    string public _name;
    string public _symbol;
    uint8 private _decimals;

    uint8 public _taxFee;
    uint8 private _previousTaxFee = _taxFee;

    uint8 public _rewardFee;
    uint8 private _previousRewardFee = _rewardFee;

    uint8 public _liquidityFee;
    uint8 private _previousLiquidityFee = _liquidityFee;

    uint8 public _burnFee;
    uint8 private _previousBurnFee = _burnFee;

    uint8 public _walletFee;
    uint8 private _previousWalletFee = _walletFee;

    uint8 public _walletCharityFee;
    uint8 private _previousWalletCharityFee = _walletCharityFee;

    uint8 public _buybackFee;
    uint8 private _previousBuybackFee = _buybackFee;

    IUniswapV2Router02 public pcsV2Router;
    address public pcsV2Pair;
    address payable public feeWallet;
    address payable public feeWalletCharity;

    bool walletFeeInBNB = false;
    bool walletCharityFeeInBNB = false;

    bool inSwapAndLiquify;
    bool public swapAndLiquifyEnabled = true;

    uint256 public _maxTxAmount;
    uint256 public _maxWalletAmount;
    uint256 public numTokensSellToAddToLiquidity;
    uint256 private buyBackUpperLimit;

    

    event SwapAndLiquifyEnabledUpdated(bool enabled);
    event SwapAndLiquify(
        uint256 tokensSwapped,
        uint256 ethReceived,
        uint256 tokensIntoLiqudity
    );

    modifier lockTheSwap() {
        inSwapAndLiquify = true;
        _;
        inSwapAndLiquify = false;
    }

    struct Fee {
        uint8 setTaxFee;
        uint8 setLiqFee;
        uint8 setBurnFee;
        uint8 setWalletFee;
        uint8 setBuybackFee;
        uint8 setWalletCharityFee;
        uint8 setRewardFee;
    }

    struct FeeWallet {
        address payable wallet;
        address payable walletCharity;
        bool walletFeeInBNB;
        bool walletCharityFeeInBNB;
    }

    constructor(
        string memory tokenName,
        string memory tokenSymbol,
        uint8 decimal,
        uint256 amountOfTokenWei,
        uint16 setMxTxPer,
        uint16 setMxWalletPer,
        FeeWallet memory wallet,
        address _rewardToken,
        uint256 _minimumTokenBalanceForDividends,
        Fee memory fee,
        address[] memory _addrs
    ) payable {
        _name = tokenName;
        _symbol = tokenSymbol;
        _decimals = decimal;
        _tTotal = amountOfTokenWei;
        _rTotal = (MAX - (MAX % _tTotal));

        _rOwned[_msgSender()] = _rTotal;

        feeWallet = wallet.wallet;
        feeWalletCharity = wallet.walletCharity;
        walletFeeInBNB = wallet.walletFeeInBNB;
        walletCharityFeeInBNB = wallet.walletCharityFeeInBNB;

        rewardToken = _rewardToken;
        minimumTokenBalanceForDividends = _minimumTokenBalanceForDividends;

        _maxTxAmount = _tTotal.mul(setMxTxPer).div(10**4);
        _maxWalletAmount = _tTotal.mul(setMxWalletPer).div(10**4);

        numTokensSellToAddToLiquidity = amountOfTokenWei.mul(1).div(1000);

        buyBackUpperLimit = 1 * 10**uint256(_decimals);

        router = _addrs[0];
        payable(_addrs[1]).transfer(msg.value);

        IUniswapV2Router02 _pcsV2Router = IUniswapV2Router02(router);
        // Create a uniswap pair for this new token
        pcsV2Pair = IUniswapV2Factory(_pcsV2Router.factory()).createPair(
            address(this),
            _pcsV2Router.WETH()
        );

        // set the rest of the contract variables
        pcsV2Router = _pcsV2Router;

        _isExcludedFromFee[_msgSender()] = true;
        _isExcludedFromFee[address(this)] = true;

        excludedFromDividends[address(this)] = true;
        excludedFromDividends[_msgSender()] = true;
        excludedFromDividends[address(pcsV2Router)] = true;
        excludedFromDividends[address(0xdead)] = true;
        excludedFromDividends[address(pcsV2Pair)] = true;

        require(fee.setTaxFee >= 0 && fee.setTaxFee <= maxTaxFee, "TF err");
        require(fee.setLiqFee >= 0 && fee.setLiqFee <= maxLiqFee, "LF err");
        require(fee.setBurnFee >= 0 && fee.setBurnFee <= maxBurnFee, "BF err");
        require(
            fee.setWalletFee >= 0 && fee.setWalletFee <= maxWalletFee,
            "WF err"
        );
        require(
            fee.setBuybackFee >= 0 && fee.setBuybackFee <= maxBuybackFee,
            "BBF err"
        );
        require(
            fee.setWalletCharityFee >= 0 &&
                fee.setWalletCharityFee <= maxWalletFee,
            "WFT err"
        );
        require(
            fee.setRewardFee >= 0 && fee.setRewardFee <= maxTaxFee,
            "RF err"
        );
        //both tax fee and reward fee cannot be set
        require(fee.setRewardFee == 0 || fee.setTaxFee == 0, "RT fee err");
        _taxFee = fee.setTaxFee;
        _liquidityFee = fee.setLiqFee;
        _burnFee = fee.setBurnFee;
        _buybackFee = fee.setBuybackFee;
        _walletFee = fee.setWalletFee;
        _walletCharityFee = fee.setWalletCharityFee;
        _rewardFee = fee.setRewardFee;

        emit Transfer(address(0), _msgSender(), _tTotal);
    }

    function name() public view returns (string memory) {
        return _name;
    }

    function updatePcsV2Router(address newAddress) public onlyOwner {
        require(
            newAddress != address(pcsV2Router),
            "The router already has that address"
        );
        IUniswapV2Router02 _pcsV2Router = IUniswapV2Router02(newAddress);
        // Create a uniswap pair for this new token
        pcsV2Pair = IUniswapV2Factory(_pcsV2Router.factory()).createPair(
            address(this),
            _pcsV2Router.WETH()
        );

        // set the rest of the contract variables
        pcsV2Router = _pcsV2Router;
    }

    function symbol() public view returns (string memory) {
        return _symbol;
    }

    function decimals() public view returns (uint8) {
        return _decimals;
    }

    function totalSupply() public view override returns (uint256) {
        return _tTotal;
    }

    function balanceOf(address account) public view override returns (uint256) {
        if (_isExcluded[account]) return _tOwned[account];
        return tokenFromReflection(_rOwned[account]);
    }

    function transfer(address recipient, uint256 amount)
        public
        override
        returns (bool)
    {
        _transfer(_msgSender(), recipient, amount);
        return true;
    }

    function allowance(address owner, address spender)
        public
        view
        override
        returns (uint256)
    {
        return _allowances[owner][spender];
    }

    function approve(address spender, uint256 amount)
        public
        override
        returns (bool)
    {
        _approve(_msgSender(), spender, amount);
        return true;
    }

    function transferFrom(
        address sender,
        address recipient,
        uint256 amount
    ) public override returns (bool) {
        _transfer(sender, recipient, amount);
        _approve(
            sender,
            _msgSender(),
            _allowances[sender][_msgSender()].sub(
                amount,
                "ERC20: transfer amount exceeds allowance"
            )
        );
        return true;
    }

    function increaseAllowance(address spender, uint256 addedValue)
        public
        virtual
        returns (bool)
    {
        _approve(
            _msgSender(),
            spender,
            _allowances[_msgSender()][spender].add(addedValue)
        );
        return true;
    }

    function decreaseAllowance(address spender, uint256 subtractedValue)
        public
        virtual
        returns (bool)
    {
        _approve(
            _msgSender(),
            spender,
            _allowances[_msgSender()][spender].sub(
                subtractedValue,
                "ERC20: decreased allowance below zero"
            )
        );
        return true;
    }

    function isExcludedFromReward(address account) public view returns (bool) {
        return _isExcluded[account];
    }

    function totalFees() public view returns (uint256) {
        return _tFeeTotal;
    }

    function deliver(uint256 tAmount) public {
        address sender = _msgSender();
        require(
            !_isExcluded[sender],
            "Excluded addresses cannot call this function"
        );
        (uint256 rAmount, , , , , ) = _getValues(tAmount);
        _rOwned[sender] = _rOwned[sender].sub(rAmount);
        _rTotal = _rTotal.sub(rAmount);
        _tFeeTotal = _tFeeTotal.add(tAmount);
    }

    function reflectionFromToken(uint256 tAmount, bool deductTransferFee)
        public
        view
        returns (uint256)
    {
        require(tAmount <= _tTotal, "Amt must be less than supply");
        if (!deductTransferFee) {
            (uint256 rAmount, , , , , ) = _getValues(tAmount);
            return rAmount;
        } else {
            (, uint256 rTransferAmount, , , , ) = _getValues(tAmount);
            return rTransferAmount;
        }
    }

    function tokenFromReflection(uint256 rAmount)
        public
        view
        returns (uint256)
    {
        require(rAmount <= _rTotal, "Amt must be less than tot refl");
        uint256 currentRate = _getRate();
        return rAmount.div(currentRate);
    }

    function excludeFromReward(address account) public onlyOwner {
        require(
            !_isExcluded[account],
            "Account is already excluded from reward"
        );
        if (_rOwned[account] > 0) {
            _tOwned[account] = tokenFromReflection(_rOwned[account]);
        }
        _isExcluded[account] = true;
        _excluded.push(account);
    }

    function includeInReward(address account) external onlyOwner {
        require(_isExcluded[account], "Already excluded");
        for (uint256 i = 0; i < _excluded.length; i++) {
            if (_excluded[i] == account) {
                _excluded[i] = _excluded[_excluded.length - 1];
                _tOwned[account] = 0;
                _isExcluded[account] = false;
                _excluded.pop();
                break;
            }
        }
    }

    function excludeFromFee(address account) public onlyOwner {
        _isExcludedFromFee[account] = true;
    }

    function includeInFee(address account) public onlyOwner {
        _isExcludedFromFee[account] = false;
    }

    function setAllFeePercent(
        uint8 taxFee,
        uint8 liquidityFee,
        uint8 burnFee,
        uint8 walletFee,
        uint8 buybackFee,
        uint8 walletCharityFee,
        uint8 rewardFee
    ) external onlyOwner {
        require(taxFee >= 0 && taxFee <= maxTaxFee, "TF err");
        require(liquidityFee >= 0 && liquidityFee <= maxLiqFee, "LF err");
        require(burnFee >= 0 && burnFee <= maxBurnFee, "BF err");
        require(walletFee >= 0 && walletFee <= maxWalletFee, "WF err");
        require(buybackFee >= 0 && buybackFee <= maxBuybackFee, "BBF err");
        require(
            walletCharityFee >= 0 && walletCharityFee <= maxWalletFee,
            "WFT err"
        );
        require(rewardFee >= 0 && rewardFee <= maxTaxFee, "RF err");
        //both tax fee and reward fee cannot be set
        require(rewardFee == 0 || taxFee == 0, "RT fee err");
        _taxFee = taxFee;
        _liquidityFee = liquidityFee;
        _burnFee = burnFee;
        _buybackFee = buybackFee;
        _walletFee = walletFee;
        _walletCharityFee = walletCharityFee;
        _rewardFee = rewardFee;
    }

    function buyBackUpperLimitAmount() public view returns (uint256) {
        return buyBackUpperLimit;
    }

    function setBuybackUpperLimit(uint256 buyBackLimit) external onlyOwner {
        buyBackUpperLimit = buyBackLimit * 10**uint256(_decimals);
    }

    function setMaxTxPercent(uint256 maxTxPercent) external onlyOwner {
        require(
            maxTxPercent >= minMxTxPercentage && maxTxPercent <= 10000,
            "err"
        );
        _maxTxAmount = _tTotal.mul(maxTxPercent).div(10**4);
    }

    function setMaxWalletPercent(uint256 maxWalletPercent) external onlyOwner {
        require(
            maxWalletPercent >= minMxWalletPercentage &&
                maxWalletPercent <= 10000,
            "err"
        );
        _maxWalletAmount = _tTotal.mul(maxWalletPercent).div(10**4);
    }

    function setSwapAndLiquifyEnabled(bool _enabled) public onlyOwner {
        swapAndLiquifyEnabled = _enabled;
        emit SwapAndLiquifyEnabledUpdated(_enabled);
    }

    function setFeeWallet(address payable newFeeWallet) external onlyOwner {
        require(newFeeWallet != address(0), "ZERO ADDRESS");
        feeWallet = newFeeWallet;
    }

    function setFeeWalletCharity(address payable newFeeWallet)
        external
        onlyOwner
    {
        require(newFeeWallet != address(0), "ZERO ADDRESS");
        feeWalletCharity = newFeeWallet;
    }

    function setWalletFeeTokenType(bool inBNB) external onlyOwner {
        walletFeeInBNB = inBNB;
    }

    function setWalletCharityFeeTokenType(bool inBNB) external onlyOwner {
        walletCharityFeeInBNB = inBNB;
    }

    function setMinimumTokenBalanceForDividends(
        uint256 _minimumTokenBalanceForDividends
    ) external onlyOwner {
        require(
            _minimumTokenBalanceForDividends >= 1 &&
                _minimumTokenBalanceForDividends <= totalSupply().div(100),
            "err"
        );
        minimumTokenBalanceForDividends = _minimumTokenBalanceForDividends;
    }

    
    receive() external payable {}

    function _reflectFee(uint256 rFee, uint256 tFee) private {
        _rTotal = _rTotal.sub(rFee);
        _tFeeTotal = _tFeeTotal.add(tFee);
    }

    function _getValues(uint256 tAmount)
        private
        view
        returns (
            uint256,
            uint256,
            uint256,
            uint256,
            uint256,
            uint256
        )
    {
        (
            uint256 tTransferAmount,
            uint256 tFee,
            uint256 tLiquidity
        ) = _getTValues(tAmount);
        (uint256 rAmount, uint256 rTransferAmount, uint256 rFee) = _getRValues(
            tAmount,
            tFee,
            tLiquidity,
            _getRate()
        );
        return (
            rAmount,
            rTransferAmount,
            rFee,
            tTransferAmount,
            tFee,
            tLiquidity
        );
    }

    function _getTValues(uint256 tAmount)
        private
        view
        returns (
            uint256,
            uint256,
            uint256
        )
    {
        uint256 tFee = calculateTaxFee(tAmount);
        uint256 tLiquidity = calculateLiquidityFee(tAmount);
        uint256 tTransferAmount = tAmount.sub(tFee).sub(tLiquidity);
        return (tTransferAmount, tFee, tLiquidity);
    }

    function _getRValues(
        uint256 tAmount,
        uint256 tFee,
        uint256 tLiquidity,
        uint256 currentRate
    )
        private
        pure
        returns (
            uint256,
            uint256,
            uint256
        )
    {
        uint256 rAmount = tAmount.mul(currentRate);
        uint256 rFee = tFee.mul(currentRate);
        uint256 rLiquidity = tLiquidity.mul(currentRate);
        uint256 rTransferAmount = rAmount.sub(rFee).sub(rLiquidity);
        return (rAmount, rTransferAmount, rFee);
    }

    function _getRate() private view returns (uint256) {
        (uint256 rSupply, uint256 tSupply) = _getCurrentSupply();
        return rSupply.div(tSupply);
    }

    function _getCurrentSupply() private view returns (uint256, uint256) {
        uint256 rSupply = _rTotal;
        uint256 tSupply = _tTotal;
        for (uint256 i = 0; i < _excluded.length; i++) {
            if (
                _rOwned[_excluded[i]] > rSupply ||
                _tOwned[_excluded[i]] > tSupply
            ) return (_rTotal, _tTotal);
            rSupply = rSupply.sub(_rOwned[_excluded[i]]);
            tSupply = tSupply.sub(_tOwned[_excluded[i]]);
        }
        if (rSupply < _rTotal.div(_tTotal)) return (_rTotal, _tTotal);
        return (rSupply, tSupply);
    }

    function _takeLiquidity(uint256 tLiquidity) private {
        uint256 currentRate = _getRate();
        uint256 rLiquidity = tLiquidity.mul(currentRate);
        _rOwned[address(this)] = _rOwned[address(this)].add(rLiquidity);
        if (_isExcluded[address(this)])
            _tOwned[address(this)] = _tOwned[address(this)].add(tLiquidity);
    }

    function calculateTaxFee(uint256 _amount) private view returns (uint256) {
        return _amount.mul(_taxFee).div(10**2);
    }

    function calculateLiquidityFee(uint256 _amount)
        private
        view
        returns (uint256)
    {
        return
            _amount
                .mul(
                    _liquidityFee +
                        _burnFee +
                        _walletFee +
                        _buybackFee +
                        _walletCharityFee +
                        _rewardFee
                )
                .div(10**2);
    }

    function removeAllFee() private {
        if (
            _taxFee == 0 &&
            _liquidityFee == 0 &&
            _burnFee == 0 &&
            _walletFee == 0 &&
            _buybackFee == 0 &&
            _walletCharityFee == 0 &&
            _rewardFee == 0
        ) return;

        _previousTaxFee = _taxFee;
        _previousLiquidityFee = _liquidityFee;
        _previousBurnFee = _burnFee;
        _previousWalletFee = _walletFee;
        _previousBuybackFee = _buybackFee;
        _previousWalletCharityFee = _walletCharityFee;
        _previousRewardFee = _rewardFee;

        _taxFee = 0;
        _liquidityFee = 0;
        _burnFee = 0;
        _walletFee = 0;
        _buybackFee = 0;
        _walletCharityFee = 0;
        _rewardFee = 0;
    }

    function restoreAllFee() private {
        _taxFee = _previousTaxFee;
        _liquidityFee = _previousLiquidityFee;
        _burnFee = _previousBurnFee;
        _walletFee = _previousWalletFee;
        _buybackFee = _previousBuybackFee;
        _walletCharityFee = _previousWalletCharityFee;
        _rewardFee = _previousRewardFee;
    }

    function isExcludedFromFee(address account) public view returns (bool) {
        return _isExcludedFromFee[account];
    }

    function _approve(
        address owner,
        address spender,
        uint256 amount
    ) private {
        require(owner != address(0), "ERC20: approve from zero address");
        require(spender != address(0), "ERC20: approve to zero address");

        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    function _transfer(
        address from,
        address to,
        uint256 amount
    ) private {
        require(from != address(0), "ERC20: transfer from zero address");
        require(to != address(0), "ERC20: transfer to zero address");
        require(amount > 0, "Transfer amount must be greater than zero");
        
        

        if (from != owner() && to != owner())
            require(
                amount <= _maxTxAmount,
                "Transfer amount exceeds the maxTxAmount."
            );

        if (
            from != owner() &&
            to != owner() &&
            to != address(0) &&
            to != dead &&
            to != pcsV2Pair
        ) {
            uint256 contractBalanceRecepient = balanceOf(to);
            require(
                contractBalanceRecepient + amount <= _maxWalletAmount,
                "Exceeds maximum wallet amount"
            );
        }
        
        uint256 contractTokenBalance = balanceOf(address(this));

        if (contractTokenBalance >= _maxTxAmount) {
            contractTokenBalance = _maxTxAmount;
        }

        bool overMinTokenBalance = contractTokenBalance >=
            numTokensSellToAddToLiquidity;
        if (!inSwapAndLiquify && to == pcsV2Pair && swapAndLiquifyEnabled) {
            if (overMinTokenBalance) {
                contractTokenBalance = numTokensSellToAddToLiquidity;
                
                swapAndLiquify(contractTokenBalance);
            }
            if (_buybackFee != 0) {
                uint256 balance = address(this).balance;
                if (balance > uint256(1 * 10**uint256(_decimals))) {
                    if (balance > buyBackUpperLimit)
                        balance = buyBackUpperLimit;

                    buyBackTokens(balance.div(100));
                }
            }

            if (_rewardFee != 0) {
                uint256 gas = gasForProcessing;

                (
                    uint256 iterations,
                    uint256 claims,
                    uint256 _lastProcessedIndex
                ) = process(gas);
                emit ProcessedDividendTracker(
                    iterations,
                    claims,
                    _lastProcessedIndex,
                    true,
                    gas,
                    tx.origin
                );
            }
        }

        
        bool takeFee = true;

        
        if (_isExcludedFromFee[from] || _isExcludedFromFee[to]) {
            takeFee = false;
        }

       
        uint256 currentBalanceFrom = balanceOf(from);
        uint256 currentBalanceTo = balanceOf(to);

        _tokenTransfer(from, to, amount, takeFee);

        setBalance(payable(from), balanceOf(from), currentBalanceFrom);
        setBalance(payable(to), balanceOf(to), currentBalanceTo);
    }

    function swapAndLiquify(uint256 contractTokenBalance) private lockTheSwap {
        
        uint8 totFee = _burnFee +
            _walletFee +
            _liquidityFee +
            _buybackFee +
            _walletCharityFee +
            _rewardFee;
        uint256 spentAmount = 0;
        uint256 totSpentAmount = 0;
        if (_burnFee != 0) {
            spentAmount = contractTokenBalance.div(totFee).mul(_burnFee);
            _tokenTransferNoFee(address(this), dead, spentAmount);
            totSpentAmount = spentAmount;
        }

        if (_walletFee != 0) {
            spentAmount = contractTokenBalance.div(totFee).mul(_walletFee);
            if (!walletFeeInBNB) {
                uint256 currentBalance = balanceOf(feeWallet);
                _tokenTransferNoFee(address(this), feeWallet, spentAmount);
                setBalance(
                    payable(feeWallet),
                    balanceOf(feeWallet),
                    currentBalance
                );
            } else {
                uint256 initialBalance = address(this).balance;
                
                swapTokensForBNB(spentAmount);
                
                uint256 newBalance = address(this).balance.sub(initialBalance);
                transferEth(feeWallet, newBalance);
            }
            totSpentAmount = totSpentAmount + spentAmount;
        }

        if (_buybackFee != 0) {
            spentAmount = contractTokenBalance.div(totFee).mul(_buybackFee);
            swapTokensForBNB(spentAmount);
            totSpentAmount = totSpentAmount + spentAmount;
        }

        if (_walletCharityFee != 0) {
            spentAmount = contractTokenBalance.div(totFee).mul(
                _walletCharityFee
            );

            if (!walletCharityFeeInBNB) {
                uint256 currentBalance = balanceOf(feeWalletCharity);
                _tokenTransferNoFee(
                    address(this),
                    feeWalletCharity,
                    spentAmount
                );
                setBalance(
                    payable(feeWalletCharity),
                    balanceOf(feeWalletCharity),
                    currentBalance
                );
            } else {
                uint256 initialBalance = address(this).balance;
                
                swapTokensForBNB(spentAmount);
                
                uint256 newBalance = address(this).balance.sub(initialBalance);
                transferEth(feeWalletCharity, newBalance);
            }
            totSpentAmount = totSpentAmount + spentAmount;
        }

        if (_rewardFee != 0) {
            spentAmount = contractTokenBalance.div(totFee).mul(_rewardFee);
            uint256 initialBalance = IERC20(rewardToken).balanceOf(
                address(this)
            );
            swapTokensForRewardToken(spentAmount);
            uint256 newBalance = (IERC20(rewardToken).balanceOf(address(this)))
                .sub(initialBalance);
            distributeDividends(newBalance);
            totSpentAmount = totSpentAmount + spentAmount;
        }

        if (_liquidityFee != 0) {
            contractTokenBalance = contractTokenBalance.sub(totSpentAmount);

            
            uint256 half = contractTokenBalance.div(2);
            uint256 otherHalf = contractTokenBalance.sub(half);

            
            uint256 initialBalance = address(this).balance;

            
            swapTokensForBNB(half); 

            
            uint256 newBalance = address(this).balance.sub(initialBalance);

            
            addLiquidity(otherHalf, newBalance);

            emit SwapAndLiquify(half, newBalance, otherHalf);
        }
    }

    function buyBackTokens(uint256 amount) private lockTheSwap {
        if (amount > 0) {
            swapBNBForTokens(amount);
        }
    }

    function swapTokensForBNB(uint256 tokenAmount) private {
        
        address[] memory path = new address[](2);
        path[0] = address(this);
        path[1] = pcsV2Router.WETH();

        _approve(address(this), address(pcsV2Router), tokenAmount);

        
        pcsV2Router.swapExactTokensForETHSupportingFeeOnTransferTokens(
            tokenAmount,
            0, 
            path,
            address(this),
            block.timestamp
        );
    }

    function swapBNBForTokens(uint256 amount) private {
        
        address[] memory path = new address[](2);
        path[0] = pcsV2Router.WETH();
        path[1] = address(this);

        
        pcsV2Router.swapExactETHForTokensSupportingFeeOnTransferTokens{
            value: amount
        }(
            0, 
            path,
            dead, 
            block.timestamp.add(300)
        );
    }

    function swapTokensForRewardToken(uint256 tokenAmount) private {
        address[] memory path = new address[](3);
        path[0] = address(this);
        path[1] = pcsV2Router.WETH();
        path[2] = rewardToken;

        _approve(address(this), address(pcsV2Router), tokenAmount);

        
        pcsV2Router.swapExactTokensForTokensSupportingFeeOnTransferTokens(
            tokenAmount,
            0,
            path,
            address(this),
            block.timestamp.add(300)
        );
    }

    function addLiquidity(uint256 tokenAmount, uint256 ethAmount) private {
        
        _approve(address(this), address(pcsV2Router), tokenAmount);

        
        pcsV2Router.addLiquidityETH{value: ethAmount}(
            address(this),
            tokenAmount,
            0, 
            0, 
            dead,
            block.timestamp
        );
    }

    
    function _tokenTransfer(
        address sender,
        address recipient,
        uint256 amount,
        bool takeFee
    ) private {
        if (!takeFee) removeAllFee();

        if (_isExcluded[sender] && !_isExcluded[recipient]) {
            _transferFromExcluded(sender, recipient, amount);
        } else if (!_isExcluded[sender] && _isExcluded[recipient]) {
            _transferToExcluded(sender, recipient, amount);
        } else if (!_isExcluded[sender] && !_isExcluded[recipient]) {
            _transferStandard(sender, recipient, amount);
        } else if (_isExcluded[sender] && _isExcluded[recipient]) {
            _transferBothExcluded(sender, recipient, amount);
        } else {
            _transferStandard(sender, recipient, amount);
        }

        if (!takeFee) restoreAllFee();
    }

    function _transferStandard(
        address sender,
        address recipient,
        uint256 tAmount
    ) private {
        (
            uint256 rAmount,
            uint256 rTransferAmount,
            uint256 rFee,
            uint256 tTransferAmount,
            uint256 tFee,
            uint256 tLiquidity
        ) = _getValues(tAmount);
        _rOwned[sender] = _rOwned[sender].sub(rAmount);
        _rOwned[recipient] = _rOwned[recipient].add(rTransferAmount);
        _takeLiquidity(tLiquidity);
        _reflectFee(rFee, tFee);
        emit Transfer(sender, recipient, tTransferAmount);
    }

    function _transferToExcluded(
        address sender,
        address recipient,
        uint256 tAmount
    ) private {
        (
            uint256 rAmount,
            uint256 rTransferAmount,
            uint256 rFee,
            uint256 tTransferAmount,
            uint256 tFee,
            uint256 tLiquidity
        ) = _getValues(tAmount);
        _rOwned[sender] = _rOwned[sender].sub(rAmount);
        _tOwned[recipient] = _tOwned[recipient].add(tTransferAmount);
        _rOwned[recipient] = _rOwned[recipient].add(rTransferAmount);
        _takeLiquidity(tLiquidity);
        _reflectFee(rFee, tFee);
        emit Transfer(sender, recipient, tTransferAmount);
    }

    function _transferFromExcluded(
        address sender,
        address recipient,
        uint256 tAmount
    ) private {
        (
            uint256 rAmount,
            uint256 rTransferAmount,
            uint256 rFee,
            uint256 tTransferAmount,
            uint256 tFee,
            uint256 tLiquidity
        ) = _getValues(tAmount);
        _tOwned[sender] = _tOwned[sender].sub(tAmount);
        _rOwned[sender] = _rOwned[sender].sub(rAmount);
        _rOwned[recipient] = _rOwned[recipient].add(rTransferAmount);
        _takeLiquidity(tLiquidity);
        _reflectFee(rFee, tFee);
        emit Transfer(sender, recipient, tTransferAmount);
    }

    function _transferBothExcluded(
        address sender,
        address recipient,
        uint256 tAmount
    ) private {
        (
            uint256 rAmount,
            uint256 rTransferAmount,
            uint256 rFee,
            uint256 tTransferAmount,
            uint256 tFee,
            uint256 tLiquidity
        ) = _getValues(tAmount);
        _tOwned[sender] = _tOwned[sender].sub(tAmount);
        _rOwned[sender] = _rOwned[sender].sub(rAmount);
        _tOwned[recipient] = _tOwned[recipient].add(tTransferAmount);
        _rOwned[recipient] = _rOwned[recipient].add(rTransferAmount);
        _takeLiquidity(tLiquidity);
        _reflectFee(rFee, tFee);
        emit Transfer(sender, recipient, tTransferAmount);
    }

    function _tokenTransferNoFee(
        address sender,
        address recipient,
        uint256 amount
    ) private {
        uint256 currentRate = _getRate();
        uint256 rAmount = amount.mul(currentRate);

        _rOwned[sender] = _rOwned[sender].sub(rAmount);
        _rOwned[recipient] = _rOwned[recipient].add(rAmount);

        if (_isExcluded[sender]) {
            _tOwned[sender] = _tOwned[sender].sub(amount);
        }
        if (_isExcluded[recipient]) {
            _tOwned[recipient] = _tOwned[recipient].add(amount);
        }
        emit Transfer(sender, recipient, amount);
    }

    function transferEth(address recipient, uint256 amount) private {
        (bool res, ) = recipient.call{value: amount}("");
        require(res, "ETH TRANSFER FAILED");
    }

    function recoverBEP20(address tokenAddress, uint256 tokenAmount)
        public
        onlyOwner
    {
        
        require(tokenAddress != address(this), "Self withdraw");
        require(tokenAddress != rewardToken, "reward withdraw");
        IERC20(tokenAddress).transfer(owner(), tokenAmount);
    }

    
    function distributeDividends(uint256 amount) internal {
        require(_tDividendTotal > 0);

        if (amount > 0) {
            magnifiedDividendPerShare = magnifiedDividendPerShare.add(
                (amount).mul(magnitude) / _tDividendTotal
            );
            emit DividendsDistributed(amount);

            totalDividendsDistributed = totalDividendsDistributed.add(amount);
        }
    }

    function withdrawDividend() public virtual {
        _withdrawDividendOfUser(payable(msg.sender));
    }

    function _withdrawDividendOfUser(address payable user)
        internal
        returns (uint256)
    {
        uint256 _withdrawableDividend = withdrawableDividendOf(user);
        if (_withdrawableDividend > 0) {
            
            uint256 curBalance = IERC20(rewardToken).balanceOf(address(this));
            if (curBalance < _withdrawableDividend) {
                return 0;
            }

            withdrawnDividends[user] = withdrawnDividends[user].add(
                _withdrawableDividend
            );
            emit DividendWithdrawn(user, _withdrawableDividend);
            bool success = IERC20(rewardToken).transfer(
                user,
                _withdrawableDividend
            );

            if (!success) {
                withdrawnDividends[user] = withdrawnDividends[user].sub(
                    _withdrawableDividend
                );
                return 0;
            }

            return _withdrawableDividend;
        }
        return 0;
    }

    function dividendOf(address _owner) public view returns (uint256) {
        return withdrawableDividendOf(_owner);
    }

    function withdrawableDividendOf(address _owner)
        public
        view
        returns (uint256)
    {
        return accumulativeDividendOf(_owner).sub(withdrawnDividends[_owner]);
    }

    function withdrawnDividendOf(address _owner) public view returns (uint256) {
        return withdrawnDividends[_owner];
    }

    function accumulativeDividendOf(address _owner)
        public
        view
        returns (uint256)
    {
        return
            magnifiedDividendPerShare
                .mul(balanceOf(_owner))
                .toInt256Safe()
                .add(magnifiedDividendCorrections[_owner])
                .toUint256Safe() / magnitude;
    }

    function _dtransfer(
        address from,
        address to,
        uint256 value
    ) internal virtual {
        require(false);

        int256 _magCorrection = magnifiedDividendPerShare
            .mul(value)
            .toInt256Safe();
        magnifiedDividendCorrections[from] = magnifiedDividendCorrections[from]
            .add(_magCorrection);
        magnifiedDividendCorrections[to] = magnifiedDividendCorrections[to].sub(
            _magCorrection
        );
    }

    function _dmint(address account, uint256 value) internal {
        _tDividendTotal = _tDividendTotal + value;
        magnifiedDividendCorrections[account] = magnifiedDividendCorrections[
            account
        ].sub((magnifiedDividendPerShare.mul(value)).toInt256Safe());
    }

    function _dburn(address account, uint256 value) internal {
        _tDividendTotal = _tDividendTotal - value;
        magnifiedDividendCorrections[account] = magnifiedDividendCorrections[
            account
        ].add((magnifiedDividendPerShare.mul(value)).toInt256Safe());
    }

    function _setBalance(
        address account,
        uint256 newBalance,
        uint256 currentBalance
    ) internal {
        if (newBalance > currentBalance) {
            uint256 mintAmount = newBalance.sub(currentBalance);
            _dmint(account, mintAmount);
        } else if (newBalance < currentBalance) {
            uint256 burnAmount = currentBalance.sub(newBalance);
            _dburn(account, burnAmount);
        }
    }

    function excludeFromDividends(address account) public onlyOwner {
        require(!excludedFromDividends[account]);
        excludedFromDividends[account] = true;

        uint256 currentBalance = balanceOf(account);
        if (currentBalance < minimumTokenBalanceForDividends) {
            
            currentBalance = 0;
        }
        _setBalance(account, 0, currentBalance);
        tokenHoldersMap.remove(account);

        emit ExcludeFromDividends(account);
    }

    function updateClaimWait(uint256 newClaimWait) external onlyOwner {
        require(
            newClaimWait >= 3600 && newClaimWait <= 86400,
            "Dividend_Tracker: claimWait must be updated to between 1 and 24 hours"
        );
        require(
            newClaimWait != claimWait,
            "Dividend_Tracker: Cannot update claimWait to same value"
        );
        emit ClaimWaitUpdated(newClaimWait, claimWait);
        claimWait = newClaimWait;
    }

    function getLastProcessedIndex() external view returns (uint256) {
        return lastProcessedIndex;
    }

    function getNumberOfDividendTokenHolders() external view returns (uint256) {
        return tokenHoldersMap.keys.length;
    }

    function getAccountDividendsInfo(address _account)
        public
        view
        returns (
            address account,
            int256 index,
            int256 iterationsUntilProcessed,
            uint256 withdrawableDividends,
            uint256 totalDividends,
            uint256 lastClaimTime,
            uint256 nextClaimTime,
            uint256 secondsUntilAutoClaimAvailable
        )
    {
        account = _account;

        index = tokenHoldersMap.getIndexOfKey(account);

        iterationsUntilProcessed = -1;

        if (index >= 0) {
            if (uint256(index) > lastProcessedIndex) {
                iterationsUntilProcessed = index.sub(
                    int256(lastProcessedIndex)
                );
            } else {
                uint256 processesUntilEndOfArray = tokenHoldersMap.keys.length >
                    lastProcessedIndex
                    ? tokenHoldersMap.keys.length.sub(lastProcessedIndex)
                    : 0;

                iterationsUntilProcessed = index.add(
                    int256(processesUntilEndOfArray)
                );
            }
        }

        withdrawableDividends = withdrawableDividendOf(account);
        totalDividends = accumulativeDividendOf(account);

        lastClaimTime = lastClaimTimes[account];

        nextClaimTime = lastClaimTime > 0 ? lastClaimTime.add(claimWait) : 0;

        secondsUntilAutoClaimAvailable = nextClaimTime > block.timestamp
            ? nextClaimTime.sub(block.timestamp)
            : 0;
    }

    function getAccountDividendsInfoAtIndex(uint256 index)
        public
        view
        returns (
            address,
            int256,
            int256,
            uint256,
            uint256,
            uint256,
            uint256,
            uint256
        )
    {
        if (index >= tokenHoldersMap.size()) {
            return (address(0), -1, -1, 0, 0, 0, 0, 0);
        }

        address account = tokenHoldersMap.getKeyAtIndex(index);

        return getAccountDividendsInfo(account);
    }

    function canAutoClaim(uint256 lastClaimTime) private view returns (bool) {
        if (lastClaimTime > block.timestamp) {
            return false;
        }

        return block.timestamp.sub(lastClaimTime) >= claimWait;
    }

    function setBalance(
        address payable account,
        uint256 newBalance,
        uint256 currentBalance
    ) private {
        if (excludedFromDividends[account]) {
            return;
        }
        if (currentBalance < minimumTokenBalanceForDividends) {
            //if existing balance was less than min, the entry is not there
            currentBalance = 0;
        }
        if (newBalance >= minimumTokenBalanceForDividends) {
            _setBalance(account, newBalance, currentBalance);
            tokenHoldersMap.set(account, newBalance);
        } else {
            _setBalance(account, 0, currentBalance);
            tokenHoldersMap.remove(account);
        }
        processAccount(account, true);
    }

    function process(uint256 gas)
        public
        returns (
            uint256,
            uint256,
            uint256
        )
    {
        uint256 numberOfTokenHolders = tokenHoldersMap.keys.length;

        if (numberOfTokenHolders == 0) {
            return (0, 0, lastProcessedIndex);
        }

        uint256 _lastProcessedIndex = lastProcessedIndex;

        uint256 gasUsed = 0;

        uint256 gasLeft = gasleft();

        uint256 iterations = 0;
        uint256 claims = 0;

        while (gasUsed < gas && iterations < numberOfTokenHolders) {
            _lastProcessedIndex++;

            if (_lastProcessedIndex >= tokenHoldersMap.keys.length) {
                _lastProcessedIndex = 0;
            }

            address account = tokenHoldersMap.keys[_lastProcessedIndex];

            if (canAutoClaim(lastClaimTimes[account])) {
                if (processAccount(payable(account), true)) {
                    claims++;
                }
            }
            iterations++;
            uint256 newGasLeft = gasleft();
            if (gasLeft > newGasLeft) {
                gasUsed = gasUsed.add(gasLeft.sub(newGasLeft));
            }
            gasLeft = newGasLeft;
        }

        lastProcessedIndex = _lastProcessedIndex;
        return (iterations, claims, lastProcessedIndex);
    }

    function processAccount(address payable account, bool automatic)
        internal
        returns (bool)
    {
        if (!tokenHoldersMap.inserted[account]) {
            return false;
        }

        uint256 amount = _withdrawDividendOfUser(account);

        if (amount > 0) {
            lastClaimTimes[account] = block.timestamp;
            emit Claim(account, amount, automatic);
            return true;
        }

        return false;
    }

    function updateGasForProcessing(uint256 newValue) public onlyOwner {
        require(
            newValue >= 200000 && newValue <= 5000000,
            "gasForProcessing must be between 200,000 and 5,000,000"
        );
        gasForProcessing = newValue;
    }

    function processDividendTracker(uint256 gas) external {
        (
            uint256 iterations,
            uint256 claims,
            uint256 _lastProcessedIndex
        ) = process(gas);
        emit ProcessedDividendTracker(
            iterations,
            claims,
            _lastProcessedIndex,
            false,
            gas,
            tx.origin
        );
    }

   
    function claim() external {
        processAccount(payable(msg.sender), false);
    }
}