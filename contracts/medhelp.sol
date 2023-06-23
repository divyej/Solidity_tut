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

    function createHelp(address _owner, string memory _title , string memory _description, uint256 _target , uint256 _deadline, string memory _image ) public returns(uint256){
        Help storage help = helps[helpCount];
        require(help.deadline>block.timestamp,"Date should be in future ");
        help.owner=_owner;
        help.title=_title;
        help.description=_description;
        help.target=_target;
        help.deadline=_deadline;
        help.amountCollected=0;
        help.image= _image;

        helpCount++;

        return helpCount-1;
    }

    function donate(uint256 _id) public payable {
        uint256 amount =msg.value;
        require(_id>0 && _id<=helpCount,"THE CONTRACT DOESNT EXIST");
        Help storage help= helps[_id];
        help.donors.push(msg.sender);
        help.donations.push(amount);

        (bool sent,)=payable(help.owner).call{value:amount}("");
        if(sent){
            help.amountCollected+=amount;
        }
    }

    function getDonors(uint256 _id)public view returns(address[] memory, uint256[] memory){
        return (helps[_id].donors,helps[_id].donations);
    }

    function getProjects() public view returns(Help[] memory){
        Help[] memory allHelps= new Help[](helpCount);
        for(uint i=0;i<helpCount;i++){
            allHelps[i]=helps[i];
        }
        return allHelps;
    }

}