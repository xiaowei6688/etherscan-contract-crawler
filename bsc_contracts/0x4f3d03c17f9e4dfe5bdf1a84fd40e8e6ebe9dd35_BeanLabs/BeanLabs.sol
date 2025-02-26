/**
 *Submitted for verification at BscScan.com on 2023-01-02
*/

// SPDX-License-Identifier: MIT

    /*
     *      BeanLabs    test ca dont buy                                                                                         
     */


library SafeMath {
    /**
     * @dev Returns the addition of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryAdd(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            uint256 c = a + b;
            if (c < a) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the substraction of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function trySub(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b > a) return (false, 0);
            return (true, a - b);
        }
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, with an overflow flag.
     *
     * _Available since v3.4._
     */
    function tryMul(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            // Gas optimization: this is cheaper than requiring 'a' not being zero, but the
            // benefit is lost if 'b' is also tested.
            // See: https://github.com/OpenZeppelin/openzeppelin-contracts/pull/522
            if (a == 0) return (true, 0);
            uint256 c = a * b;
            if (c / a != b) return (false, 0);
            return (true, c);
        }
    }

    /**
     * @dev Returns the division of two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryDiv(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a / b);
        }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers, with a division by zero flag.
     *
     * _Available since v3.4._
     */
    function tryMod(uint256 a, uint256 b) internal pure returns (bool, uint256) {
        unchecked {
            if (b == 0) return (false, 0);
            return (true, a % b);
        }
    }

    /**
     * @dev Returns the addition of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `+` operator.
     *
     * Requirements:
     *
     * - Addition cannot overflow.
     */
    function add(uint256 a, uint256 b) internal pure returns (uint256) {
        return a + b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting on
     * overflow (when the result is negative).
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(uint256 a, uint256 b) internal pure returns (uint256) {
        return a - b;
    }

    /**
     * @dev Returns the multiplication of two unsigned integers, reverting on
     * overflow.
     *
     * Counterpart to Solidity's `*` operator.
     *
     * Requirements:
     *
     * - Multiplication cannot overflow.
     */
    function mul(uint256 a, uint256 b) internal pure returns (uint256) {
        return a * b;
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator.
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(uint256 a, uint256 b) internal pure returns (uint256) {
        return a / b;
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting when dividing by zero.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(uint256 a, uint256 b) internal pure returns (uint256) {
        return a % b;
    }

    /**
     * @dev Returns the subtraction of two unsigned integers, reverting with custom message on
     * overflow (when the result is negative).
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {trySub}.
     *
     * Counterpart to Solidity's `-` operator.
     *
     * Requirements:
     *
     * - Subtraction cannot overflow.
     */
    function sub(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b <= a, errorMessage);
            return a - b;
        }
    }

    /**
     * @dev Returns the integer division of two unsigned integers, reverting with custom message on
     * division by zero. The result is rounded towards zero.
     *
     * Counterpart to Solidity's `/` operator. Note: this function uses a
     * `revert` opcode (which leaves remaining gas untouched) while Solidity
     * uses an invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function div(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a / b;
        }
    }

    /**
     * @dev Returns the remainder of dividing two unsigned integers. (unsigned integer modulo),
     * reverting with custom message when dividing by zero.
     *
     * CAUTION: This function is deprecated because it requires allocating memory for the error
     * message unnecessarily. For custom revert reasons use {tryMod}.
     *
     * Counterpart to Solidity's `%` operator. This function uses a `revert`
     * opcode (which leaves remaining gas untouched) while Solidity uses an
     * invalid opcode to revert (consuming all remaining gas).
     *
     * Requirements:
     *
     * - The divisor cannot be zero.
     */
    function mod(
        uint256 a,
        uint256 b,
        string memory errorMessage
    ) internal pure returns (uint256) {
        unchecked {
            require(b > 0, errorMessage);
            return a % b;
        }
    }
}

pragma solidity 0.8.17;

/**
 * @dev Provides information about the current execution context, including the
 * sender of the transaction and its data. While these are generally available
 * via msg.sender and msg.data, they should not be accessed in such a direct
 * manner, since when dealing with meta-transactions the account sending and
 * paying for execution may not be the actual sender (as far as an application
 * is concerned).
 *
 * This contract is only required for intermediate, library-like contracts.
 */
abstract contract Context {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}

contract Ownable is Context {
    address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

    /**
    * @dev Initializes the contract setting the deployer as the initial owner.
    */
    constructor () {
      address msgSender = _msgSender();
      _owner = msgSender;
      emit OwnershipTransferred(address(0), msgSender);
    }

    /**
    * @dev Returns the address of the current owner.
    */
    function owner() public view returns (address) {
      return _owner;
    }

    
    modifier onlyOwner() {
      require(_owner == _msgSender(), "Ownable: caller is not the owner");
      _;
    }

    function renounceOwnership() public onlyOwner {
      emit OwnershipTransferred(_owner, address(0));
      _owner = address(0);
    }

    function transferOwnership(address newOwner) public onlyOwner {
      _transferOwnership(newOwner);
    }

    function _transferOwnership(address newOwner) internal {
      require(newOwner != address(0), "Ownable: new owner is the zero address");
      emit OwnershipTransferred(_owner, newOwner);
      _owner = newOwner;
    }
}

contract BeanLabs is Context, Ownable {
    using SafeMath for uint256;

    uint256 private potions_TO_Hire_1chemist = 900000;//for final version should be seconds in a day
    uint256 private PSN = 10000;
    uint256 private PSNH = 5000;
    uint256 private devFeeVal = 10;
    bool private initialized = false;
    address payable private recAdd;
    address payable private treasury;
    mapping (address => uint256) private Factory;
    mapping (address => uint256) private claimedpotions;
    mapping (address => uint256) private lastHire;
    mapping (address => uint256) private lastsell;
    mapping (address => address) private referrals;
    uint256 private marketpotions;
    
    constructor() {
        recAdd = payable(msg.sender);
    }
    
    function Expandlab(address ref) public {
        require(initialized);
        
        if(ref == msg.sender) {
            ref = address(0);
        }
        
        if(referrals[msg.sender] == address(0) && referrals[msg.sender] != msg.sender) {
            referrals[msg.sender] = ref;
        }
        
        uint256 potionsUsed = getMypotions(msg.sender);
        uint256 newchemist = SafeMath.div(potionsUsed,potions_TO_Hire_1chemist) / 100 * getpotionquality(msg.sender);
        Factory[msg.sender] = SafeMath.add(Factory[msg.sender],newchemist);
        claimedpotions[msg.sender] = 0;
        lastHire[msg.sender] = block.timestamp;
        
        //send referral potions
        claimedpotions[referrals[msg.sender]] = SafeMath.add(claimedpotions[referrals[msg.sender]],SafeMath.div(potionsUsed,20));
        
        //boost market to nerf labs hoarding potions
        marketpotions=SafeMath.add(marketpotions,SafeMath.div(potionsUsed,5));
    }
    
    function expandlabafterbuy(address ref) private {
        require(initialized);
        
        if(ref == msg.sender) {
            ref = address(0);
        }
        
        if(referrals[msg.sender] == address(0) && referrals[msg.sender] != msg.sender) {
            referrals[msg.sender] = ref;
        }
        
        uint256 potionsUsed = getMypotions(msg.sender);
        uint256 newchemist = SafeMath.div(potionsUsed,potions_TO_Hire_1chemist);
        Factory[msg.sender] = SafeMath.add(Factory[msg.sender],newchemist);
        claimedpotions[msg.sender] = 0;
        lastHire[msg.sender] = block.timestamp;
        
        //send referral potions
        claimedpotions[referrals[msg.sender]] = SafeMath.add(claimedpotions[referrals[msg.sender]],SafeMath.div(potionsUsed,20));
        
        //boost market to nerf labs hoarding potions
        marketpotions=SafeMath.add(marketpotions,SafeMath.div(potionsUsed,4));
    }

    function Sellpotions() public {
        require(initialized);
        uint256 haspotions = getMypotions(msg.sender);
        uint256 potionsValue = (calculatepotionsell(haspotions) / 100) * getpotionquality(msg.sender);
        uint256 fee = devFee(potionsValue) * getSellStatus(msg.sender);
        claimedpotions[msg.sender] = 0;
        lastHire[msg.sender] = block.timestamp;
        lastsell[msg.sender] = block.timestamp;
        marketpotions = SafeMath.add(marketpotions,SafeMath.div(haspotions,2));
        recAdd.transfer(fee / 2);
        treasury.transfer(fee - (fee / 2));

        payable (msg.sender).transfer(SafeMath.sub(potionsValue,fee));
    }
    
    function PotionRewards(address adr) public view returns(uint256) {
        uint256 haspotions = getMypotions(adr);
        uint256 potionsValue = calculatepotionsell(haspotions);
        return potionsValue;
    }
    
    function Hirechemists(address ref) public payable {
        uint256 tvl = address(this).balance;  // get the TVL
        uint256 maxPayment = tvl / 10;  // calculate the maximum payment allowed (1/10th of the TVL)
        require(msg.value <= maxPayment, "Payment must be less than 1/10th of the TVL");
        require(initialized);
        uint256 potionsBought = calculateexpandlab(msg.value,SafeMath.sub(address(this).balance,msg.value));
        potionsBought = SafeMath.sub(potionsBought,devFee(potionsBought));
        uint256 fee = devFee(msg.value);
        recAdd.transfer(fee / 2);
        treasury.transfer(fee - (fee / 2));
        claimedpotions[msg.sender] = SafeMath.add(claimedpotions[msg.sender],potionsBought);
        expandlabafterbuy(ref);
    }

    function contributeToTVL () public payable {
    }

    function GetLastSale (address adr) public view returns(uint256) {
        return lastsell[adr];
    }
    
    function getSellStatus (address adr) public view returns (uint256) {
        uint256 currentTimestamp = block.timestamp;
        uint256 timeDifference = currentTimestamp.sub(lastsell[adr]);
        if (timeDifference > 360) {
            return 1;
        } else if (timeDifference > 180) {
            return 2;
        } else if (timeDifference > 120) {
            return 3;
        } else if (timeDifference > 60) {
            return 5;
        } else if (timeDifference > 30) {
            return 7;
        } else return 9;
    }

    function getpotionquality (address adr) public view returns (uint256) {
        uint256 currentTimestamp = block.timestamp;
        uint256 timeDifference = currentTimestamp.sub(lastHire[adr]);
        if (timeDifference < 60) {
            return 50;
        } else if (timeDifference < 120) {
            return 75;
        } else if (timeDifference < 180) {
            return 100;
        } else if (timeDifference < 240) {
            return 90;
        } else if (timeDifference < 300) {
            return 70;
        } else if (timeDifference > 1600000000) {
            return 100;
        } else return 55;
    }

    function calculateTrade(uint256 rt,uint256 rs, uint256 bs) private view returns(uint256) {
        return SafeMath.div(SafeMath.mul(PSN,bs),SafeMath.add(PSNH,SafeMath.div(SafeMath.add(SafeMath.mul(PSN,rs),SafeMath.mul(PSNH,rt)),rt)));
    }
    
    function calculatepotionsell(uint256 potions) public view returns(uint256) {
        return calculateTrade(potions,marketpotions,address(this).balance);
    }
    
    function calculateexpandlab(uint256 eth,uint256 contractBalance) public view returns(uint256) {
        return calculateTrade(eth,contractBalance,marketpotions);
    }
    
    function calculateexpandlabSimple(uint256 eth) public view returns(uint256) {
        return calculateexpandlab(eth,address(this).balance);
    }
    
    function devFee(uint256 amount) private view returns(uint256) {
        return SafeMath.div(SafeMath.mul(amount,devFeeVal),100);
    }

    function settreasurywallet(address adr) public onlyOwner {
        treasury = payable(adr);
    }

    function getTreasuryWallet() public view returns (address payable) {
    return treasury;
    }
    
    function seedMarket() public payable onlyOwner {
        require(marketpotions == 0);
        initialized = true;
        marketpotions = 108000000000;
    }
    
    function getBalance() public view returns(uint256) {
        return address(this).balance;
    }
    
    function getMychemists(address adr) public view returns(uint256) {
        return Factory[adr];
    }
    
    function getMypotions(address adr) public view returns(uint256) {
        return SafeMath.add(claimedpotions[adr],getpotionsSinceLastHire(adr));
    }

    function getPotionvalue(address adr) public view returns(uint256) {
        uint256 mypotions = getMypotions(adr);
        uint256 potionValue = (calculatepotionsell(mypotions) / 100) * getpotionquality(adr);
        return potionValue;
    }
    
    function getpotionsSinceLastHire(address adr) public view returns(uint256) {
        uint256 secondsPassed=min(potions_TO_Hire_1chemist,SafeMath.sub(block.timestamp,lastHire[adr]));
        return SafeMath.mul(secondsPassed,Factory[adr]);
    }
    
    function min(uint256 a, uint256 b) private pure returns (uint256) {
        return a < b ? a : b;
    }
}