pragma solidity ^0.5.0;

contract Addresses{

    address public myAddress;

    function setAddress(address _myAddress) public{
        myAddress = _myAddress;
    }

    function getBalance() public view returns(uint){
        return myAddress.balance;
    }

    //payable fun is used for transaction from any address  or variable or function
    address payable public newAddress;

    function setnewAddress(address payable _newAddress) public{
        newAddress = _newAddress;
    }

    function payme() payable public{
    }

    function transferthemMoneyOut() public{
        newAddress.transfer(address(this).balance);
    }

}