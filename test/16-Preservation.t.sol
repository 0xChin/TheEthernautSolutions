// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../src/16-Preservation.sol";
import "../src/attackers/16-PreservationAttacker.sol";

contract PreservationTest is Test {
    Preservation public target;
    PreservationAttacker public attacker;
    address player = vm.addr(1);

    function setUp() public {
        target = new Preservation(
            address(new LibraryContract()),
            address(new LibraryContract())
        );

        attacker = new PreservationAttacker(address(target));

        vm.label(address(target), "Challenge");
        vm.label(address(player), "Player");
    }

    function testPreservation() public {
        vm.startPrank(address(player));

        attacker.attack();

        assertTrue(target.owner() == player);
    }
}
