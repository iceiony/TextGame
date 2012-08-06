"use strict";
Game.namespace("Game.Engine");

Game.Engine = function(){
    this.state = new Game.StateManager();
    this.custom = {};
};

Game.Engine.prototype.loadStory = function(gameStory) {
    localStorage.currentStateKey = "initial";
    localStorage.persistantState = JSON.stringify(gameStory);
    this.state = new Game.StateManager();
};

Game.Engine.prototype.process = function(input){
    var processedInput = input,
        i,
        length,
        currentState = this.state.getCurrent();

    //execute preTransition functions
    if(currentState.preTransition){
        for(i=0,length=currentState.preTransition.length;i <length;i+=1){
            processedInput = this.custom[currentState.preTransition[i]](processedInput);
        };
    };

    this.state.transfer(processedInput);
};