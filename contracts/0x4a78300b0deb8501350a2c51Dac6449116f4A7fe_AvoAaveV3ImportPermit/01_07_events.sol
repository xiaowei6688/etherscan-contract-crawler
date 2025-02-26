//SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract Events {
	event LogAaveV3ImportWithPermit(
		address indexed user,
		address[] atokens,
		string[] supplyIds,
		string[] borrowIds,
		uint256[] flashLoanFees,
		uint256[] supplyAmts,
		uint256[] borrowAmts
	);
	event LogAaveV3ImportWithPermitAndCollateral(
		address indexed user,
		address[] atokens,
		string[] supplyIds,
		string[] borrowIds,
		uint256[] flashLoanFees,
		uint256[] supplyAmts,
		uint256[] borrowAmts,
		bool[] enableCollateral
	);
}