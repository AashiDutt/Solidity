pragma solidity ^0.5.0;

contract HelloWorld{

    string public helloworld = "Hello World !!";

    function WriteIntoHelloWorld(string  memory _helloworld) public{
        helloworld = _helloworld;
    }
}