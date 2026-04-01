const hre = require("hardhat");

async function main() {
  const ETH_USD_FEED = "0x694AA1769357215DE4FAC081bf1f309aDC325306"; // Sepolia
  const URIS = [
    "ipfs://stage-1-metadata",
    "ipfs://stage-2-metadata"
  ];

  const DynamicNFT = await hre.ethers.getContractFactory("EvolutionNFT");
  const nft = await DynamicNFT.deploy(ETH_USD_FEED, URIS);

  await nft.waitForDeployment();
  console.log("Dynamic NFT deployed to:", await nft.getAddress());
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
