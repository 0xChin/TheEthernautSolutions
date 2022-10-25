// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../src/3-Coinflip.sol";
import "../src/attackers/3-CoinflipAttacker.sol";

contract CoinflipTest is Test {
    CoinFlip public target;
    CoinFlipAttacker public attacker;
    address player = vm.addr(1);

    function setUp() public {
        target = new CoinFlip();
        attacker = new CoinFlipAttacker(address(target));

        vm.label(address(target), "Challenge");
        vm.label(address(attacker), "Attacker Contract");
        vm.label(address(player), "Player");
    }

    function testCoinflip() public {
        vm.startPrank(address(player));

        for (uint256 i = 0; i < 10; i++) {
            attacker.attack();
            vm.roll(block.number + 1);
        }

        assertTrue(target.consecutiveWins() == 10);
    }
}
