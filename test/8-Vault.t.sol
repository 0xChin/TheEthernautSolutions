// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../src/8-Vault.sol";

contract VaultTest is Test {
    using stdStorage for StdStorage;

    Vault public target;
    address player = vm.addr(1);

    function setUp() public {
        target = new Vault(bytes32(abi.encodePacked("A difficult password")));

        vm.label(address(target), "Challenge");
        vm.label(address(player), "Player");
    }

    function testVault() public {
        vm.startPrank(address(player));
        bytes32 answer = vm.load(
            address(target),
            bytes32(abi.encodePacked(uint256(1)))
        );

        target.unlock(answer);

        assertFalse(target.locked());
    }
}
