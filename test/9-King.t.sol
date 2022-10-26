// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../src/attackers/9-KingAttacker.sol";

interface IKing {
    function _king() external view returns (address payable);
}

contract KingTest is Test {
    IKing public target;
    KingAttacker public attacker;
    address player = vm.addr(1);

    function setUp() public {
        address deployment = deployCode("9-King.sol:King");
        target = IKing(deployment);
        attacker = new KingAttacker(deployment);

        vm.label(address(target), "Challenge");
        vm.label(address(player), "Player");
        vm.label(address(attacker), "Attacker");
        vm.deal(player, 2 ether);
    }

    function testKing() public {
        vm.startPrank(address(player));
        attacker.attack{value: 2 ether}();
        vm.stopPrank();

        vm.expectRevert();
        payable(address(target)).transfer(3 ether);

        assertTrue(address(attacker) == target._king());
    }
}
