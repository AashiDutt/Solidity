// SPDX-License-Identifier: MIT
pragma solidity >=0.4.22 <0.9.0;
import {GameManager} from "./GameManager.sol";

contract ThreeInARow{
    GameManager gameManager;

    uint256 public gameCost = 0.1 ether;

    address payable  public player1;
    address payable public player2;
    address payable activePlayer;

    event PlayerJoined(address _player);
    event NextPlayer(address _player);

    event GameOverWithWin(address _winner);
    event GameOverWithDraw();
    event PayoutSuccess(address _reciever, uint _amountInWei);

    bool gameActive;

    address[3][3] gameBoard;

    uint gameValidUntil;
    uint timeToReact = 3 minutes;

    uint8 movesCounter;
    uint balanceToWithdrawPlayer1;
    uint balanceToWithdrawPlayer2;

    constructor(address _addrGameManager, address payable _player1)  payable {
        gameManager = GameManager(_addrGameManager);
        require(msg.value == gameCost, "Add more money");
        player1 = _player1;

    }

//player2 joins the game
    function joinGame() public payable{
        assert(player2 == address(0x0));
        assert(gameActive == false);
        require(msg.value == gameCost, "Add more money!! Aborting!");

        address admin;
        require(admin == msg.sender);
        player2 = payable(admin);

        emit PlayerJoined(player2);

        if(block.number %2 ==0){
            activePlayer = player2;
        } else{
            activePlayer = player1;
        }

        gameActive = true;

        gameValidUntil = block.timestamp + timeToReact;

        emit NextPlayer(activePlayer);

    }

//we return the board
    function getBoard() public view returns(address[3][3] memory) {
        	return gameBoard;
    }

//Set stone
    function setStone(uint8 x, uint8 y) public{
        uint8 boardSize = uint8(gameBoard.length);
        require(gameBoard[x][y] == address(0));
        assert(gameActive);
        assert(x < boardSize);
        assert(y < boardSize);
        require(msg.sender == activePlayer);
        require(gameValidUntil >= block.timestamp);
        movesCounter++;
        gameBoard[x][y] = msg.sender;

        //check for a win

        for(uint8 i =0; i< boardSize; i++){
            if(gameBoard[i][y] != activePlayer){
                break;
            }
            if(i == boardSize -1){
                setWinner(activePlayer);
                return;
            }
        }

        for(uint8 i =0; i< boardSize; i++){
            if(gameBoard[x][i] != activePlayer){
                break;
            }
            if(i == boardSize -1){
                setWinner(activePlayer);
                return;
            }
        }

        // checking if it's a diagonal win
        if(x == y){
            for(uint8 i =0; i< boardSize; i++){
                if(gameBoard[i][i] != activePlayer){
                    break;
                }
                if(i == boardSize-1){
                    setWinner(activePlayer);
                    return;
                }
            }
        }

        // checking if it's anti diagonal win
        if((x+y)== boardSize-1){
            for(uint8 i=0; i <boardSize; i++){
                if(gameBoard[i][(boardSize-1)-i] != activePlayer){
                    break;
                }

                if(i == boardSize-1){
                    setWinner(activePlayer);
                    return;
                }
            }
        }

        //check if it's a draw
        if(movesCounter ==(boardSize**2)){
            setDraw();
            return;
        }

        if(activePlayer ==player1){
            activePlayer =player2;
        } else{
            activePlayer = player1;
        }

        emit NextPlayer(activePlayer);
    }

//set the winner of game

    function setWinner(address payable _player) private{
        gameActive = false;
        gameManager.enterWinner(_player);
        uint balanceToPayOut = address(this).balance;
        if(_player.send(balanceToPayOut)!= true){
            if(_player == player1){
                balanceToWithdrawPlayer1 += balanceToPayOut;
            } else{
                balanceToWithdrawPlayer2 += balanceToPayOut;
            } 
        } else {
             emit PayoutSuccess(_player, balanceToPayOut);
        }
        
        emit GameOverWithWin(_player);
    }

// if the game is draw
    function setDraw() private{
        uint balanceToPayOut = address(this).balance/2;

        if(player1.send(balanceToPayOut) == false){
            balanceToWithdrawPlayer1 += balanceToPayOut;
        } else{
            emit PayoutSuccess(player1, balanceToPayOut);
        }
        if(player2.send(balanceToPayOut)== false){
            balanceToWithdrawPlayer2 += balanceToPayOut;
        } else{
            emit PayoutSuccess(player2, balanceToPayOut);
        }

        emit GameOverWithDraw();
    }

//if some problem arises while transfering ether at cashout/ win
    function withdrawWin(address payable _to) public{
        uint balanceToWithdraw;
        if(msg.sender == player1){
            require(balanceToWithdrawPlayer1 > 0);
            balanceToWithdraw = balanceToWithdrawPlayer1;
            balanceToWithdrawPlayer1 = 0;
            _to.transfer(balanceToWithdraw);
            emit PayoutSuccess(_to, balanceToWithdraw);
        }

        if(msg.sender == player2){
            require(balanceToWithdrawPlayer2 > 0);
            balanceToWithdraw = balanceToWithdrawPlayer2;
            balanceToWithdrawPlayer2 = 0;
            _to.transfer(balanceToWithdraw);
            emit PayoutSuccess(_to, balanceToWithdraw);
        }
    }

    function emergencyCashOut() public{
        require(gameValidUntil < block.timestamp);
        require(gameActive);
        setDraw();
    }

}