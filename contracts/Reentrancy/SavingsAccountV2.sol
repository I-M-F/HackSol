// SPDX-License-Identifier: MIT
pragma solidity 0.8.9;

import "@openzeppelin/contracts/utils/Address.sol";
import "hardhat/console.sol";


contract SavingsAccountV2 {
  using Address for address payable;

  mapping(address => uint256) public balanceOf;

  function deposit() external payable {
    balanceOf[msg.sender] += msg.value;
  }

  function withdraw() external {
    console.log("");
    console.log("ReentrancyVictim's balance: ", address(this).balance);
    console.log("ReentrancyAttacker's balance: ", balanceOf[msg.sender]);
    console.log("");

    uint256 depositedAmount = balanceOf[msg.sender];

    payable(msg.sender).sendValue(depositedAmount);

    balanceOf[msg.sender] = 0;
  }
}