// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

import {ThreeInARow} from "./ThreeInARow.sol";
import {HighscoreManager} from "./Highscoremanager.sol";

contract GameManager{
    HighscoreManager highscoremanager;

    event EventGameCreated(address _player, address _gameAddress);
    mapping(address => bool) allowedToEnterHighscore;

    constructor() {
        highscoremanager = new HighscoreManager(address(this));
    }

    modifier onlyInGameHighscoreEditing{
        require(allowedToEnterHighscore[msg.sender], "You are not allowed to enter highscore here");
        _;
    }

    function enterWinner(address _winner)public onlyInGameHighscoreEditing{
        highscoremanager.addWin(_winner);
    }

    function getTop10() public view returns(address[10] memory, uint[10] memory){

        return highscoremanager.getTop10();
    }

    function startNewGame() public payable{
        
        address admin;
        require(msg.sender == admin);

        ThreeInARow threeInARow = (new ThreeInARow{value:msg.value})(address(this), payable(admin));
        allowedToEnterHighscore[address(threeInARow)] = true;
        emit EventGameCreated(msg.sender,address(threeInARow));


    }
}