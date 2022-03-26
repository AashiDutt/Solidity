// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract HelloWorld{

    string public helloworld = "Hello World !!";

    function WriteIntoHelloWorld(string  memory _helloworld) public{
        helloworld = _helloworld;
    }
}