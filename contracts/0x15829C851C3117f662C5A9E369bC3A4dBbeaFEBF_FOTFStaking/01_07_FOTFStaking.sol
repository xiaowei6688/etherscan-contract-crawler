// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/token/ERC20/utils/SafeERC20.sol";
import "@openzeppelin/contracts/token/ERC721/IERC721.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract FOTFStaking is ReentrancyGuard {
  // We do this so we can use the safeTransfer function
  using SafeERC20 for IERC20;

  // Interfaces for ERC20 and ERC721
  IERC20 public immutable rewardsToken;
  IERC721 public immutable nftCollection;

  struct StakedToken {
    address staker;
    uint256 tokenId;
  }

  // Staker info
  struct Staker {
    // Amount of tokens staked by the staker
    uint256 amountStaked;
    // Staked token ids
    StakedToken[] stakedTokens;
    // Last time of the rewards were calculated for this user
    uint256 timeOfLastUpdate;
    // Calculated, but unclaimed rewards for the User. The rewards are
    // calculated each time the user writes to the Smart Contract
    uint256 unclaimedRewards;
  }

  // Rewards per hour per token deposited in wei.
  uint256 private rewardsPerHour = 4166666666000000000; // 100 per day or 4.16 per hour
  uint256 private rewardsPerHour2 = 4999999999200000000; // 1.2x
  uint256 private rewardsPerHour3 = 5624999999100000000; // 1.35x
  uint256 private rewardsPerHour4 = 6041666665700000000; // 1.45x
  uint256 private rewardsPerHour5 = 6249999998000000000; // 1.5x

  // Mapping of User Address to Staker info
  mapping(address => Staker) public stakers;

  // Mapping of Token Id to staker. Made for the SC to remeber
  // who to send back the ERC721 Token to.
  mapping(uint256 => address) public stakerAddress;

  // Constructor function to set the rewards token and the NFT collection addresses
  constructor(IERC721 _nftCollection, IERC20 _rewardsToken) {
    nftCollection = _nftCollection;
    rewardsToken = _rewardsToken;
  }

  // If address already has ERC721 Token/s staked, calculate the rewards.
  // Increment the amountStaked and map msg.sender to the Token Id of the staked
  // Token to later send back on withdrawal. Finally give timeOfLastUpdate the
  // value of now.
  function stake(uint256[] calldata _tokenIds) external nonReentrant {
    // If wallet has tokens staked, calculate the rewards before adding the new token
    if (stakers[msg.sender].amountStaked > 0) {
      uint256 rewards = calculateRewards(msg.sender);
      stakers[msg.sender].unclaimedRewards += rewards;
    }

    // Wallet must own the token they are trying to stake
    require(
      nftCollection.ownerOf(_tokenIds[0]) == msg.sender,
      "You don't own these tokens!"
    );

    for (uint256 i = 0; i < _tokenIds.length; i++) {
      // Transfer all the tokens from the wallet to the Smart contract
      nftCollection.transferFrom(msg.sender, address(this), _tokenIds[i]);
    }

    // Create StakedTokens
    for (uint256 i = 0; i < _tokenIds.length; i++) {
      StakedToken memory stakedToken = StakedToken(msg.sender, _tokenIds[i]);
      // Add the token to the stakedTokens array
      stakers[msg.sender].stakedTokens.push(stakedToken);
      // Increment the amount staked for this wallet
      stakers[msg.sender].amountStaked++;

      // Update the mapping of the tokenId to the staker's address
      stakerAddress[_tokenIds[i]] = msg.sender;
      // Update the timeOfLastUpdate for the staker
      stakers[msg.sender].timeOfLastUpdate = block.timestamp;
    }
  }

  // Check if user has any ERC721 Tokens Staked and if they tried to withdraw,
  // calculate the rewards and store them in the unclaimedRewards
  // decrement the amountStaked of the user and transfer the ERC721 token back to them
  function withdraw(uint256[] calldata _tokenIds) external nonReentrant {
    // Make sure the user has at least one token staked before withdrawing
    require(stakers[msg.sender].amountStaked > 0, "You have no tokens staked");

    // Wallet must own the token they are trying to withdraw
    require(
      stakerAddress[_tokenIds[0]] == msg.sender,
      "You don't own these tokens!"
    );

    // Update the rewards for this user, as the amount of rewards decreases with less tokens.
    uint256 rewards = calculateRewards(msg.sender);
    stakers[msg.sender].unclaimedRewards += rewards;

    for (uint256 i = 0; i < _tokenIds.length; i++) {
      // Find the index of this token id in the stakedTokens array
      uint256 index = 0;
      for (uint256 j = 0; j < stakers[msg.sender].stakedTokens.length; j++) {
        if (
          stakers[msg.sender].stakedTokens[j].tokenId == _tokenIds[i] &&
          stakers[msg.sender].stakedTokens[j].staker != address(0)
        ) {
          index = j;
          break;
        }
      }

      // Set this token's .staker to be address 0 to mark it as no longer staked
      stakers[msg.sender].stakedTokens[index].staker = address(0);

      // Decrement the amount staked for this wallet
      stakers[msg.sender].amountStaked--;

      // Update the mapping of the tokenId to the be address(0) to indicate that the token is no longer staked
      stakerAddress[_tokenIds[i]] = address(0);

      // Transfer the token back to the withdrawer
      nftCollection.transferFrom(address(this), msg.sender, _tokenIds[i]);
    }

    // Update the timeOfLastUpdate for the withdrawer
    stakers[msg.sender].timeOfLastUpdate = block.timestamp;
  }

  // Calculate rewards for the msg.sender, check if there are any rewards
  // claim, set unclaimedRewards to 0 and transfer the ERC20 Reward token
  // to the user.
  function claimRewards() external {
    uint256 rewards = calculateRewards(msg.sender) +
      stakers[msg.sender].unclaimedRewards;
    require(rewards > 0, "You have no rewards to claim");
    stakers[msg.sender].timeOfLastUpdate = block.timestamp;
    stakers[msg.sender].unclaimedRewards = 0;
    rewardsToken.safeTransfer(msg.sender, rewards);
  }

  // Calculate rewards for param _staker by calculating the time passed
  // since last update in hours and mulitplying it to ERC721 Tokens Staked
  // and rewardsPerHour.
  function calculateRewards(address _staker)
    internal
    view
    returns (uint256 _rewards)
  {
    if (stakers[_staker].amountStaked < 1) {
      return 0;
    }
    //1-5 = 1x multiplier
    if (
      stakers[_staker].amountStaked >= 1 && stakers[_staker].amountStaked <= 5
    ) {
      return (((
        ((block.timestamp - stakers[_staker].timeOfLastUpdate) *
          stakers[_staker].amountStaked)
      ) * rewardsPerHour) / 3600);
    }
    // 6-15 Staked = 1.2x Multiplier
    if (
      stakers[_staker].amountStaked >= 6 && stakers[_staker].amountStaked <= 15
    ) {
      return (((
        ((block.timestamp - stakers[_staker].timeOfLastUpdate) *
          stakers[_staker].amountStaked)
      ) * rewardsPerHour2) / 3600);
    }
    // 16-25
    if (
      stakers[_staker].amountStaked >= 16 && stakers[_staker].amountStaked <= 25
    ) {
      return (((
        ((block.timestamp - stakers[_staker].timeOfLastUpdate) *
          stakers[_staker].amountStaked)
      ) * rewardsPerHour3) / 3600);
    }
    // 26-29
    if (
      stakers[_staker].amountStaked >= 26 && stakers[_staker].amountStaked <= 29
    ) {
      return (((
        ((block.timestamp - stakers[_staker].timeOfLastUpdate) *
          stakers[_staker].amountStaked)
      ) * rewardsPerHour4) / 3600);
    }
    // 26-29
    if (stakers[_staker].amountStaked >= 30) {
      return (((
        ((block.timestamp - stakers[_staker].timeOfLastUpdate) *
          stakers[_staker].amountStaked)
      ) * rewardsPerHour5) / 3600);
    }
  }

  // A view to get how many tokens a person
  function getStakedTokens(address _user)
    public
    view
    returns (StakedToken[] memory)
  {
    // Check if we know this user
    if (stakers[_user].amountStaked > 0) {
      // Return all the tokens in the stakedToken Array for this user that are not -1
      StakedToken[] memory _stakedTokens = new StakedToken[](
        stakers[_user].amountStaked
      );
      uint256 _index = 0;

      for (uint256 j = 0; j < stakers[_user].stakedTokens.length; j++) {
        if (stakers[_user].stakedTokens[j].staker != (address(0))) {
          _stakedTokens[_index] = stakers[_user].stakedTokens[j];
          _index++;
        }
      }

      return _stakedTokens;
    }
    // Otherwise, return empty array
    else {
      return new StakedToken[](0);
    }
  }

  // View to check the available rewards a user has
  function availableRewards(address _staker) public view returns (uint256) {
    uint256 rewards = calculateRewards(_staker) +
      stakers[_staker].unclaimedRewards;
    return rewards;
  }
}