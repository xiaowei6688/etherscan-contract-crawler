// SPDX-License-Identifier: GPL-3.0

/**

             #@@@@                                         @@@@@            
           @@@@@@@@@.                                    @@@@@@@@@          
           @@@@@@@@@.                                    @@@@@@@@@          
           @@@@@@@@@.      @@@@@              %@@@@      @@@@@@@@@          
             #@@@@           @@@@@         @@@@@           @@@@@            
                                 @@@@@@@@@@@@                               
      /////////////                                        ////////////     
     ///////////////.                                   //////////////////  
    /////////////////                                   //////////////////  
    /////////////////                                    ////////////////   
      /////////////                                        ////////////     

*/

pragma solidity ^0.8.6;

import "@openzeppelin/contracts/access/Ownable.sol";
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV2V3Interface.sol";
import "@openzeppelin/contracts/utils/Strings.sol";

contract FiniOracle is Ownable {
    using Strings for uint256;

    string[] public neutralStates;

    /// @dev an array of arrays. add a new array to add a new gradation of happy.
    /// outside array is a new gradation (e.g. happy and superHappy) and inside
    /// array is an instance of that gradation (e.g. happy_dance)
    string[][] public happyStates;
    string[][] public sadStates;

    /// @dev denotes breakpoints between gradations in percentage terms
    int16[] public happyBreakpoints;
    int16[] public sadBreakpoints;

    /// @dev list of oracles that correspond to each family
    address[10] public oracles = [
        0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419, // 0 eth mainnet
        0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c, // 1 btc
        0xFF3EEb22B5E3dE6e705b44749C2559d704923FD7, // 2 avax
        0x2465CefD3b488BE410b941b1d4b2767088e2A028, // 3 doge
        0x2c1d072e956AFFC0D435Cb7AC38EF18d24d9127c, // 4 link mainnet
        0x7bAC85A8a13A4BcD8abb3eB7d6b4d632c5a57676, // 5 matic
        0x5239a625dEb44bF3EeAc2CD5366ba24b8e9DB63F, // 6 tezos
        0x14e613AC84a31f709eadbdF89C6CC390fDc9540A, // 7 binance
        0x4ffC43a60e009B551865A93d232E33Fce9f01507, // 8 sol
        0x553303d460EE0afB37EdFf9bE42922D8FF63220e  // 9 uniswap
    ];

    /// @dev specifies whether a fallback URI should be used for a given family
    bool[10] public useFallbackUri;

    string public fallbackUri = "https://api.finiliar.com/metadata/";

    /// @dev see `getMetadataForTokenId` for details
    mapping(uint256 => bytes32) public tokenMetadata;

    /// @dev index 0 = monthly, 1 = weekly, 2 = daily, 3 = twice daily, 4 = hourly
    uint16[5] public jumpSizes = [600, 100, 12, 5, 1];

    /// @dev controls the rate at which animations will update, in seconds
    uint256 public updateInterval = 360;

    // ======================= PUBLIC FUNCTIONS ================================

    /**
     * @notice Primary interface for finiliar ERC721 contract
     */
    function tokenURI(uint256 tokenId) external view returns (string memory) {
        (uint256 frequency, uint256 family) = getMetadataForTokenId(tokenId);

        // if we're meant to use the fallbackUri, do it now
        if (useFallbackUri[family]) {
            return string(abi.encodePacked(fallbackUri, tokenId.toString()));
        }

        // else proceed with oracle check. note that getDelta returns a % delta
        // with an extra two decimal points, so dividing by 100
        int256 delta = getDelta(frequency, family) / 100;
        return getUriForDelta(delta, tokenId);
    }

    /**
     * @notice Get a % delta for a given frequency and family
     * @return delta This is a % delta * 100, i.e. it must be divided by 100 to
     * get the real %. We're doing this to preserve some precision with the calculation.
     */
    function getDelta(uint256 frequency, uint256 family) public view returns (int256) {
        // first fetch the current price
        AggregatorV2V3Interface feed = AggregatorV2V3Interface(oracles[family]);
        int256 latestPrice = feed.latestAnswer();

        // fetch the corresponding previous roundId
        uint80 roundId = getPreviousRoundId(frequency, family);

        // now derive the previous price from the roundId
        int256 previousPrice = getPriceFromRoundId(roundId, family);

        // compare the two
        int256 delta = (latestPrice - previousPrice) * 10000 / previousPrice;

        return delta;
    }

    /// idea: implement an ASCII based visualization for true decentralization,
    /// e.g. onChainVisualization

    /**
     * @notice Given a % delta, return a URI.
     * @dev We use a single IPFS directory per mood for all finiliar (e.g.
     * happy_dance is a single directory of 10k items)
     */
    function getUriForDelta(int256 delta, uint256 tokenId) public view returns (string memory) {
        uint256 rand = pseudoRandom(tokenId);

        // neutral + fallback
        string memory path = neutralStates[rand % neutralStates.length];

        // check happy breakpoints
        for (uint256 i = 0; i < happyBreakpoints.length; i++) {
            // if this is the last in the array, stub in an arbitrarily high value
            // for outside bound, else use the next value in the array as the outside bound
            int256 nextBreakpoint = (happyBreakpoints.length - 1 == i)
                ? int256(200000)
                : happyBreakpoints[i + 1];
            if (delta >= happyBreakpoints[i] && delta < nextBreakpoint) {
                path = happyStates[i][rand % happyStates[i].length];
            }
        }

        // check sad breakpoints
        for (uint256 i = 0; i < sadBreakpoints.length; i++) {
            // if this is the last in the array, stub in an arbitrarily high value
            // for outside bound, else use the next value in the array as the outside bound
            int256 nextBreakpoint = (sadBreakpoints.length - 1 == i)
                ? -200000
                : sadBreakpoints[i + 1];
            if (delta <= sadBreakpoints[i] && delta > nextBreakpoint) {
                path = sadStates[i][rand % sadStates[i].length];
            }
        }

        return string(abi.encodePacked('ipfs://', path, '/', tokenId.toString()));
    }

    /**
     * @notice Recurse to find a round id at (or nearest) our target timestamp.
     * We compare the price at this round to the current price to derive a delta/mood.
     * @dev This is a binary search algo where jumpSize differs depending on
     * timestamp.
     * @param targetTimestamp the timestamp we need a price for
     * @param feed the oracle contract corresponding to the finiliar family
     * @param roundId the round id we should test for a timestamp
     * @param counter helps us prevent running out of gas
     * @param jumpSize how many round ids to skip as we iterate. halves each time
     * we overshoot.
     * @param jumpDirection whether our search is going backward or forward in time.
     * false = backwards, true = forwards. switch each time we overshoot.
     * @return thisRoundId the roundId we should use to compare to current prices.
     */
    function findRoundId(
        uint256 targetTimestamp,
        AggregatorV2V3Interface feed,
        uint80 roundId,
        uint16 counter,
        uint16 jumpSize,
        bool jumpDirection
    )
        public
        view
        returns (uint80)
    {
        uint80 thisRoundId = uint80(jumpDirection ? (roundId + jumpSize) : (roundId - jumpSize));
        uint256 timestamp = feed.getTimestamp(thisRoundId);

        // determine if we're before or after our target timestamp.
        // if we've accidentally hit the future, then the tooEarly and tooLate
        // values aren't reliable, so falsify them
        bool tooEarly = (timestamp != 0) ? (timestamp < targetTimestamp) : false;
        bool tooLate = (timestamp != 0) ? (timestamp > targetTimestamp) : false;

        // KEEP GOING. if we haven't gone far back enough in either direction, keep going. if
        // we hit a timestamp of 0 (meaning future roundId) and we're going backward, keep going.
        if (
            (tooLate && !jumpDirection) || // still too late but heading backwards
            (tooEarly && jumpDirection) || // still too early but heading forwards
            (timestamp == 0 && !jumpDirection) // we're in the future but heading backward
        ) {
            return this.findRoundId(
                targetTimestamp,
                feed,
                thisRoundId,
                counter + 1,
                jumpSize,
                jumpDirection
            );
        }

        // SWITCH DIRECTIONS. if we overshot in either direction, switch directions and halve jumps.
        // if we overshot into the future (timestamp == 0), switch directions as well.
        if (
            (tooEarly && !jumpDirection) || // too early and heading back in time
            (tooLate && jumpDirection) || // too late and heading forward in time
            (timestamp == 0 && jumpDirection) // we've hit the future and we're still heading forward in time
        ) {
            // if we have a jump size of 1, and switching directions will continue
            // an endless loop (bc we don't have a roundId at our exact timestamp),
            // then stop here and simply select the roundId that is earliest, since
            // the lack of a subsequent round indicates a lack of price action
            if (jumpSize == 1 && jumpDirection && thisRoundId - 1 == roundId) {
                return roundId;
            }
            if (jumpSize == 1 && !jumpDirection && thisRoundId + 1 == roundId) {
                return thisRoundId;
            }
            
            // otherwise, switch directions and halve jumps
            return this.findRoundId(
                targetTimestamp,
                feed,
                thisRoundId,
                counter + 1,
                (jumpSize / 2) == 0 ? 1 : (jumpSize / 2),
                !jumpDirection
            );
        }

        // if we made it out of here, we've found a roundId with our timestamp
        return thisRoundId;
    }

    /**
     * @notice Get the previous roundId for a given frequency and family. 
     * The roundId is used later to fetch an historical price.
     * @dev Keeping this separate so we can debug on mainnet if needed.
     * @param frequency of the finiliar (0-4)
     * @param family of the finiliar (0-9)
     * @return roundId
     */
    function getPreviousRoundId(uint256 frequency, uint256 family) public view returns (uint80) {
        AggregatorV2V3Interface feed = AggregatorV2V3Interface(oracles[family]);

        // grab the latest roundId
        uint80 latestRound = uint80(feed.latestRound());

        // recurse to find the previous roundId for our frequency
        uint80 roundId = findRoundId(
            getTargetTimestamp(frequency),
            feed,
            latestRound,
            0,
            jumpSizes[frequency],
            false
        );

        return roundId;
    }

    /**
     * @notice Get a price from a roundId.
     * @param roundId the roundId we want pricing data for.
     * @param family the family (0-9) of the finiliar
     * @return answer the price, denominated in native decimals
     */
    function getPriceFromRoundId(uint80 roundId, uint256 family) public view returns (int256) {
        AggregatorV2V3Interface feed = AggregatorV2V3Interface(oracles[family]);

        (
          ,
          int256 answer,
          ,
          ,
        ) = feed.getRoundData(roundId);

        return answer;
    }

    /**
     * @notice Get a target timestamp for a given frequency.
     */
    function getTargetTimestamp(uint256 frequency) public view returns (uint256) {
        // monthly
        if (frequency == 0) return block.timestamp - 2592000; // 30 days in seconds
        // weekly
        if (frequency == 1) return block.timestamp - 604800; // 7 days in seconds
        // daily
        if (frequency == 2) return block.timestamp - 86400; // 1 day in seconds
        // twice daily
        if (frequency == 3) return block.timestamp - 43200; // 12 hours in seconds
        // hourly
        if (frequency == 4) return block.timestamp - 3600; // 1 hour in seconds

        revert("Invalid frequency");
    }

    /**
     * @notice Fetch the frequency and family for a tokenId.
     * @dev We store both frequency and family values as a single byte (8 bits).
     * The tens place of the final uint256 is frequency, the ones place is family.
     * So if bytes32[0][0] = 00001001 (0x9, or 9), frequency is 0 and family is 9.
     * If bytes32[0][1] = 00011000 (0x18, or 24), frequency is 2 and family is 4.
     * @return frequency. 0 monthly, 1 weekly, 2 daily, 3 twice daily, 4 hourly
     * @return family. see oracle feed orderings for mappings
     */
    function getMetadataForTokenId(uint256 tokenId) public view returns (uint256, uint256) {
        // grab the relevant byte. h/t @dievardump & @fiveoutofnine
        bytes1 data = bytes1(tokenMetadata[tokenId / 32] << (8 * (tokenId % 32)));

        // convert to uint and grab tens and ones place
        uint256 values = uint256(uint8(data));
        uint256 frequency = values / 10;
        uint256 family = values % 10;

        return (
            frequency,
            family
        );
    }

    /**
     * @notice Get a pseudorandom value that stays consistent during updateInterval.
     * @dev This gives the finis a nice statefulness without writing new data. We need
     * a tokenId so that not every fini in the same fam/freq is performing the same
     * animation.
     */
    function pseudoRandom(uint256 tokenId) public view returns (uint) {
        return uint(keccak256(abi.encodePacked(block.timestamp / updateInterval, tokenId)));
    }

    // ======================= ADMIN FUNCTIONS =================================

    /**
     * @notice Update token metadata (frequency and family) for tokenIds. Each
     * byte represents 32 token ids. See getMetadataForTokenId for more detail.
     */
    function updateMetadata(bytes32[] calldata data, uint256 startingIndex)
        public
        onlyOwner
    {
        for (uint256 i = startingIndex; i < data.length; i++) {
            tokenMetadata[i] = data[i];
        }
    }

    /**
     * @notice Adjust the jumpSizes that our binary search algo starts from.
     * @dev 0 = monthly, 1 = weekly, 2 = daily, 3 = twice daily, 4 = hourly
     */
    function updateJumpSize(uint256 freqIndex, uint16 newSize)
        public
        onlyOwner
    {
        jumpSizes[freqIndex] = newSize;
    }

    /**
     * @notice Adds a new sadBreakpoints and initializes a new sadStates array for that
     * breakpoint.
     */
    function addSadBreakpoint(int16 value, string[] memory firstUris) public onlyOwner {
        sadBreakpoints.push(value);
        sadStates.push(firstUris);
    }

    /**
     * @notice Adds a new happyBreakpoints and initializes a new happyStates array for that
     * breakpoint.
     */
    function addHappyBreakpoint(int16 value, string[] memory firstUris) public onlyOwner {
        happyBreakpoints.push(value);
        happyStates.push(firstUris);
    }

    /**
     * @notice Delete a breakpoint and corresponding sadState array, then move
     * everything up to maintain the proper order.
     */
    function deleteSadBreakpoint(uint256 index) public onlyOwner {
        for(uint i = index; i < sadBreakpoints.length - 1; i++) {
            sadBreakpoints[i] = sadBreakpoints[i + 1];
            sadStates[i] = sadStates[i + 1];
        }
        sadBreakpoints.pop();
        sadStates.pop();
    }

    /**
     * @notice Delete a happyBreakpoints and corresponding happyStates array, then move
     * everything up to maintain the proper order.
     */
    function deleteHappyBreakpoint(uint256 index) public onlyOwner {
        for(uint i = index; i < happyBreakpoints.length - 1; i++) {
            happyBreakpoints[i] = happyBreakpoints[i + 1];
            happyStates[i] = happyStates[i + 1];
        }
        happyBreakpoints.pop();
        happyStates.pop();
    }

    /**
     * @notice Add a new sadStates URI. Must indicate which mood/breakpoint it
     * should correspond to.
     */
    function addSadStateUri(uint256 breakpointIndex, string memory uri) public onlyOwner {
        sadStates[breakpointIndex].push(uri);
    }

    /**
     * @notice Add a new happyStates URI. Must indicate which mood/breakpoint it
     * should correspond to.
     */
    function addHappyStateUri(uint256 breakpointIndex, string memory uri) public onlyOwner {
        happyStates[breakpointIndex].push(uri);
    }

    /**
     * @notice Add a new neutralStates URI
     */
    function addNeutralStateUri(string memory uri) public onlyOwner {
        neutralStates.push(uri);
    }

    /**
     * @notice Delete a URI from a specific sadStates/sadBreakpoints index
     */
    function deleteSadStateUri(uint256 breakpointIndex, uint256 uriIndex) public onlyOwner {
        // move last item into the to-be-deleted item's spot
        sadStates[breakpointIndex][uriIndex] = sadStates[breakpointIndex][sadStates[breakpointIndex].length - 1];
        // delete the last item
        sadStates[breakpointIndex].pop();
    }

    /**
     * @notice Delete a URI from a specific happyStates/happyBreakpoints index
     */
    function deleteHappyStateUri(uint256 breakpointIndex, uint256 uriIndex) public onlyOwner {
        // move last item into the to-be-deleted item's spot
        happyStates[breakpointIndex][uriIndex] = happyStates[breakpointIndex][happyStates[breakpointIndex].length - 1];
        // delete the last item
        happyStates[breakpointIndex].pop();
    }

    /**
     * @notice Delete a neutralStates URI by index
     */
    function deleteNeutralStateUri(uint256 index) public onlyOwner {
        neutralStates[index] = neutralStates[neutralStates.length - 1];
        neutralStates.pop();
    }

    /**
     * @notice Update the interval in which a token's animation will stay fixed.
     */
    function updateUpdateInterval(uint256 interval) external onlyOwner () {
        updateInterval = interval;
    }

    /**
     * @notice Update the address of an oracle
     */
    function updateOracleAddress(uint256 index, address newAddress) external onlyOwner () {
        oracles[index] = newAddress;
    }

    /**
     * @notice Update the fallbackUri
     */
    function updateFallbackUri(string memory uri) external onlyOwner () {
        fallbackUri = uri;
    }

    /**
     * @notice Toggle whether a family should use the fallbackUri
     */
    function toggleFamilyFallbackUriSetting(uint256 familyIndex) external onlyOwner () {
        useFallbackUri[familyIndex] = !useFallbackUri[familyIndex];
    }

}