 D:\Documentos\Reentrancy> npm run local-testnet

 npm run deploy:local (ejecuta scripts/deployMyContract.js)

npx hardhat console --network localhost

Auction deployed to: 0x5FbDB2315678afecb367f032d93F642f64180aa3
Atacker deployed to: 0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512


https://docs.openzeppelin.com/learn/deploying-and-interacting


const Auction = await ethers.getContractFactory('Auction');
const auction = await Auction.attach('0x5FbDB2315678afecb367f032d93F642f64180aa3');

const Attacker = await ethers.getContractFactory('Attacker');
const attacker = await Attacker.attach('0xe7f1725E7734CE288F8367e1Bb143E90bb3F0512');