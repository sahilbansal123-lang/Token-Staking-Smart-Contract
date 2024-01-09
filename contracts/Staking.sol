// SPDX-License-Identifier: MIT
pragma solidity >=0.8.2 <0.9.0;

import "@openzeppelin/contracts/token/ERC20/IERC20.sol";
import "@openzeppelin/contracts/security/ReentrancyGuard.sol";
import "@openzeppelin/contracts/utils/math/SafeMath.sol";

contract Staking is ReentrancyGuard {
    using SafeMath for uint256;
    IERC20 public s_stakeingToken;
    IERC20 public s_rewardToken;

    uint public constant REWARD_RATE=10;
    uint private totalStakedTokens;
    uint public rewardPerTokenStored;
    uint public lastUpdateTime;

    mapping (address=>uint256) public stakedBalance;
    mapping (address=>uint256) public rewards;
    mapping (address=>uint256) public userRewardPerTokenPaid;

    event Staked(address indexed user, uint256 indexed amount);
    event Withdrawn(address indexed user, uint256 indexed amount);
    event RewardsClaimed(address indexed user, uint256 indexed amount);

    constructor(address stakingToken, address rewardToken) {
        s_stakeingToken = IERC20(stakingToken);
        s_rewardToken = IERC20(rewardToken);
    }

    function rewardPerToken() public view returns(uint) {
        if(totalStakedTokens == 0) {
            return rewardPerTokenStored;
        }

        uint totalTime = block.timestamp-lastUpdateTime;
        uint totalRewards = REWARD_RATE*totalTime;
        return rewardPerTokenStored + totalRewards/totalStakedTokens;
    }

    function earned(address account) public view returns(uint) {
        return(stakedBalance[account]*(rewardPerToken()-userRewardPerTokenPaid[account]))
    }


}

