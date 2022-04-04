// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;

import "truffle/Assert.sol";
import "truffle/DeployedAddresses.sol";
import "../contracts/GameManager.sol";

contract TestGamemanager{
    function testInitialHighscoreIsZero(){
        GameManager gameManager = GameManager(DeployedAddresses.GameManager());
        (address[10] memory top10Adresses, uint[10] memory top10Wins) = gameManager.getTop10();
        Assert.equal(top10Wins[0], 0 ,"Initially no wins");
        Assert.equal(top10Addresses[0], address(0),"Initially noone is on top 10 list" );

    }
}