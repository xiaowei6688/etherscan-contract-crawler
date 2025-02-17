// SPDX-License-Identifier: MIT
pragma solidity 0.8.7;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "../interfaces/ICurvePool.sol";
import "../interfaces/ICurveZapper.sol";
import "../interfaces/IFeeDistributor.sol";
import "../interfaces/ISdFraxVault.sol";
import "../interfaces/IUniswapRouter.sol";

contract VeSDTFeeAngleProxyV2 is Ownable {
	using SafeERC20 for IERC20;

    struct CurveExchangeData {
        address pool;
        uint256 fromIndex;
        uint256 toIndex;
    }

	address public constant ANGLE = 0x31429d1856aD1377A8A0079410B297e1a9e214c2;
	address public constant AG_EUR = 0x1a7e4e63778B4f12a199C062f3eFdD288afCBce8;
    address public constant CURVE_ZAPPER = 0x5De4EF4879F4fe3bBADF2227D2aC5d0E2D76C895;
	address public constant FEE_D = 0x29f3dd38dB24d3935CF1bf841e6b2B461A3E5D92;
	address public constant FRAX = 0x853d955aCEf822Db058eb8505911ED77F175b99e;
	address public constant FRAX_3CRV = 0xd632f22692FaC7611d2AA1C0D552930D43CAEd3B;
	address public constant SD_FRAX_3CRV = 0x5af15DA84A4a6EDf2d9FA6720De921E1026E37b7;
	address public constant SUSHI_ROUTER = 0xd9e1cE17f2641f24aE83637ab66a2cca9C378B9F;
	
	uint256 public constant BASE_FEE = 10000;
    uint256 public claimerFee = 100;
	address[] public angleToAgEurPath;
    CurveExchangeData public curveExchangeData;

	constructor(
        address[] memory _angleToAgEurPath,
        CurveExchangeData memory _curveExchangeData
    ) {
		angleToAgEurPath = _angleToAgEurPath;
		curveExchangeData = _curveExchangeData;
		IERC20(ANGLE).safeApprove(SUSHI_ROUTER, type(uint256).max);
        IERC20(AG_EUR).safeApprove(CURVE_ZAPPER, type(uint256).max);
	}

    /// @notice function to send reward
	function sendRewards() external {
		uint256 angleBalance = IERC20(ANGLE).balanceOf(address(this));
        if (angleBalance != 0) {
            // swap ANGLE <-> agEUR on sushiswap
            _swapOnSushi(angleBalance);
		    uint256 agEurBalance = IERC20(AG_EUR).balanceOf(address(this));
            // swap agEUR <-> FRAX on curve
            _swapOnCurve(agEurBalance);
		    uint256 fraxBalance = IERC20(FRAX).balanceOf(address(this));
		    uint256 claimerPart = (fraxBalance * claimerFee) / BASE_FEE;
		    IERC20(FRAX).transfer(msg.sender, claimerPart);
		    IERC20(FRAX).approve(FRAX_3CRV, fraxBalance - claimerPart);
		    ICurvePool(FRAX_3CRV).add_liquidity([fraxBalance - claimerPart, 0], 0);
		    uint256 frax3CrvBalance = IERC20(FRAX_3CRV).balanceOf(address(this));
		    IERC20(FRAX_3CRV).approve(SD_FRAX_3CRV, fraxBalance - claimerPart);
		    ISdFraxVault(SD_FRAX_3CRV).deposit(frax3CrvBalance);
		    IERC20(SD_FRAX_3CRV).transfer(FEE_D, IERC20(SD_FRAX_3CRV).balanceOf(address(this)));
        } 
	}

	/// @notice internal function to swap ANGLE to agEUR on sushi
	/// @dev slippageCRV = 100 for 1% max slippage
	/// @param _amount amount to swap
	function _swapOnSushi(uint256 _amount) internal {
		IUniswapRouter(SUSHI_ROUTER).swapExactTokensForTokens(
			_amount,
			0,
			angleToAgEurPath,
			address(this),
			block.timestamp + 1800
		);
	}

    /// @notice internal function to swap agEUR to FRAX on curve
	/// @param _amount amount to swap
    function _swapOnCurve(uint256 _amount) internal {
        ICurveZapper(CURVE_ZAPPER).exchange(
            curveExchangeData.pool, 
            curveExchangeData.fromIndex,
            curveExchangeData.toIndex,
            _amount,
            0
        );
    }

    /// @notice function to calculate the amount reserved for keepers
	function claimableByKeeper() public view returns (uint256) {
		uint256 angleBalance = IERC20(ANGLE).balanceOf(address(this));
		if (angleBalance == 0) {
			return 0;
		}
		uint256[] memory amounts = IUniswapRouter(SUSHI_ROUTER).getAmountsOut(angleBalance, angleToAgEurPath);

        uint256 fraxAmount = ICurveZapper(CURVE_ZAPPER).get_dy(
            curveExchangeData.pool,
            curveExchangeData.fromIndex, 
            curveExchangeData.toIndex, 
            amounts[angleToAgEurPath.length - 1]
        );
		return (fraxAmount * claimerFee) / BASE_FEE;
	}

    /// @notice function to set a new claimer fee 
	/// @param _claimerFee claimer fee
	function setClaimerFee(uint256 _claimerFee) external onlyOwner {
        require(_claimerFee <= BASE_FEE, ">100%");
		claimerFee = _claimerFee;
	}

    /// @notice function to set the sushiswap Angle <-> agEur swap path  (ANGLE <-> .. <-> AgEur)
	/// @param _path swap path
	function setAngleAgEurPathOnSushi(address[] calldata _path) external onlyOwner {
        require(_path[0] == ANGLE, "wrong initial pair");
        require(_path[_path.length - 1] == AG_EUR, "wrong final pair");
		angleToAgEurPath = _path;
	}

    /// @notice function to set curve exchange data
	/// @param _exchangeData exchange data (pool, fromIndex, toIndex)
    function setCurveExchangeData(CurveExchangeData calldata _exchangeData) external onlyOwner {
        address pool = _exchangeData.pool;
        require(pool != address(0), "zero address");
        curveExchangeData = _exchangeData;
    }
    
    /// @notice function to recover any ERC20 and send them to the owner
	/// @param _token token address
	/// @param _amount amount to recover
	function recoverERC20(address _token, uint256 _amount) external onlyOwner {
		IERC20(_token).transfer(owner(), _amount);
	}
}