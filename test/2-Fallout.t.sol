// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../src/2-Fallout.sol";

contract FalloutTest is Test {
    Fallout public target;
    address player = vm.addr(1);

    function setUp() public {
        target = new Fallout();

        vm.label(address(target), "Challenge");
        vm.label(address(player), "Player");
    }

    function testFallout() public {
        vm.startPrank(address(player));

        target.Fal1out();

        assertTrue(target.owner() == player);
    }
}
