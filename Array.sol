// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

contract Arrays{

   // fixed size array -- all initial values are zero
   uint[5] public arrayFixedSize;

   //Dynamic sized array -- no initial values error
   uint[] public arrayDynamicSize;

   //Multi-dim array
   uint[2][] public arrayFixedDynamic;

   function getFixedDynamicLength() view public returns(uint, uint){
       return (arrayFixedDynamic.length, arrayFixedDynamic[0].length);
   }

   // to print whole array use getter fun

   function getFixedArray() view public returns(uint[5] memory){
       return arrayFixedSize;

   } 

   function getDynamicAll() view public returns(uint[2][] memory){
       return arrayFixedDynamic;
   }

   // writing into Dynamic array
   function increaseDynamicLength() public{
       arrayDynamicSize.length++;
       arrayDynamicSize[arrayDynamicSize.length-1] = 111;
       
   }

   function getDynamicArray() view public returns(uint[] memory){
       return arrayDynamicSize;
   }

    // writing into Fixed Dynamic array -- 1. inc length -- 2. put a number at index 0
   function increaseFixedDynamicLength() public{
       arrayFixedDynamic.length++;
       arrayFixedDynamic[arrayFixedDynamic.length-1][0] = 123;
       arrayFixedDynamic[arrayFixedDynamic.length-1][1] = 234;

   }
}