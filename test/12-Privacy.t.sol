// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../src/12-Privacy.sol";

contract FalloutTest is Test {
    event log(bytes32);
    Privacy public target;
    address player = vm.addr(1);

    function setUp() public {
        target = new Privacy();

        vm.label(address(target), "Challenge");
        vm.label(address(player), "Player");
    }

    function testPrivacy() public {
        vm.startPrank(address(player));

        target.setupChallenge();

        bytes32 data = vm.load(address(target), bytes32(uint256(5)));
        target.unlock(bytes16(data));

        assertFalse(target.locked());
    }
}
