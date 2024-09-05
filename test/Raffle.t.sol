// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Test} from "forge-std/Test.sol";
import {Raffle, Raffle__SendMoreToEnterRaffle} from "../src/Raffle.sol";

contract RaffleTest is Test {
    Raffle raffle;

    function setUp() public {
        raffle = new Raffle(100);
    }

    function testEnterRaffleWithToLittleEth() public {
        vm.expectRevert(Raffle__SendMoreToEnterRaffle.selector);
        raffle.enterRaffle{value: 42}();
    }
}
