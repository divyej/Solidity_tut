// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Lottery{
    address public managers;
    address payable[]  public players;

    constructor(){
        managers=msg.sender;
    }

    event TicketBought(address indexed player ,uint256 amount);
    event winnerSelected(address winner , uint256 prize);
    
    function buyTicket() public payable{
        require(msg.value>0.01 ether,"insufficinet funds");
        players.push(payable(msg.sender));
        emit TicketBought(msg.sender, msg.value);
    }

    function random() private view returns (uint256){
        

    }
}
