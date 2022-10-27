// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../src/13-GatekeeperOne.sol";
import "../src/attackers/13-GatekeeperOneAttacker.sol";

contract GatekeeperOneTest is Test {
    event log(bytes32);
    GatekeeperOne public target;
    GatekeeperOneAttacker public attacker;
    address player = vm.addr(1);

    function setUp() public {
        target = new GatekeeperOne();
        attacker = new GatekeeperOneAttacker(address(target));

        vm.label(address(target), "Challenge");
        vm.label(address(player), "Player");
        vm.label(address(attacker), "Attacker");
    }

    function testGatekeeperOne() public {
        vm.startPrank(player);

        attacker.attack();

        assertTrue(target.entrant() == tx.origin);
    }
}
