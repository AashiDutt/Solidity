// SPDX-License-Identifier: MIT
// https://docs.soliditylang.org/en/v0.8.10/units-and-global-variables.html
pragma solidity ^0.8.13;

contract Time{
    uint biddingStartTimeStamp = block.timestamp;
    uint biddingDays = 10 seconds; //gets converted into seconds

    function getCurrentTimeStamp() public  view returns(uint){
        return block.timestamp;
    }

    function isBiddingStillOpen() public view returns(bool) {
        return(getCurrentTimeStamp() > biddingStartTimeStamp && getCurrentTimeStamp() <=biddingStartTimeStamp + biddingDays );
    }

}