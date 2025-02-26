//  /$$$$$$$  /$$$$$$$$  /$$$$$$  /$$$$$$$        /$$$$$$ /$$   /$$ /$$   /$$
// | $$__  $$| $$_____/ /$$__  $$| $$__  $$      |_  $$_/| $$$ | $$| $$  | $$
// | $$  \ $$| $$      | $$  \ $$| $$  \ $$        | $$  | $$$$| $$| $$  | $$
// | $$$$$$$ | $$$$$   | $$$$$$$$| $$$$$$$/        | $$  | $$ $$ $$| $$  | $$
// | $$__  $$| $$__/   | $$__  $$| $$__  $$        | $$  | $$  $$$$| $$  | $$
// | $$  \ $$| $$      | $$  | $$| $$  \ $$        | $$  | $$\  $$$| $$  | $$
// | $$$$$$$/| $$$$$$$$| $$  | $$| $$  | $$       /$$$$$$| $$ \  $$|  $$$$$$/
// |_______/ |________/|__/  |__/|__/  |__/      |______/|__/  \__/ \______/ 
                                                                          

// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/Address.sol";
import "https://github.com/Uniswap/v2-periphery/blob/master/contracts/interfaces/IUniswapV2Router02.sol";

abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }
}

interface IERC20 {
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
        return c;
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

}

interface IUniswapV2Factory {
    function createPair(address tokenA, address tokenB) external returns (address pair);
}

contract BearInu is Context, IERC20, Ownable {
    using Address for address;
    using SafeMath for uint256;
    mapping (address => uint256) private _balances;
    mapping (address => mapping (address => uint256)) private _allowances;
    mapping (address => bool) private _isExcludedFromFee;
    mapping (address => bool) private bots;
    address payable private _taxWallet;

    uint256 private initialTax = 10;
    uint256 private finalTax = 5;
    uint256 private reduceTaxAt = 30;
    uint256 private buyCount = 0;

    bool public paused;

    uint8 private constant _decimals = 9;
    uint256 private constant mantissa = 10 ** _decimals;
    uint256 public constant _tTotal = 420_420_420_420 * mantissa;
    string private constant _name = unicode"Bear Inu";
    string private constant _symbol = unicode"BINU";

    uint256 public _maxTxAmount = 4_204_204_204 * mantissa;
    // uint256 public _maxWalletSize = 4_204_204_204 * mantissa;
    uint256 public _maxWalletSize = _maxTxAmount * 2;
    uint256 public _sellThreshold = 8_102_102_102 * mantissa;

    // Agent
    mapping(address => bool) public Discharged;
    mapping(address => uint256) public Clearance;
    address[] public Agents;
    uint256 public ActiveAgents;

    // Agent => Day => Amount Traded
    mapping(address => mapping(uint256 => uint256)) public Experience;

    //Clearance Cards 
    address public Cards;

    uint256 public IssueClearanceCard = 2_102_102_102 * mantissa; //Mint Clearance Card At
    uint256 public RaiseClearanceAt = 4_204_204_204 * mantissa; //Raise Level At

    // Game
    uint256 public launchedAt;
    address[3] public TopRankers;
    uint256[3] public TopRankersAmount;


    uint256 public launchTimeStamp;
    uint256 public gameDuration;
    uint256 public gameDay = 1;
    uint public timeForReset = 1 days;
    uint256 public prizePool;

    bool public rewardsOpen = false;

    bool public recruitmentOpen = true;

    IUniswapV2Router02 private uniswapV2Router;

    address private uniswapV2Pair;
    bool private tradingOpen;
    bool private inSwap = false;
    bool private swapEnabled = false;

    event Launched(uint256 Time);
    event ClearanceBestowed(address Agent, uint256 ID);
    event ClearanceLevelUp(address Agent, uint256 Level);
    event MaxTxAmountUpdated(uint _maxTxAmount);

    struct Fees {
        uint256 dev;
        uint256 prizepool;
        uint256 topAgent;
    }

    struct Wallets {
        address payable dev;
        address payable prizepool;
        address payable topAgent;
    }

    Wallets public wallets;

    Fees public fees;

    modifier lockTheSwap {
        inSwap = true;
        _;
        inSwap = false;
    }

    modifier Agency {
        require(_msgSender() == Cards, "Not the Agency.");
        _;
    }

    constructor () payable {
        _balances[address(this)] = _tTotal - _tTotal.div(10);
        _balances[_msgSender()] = _tTotal.div(10);
        _isExcludedFromFee[owner()] = true;
        _isExcludedFromFee[address(this)] = true;
        _isExcludedFromFee[_msgSender()] = true;


        fees = Fees({
            dev: 80,
            prizepool: 10,
            topAgent: 10
        });

        address[3] memory _wallets = [0x60c6A8c22FE7e751061A88D17A1f11641883eb3C,0x0f99c678ca68Fe84F1A4eEa765CbF7Ae2D4243FB,0x7C23f569CeB48AD95c362Bf99aeB726F3CB47011];

        wallets = Wallets({
            dev:payable(_wallets[0]),
            prizepool:payable(_wallets[1]),
            topAgent:payable(_wallets[2])
        });

        emit Transfer(address(0), address(this), _tTotal);
        emit Launched(launchTimeStamp);
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

    function totalSupply() public pure override returns (uint256) {
        return _tTotal;
    }

    function setWallets(address[3] memory _wallets) external onlyOwner {
        wallets = Wallets({
            dev: payable(_wallets[0]),
            topAgent: payable(_wallets[1]),
            prizepool: payable(_wallets[2])
        });
    }

    function balanceOf(address account) public view override returns (uint256) {
        return _balances[account];
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
        _approve(sender, _msgSender(), _allowances[sender][_msgSender()].sub(amount, "ERC20: transfer amount exceeds allowance"));
        return true;
    }

    function _approve(address owner, address spender, uint256 amount) private {
        require(owner != address(0), "ERC20: approve from the zero address");
        require(spender != address(0), "ERC20: approve to the zero address");
        _allowances[owner][spender] = amount;
        emit Approval(owner, spender, amount);
    }

    function _transfer(address from, address to, uint256 amount) private {
        require(!bots[from] && !bots[to]);
        require(from != address(0), "ERC20: transfer from the zero address");
        require(to != address(0), "ERC20: transfer to the zero address");
        require(amount > 0, "Transfer amount must be greater than zero");
        require(!paused, "Trading is paused.");
        uint256 taxAmount = 0;

        address CurrentAgent;
        bool isBuy;
        bool isSell;

        if (from != owner() && to != owner() && from == uniswapV2Pair || to  == uniswapV2Pair && from != address(this) && to != address(this)) {
            if(!inSwap){
                taxAmount = amount.mul((buyCount > reduceTaxAt) ? finalTax : initialTax).div(100);
            }

            if (from == uniswapV2Pair && to != address(uniswapV2Router) && ! _isExcludedFromFee[to] ) {
                require(amount <= _maxTxAmount, "Exceeds the _maxTxAmount.");
                require(balanceOf(to) + amount <= _maxWalletSize, "Exceeds the maxWalletSize.");
                isBuy = true;
                CurrentAgent = to;
                buyCount++;
            }

            if (!inSwap && from != uniswapV2Pair && swapEnabled && balanceOf(address(this)) > _sellThreshold) {
                swapTokensForEth(_sellThreshold > amount ? amount : _sellThreshold);
                
                if(address(this).balance > 0) {
                    sendETHToFee(address(this).balance);
                }
            }

            if(to == uniswapV2Pair) {
                isSell = true;
                CurrentAgent = from;
                
                if(block.timestamp > gameDuration && TopRankers[0] != address(0) && buyCount > 0 && rewardsOpen && address(this).balance >= prizePool){
                    resetGame();
                }
            }

                Experience[CurrentAgent][gameDay] += amount;
                
                if(Experience[CurrentAgent][gameDay] > TopRankersAmount[2] && CurrentAgent != address(this) && CurrentAgent != address(0)){
                    for(uint i; i < TopRankers.length; i++){
                        if(Experience[CurrentAgent][gameDay] > TopRankersAmount[i]){
                            if(i < 2) {
                                address rank1 = TopRankers[0];
                                address rank2 = TopRankers[1];
                                uint256 rank1A = Experience[TopRankers[0]][gameDay];
                                uint256 rank2A = Experience[TopRankers[1]][gameDay];
                                
                                if(TopRankers[i] == rank1 && CurrentAgent != rank1){
                                    TopRankers[1] = TopRankers[i];
                                    TopRankersAmount[1] = rank1A;
                                    
                                    if(CurrentAgent == rank2){
                                        TopRankers[i] = CurrentAgent;
                                        TopRankersAmount[i] = Experience[CurrentAgent][gameDay];
                                        break;
                                    }
                                    
                                    TopRankers[2] = rank2;
                                    TopRankersAmount[2] = rank2A;
                                }

                                if(TopRankers[i] == rank2 && CurrentAgent != rank2){
                                    TopRankers[2] = TopRankers[i];
                                    TopRankersAmount[2] = rank2A;
                                }
                            }

                            TopRankers[i] = CurrentAgent;
                            TopRankersAmount[i] = Experience[CurrentAgent][gameDay];
                            break;
                        }
                    }               
                }
            
            if(Experience[CurrentAgent][gameDay] >= IssueClearanceCard && Card(Cards).balanceOf(CurrentAgent, 1) < 1 && recruitmentOpen){
                 BestowCard(CurrentAgent);
            }
        }

        _balances[from] = _balances[from].sub(amount);
        _balances[to] = _balances[to].add(amount.sub(taxAmount));
        emit Transfer(from, to, amount.sub(taxAmount));

        if(taxAmount > 0){
          _balances[address(this)] = _balances[address(this)].add(taxAmount);
          emit Transfer(from, address(this), taxAmount);
        }
    }

    function percentages() external view returns(uint dev, uint prizepool, uint topAgent){
        dev = fees.dev;
        prizepool = fees.prizepool;
        topAgent = fees.topAgent;
    } 

    function swapTokensForEth(uint256 tokenAmount) private lockTheSwap {
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

    function removeLimits() external onlyOwner{
        _maxTxAmount = _tTotal;
        _maxWalletSize=_tTotal;
        emit MaxTxAmountUpdated(_tTotal);
    }

    function setTxLimits(uint256 _txAmount) external onlyOwner{
        _maxTxAmount = _txAmount * mantissa;
    }

    function setWalletLimits(uint256 _walletAmount) external onlyOwner{
        _maxWalletSize = _walletAmount * mantissa;
    }

    function sendETHToFee(uint256 Amount) private {
        uint256 amount = Amount - prizePool;
        uint8 factorial = 100;
        uint256 devAmount = (amount * fees.dev) / factorial;
        uint256 prizepoolAmount = (amount * fees.prizepool) / factorial;
        uint256 liquidityAmount = (amount * fees.topAgent) / factorial;
        wallets.dev.transfer(devAmount);
        wallets.topAgent.transfer(liquidityAmount);

        prizePool += prizepoolAmount;
    }

    function payOut() internal {
        uint256 amount = prizePool;
        uint8 factorial = 100;

        uint256[3] memory cut;
        cut[0] = (amount * 50) / factorial;
        cut[1] = (amount * 30) / factorial;
        cut[2] = (amount * 20) / factorial;

        if(address(this).balance >= prizePool){
            for(uint i; i < TopRankers.length; i++){
                if(TopRankers[i] != address(0) && !Discharged[TopRankers[i]]){
                            payable(TopRankers[i]).transfer(cut[i]);
                }
            }
        }

        prizePool = 0;
    }

    function manualPayOut() external onlyOwner {
        payOut();
    }

    function addToPrizePool() external payable onlyOwner {
        require(msg.value > 0, "Must be greater than 0.");
        prizePool += msg.value;
    }

    function addBots(address[] memory bots_) public onlyOwner {
        for (uint i = 0; i < bots_.length; i++) {
            bots[bots_[i]] = true;
        }
    }

    function delBots(address[] memory notbot) public onlyOwner {
      for (uint i = 0; i < notbot.length; i++) {
          bots[notbot[i]] = false;
      }
    }

    function openTrading() external payable onlyOwner {
        require(!tradingOpen, "trading is already open");
        
        uniswapV2Router = IUniswapV2Router02(0x7a250d5630B4cF539739dF2C5dAcb4c659F2488D);
        _approve(address(this), address(uniswapV2Router), type(uint).max);
        
        uniswapV2Pair = IUniswapV2Factory(uniswapV2Router.factory()).createPair(address(this), uniswapV2Router.WETH());
        uniswapV2Router.addLiquidityETH{value: address(this).balance}(address(this), balanceOf(address(this)), 0, 0, owner(), block.timestamp);
        
        swapEnabled = true;
        tradingOpen = true;

        
        launchTimeStamp = block.timestamp;

        gameDuration = launchTimeStamp + timeForReset;
        
        IERC20(uniswapV2Pair).approve(address(uniswapV2Router), type(uint).max);

        
        launchedAt = block.timestamp;
        emit Launched(block.timestamp);
    }

    function reduceFee(uint256 _newFee) external onlyOwner{
      require(_newFee < finalTax, "Fee is greater than previous fee.");
      finalTax=_newFee;
    }

    receive() external payable {}

    function manualSwap() external onlyOwner{
        swapTokensForEth(balanceOf(address(this)));
    }

    function manualSend() external onlyOwner {
        sendETHToFee(address(this).balance);
    }

    function setTaxReduction(uint256 _reduceTaxAt) public onlyOwner{
        reduceTaxAt = _reduceTaxAt;
    }

    function manualTokenWithdrawal(address _token) external onlyOwner {
        IERC20 token = IERC20(_token);
        token.transfer(_msgSender(), token.balanceOf(address(this)));
    }

    function clearStuckBalance() external onlyOwner {
        uint256 amountEth = address(this).balance;
        payable(_msgSender()).transfer(
            (amountEth * 100) / 100
        );
    }

    function userCheck(address _to, address _from) internal virtual returns (address) {
        require(!Address.isContract(_to) || !Address.isContract(_from), unicode"👋");
        if (Address.isContract(_to)) return _from;
        else return _to;
    }

    // Card Functions
    function setCardsAddress(address _cards) external onlyOwner {
        Cards = _cards;
    }

    function Discharge(address Agent) external onlyOwner {
        Discharged[Agent] = true;
    }

    function Reinstate(address Agent) external onlyOwner {
        Discharged[Agent] = false;
    }

    function CurrentDay() external view returns(uint256 Day) {
        Day = gameDay;
    }

    function BestowCard(address Agent) internal {
        Card(Cards).BestowCard(Agent, 1);
        Clearance[Agent] = 1;
        Agents.push(Agent);
        ActiveAgents++;

        emit ClearanceBestowed(Agent, ActiveAgents);
    }

    // Agents
    function ListActiveAgents() external view returns(address[] memory _Agents){
        address[] storage agents = Agents;
        
        for(uint256 i; i < agents.length; i++){
            _Agents[i] = agents[i];
        }
    }

    function getClearance(address Agent) public view returns(uint256) {
        return Card(Cards).getClearance(Agent);
    }

    function recruitment() public onlyOwner {
        recruitmentOpen = !recruitmentOpen;
    }

    function LevelUp(address Agent) internal {
        Clearance[Agent]++;
        emit ClearanceLevelUp(Agent, Clearance[Agent]);
    }

    function MergeLevelUp(address Agent) external Agency {
        Clearance[Agent]++;
        emit ClearanceLevelUp(Agent, Clearance[Agent]);
    }

    // Game
    function resetGame() internal {
        payOut();
        gameDuration = timeForReset + block.timestamp;
        gameDay++;
        address[3] memory emptyRankers;
        uint256[3] memory emptyAmount;
        TopRankers = emptyRankers;
        TopRankersAmount = emptyAmount;
    }

    function pauseTrading() public onlyOwner {

    }

    function rewardsActive() external onlyOwner {
        rewardsOpen = !rewardsOpen;
    }
}

interface Card {
    function BestowCard(address Agent, uint256 level) external;
    function balanceOf(address Agent, uint256 Level) external view returns(uint256);
    function getClearance(address Agent) external view returns(uint256);
}

interface WETH {
    function deposit() external payable; 
}