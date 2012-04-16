game = {};

game.State = function() { };

game.State.prototype.transfer = function(symbol) {
  console.log("state transfer by "+symbol);
};
