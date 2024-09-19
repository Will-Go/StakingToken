// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/security/Pausable.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";

contract StackContract is ERC20, Pausable, ReentrancyGuard {
    // The reward rate (tokens per second)
    uint256 public rewardRate = 8;
    address public owner;
    // User-specific staking information
    struct Staker {
        uint256 stakedAmount;
        uint256 rewardDebt;
        uint256 stakeTimestamp;
    }

    mapping(address => Staker) public stakers;

    event Staked(address indexed user, uint256 amount);
    event Unstaked(address indexed user, uint256 amount);
    event RewardClaimed(address indexed user, uint256 amount);

    constructor(uint256 _initialValue) ERC20("KipuCoin", "KPC") {
        owner = msg.sender;
        _mint(owner, _initialValue * 10**decimals());
    }

    modifier onlyOwner() {
        require(owner == msg.sender, "Only owner!!");
        _;
    }

    function pause() external onlyOwner {
        _pause();
    }

    function unpause() external onlyOwner {
        _unpause();
    }

    // Function to stake tokens
    function stake(uint256 amount) external whenNotPaused nonReentrant {
        require(amount > 0, "Cannot stake zero tokens");

        Staker storage staker = stakers[msg.sender];

        // Calculate and claim pending rewards before staking more
        uint256 pendingReward = calculateReward(msg.sender);
        if (pendingReward > 0) {
            _mint(msg.sender, pendingReward); // Mint the pending rewards as tokens
            emit RewardClaimed(msg.sender, pendingReward);
        }

        // Transfer staking tokens to the contract
        _transfer(msg.sender, address(this), amount);

        // Update staking info
        staker.stakedAmount += amount;
        staker.stakeTimestamp = block.timestamp;
        staker.rewardDebt = staker.stakedAmount * rewardRate;

        emit Staked(msg.sender, amount);
    }

    // Function to unstake tokens and claim rewards
    function unstake(uint256 amount) external whenNotPaused nonReentrant {
        Staker storage staker = stakers[msg.sender];
        require(staker.stakedAmount >= amount, "Not enough staked tokens");

        // Calculate and claim pending rewards before unstaking
        uint256 pendingReward = calculateReward(msg.sender);
        if (pendingReward > 0) {
            _mint(msg.sender, pendingReward); // Mint the pending rewards as tokens
            emit RewardClaimed(msg.sender, pendingReward);
        }

        // Update staking info
        staker.stakedAmount -= amount;
        staker.rewardDebt = staker.stakedAmount * rewardRate;
        staker.stakeTimestamp = block.timestamp;

        // Transfer the unstaked tokens back to the user
        _transfer(address(this), msg.sender, amount);

        emit Unstaked(msg.sender, amount);
    }

    function calculateReward(address stakerAddress)
        public
        view
        returns (uint256)
    {
        Staker storage staker = stakers[stakerAddress];
        uint256 stakingTime = block.timestamp - staker.stakeTimestamp;
        uint256 reward = (staker.stakedAmount * rewardRate * stakingTime) /
            1e18;
        return reward;
    }

    // Owner function to adjust the reward rate
    function setRewardRate(uint256 newRate) external onlyOwner {
        rewardRate = newRate;
    }
}