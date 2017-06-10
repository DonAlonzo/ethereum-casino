pragma solidity ^0.4.4;

contract MoneyLaunderer {

	uint TIME_TO_COLLECT = 200;
	uint MIN_BET = 0.002 ether;
	uint WINRATE = 100;
	mapping (address => uint) bets;
    
	function MoneyLaunderer() {}
    
	function bet() public payable {
		if (msg.value < MIN_BET) throw;
		if (bets[msg.sender] != 0) throw;
		bets[msg.sender] = block.number;
	}
    
	function collect() public {
		if (block.number - bets[msg.sender] >= TIME_TO_COLLECT) {
			bets[msg.sender] = 0;
		} else if (ticketNumber() == 0) {
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
		if (block.number > bets[msg.sender] + 1) throw;
		uint unknowableFutureHash = uint(block.blockhash(bets[msg.sender] + 2));
		uint userHash = uint(msg.sender);
		return (unknowableFutureHash + userHash) % WINRATE; 
	}
}
