// SPDX-License-Identifier: MIT
pragma solidity >=0.8.0;

import {
    IArrakisV2
} from "@arrakisfi/v2-core/contracts/interfaces/IArrakisV2.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import {FullMath} from "@arrakisfi/v3-lib-0.8/contracts/FullMath.sol";

function _burn(IArrakisV2 vault_, address me)
    returns (
        uint256 amount0,
        uint256 amount1,
        uint256 balance
    )
{
    balance = IERC20(address(vault_)).balanceOf(me);
    (amount0, amount1) = vault_.burn(balance, me);
}

function _getInits(
    uint256 mintAmount_,
    uint256 amount0_,
    uint256 amount1_
) pure returns (uint256 init0, uint256 init1) {
    init0 = FullMath.mulDiv(amount0_, 1e18, mintAmount_);
    init1 = FullMath.mulDiv(amount1_, 1e18, mintAmount_);
}

function _getEmolument(uint256 allocation_, uint16 emolument_)
    pure
    returns (uint256)
{
    return (allocation_ * emolument_) / 10000;
}

function _requireTokensAllocationsGtZero(uint256 amount0_, uint256 amount1_)
    pure
{
    require(amount0_ > 0 || amount1_ > 0, "PALMTerms: no tokens allocations.");
}

function _requireTknOrder(address token0_, address token1_) pure {
    require(token0_ < token1_, "PALMTerms: tokens order inverted.");
}