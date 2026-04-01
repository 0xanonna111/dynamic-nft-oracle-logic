// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";
import "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";

/**
 * @title EvolutionNFT
 * @dev An NFT that evolves based on the price of ETH.
 */
contract EvolutionNFT is ERC721URIStorage, Ownable {
    AggregatorV3Interface internal dataFeed;
    
    uint256 private _nextTokenId;
    int256 public constant EVOLUTION_PRICE = 3000 * 10**8; // $3000 threshold

    string[] private _stageURIs;

    constructor(address _priceFeed, string[] memory _uris) 
        ERC721("DynamicWarrior", "DWAR") 
        Ownable(msg.sender) 
    {
        dataFeed = AggregatorV3Interface(_priceFeed);
        _stageURIs = _uris; // Array of [SeedURI, SaplingURI, TreeURI]
    }

    function safeMint(address to) public onlyOwner {
        uint256 tokenId = _nextTokenId++;
        _safeMint(to, tokenId);
        _setTokenURI(tokenId, _stageURIs[0]);
    }

    /**
     * @dev Checks ETH price and evolves the NFT if threshold is met.
     */
    function checkAndEvolve(uint256 tokenId) external {
        (, int256 price, , , ) = dataFeed.latestRoundData();
        
        if (price >= EVOLUTION_PRICE) {
            _setTokenURI(tokenId, _stageURIs[1]);
        }
    }

    function updateStageURIs(string[] memory _newUris) external onlyOwner {
        _stageURIs = _newUris;
    }
}
