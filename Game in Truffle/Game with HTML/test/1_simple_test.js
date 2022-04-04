const GameManager = artifacts.require("GameManger");
const ThreeInARow = artifacts.require("ThreeInARow");

contract("ThreeInARow Test", accounts =>{
    it("should have an empty game board at the beginning", async () =>{
        let gameManagerInstance = await GameManager.deployed();
        let txReciept = await gameManagerInstance.startNewGame({value: web3.utils.toWei("0.1", "ether")});
        let threeInARowInstance = await ThreeInARow.at(txReciept.logs[0].args._gameAddress);
        let board = await threeInARowInstance.getboard();
        for(let i=0; i< 3; i++){
            for(let j =0; j< 3; j++){
                assert.equal(0, board[i][j], i+ " Row," +j +" column must be zero");
            }
        }
        Console.log(board);
        Console.log("Hello World");
        
    })
});