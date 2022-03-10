// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

contract AgreedPrice {
    address public owner;
    uint256 public price;

    constructor(uint256 _price) {
        owner = msg.sender;
        price = _price;
    }

    modifier justOwner() {
        require(msg.sender == owner, "Restricted Access");
        _;
    }

    function changeOwner(address _newOwner) external justOwner {
        owner = _newOwner;
    }

    function updatePrice(uint256 _price) external justOwner {
        price = _price;
    }
}
