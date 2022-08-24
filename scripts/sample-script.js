const hre = require('hardhat');

async function main() {
    const BettingSM = await hre.ethers.getContractFactory('BettingSM');
    const bettingSM = await Greeter.deploy('Hello, Hardhat!');

    await bettingSM.deployed();

    console.log('Greeter deployed to:', bettingSM.address);
}

main()
    .then(() => process.exit(0))
    .catch((error) => {
        console.error(error);
        process.exit(1);
    });
