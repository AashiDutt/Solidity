const GameManager = artifacts.require("GameManger");
const ThreeInARow = artifacts.require("ThreeInARow");

contract("ThreeInARow Test Win", accounts =>{
    it("should be possible to end the game without a winner", async () =>{
        let gameManagerInstance = await GameManager.deployed();
        let txReciept = await gameManagerInstance.startNewGame({from: accounts[0], value: web3.utils.toWei("0.1", "ether")});
        let threeInARowInstance = await ThreeInARow.at(txReciept.logs[0].args._gameAddress);
        let txReceiptJoin = await threeInARowInstance.joinGame({from: accounts[1], value:web3.utils.toWei("0.1", "ether")});
        assert.equal("NextPlayer", txReceiptJoin.logs[1].event);

        let balancePlayer1BeforeDraw = await web3.eth.getBalance(accounts[0]);
        let balancePlayer2BeforeDraw = await web3.eth.getBalance(accounts[1]);

        let txReceiptPlayed = await threeInARowInstance.setStone(0,0, {from:txReceiptJoin.logs[1].args._player});
        
        txReceiptPlayed = await threeInARowInstance.setStone(1,1, {from:txReceiptPlayed.logs[0].args._player});
        txReceiptPlayed = await threeInARowInstance.setStone(0,1, {from:txReceiptPlayed.logs[0].args._player});
        txReceiptPlayed = await threeInARowInstance.setStone(0,2, {from:txReceiptPlayed.logs[0].args._player});
        txReceiptPlayed = await threeInARowInstance.setStone(2,0, {from:txReceiptPlayed.logs[0].args._player});
        txReceiptPlayed = await threeInARowInstance.setStone(1,0, {from:txReceiptPlayed.logs[0].args._player});
        txReceiptPlayed = await threeInARowInstance.setStone(2,1, {from:txReceiptPlayed.logs[0].args._player});
        txReceiptPlayed = await threeInARowInstance.setStone(2,2, {from:txReceiptPlayed.logs[0].args._player});
        txReceiptPlayed = await threeInARowInstance.setStone(1,2, {from:txReceiptPlayed.logs[0].args._player});

        // console.log(txReceiptPlayed);
        
        //let board = await threeInARowInstance.getBoard();
        let balancePlayer1AfterDraw = await web3.eth.getBalance(accounts[0]);
        let balancePlayer2AfterDraw = await web3.eth.getBalance(accounts[1]);
        
        if(txReceiptPlayed.logs[0].args._reciever == accounts[0]){
            assert.equal(accounts[0], txReceiptPlayed.logs[0].args._reciever , "Payout must be the first account");
            assert.equal(web3.utils.toWei("0.1", "ether"), txReceiptPlayed.logs[0].args._amountInWei , "Payout must be 0.1 Ether to the first account");
            assert.equal(accounts[1], txReceiptPlayed.logs[1].args._reciever , "Payout must be the second account");
            assert.equal(web3.utils.toWei("0.1", "ether"), txReceiptPlayed.logs[1].args._amountInWei , "Payout must be 0.1 Ether to the Second account");
        } else{
            assert.equal(accounts[1], txReceiptPlayed.logs[0].args._reciever , "Payout must be the first account");
            assert.equal(web3.utils.toWei("0.1", "ether"), txReceiptPlayed.logs[0].args._amountInWei , "Payout must be 0.1 Ether to the first account");
            assert.equal(accounts[0], txReceiptPlayed.logs[1].args._reciever , "Payout must be the second account");
            assert.equal(web3.utils.toWei("0.1", "ether"), txReceiptPlayed.logs[1].args._amountInWei , "Payout must be 0.1 Ether to the Second account");

        }
        

        assert.equal("GameOverWithDraw", txReceiptPlayed.logs[2].event, "Event GameOverWithDraw should have been emitted");


        
    });

    
});