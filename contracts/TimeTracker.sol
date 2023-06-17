// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract TimeTracking{
    struct workTime{
        uint256 id;
        address worker;
        uint256 startTime;
        uint256 endTime;
        uint256 hourlyRate;

    }
    mapping(uint256=> workTime) public workEntries;
    uint256 public entryCount;

    event workEntryRecorded(uint256 indexed entryId, address indexed worker , uint256 startTime, uint256 endTime , uint256 hourlyRate);

    constructor(){
        entryCount=0;
    }

    function recordWorkHours(uint256 _startTime, uint256 _endTime, uint256 _hourlyRate) public{
        require(_startTime<_endTime,"invalid time range");
        entryCount++;
        workEntries[entryCount]= workTime(entryCount,msg.sender,_startTime,_endTime,_hourlyRate);

        emit workEntryRecorded(entryCount, msg.sender, _startTime, _endTime, _hourlyRate);
   }
   function calculatePayment(uint256 _entryId)  public view returns(uint256){
    require(_entryId>0 && _entryId<=entryCount,"provide valid id" );

    workTime storage entry = workEntries[_entryId];
    uint256 hoursWorked =entry.endTime - entry.startTime;
    uint256 payment = hoursWorked* entry.hourlyRate;

    return payment;

   }
}