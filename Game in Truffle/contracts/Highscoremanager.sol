// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;

contract HighscoreManager{
    address gameManager;

    event NewWinAdded(address _for, uint _totalWins);

    constructor(address _gameManager){
        gameManager = _gameManager;
    }

    modifier onlyGameManager(){
        require(msg.sender == gameManager);
        _;
    }

    struct Highscore{
        address lowerHighscoreAddress;
        address higherHighscoreAddress;

        uint numberOfWins;
        uint timeOfLastWin;
    }

    mapping(address => Highscore) public highscoreMapping;
    address highscoreHolder;

    function addWin(address _for) public onlyGameManager{
        highscoreMapping[_for].numberOfWins++;
        highscoreMapping[_for].timeOfLastWin = block.timestamp;

        emit NewWinAdded(_for, highscoreMapping[_for].numberOfWins);

        // Highscore list is initially empty
        if(highscoreHolder == address(0)){
            highscoreHolder =_for;
            return;
        }

        // if highscore list contains some elements -- reordering in a linkedlist
        address currentPosition = highscoreHolder;
        uint count;
        while(count <= 10){
            if(highscoreMapping[currentPosition].numberOfWins <= highscoreMapping[_for].numberOfWins && currentPosition != _for ){
                // first detach the item
                if(highscoreMapping[_for].lowerHighscoreAddress !=address(0)){
                    highscoreMapping[highscoreMapping[_for].lowerHighscoreAddress].higherHighscoreAddress = highscoreMapping[_for].higherHighscoreAddress;
                }

                if(highscoreMapping[_for].higherHighscoreAddress !=address(0)){
                    highscoreMapping[highscoreMapping[_for].higherHighscoreAddress].lowerHighscoreAddress = highscoreMapping[_for].lowerHighscoreAddress;
                }


                // assign the rigt upper and lower bounds

                highscoreMapping[_for].lowerHighscoreAddress = currentPosition;
                if(highscoreMapping[currentPosition].higherHighscoreAddress != address(0) && highscoreMapping[currentPosition].higherHighscoreAddress != _for ){
                    highscoreMapping[_for].higherHighscoreAddress  = highscoreMapping[currentPosition].higherHighscoreAddress;
                } else{
                    highscoreMapping[_for].higherHighscoreAddress = address(0);
                }


                //re-attach the item inside correct currentPosition
                if(highscoreMapping[currentPosition].higherHighscoreAddress !=address(0)){
                    highscoreMapping[highscoreMapping[currentPosition].higherHighscoreAddress].lowerHighscoreAddress =_for;
                }
                highscoreMapping[currentPosition].higherHighscoreAddress = _for;

                // if required assign a new highscoreholder
                if(count == 0){
                    highscoreHolder = _for;
                }
                return;

            }
            if(highscoreMapping[currentPosition].lowerHighscoreAddress == address(0) && currentPosition != _for){
               if(highscoreMapping[_for].lowerHighscoreAddress !=address(0)){
                    highscoreMapping[highscoreMapping[_for].lowerHighscoreAddress].higherHighscoreAddress = highscoreMapping[_for].higherHighscoreAddress;
                }

                if(highscoreMapping[_for].higherHighscoreAddress !=address(0)){
                    highscoreMapping[highscoreMapping[_for].higherHighscoreAddress].lowerHighscoreAddress = highscoreMapping[_for].lowerHighscoreAddress;
                } 

                highscoreMapping[currentPosition].lowerHighscoreAddress =_for;
                highscoreMapping[_for].higherHighscoreAddress = currentPosition;
                highscoreMapping[_for].lowerHighscoreAddress = address(0);
                return;
            }

            count++;
            currentPosition = highscoreMapping[currentPosition].lowerHighscoreAddress;
        }

        
    }

    function getTop10() public view returns(address[10] memory, uint[10] memory){
        address[10] memory topTenAddresses;
        uint[10] memory topTenWins;

        address currentPosition = highscoreHolder;
        for(uint i = 0; i<10; i++){
            topTenAddresses[i] = currentPosition;
            topTenWins[i] = highscoreMapping[currentPosition].numberOfWins;
            currentPosition = highscoreMapping[currentPosition].lowerHighscoreAddress;
            
        }

        return(topTenAddresses, topTenWins);

    }
}