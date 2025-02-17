// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract ZboPeg is Ownable, ReentrancyGuard {
    address public zbo;
    address public zcr;
    address public dead = 0x000000000000000000000000000000000000dEaD;
    using SafeMath for uint256;

    constructor(address _zbo, address _zcr) {
        zbo = _zbo;
        zcr = _zcr;
    }
     
    event TokenSwapComplete(address user, uint256 zbo, uint256 zcr);
    event WithDrawRestComplete(address user, uint256 amount);
    event Burn(address user, uint256 amount);

    function deposit(uint256 amount) external nonReentrant {
        uint256 _zcr =  amount.mul(10);
        require(IERC20(zbo).transferFrom(msg.sender, address(this), amount));
        require(IERC20(zcr).balanceOf(address(this)) >= _zcr);
        require(IERC20(zcr).transfer(msg.sender,_zcr), "the transfer failed");        
        emit TokenSwapComplete(msg.sender, amount, _zcr);
    }

    function withDrawRest() external onlyOwner {
        uint256 amount = IERC20(zcr).balanceOf(address(this));
        require(IERC20(zcr).transfer(msg.sender, amount), "the transfer failed");
        emit WithDrawRestComplete(msg.sender, amount);
    }

    function burn() external onlyOwner {
        uint256 amount = IERC20(zbo).balanceOf(address(this));
        require(IERC20(zbo).transfer(dead, amount), "the transfer failed");
        emit Burn(msg.sender, amount);
    }    
}