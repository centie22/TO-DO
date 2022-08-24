//SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

contract ToDo{

    struct myToDoList{
        string activity;
        uint time;
        bool activityCompleted;
    }

    mapping(address => myToDoList[]) Todotracking;

    function fillList(string memory _activity, uint32 _time) external{
        address owner = msg.sender;
        require(owner != address(0), "Cannot work with address zero");
        

        Todotracking[owner].push(myToDoList(_activity, _time + block.timestamp, false));
    }

    function getTaskList() public view returns(myToDoList[] memory){
        myToDoList[] memory activityList = Todotracking[msg.sender];
        return activityList;
    }

    function addTask(string memory _activity, uint _index) external{
       myToDoList storage activityList = Todotracking[msg.sender][_index];
        activityList.activity =_activity;
    }

    function deleteTask( uint _index) external  view {
       myToDoList memory activityList = Todotracking[msg.sender][_index];
        delete activityList;
    }

    function completedActivity(uint _index) external{
        myToDoList storage activityList = Todotracking[msg.sender][_index];
        activityList.activityCompleted = true;
    }

}