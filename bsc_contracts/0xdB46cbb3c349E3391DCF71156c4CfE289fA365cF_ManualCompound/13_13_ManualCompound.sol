// SPDX-License-Identifier: MIT

pragma solidity ^0.8.0;

import { Ownable } from "@openzeppelin/contracts/access/Ownable.sol";
import { SafeERC20 } from "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import { IERC20Metadata } from "@openzeppelin/contracts/token/ERC20/extensions/IERC20Metadata.sol";
import { Address } from "@openzeppelin/contracts/utils/Address.sol";
import { IERC20, ERC20 } from "@openzeppelin/contracts/token/ERC20/ERC20.sol";

import "../interfaces/IMasterMagpie.sol";
import "../interfaces/ISimpleHelper.sol";
import "../interfaces/IConvertor.sol";
import "../interfaces/ILocker.sol";

contract ManualCompound is Ownable {
    using SafeERC20 for IERC20;

    address public immutable masterMagpie;

    struct Reward {
        address tokenAddress;
        address tokenHelper;
        address convertor;
        address locker;
    }

    Reward[] public rewards;
    mapping(address => bool) public compoundableRewards;

    /* ============ Events ============ */

    event HelperSet(uint256 indexed index, address helper);
    event ConvertorSet(uint256 indexed index, address conveter);
    event LockerSet(uint256 indexed index, address locker);
    event RewardAdded(address indexed rewardToken);
    event RewardRemoved(uint256 indexed index, address rewardToken);
    event Compounded(address indexed user, uint256 rewardLength, bool forLock);

    /* ============ Errors ============ */

    error InvalidIndex();
    error InvalidReward();

    /* ============ Constructor ============ */

    constructor(
        address _masterMagpie
    ) {
        masterMagpie = _masterMagpie;
    }

    /* ============ External Functions ============ */

    function setHelper(uint256 _index, address _helper) external onlyOwner {
        if(_index >= rewards.length) revert InvalidIndex();
        rewards[_index].tokenHelper = _helper;
        emit HelperSet(_index, _helper);
    }

    function setConvertor(uint256 _index, address _convertor) external onlyOwner {
        if(_index >= rewards.length) revert InvalidIndex();
        rewards[_index].convertor = _convertor;
        emit ConvertorSet(_index, _convertor);
    }

    function setLocker(uint256 _index, address _locker) external onlyOwner {
        if(_index >= rewards.length) revert InvalidIndex();
        rewards[_index].locker = _locker;
        emit LockerSet(_index, _locker);
    }

    function addReward(address _tokenAddress, address _tokenHelper, address _convertor, address _locker) external onlyOwner {
        rewards.push(Reward({
            tokenAddress : _tokenAddress,
            tokenHelper : _tokenHelper,
            convertor : _convertor,
            locker : _locker
        }));

        compoundableRewards[_tokenAddress] = true;
        emit RewardAdded(_tokenAddress);
    }

    function removeReward(uint256 _index, address _tokenAddress) external onlyOwner {
        if(_index >= rewards.length) revert InvalidIndex();
        if(rewards[_index].tokenAddress != _tokenAddress) revert InvalidReward();
        for (uint i = _index; i < rewards.length - 1; i++) {
           rewards[i] = rewards[i+1];
        }
        rewards.pop();

        compoundableRewards[_tokenAddress] = false;
        emit RewardRemoved(_index, _tokenAddress);
    }

    function getRewardLength() external view returns(uint256) {
        return rewards.length;
    }

    function getRewardByIndex(uint256 _index) external view
    returns(
        uint256 index,
        address tokenAddress,
        address tokenHelper,
        address convertor,
        address locker
    ) {
        if(_index >= rewards.length) revert InvalidIndex();
        index = _index;
        tokenAddress = rewards[_index].tokenAddress;
        tokenHelper = rewards[_index].tokenHelper;
        convertor = rewards[_index].convertor;
        locker = rewards[_index].locker;
    }

    // @param _lps lp pool to claim reward from master magpie
    // @param _convertRatio the percentage of total collected wom to convert to mWom with smart convert
    // @param _minRec the expected min mWom to receive upon convert with smart wom convert
    // @param _lockMgp the flag for if MGP should be locked
    function compound(address[] calldata _lps, uint256 _convertRatio, uint256 _minRec, bool _lockMgp) external {
        uint256 rewardTokensLength = rewards.length;        
        IMasterMagpie(masterMagpie).multiclaimOnBehalf(_lps, msg.sender);
        address[] memory bonusTokenAddresses;
        // send none compoundable reward back to caller
        for(uint256 i; i < _lps.length; i++) {
            (bonusTokenAddresses, ) = IMasterMagpie(masterMagpie).rewarderBonusTokenInfo(_lps[i]);
            for (uint j; j < bonusTokenAddresses.length; j++) {
                if (!compoundableRewards[bonusTokenAddresses[j]]) {
                    uint256 rewardBalance = IERC20(bonusTokenAddresses[j]).balanceOf(address(this));
                    IERC20(bonusTokenAddresses[j]).safeTransfer(msg.sender, rewardBalance);
                }
            }
        }
        for (uint256 i; i< rewardTokensLength; i++) {
            address _tokenAddress = rewards[i].tokenAddress;
            address _helperAddress = rewards[i].tokenHelper;
            address _convertor = rewards[i].convertor;
            address _locker = rewards[i].locker;
            uint256 receivedBalance = IERC20(_tokenAddress).balanceOf(address(this));

            if (receivedBalance > 0) {
                if (_convertor != address(0)) {
                    IERC20(_tokenAddress).safeApprove(_convertor, receivedBalance);
                    IConvertor(_convertor).convertFor(receivedBalance, _convertRatio, _minRec, msg.sender, true);
                } else if (_locker != address(0) && _lockMgp) {
                    IERC20(_tokenAddress).safeApprove(_locker, receivedBalance);
                    ILocker(_locker).lockFor(receivedBalance, msg.sender);                        
                } else if (_helperAddress != address(0)) { 
                    IERC20(_tokenAddress).safeApprove(_helperAddress, receivedBalance);
                    ISimpleHelper(_helperAddress).depositFor(receivedBalance, msg.sender);
                } else {
                    IERC20(_tokenAddress).safeTransfer(msg.sender, receivedBalance);
                }
            }
        }

        emit Compounded(msg.sender, rewardTokensLength, _lockMgp);
    }
}