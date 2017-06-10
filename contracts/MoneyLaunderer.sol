pragma solidity ^0.4.4;

contract MoneyLaunderer {

	uint min_bet = 0.002 ether;
    mapping (address => uint) bets;
    



	function MoneyLaunderer() {
		// constructor
	}
    
    function bet() public payable {
        if (msg.value < min_bet) throw;
        if (bets[msg.sender] != 0) throw;
        bets[msg.sender] = block.number;
    }
    
    function collect() public {
        if (bets[msg.sender] == 0 || block.number == bets[msg.sender]) {
        	throw;
        } else if (block.number - bets[msg.sender] >= 256) {
            bets[msg.sender] = 0;
        } else if (uint(block.blockhash(bets[msg.sender] + 1)) % 2 == 0) {
            if (msg.sender.send(this.balance / 2)) {
                bets[msg.sender] = 0;
            } else {
                throw;
            }
        } else {
            bets[msg.sender] = 0;
        }
    }

    function ticketNumber() constant returns (uint) {
        return uint(block.blockhash(0));
    }
    
    function getCurrentTotalBet() constant returns (uint) {
        return this.balance / 2;
    }

}