// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts-upgradeable/security/PausableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/access/AccessControlEnumerableUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/proxy/utils/Initializable.sol";
import "@openzeppelin/contracts-upgradeable/security/ReentrancyGuardUpgradeable.sol";

import "@openzeppelin/contracts-upgradeable/token/ERC20/IERC20Upgradeable.sol";

/// @custom:security-contact [email protected]
contract BombDepositHandler is
    Initializable,
    PausableUpgradeable,
    AccessControlEnumerableUpgradeable
{
    bytes32 public constant OPERATOR_ROLE = keccak256("OPERATOR_ROLE");

    event LogCollected(
        address indexed caller,
        address indexed user,
        address indexed token,
        uint256 amount
    );

    event ExecutedWithdraw(
        address indexed token,
        address indexed to,
        uint256 amount
    );

    /// @custom:oz-upgrades-unsafe-allow constructor
    constructor() {
        _disableInitializers();
    }

    function initialize(address _admin) public initializer {
        __Pausable_init();
        __AccessControl_init();

        _grantRole(DEFAULT_ADMIN_ROLE, _admin);
        _grantRole(OPERATOR_ROLE, _admin);
    }

    function executeWithdraw(
        address _to,
        IERC20Upgradeable _token,
        uint256 _amount
    ) external onlyRole(OPERATOR_ROLE) {
        require(
            _amount <= _token.balanceOf(address(this)),
            "Not enough assets to withdraw"
        );
        require(_token.transfer(_to, _amount), "Could not transfer tokens");

        emit ExecutedWithdraw(address(_token), _to, _amount);
    }

    function collect(
        address _address,
        address _token
    ) external onlyRole(OPERATOR_ROLE) {
        _collect(_address, _token);
    }

    function collectMultiple(
        address[] calldata _address,
        address[] calldata _token
    ) external onlyRole(OPERATOR_ROLE) {
        // TODO: This can be optimized a fair bit, but this is safer and simpler for now
        uint256 len = _address.length;
        for (uint256 i = 0; i < len; i++) {
            _collect(_address[i], _token[i]);
        }
    }

    function _collect(address _address, address _token) internal {
        uint256 _balance = IERC20Upgradeable(_token).balanceOf(_address);
        require(_balance > 0, "No balance to collect");
        require(
            IERC20Upgradeable(_token).transferFrom(
                _address,
                address(this),
                _balance
            ),
            "Could not transfer tokens"
        );

        emit LogCollected(msg.sender, _address, _token, _balance);
    }

    function pause() public onlyRole(DEFAULT_ADMIN_ROLE) {
        _pause();
    }

    function unpause() public onlyRole(DEFAULT_ADMIN_ROLE) {
        _unpause();
    }

    function governanceRecoverToken(
        IERC20Upgradeable _token,
        address _to
    ) external onlyRole(DEFAULT_ADMIN_ROLE) {
        require(
            _token.transfer(_to, _token.balanceOf(address(this))),
            "Token could not be transferred"
        );
    }

    function governanceRecoverNative(
        address payable _to
    ) external onlyRole(DEFAULT_ADMIN_ROLE) {
        (bool sent, bytes memory data) = _to.call{value: getBalance()}("");
        require(sent, "Failed to send native");
    }

    receive() external payable {}

    fallback() external payable {}

    function getBalance() public view returns (uint) {
        return address(this).balance;
    }
}