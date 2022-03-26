// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract MappingStruct{

    mapping(address => bool) public myAddressBoolMapping;

    function writeBoolMapping(address _address, bool _bool) public {
        myAddressBoolMapping[_address] = _bool;
    }

    //function overoading in soidity
    function writeBoolMapping(bool _bool) public{
        myAddressBoolMapping[msg.sender] = _bool;
    }

    mapping(address => uint) public myBalanceForAddress;
    
    function depositMapping() public payable {
        myBalanceForAddress[msg.sender] += msg.value;
    }

    function withdrawMapping(address payable _to, uint _amount) public{
        if (myBalanceForAddress[msg.sender] >= _amount){
            myBalanceForAddress[msg.sender] -= _amount;
            _to.transfer(_amount);
        }
    }
}