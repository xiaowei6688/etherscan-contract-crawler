// SPDX-License-Identifier: Unlicensed.
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";

contract ARTXVesting is Ownable {
    using SafeERC20 for IERC20;
    address public immutable ARTX;
	
    uint256 constant public CHECKPOINT = 1 weeks; 
    uint256 constant public VESTING_DAYS = 3 weeks; 
	
    uint256 public initTimestamp;
    uint256 public totalContribution;

    mapping(address => uint256) public contributors;
    mapping(address => uint256) public claimedBalance;
	
	event VestingInitialized();
    event AmountClaimed(address account, uint256 amount);
	
    constructor(address _ARTX) {
        require(_ARTX != address(0), "Error: Cannot be the null address");
        ARTX = _ARTX;
    }
	
    function addContributors(address[] calldata accounts, uint256[] calldata amounts) external onlyOwner {
        require(initTimestamp == 0, "Error: Vesting has already started");

        require(accounts.length == amounts.length, "Error: Array lengths do not match");

        for(uint256 i = 0; i < accounts.length; i++) {
            require(contributors[accounts[i]] == 0, "Error: Contributor has already been registered");

            contributors[accounts[i]] = amounts[i];
            totalContribution += amounts[i];
        }
    }
	
    function removeContributors(address[] calldata accounts) external onlyOwner {
        require(initTimestamp == 0, "Error: Vesting has already started");

        for (uint256 i = 0; i < accounts.length; i++) {
            uint256 amount = contributors[accounts[i]];
            require(amount > 0, "Error: Contributor not registered");

            contributors[accounts[i]] = 0;
            totalContribution -= amount;
        }
    }

    function initializeVesting() external onlyOwner {
        require(initTimestamp == 0, "Error: Vesting has already started");

        require(IERC20(ARTX).balanceOf(address(this)) >= totalContribution, "Error: Not enough ARTX balance");
        initTimestamp = block.timestamp;

        emit VestingInitialized();
    }

    function claim() external {
        address caller = _msgSender();

        (, uint256 amountToClaim) = getAccruedARTX(caller);
        require(amountToClaim > 0, "Error: No balance to claim");

        claimedBalance[caller] += amountToClaim;

        IERC20(ARTX).safeTransfer(caller, amountToClaim);

        emit AmountClaimed(caller, amountToClaim);
    }

    function getAccruedARTX(address account) public view returns (uint256, uint256) {
        require(initTimestamp != 0, "Error: Vesting period has not started yet");
        require(contributors[account] > 0, "Error: Account is not contributor");
		
        uint256 daysPassed = ((block.timestamp - initTimestamp) / CHECKPOINT) + 1;
		
        uint256 grossAccrued = contributors[account] * daysPassed * 25 / 100;
		        grossAccrued = grossAccrued > contributors[account] ? contributors[account] : grossAccrued;
				
        uint256 netAccrued = grossAccrued - claimedBalance[account];
        return (grossAccrued, netAccrued);
    }
}