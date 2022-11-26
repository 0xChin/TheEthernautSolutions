// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../src/22-Dex.sol";

contract DexTest is Test {
    address player;
    SwappableToken tokenInstance;
    SwappableToken tokenInstanceTwo;
    Dex target;

    function setUp() public {
        player = vm.addr(1);

        tokenInstance = new SwappableToken("Token 1", "TKN1", 110);
        tokenInstanceTwo = new SwappableToken("Token 2", "TKN2", 110);
        target = new Dex(address(tokenInstance), address(tokenInstanceTwo));

        tokenInstance.approve(address(target), 100);
        tokenInstanceTwo.approve(address(target), 100);
        target.add_liquidity(address(tokenInstance), 100);
        target.add_liquidity(address(tokenInstanceTwo), 100);
        tokenInstance.transfer(player, 10);
        tokenInstanceTwo.transfer(player, 10);

        vm.label(address(player), "Player");
    }

    function testDex() public {
        vm.startPrank(address(player));

        target.approve(player, 100);
        tokenInstance.transferFrom(address(target), player, 100);
        tokenInstanceTwo.transferFrom(address(target), player, 100);

        assertTrue(
            IERC20(address(tokenInstance)).balanceOf(address(target)) == 0
        );

        assertTrue(
            IERC20(address(tokenInstanceTwo)).balanceOf(address(target)) == 0
        );

        vm.stopPrank();
    }
}
