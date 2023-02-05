// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../src/25-Motorbike.sol";
import "forge-std/console.sol";

contract PuzzleWalletTest is Test {
    address player;
    Motorbike target;
    Engine ethernautEngine;

    function setUp() public {
        player = vm.addr(1);

        Engine engine = new Engine();
        target = new Motorbike(address(engine));
        ethernautEngine = Engine(payable(address(target)));

        vm.label(address(player), "Player");
        vm.deal(player, 1 ether);
    }

    function testPuzzleWallet() public {
        vm.startPrank(address(player));

        assertTrue(ethernautEngine.upgrader() == player);

        vm.stopPrank();
    }
}
