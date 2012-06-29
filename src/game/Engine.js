game.Engine = function(){
    this.state = new game.State(hash.clearHash);
};

game.Engine.prototype.loadStory = function(gameStory) {
    gameStory.current="initial";
    localStorage.currentStateKey = "initial";
    localStorage.persistantState = JSON.stringify(gameStory);
    this.state = new game.State(hash.clearHash);
};