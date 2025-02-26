// SPDX-License-Identifier: MIT

// ######  ######  #######  #####  #     # ####### #     # 
// #     # #     # #     # #     #  #   #  #     # ##    # 
// #     # #     # #     # #         # #   #     # # #   # 
// ######  ######  #     # #          #    #     # #  #  # 
// #       #   #   #     # #          #    #     # #   # # 
// #       #    #  #     # #     #    #    #     # #    ## 
// #       #     # #######  #####     #    ####### #     # 

pragma solidity 0.6.12;
 
import "./libs/IBEP20.sol";
import "./libs/SafeBEP20.sol";
import "./libs/IProcyonFarmingReferral.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract ProcyonFarmingReferral is IProcyonFarmingReferral, Ownable {
    using SafeBEP20 for IBEP20;

    mapping(address => bool) public operators;
    mapping(address => address) public referrers; 
    mapping(address => uint256) public referralsCount;
    mapping(address => uint256) public totalReferralCommissions;

    event ReferralRecorded(address indexed user, address indexed referrer);
    event ReferralCommissionRecorded(address indexed referrer, uint256 commission);
    event OperatorUpdated(address indexed operator, bool indexed status);

    modifier onlyOperator {
        require(operators[msg.sender], "Operator: caller is not the operator");
        _;
    }

    // Get the referrer address that referred the user
    function getReferrer(address _user) public override view returns (address) {
        return referrers[_user];
    }

    // Update the status of the operator
    function updateOperator(address _operator, bool _status) external onlyOwner {
        operators[_operator] = _status;
        emit OperatorUpdated(_operator, _status);
    }

        function recordReferral(address _user, address _referrer) public override onlyOperator {
        if (_user != address(0)
            && _referrer != address(0)
            && _user != _referrer
            && referrers[_user] == address(0)
        ) {
            referrers[_user] = _referrer;
            referralsCount[_referrer] += 1;
            emit ReferralRecorded(_user, _referrer);
        }
    }

    function recordReferralCommission(address _referrer, uint256 _commission) public override onlyOperator {
        if (_referrer != address(0) && _commission > 0) {
            totalReferralCommissions[_referrer] += _commission;
            emit ReferralCommissionRecorded(_referrer, _commission);
        }
    }

    // Owner can recover tokens that are sent here by mistake
    function recoverBEP20Token(IBEP20 _token, uint256 _amount, address _to) external onlyOwner {
        _token.safeTransfer(_to, _amount);
    }
}