const { expect } = require("chai");
const { ethers } = require("hardhat");

describe("Access Control", () => {
  let deployer, attacker;

  beforeEach(async function () {
    [deployer, attacker] = await ethers.getSigners();

    const AgreedPrice = await ethers.getContractFactory("AgreedPrice", deployer);
    this.agreedPrice = await AgreedPrice.deploy(100);
  });

  describe("AgreedPrice", () => {
    it("Should set price at deployment", async function () {
      expect(await this.agreedPrice.price()).to.eq(100);
    });

    it("Should set the deployer account as the owner at deployment", async function () {
      expect(await this.agreedPrice.owner()).to.eq(deployer.address);
    });
    it("Should be possible for the owner to change price", async function () {
      await this.agreedPrice.updatePrice(1000);
      expect(await this.agreedPrice.price()).to.eq(1000);
    });
    it("Should NOT be possible for other than the owner to change price", async function () {
      await expect(this.agreedPrice.connect(attacker).updatePrice(1000)).to.be.revertedWith("Restricted Access");
    });


  });
});