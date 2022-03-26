// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Variables{

    bool public myBool = false;
    // bool is bydefault false

    function setbool(bool _myBool) public{
        myBool = _myBool;
    }

    //unsigned integers vary from 8bit to 256 bit
    uint8 public myUints = 2 ** 8 -1;

    //Wrap around -- add 1 to 256 it becomes 0, decrement 0 from 256 it gives the greatest number
    // scope of pure function are inside the function itself

    function myUintWrapAround() public pure returns(uint8){
        uint8 myZeroUint = 0;
        myZeroUint--;
        return myZeroUint;
    }

    function DivisionExample() public pure returns(uint8){
        uint8 five = 5;
        uint8 two = 2;
        return five/two;
    }

    bytes1 public myBytes1 = 0xFF;

    function myBytesCompare() public view returns(bool){
        bytes2 myBytes2 = 0xFFFF;
        return myBytes1 < myBytes2;
    }

    function getMyBytesLength() public view returns(uint8){
        return myBytes1.length;
    }

    bytes32 public myBytes32 = 0xFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF;

    function compare32and1() public view returns(bool){
        return myBytes1 < myBytes32;
    }
}