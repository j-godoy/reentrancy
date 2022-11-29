async function main() {
    const Auction = await ethers.getContractFactory("Auction");
    const auction = await Auction.deploy(100, 1000, "0x70997970C51812dc3A010C7d01b50e0d17dc79C8");
    console.log("Auction deployed to:", auction.address);


    const Atacker = await ethers.getContractFactory("Attacker");
    const atacker = await Atacker.deploy("0xf39Fd6e51aad88F6F4ce6aB8827279cffFb92266", auction.address, 3);
    console.log("Atacker deployed to:", atacker.address);
    
  }
  main()
    .then(() => process.exit(0))
    .catch(error => {
      console.error(error);
      process.exit(1);
  });