// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract SimpleCoin{

    mapping(address => uint) public coinBalance;

    constructor() {
        coinBalance[0x5B38Da6a701c568545dCfcB03FcB875f56beddC4] = 10000;
    }

    function transfer(address _to, uint _amount) public{
        coinBalance[msg.sender] -= _amount;
        coinBalance[_to] += _amount;
    }

    //msg.sender -- address of sender
}