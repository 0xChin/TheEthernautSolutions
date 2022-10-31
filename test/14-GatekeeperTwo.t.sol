// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../src/14-GatekeeperTwo.sol";
import "../src/attackers/14-GatekeeperTwoAttacker.sol";

contract GatekeeperTwoTest is Test {
    GatekeeperTwo public target;
    GatekeeperTwoAttacker public attacker;
    address player = vm.addr(1);

    function setUp() public {
        target = new GatekeeperTwo();

        vm.label(address(target), "Challenge");
        vm.label(address(player), "Player");
        vm.label(address(attacker), "Attacker");
    }

    function testGatekeeperTwo() public {
        vm.startPrank(player, player);

        new GatekeeperTwoAttacker(address(target));

        assertTrue(target.entrant() == player);
    }
}
