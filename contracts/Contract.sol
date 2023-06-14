// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract VotingSystem{
  struct Candidate {
    string Name;
    uint256 voteCount;
    }
    mapping(uint256=>Candidate) public candidates;
    uint256 public candidatesCount;
    constructor(string[] memory _candidatesNames){
        candidatesCount= _candidatesNames.length;
        for(uint256 i=0;i<candidatesCount;
        i++){
            candidates[i+1]=Candidate({
                Name: _candidatesNames[i],
                voteCount:0
            });
        }
    }
}