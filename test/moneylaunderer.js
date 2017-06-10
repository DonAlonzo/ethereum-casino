var MoneyLaunderer = artifacts.require("./MoneyLaunderer.sol");

contract('MoneyLaunderer', (accounts) => {
  it("should not be zero", ()=> {
    return MoneyLaunderer.deployed().then((instance)=> {
      return instance.ticketNumber();
    }).then((balance)=> {
      assert.notEqual(balance.valueOf(), 0, "Should be a random number");
    });
  });
});
