# Dynamic NFT (Oracle-driven)

A professional-grade implementation of "Living Assets." This repository demonstrates how to build NFTs that change over time. Using Chainlink Data Feeds or Functions, the NFT can "evolve," "level up," or "weather" based on external triggers like crypto prices, weather patterns, or sports results.

## Core Features
* **State Evolution:** Internal logic to transition between metadata URIs (e.g., Baby -> Adult).
* **Oracle Integration:** Clean interface for consuming Chainlink Price Feeds.
* **Gas Optimized:** Efficient storage of "Stage" variables to minimize update costs.
* **Flat Structure:** Single-directory layout for the NFT contract and the evolution script.

## Logic Flow
1. **Mint:** User receives a "Level 1" NFT.
2. **Monitor:** A keeper or automation script checks the Oracle price.
3. **Trigger:** If Price > Threshold, the contract updates the `tokenURI`.
4. **Evolve:** The NFT metadata now points to "Level 2" assets on IPFS.

## Setup
1. `npm install`
2. Deploy `EvolutionNFT.sol` with the Chainlink Price Feed address for your network.
