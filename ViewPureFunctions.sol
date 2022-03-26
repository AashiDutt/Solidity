// SPDX-License-Identifier: MIT
// https://solidity-by-example.org/view-and-pure-functions/
//View function declares that no state will be changed.
//Pure function declares that no state variable will be changed or read.

pragma solidity ^0.8.13;

contract ViewPureFunctions{
    uint myUint = 5; //Not public -- we need a reading function

    function updateMyUint(uint _myUint) public{
        myUint = _myUint;
    }

    //View fun won't update the state of the variable myUint
    function getMyUint() public view returns(uint){ 
       // myUint = 11; this is not possible
        return myUint;
    }

    //Pure function can access othe rpure func
    function multiplyByFive(uint _someNumber) public pure returns(uint){
        return _someNumber * 5;
    } 

    function fiveTimesMyUint() public view returns(uint){
        return multiplyByFive(myUint);
    }

}