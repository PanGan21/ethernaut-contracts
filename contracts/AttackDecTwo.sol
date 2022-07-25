// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

// Use an ERC20 as intermediate token for the Dex attack
// Approve allowance for 100 ATC tokens for the contract to attack
// and transfer to this contract an amount (1)
// Swap amount 1 with token 1
// Swap amount 2 with token 2
contract AttackDexTwo is ERC20 {
    constructor() ERC20("AttackDexTwo", "ATC") {
        // Mint for the sender
        _mint(msg.sender, 1000000 * (10**uint256(decimals())));
    }
}
