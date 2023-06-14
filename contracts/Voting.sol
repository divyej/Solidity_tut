// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract VotingSystem{
    address public owner;
  struct Candidate {
    string Name;
    uint256 voteCount;
    }
    mapping(uint256=>Candidate) public candidates;
    uint256 public candidatesCount;
    constructor(string[] memory _candidatesNames){
        owner=msg.sender;
        candidatesCount= _candidatesNames.length;
        for(uint256 i=0;i<candidatesCount;
        i++){
            candidates[i+1]=Candidate({
                Name: _candidatesNames[i],
                voteCount:0
            });
        }
    }
    //adding modifiers for voting end time and owner restrictions
    function vote(uint256 _candidateId) public{
        require(_candidateId>0 && _candidateId<=candidatesCount,"Invalid id ");
        _;
        candidates[_candidateId].voteCount++;
        emit voteCasted(msg.sender,_candidateId);
    }

    modifier onlyOwner(){
        require(msg.sender==owner,"Only contract owner can call this funcvtion");
        _;
    
    }
    modifier onlybeforeVotingends(){
        require(block.timestamp< votingEndTime,"Voting has ended");
        _;
    }
    event voteCasted(address indexed voter,uint256 candidateId);

}