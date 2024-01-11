// contracts/GLDToken.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract StakeToken is ERC20 {
    constructor(uint256 initialSupply) ERC20("StakeToken", "STK") {
        _mint(msg.sender, initialSupply);
    }

    function decimals() public pure override  returns (uint8) {
        return 0;
    }
}


// Stake Token Address = 0xd8b934580fcE35a11B58C6D73aDeE468a2833fa8
// Staking Contract Address = 0xd9145CCE52D386f254917e481eB44e9943F39138
// Reward token Address = 0xf8e81D47203A594245E36C48e151709F0C19fBe8