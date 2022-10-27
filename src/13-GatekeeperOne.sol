// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract GatekeeperOne {
    using SafeMath for uint256;
    address public entrant;
    event log(uint32);
    event log1(uint16);
    event log2(uint64);
    event log3(address);

    modifier gateOne() {
        require(msg.sender != tx.origin, "GatekeeperOne: invalid gateOne");
        _;
    }

    modifier gateTwo() {
        require(gasleft().mod(8191) == 0, "GatekeeperOne: invalid gateTwo");
        _;
    }

    modifier gateThree(bytes8 _gateKey) {
        emit log3(tx.origin);
        emit log(uint32(uint64(_gateKey)));
        emit log1(uint16(uint64(_gateKey)));
        emit log2(uint64(_gateKey));
        emit log1(uint16(uint160(tx.origin)));
        require(
            uint32(uint64(_gateKey)) == uint16(uint64(_gateKey)),
            "GatekeeperOne: invalid gateThree part one"
        );
        require(
            uint32(uint64(_gateKey)) != uint64(_gateKey),
            "GatekeeperOne: invalid gateThree part two"
        );
        require(
            uint32(uint64(_gateKey)) == uint16(uint160(tx.origin)),
            "GatekeeperOne: invalid gateThree part three"
        );
        _;
    }

    function enter(bytes8 _gateKey)
        public
        gateOne
        gateTwo
        gateThree(_gateKey)
        returns (bool)
    {
        entrant = tx.origin;
        return true;
    }
}
