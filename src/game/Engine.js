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

    //execute attached functions
    if(currentState.functions){
        for(i=0,length=currentState.functions.length;i <length;i+=1){
            processedInput = this.custom[currentState.functions[i]](input);
        };
    };
    this.state.transfer(processedInput);
};