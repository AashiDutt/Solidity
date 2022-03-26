// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract MappingStruct{

    struct MyStruct{   // saves gas when you have multiple mappings
        uint balance;
        bool isSet;
        uint lastUpdated;
    }

    mapping(address => MyStruct) public myBalanceForAddress;
    
    
    function depositStruct() public payable {       
        myBalanceForAddress[msg.sender].balance += msg.value;
        myBalanceForAddress[msg.sender].isSet = true;
        myBalanceForAddress[msg.sender].lastUpdated = block.timestamp;
        
    }

    function withdrawStruct(address payable _to, uint _amount) public{
        if (myBalanceForAddress[msg.sender].balance >= _amount){
            myBalanceForAddress[msg.sender].balance -= _amount;
            _to.transfer(_amount);
        }
    }
}
    