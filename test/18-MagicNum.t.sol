// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../src/18-MagicNum.sol";

interface Solver {
    function whatIsTheMeaningOfLife() external view returns (bytes32);
}

contract MagicNumTest is Test {
    MagicNum public target;
    Solver public solver;
    address player = vm.addr(1);

    function setUp() public {
        target = new MagicNum();

        vm.label(address(target), "Challenge");
        vm.label(address(player), "Player");
    }

    function testMagicNum() public {
        vm.startPrank(address(player));

        bytes
            memory code = "\x60\x0a\x60\x0c\x60\x00\x39\x60\x0a\x60\x00\xf3\x60\x2a\x60\x80\x52\x60\x20\x60\x80\xf3";
        address solverAddress;
        assembly {
            solverAddress := create(0, add(code, 0x20), mload(code))
        }

        target.setSolver(solverAddress);

        solver = Solver(target.solver());
        bytes32 number = solver.whatIsTheMeaningOfLife();

        uint256 solverSize = target.getSolverSize();

        assertTrue(
            number ==
                0x000000000000000000000000000000000000000000000000000000000000002a &&
                solverSize <= 10
        );
    }
}
