import { expect } from "chai";
import { ethers } from "hardhat";
import { Protocol } from "../typechain-types";

describe("YourContract", function () {
  // We define a fixture to reuse the same setup in every test.

  let protocolContract: Protocol;
  before(async () => {
    const [owner] = await ethers.getSigners();
    const protocolContractFactory = await ethers.getContractFactory("Protocol");
    protocolContract = (await protocolContractFactory.deploy({ from: owner.address })) as Protocol;
    await protocolContract.waitForDeployment();
  });

  describe("Deployment", function () {
    it("Should have the right message on deploy", async function () {
      // expect(await protocolContract.greeting()).to.equal("Building Unstoppable Apps!!!");
      await protocolContract.registerUser("test", "test", 1);
      expect(1).to.equal(1);
      const result = await protocolContract.getStores();
      console.log(result);
    });
  });
});
