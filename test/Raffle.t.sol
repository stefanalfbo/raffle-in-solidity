// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

import {Test} from "forge-std/Test.sol";
import {Raffle, Raffle__SendMoreToEnterRaffle, RaffleEvent} from "../src/Raffle.sol";

contract RaffleTest is Test, RaffleEvent {
    Raffle raffle;
    address USER = makeAddr("user");
    uint256 constant ENTRANCE_FEE = 100;
    uint256 constant INTERVAL = 60;

    function setUp() public {
        raffle = new Raffle(ENTRANCE_FEE, INTERVAL, address(1), bytes32(0), 0, 0);
    }

    function testEnterRaffleWithToLittleEth() public {
        vm.expectRevert(Raffle__SendMoreToEnterRaffle.selector);
        raffle.enterRaffle{value: 42}();
    }

    function testEnterRaffle() public {
        vm.deal(USER, ENTRANCE_FEE);
        vm.prank(USER);
        vm.expectEmit();
        emit RaffleEntered(USER);

        raffle.enterRaffle{value: ENTRANCE_FEE}();
        assert(raffle.getEntranceFee() == ENTRANCE_FEE);
    }
}
