// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../src/4-Telephone.sol";
import "../src/attackers/4-TelephoneAttacker.sol";

contract TelephoneTest is Test {
    Telephone public target;
    TelephoneAttacker public attacker;
    address player = vm.addr(1);

    function setUp() public {
        target = new Telephone();
        attacker = new TelephoneAttacker(address(target), player);

        vm.label(address(target), "Challenge");
        vm.label(address(player), "Player");
        vm.label(address(attacker), "Attacker Contract");
    }

    function testTelephone() public {
        vm.startPrank(address(player));

        attacker.attack();

        assertTrue(target.owner() == address(player));
    }
}
