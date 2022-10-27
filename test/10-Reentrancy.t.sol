// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../src/10-Reentrancy.sol";
import "../src/attackers/10-ReentrancyAttacker.sol";

contract ReentrancyTest is Test {
    Reentrance public target;
    ReentrancyAttacker public attacker;

    address player = vm.addr(1);

    function setUp() public {
        target = new Reentrance();
        attacker = new ReentrancyAttacker(address(target), player);
        vm.label(address(target), "Challenge");
        vm.label(address(player), "Player");
        vm.label(address(attacker), "Attacker");
        vm.deal(player, 1 ether);

        target.donate{value: 9 ether}(address(0));
    }

    function testReentrancy() public {
        vm.startPrank(address(player));

        attacker.attack{value: 1 ether}();
        attacker.withdraw();

        assertTrue(address(target).balance == 0);
        assertTrue(player.balance == 10 ether);
    }
}
