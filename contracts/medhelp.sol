// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract medHelp{
    struct Help{
        address owner;
        string title;
        string description;
        uint256 target;
        uint256 deadline;
        uint256 amountCollected;
        string image;
        address[] donors;
        uint256[] donations;
    }
    mapping(uint256 => Help) public helps;

    uint256 helpCount=0;

    function createHelp(address _owner, string memory _title , string memory _description, uint256 target , uint256 deadline, string memory _image ) public returns(uint256){
        Help storage help = helps[helpCount];
        require(help.deadline>block.timestamp,"Date should be in future ");
        help.owner=_owner;
        help.title=_title;
        help.description=_description;
        help.target=_target;
        hel
        

    }

}