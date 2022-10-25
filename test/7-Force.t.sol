// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../src/7-Force.sol";
import "../src/attackers/7-ForceAttacker.sol";

contract ForceTest is Test {
    Force public target;
    ForceAttacker public attacker;

    address player = vm.addr(1);

    function setUp() public {
        target = new Force();
        attacker = new ForceAttacker();
        vm.label(address(target), "Challenge");
        vm.label(address(player), "Player");
        vm.deal(player, 1);
    }

    function testForce() public {
        vm.startPrank(address(player));

        attacker.boom{value: 1}(address(target));

        assertTrue(address(target).balance > 0);
    }
}
