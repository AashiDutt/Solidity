// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract HelloWorld{

    string public helloworld = "Hello World!!";

    function killMe() public{
        selfdestruct(msg.sender);
    }
}