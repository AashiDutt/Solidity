// SPDX-License-Identifier: MIT
// Exceptions: Require, Assert, Revert -- goes back to original state
pragma solidity ^0.8.13;

contract Exceptions {
    bool isRunning = false;
    address owner;

    mapping(address => uint) balance;

    constructor() {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner");
        _; 
        
    }

    function setRunning(bool _running) public onlyOwner{
        isRunning = _running;
    }

    function depositMoney() public payable{
        require(isRunning, "Smart contract is not running currently");

        //assert(isRunning); 

        //if(isRunning) {
        //    balance[msg.sender] += msg.value;
        //} else{
        //    revert("Smart contract is not running currently");
        //}
        
    }
    function withdrawMoney(address payable _to, uint _amount) public{
        require(balance[msg.sender]>= _amount, "Insufficient Balance");
        balance[msg.sender] -= _amount;
        assert(balance[msg.sender] <= balance[msg.sender] + _amount);
        _to.transfer(_amount);
       
    }
}