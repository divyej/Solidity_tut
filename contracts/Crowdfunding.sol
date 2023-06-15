// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract CrowdFuhding{
struct Project{
uint256 id;
address creator;
string title;
string description;
uint256 goalAmount;
uint256 currentAmount;
mapping(address => uint256) contributions;
uint256 contributionCount;
bool isCompleted;

}

}