// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../src/11-Elevator.sol";
import "../src/attackers/11-ElevatorAttacker.sol";

contract ElevatorTest is Test {
    Elevator public target;
    ElevatorAttacker public attacker;
    address player = vm.addr(1);

    function setUp() public {
        target = new Elevator();
        attacker = new ElevatorAttacker(address(target));

        vm.label(address(target), "Challenge");
        vm.label(address(player), "Player");
        vm.label(address(attacker), "Attacker");
    }

    function testElevator() public {
        vm.startPrank(address(player));

        attacker.attack();

        assertTrue(target.top());
    }
}
