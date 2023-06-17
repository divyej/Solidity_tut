// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Dex{

    struct Token{
        address tokenAddress;
        uint256 Price;
        uint256 Supply;
        mapping(address => uint256) balances;
    }
    mapping(address => Token) public tokens;
    address[] public supportedTokens;

    event TokenAdded(address tokenAddress, uint256 price, uint256 Supply );
    event TokenBought(address tokenAddress , address buyer , uint256 Amount, uint256 totalCost);
    event TokenSold(address tokenAddress , address seller , uint256 Amount, uint256 totalEarned);

    constructor() {

    }

    function addToken(address _tokenAddress, uint256 _price , uint256 _Supply) public {
        require(tokens[_tokenAddress].tokenAddress==address(0),"token already exists");
       
    }

}