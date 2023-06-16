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
    
    modifier restricted(){
        require(msg.sender==managers,"Only the manager can call this function");
        _;
    }
    
    function buyTicket() public payable{
        require(msg.value>0.01 ether,"insufficinet funds");
        players.push(payable(msg.sender));
        emit TicketBought(msg.sender, msg.value);
    }

    function random() private view returns (uint256){
        return uint256(keccak256(abi.encodePacked(block.timestamp,block.difficulty,players.length)));
    }
    function selectWinner() public restricted{
        require(players.length>0,"no players in this lottery");
        uint256 index = random() % players.length;
        address payable winner = players[index];
        winner.transfer(address(this).balance);

        players = new address payable[](0);
    }
}
