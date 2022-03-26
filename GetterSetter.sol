// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract GetterSetter{
    uint256 public myUint;
    uint256 public myOtherUint;

    function setmyUint(uint _myUint) public{
        myUint = _myUint;
    }

    //sets value for 2 variables together

    function setBothValues(uint _myUint, uint _myOtherUint) public{

        myUint = _myUint;
        myOtherUint = _myOtherUint;
    }

    //Gets values for both variables

    function getBothValues() public view returns(uint, uint) {
        return(myUint, myOtherUint);
    }

}