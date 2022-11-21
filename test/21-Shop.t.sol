// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../src/21-Shop.sol";
import "../src/attackers/21-ShopAttacker.sol";

contract ShopTest is Test {
    Shop public target;
    ShopAttacker public attacker;
    address player = vm.addr(1);

    function setUp() public {
        target = new Shop();
        attacker = new ShopAttacker(address(target));

        vm.label(address(target), "Challenge");
        vm.label(address(player), "Player");
    }

    function testShop() public {
        vm.startPrank(address(player));

        attacker.attack();

        assertTrue(target.price() < 100);

        vm.stopPrank();
    }
}
