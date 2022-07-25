// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IMagicNum {
    function setSolver(address _solver) external;
}

// The meaning of life: 42 -> 0x2a
// OPCODES used
// 602a    push1 0x2a (value is 0x2a)
// 6000    push1 0x00 (memory slot is 0x00)
// 52      mstore
// 6020    push1 0x20 (value is 32 bytes in size)
// 6000    push1 0x00 (value was stored in slot 0x00)
// f3      return
// 600a600c600039600a6000f3602a60005260206000f3

contract AttackMagicNum {
    address magicNum;

    constructor(address _magicNum) {
        magicNum = _magicNum;
    }

    function attack() public {
        bytes
            memory bytecode = hex"600a600c600039600a6000f3602a60005260206000f3";
        bytes32 salt = 0;
        address solver;

        assembly {
            solver := create2(0, add(bytecode, 0x20), mload(bytecode), salt)
        }

        IMagicNum(magicNum).setSolver(solver);
    }
}
