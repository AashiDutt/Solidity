pragma solidity ^0.5.0;

contract HelloWorld{

    string public helloworld = "Hello World!!";

    function killMe() public{
        selfdestruct(msg.sender);
    }
}