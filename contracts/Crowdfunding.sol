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
uint256 public projectsCount;
mapping(uint256 => Project) public projects;


event projectCreated(uint256 projectId,string title,uint256 goalAmount);
event contributionMade(uint256 projectId, address contributor, uint256 amopunt );
event projectCompleted(uint256 projextId, string title, uint256 totalAmount);

function createProject(string memory _title, string memory _description, uint256 _goalAmount ) public{
  projectsCount++;
  projects[projectsCount].id=projectsCount;
  projects[projectsCount].creator=msg.sender;
  projects[projectsCount].title=_title;
  projects[projectsCount].description=_description;
  projects[projectsCount].goalAmount=_goalAmount;
  projects[projectsCount].currentAmount =0;
  projects[projectsCount].contributionCount=0;
  projects[projectsCount].contributionCount=0;
  projects[projectsCount].isCompleted=false;
emit projectCreated(projectsCount, _title, _goalAmount);
}



}