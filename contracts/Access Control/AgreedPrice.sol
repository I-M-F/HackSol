// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;


contract AgreedPrice {
    address public owner;
    uint256 public price;

    constructor(uint256 _price) {
        owner = msg.sender;
        price = _price;
    }

    function updatePrice(uint256 _price) external {
        require(msg.sender == owner, "Restricted Access");
        price = _price;
    }
}