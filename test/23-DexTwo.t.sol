// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../src/23-DexTwo.sol";

contract DexTwoTest is Test {
    address player;
    SwappableTokenTwo tokenInstance;
    SwappableTokenTwo tokenInstanceTwo;
    DexTwo target;

    function setUp() public {
        player = vm.addr(1);

        target = new DexTwo();
        tokenInstance = new SwappableTokenTwo(
            address(target),
            "Token 1",
            "TKN1",
            110
        );
        tokenInstanceTwo = new SwappableTokenTwo(
            address(target),
            "Token 2",
            "TKN2",
            110
        );

        target.setTokens(address(tokenInstance), address(tokenInstanceTwo));

        tokenInstance.approve(address(target), 100);
        tokenInstanceTwo.approve(address(target), 100);
        target.add_liquidity(address(tokenInstance), 100);
        target.add_liquidity(address(tokenInstanceTwo), 100);
        tokenInstance.transfer(player, 10);
        tokenInstanceTwo.transfer(player, 10);

        vm.label(address(player), "Player");
    }

    function testDexTwo() public {
        vm.startPrank(address(player));

        address tokenInstanceAddress = address(tokenInstance);
        address tokenInstanceAddressTwo = address(tokenInstanceTwo);

        tokenInstance.approve(player, address(target), 9);
        target.swap(tokenInstanceAddress, tokenInstanceAddressTwo, 9);

        assertTrue(
            IERC20(address(tokenInstance)).balanceOf(address(target)) == 0
        );

        assertTrue(
            IERC20(address(tokenInstanceTwo)).balanceOf(address(target)) == 0
        );

        vm.stopPrank();
    }
}
