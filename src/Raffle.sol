// SPDX-License-Identifier: MIT
pragma solidity 0.8.19;

// Custom errors
error Raffle__SendMoreToEnterRaffle();

interface RaffleEvent {
    event RaffleEntered(address indexed player);
}

/**
 * @title A sample Raffle contract
 * @author Stefan Alfbo
 * @notice This contract is for creating a sample raffle
 * @dev Implements Chainlink VRFv2.5
 */
contract Raffle is RaffleEvent {
    uint256 private immutable i_entranceFee;
    // @dev The duration of the raffle in seconds
    uint256 private immutable i_interval;
    address payable[] private s_players;
    uint256 private s_lastTimeStamp;

    constructor(uint256 entranceFee, uint256 interval) {
        i_entranceFee = entranceFee;
        i_interval = interval;
        s_lastTimeStamp = block.timestamp;
    }

    function enterRaffle() external payable {
        if (msg.value < i_entranceFee) {
            revert Raffle__SendMoreToEnterRaffle();
        }

        s_players.push(payable(msg.sender));
        emit RaffleEntered(msg.sender);
    }

    function pickWinner() public {
        if ((block.timestamp - s_lastTimeStamp) < i_interval) {
            revert();
        }
    }

    /** Getter functions **/
    function getEntranceFee() public view returns (uint256) {
        return i_entranceFee;
    }
}
