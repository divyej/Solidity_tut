// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Dex{

    struct Token{
        address tokenAddress;
        uint256 Price;
        uint256 Supply;
    }
    mapping(address => Token) public tokens;
    address[] public supportedTokens;
    //a struct cant be constructed with nested mapping 
    mapping(address => mapping(address=>uint256)) public balances;

    event TokenAdded(address tokenAddress, uint256 price, uint256 Supply );
    event TokenBought(address tokenAddress , address buyer , uint256 Amount, uint256 totalCost);
    event TokenSold(address tokenAddress , address seller , uint256 Amount, uint256 totalEarned);

    constructor() {

    }

    function addToken(address _tokenAddress, uint256 _price , uint256 _Supply) public {
        require(tokens[_tokenAddress].tokenAddress==address(0),"token already exists");
        Token memory newToken = Token(_tokenAddress,
        _price,
        _Supply
        ) ;
        tokens[_tokenAddress]=newToken;
        supportedTokens.push(_tokenAddress);
        emit TokenAdded(_tokenAddress, _price, _Supply);
    }

    function buyToken(address _tokenAddress , uint256 _tokenAmount) public payable{
        Token storage token = tokens[_tokenAddress];
        require(token.tokenAddress!=address(0),"no such token found");
        require(token.Supply>=_tokenAmount,"insufficient token supply");
        uint256 totalCost = token.Price*(_tokenAmount);
        require(msg.value>totalCost,"insufficientFaunds");

//the user addresses holds the number of token
        balances[_tokenAddress][msg.sender]+=_tokenAmount;
        token.Supply -= _tokenAmount;
        if(msg.value>totalCost){
         payable(msg.sender).transfer(msg.value-totalCost);
        }
         emit TokenBought(_tokenAddress, msg.sender, _tokenAmount, totalCost);
    }

    function sellToken(address _tokenAddress , uint256 _tokenAmount) public payable{
        Token storage token = tokens[_tokenAddress];
         require(token.tokenAddress!=address(0),"no such token found");
         require(balances[_tokenAddress][msg.sender]>=_tokenAmount,"insuffucint balance");
         uint256 totalEarned = token.Price * _tokenAmount;

         //transfer token from seller 

         balances[_tokenAddress][msg.sender]-=_tokenAmount;
         token.Supply+= _tokenAmount;

         //payment to the seller 

         payable(msg.sender).transfer(totalEarned);

         emit TokenSold(_tokenAddress, msg.sender, _tokenAmount, totalEarned);   

    }
}