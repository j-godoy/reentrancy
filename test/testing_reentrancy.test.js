const { expect } = require("chai");

describe("Reentrant", () => {
  it("should return its name", async () => {
    const MyContract = await ethers.getContractFactory("Auction");
    const myContract = await MyContract.deploy(100, 1000, "0x70997970C51812dc3A010C7d01b50e0d17dc79C8");
    await myContract.deployed();
    expect(await myContract.get_blocknumber()).to.equal("1");
  });
});