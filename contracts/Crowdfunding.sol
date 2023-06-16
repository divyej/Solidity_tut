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
event projectCompleted(uint256 projectId, string title, uint256 totalAmount);

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
 function contributeProject(uint256 _projectId)payable public {
    require(_projectId>0&& _projectId<=projectsCount,"project not found ");
    Project storage project= projects[_projectId];
    require(!project.isCompleted,"Project has reached its goal");
    require(msg.value>0,"baklance is not enough ");
    project.contributions[msg.sender]+=msg.value;
    project.currentAmount += msg.value;
    project.contributionCount;

    emit contributionMade(_projectId, msg.sender, msg.value);
    if(project.currentAmount>=project.goalAmount){
        project.isCompleted=true;
        emit projectCompleted(_projectId,project.title,project.currentAmount);
    }
    }
    function getProjectDetails(uint256 _projectId) public view returns(address creator,
    string memory title,
    string memory description,
    string memory goalAmount,
    uint256 currentAmount,
    uint256 contributionCount,
    bool isCompleted)
    {
        require(_projectId>0 && _projectId<=projectCount,"invalid project id" );
        Project storage project =projects[_projectId];
        return(
            project.creator,
            project.title,
            project.description,
            project.goalAmount,
            project.currentAmount,
            project.contributionCount,
            project.isCompleted
        );
    }
 }


  