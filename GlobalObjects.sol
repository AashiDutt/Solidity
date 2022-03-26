// SPDX-License-Identifier: MIT
// Code for global objects, constructors, modifiers

pragma solidity ^0.8.13;

contract GlobalObjects{

    address owner;
    

    bool public auctionIsRunning = true;

    constructor(){
        owner = msg.sender;
    }

//Helps to remove duplicates
    modifier onlyOwner() {
        if(msg.sender == owner){
            _;
        }
        
    }

    modifier auctionRunning() {
        require(auctionIsRunning);
        _;
    }

    function setAuctionRunning(bool _auctionIsRunning) onlyOwner public{
        auctionIsRunning = _auctionIsRunning;
    }

    function setTheOwner(address _address) onlyOwner public {
        owner = _address;
    }

    function paymeSomething() auctionRunning payable public {
        

    }

    function withdraw(address payable _to) onlyOwner public{
    
        _to.transfer(1000000000000000000);   //1 ether --18 zeros

    }
}