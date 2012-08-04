"use strict";
game.Engine = function(){
    this.state = new game.StateManager();
    this.custom = {};
};

game.Engine.prototype.loadStory = function(gameStory) {
    gameStory.current="initial";
    localStorage.currentStateKey = "initial";
    localStorage.persistantState = JSON.stringify(gameStory);
    this.state = new game.StateManager();
};

game.Engine.prototype.process = function(input){
    var processedInput = input,
        i,
        currentState = this.state.getCurrent();

    //execute attached functions
    if(currentState.functions){
        for(i=0;i <currentState.functions.length;i++){
            console.log(currentState.functions[i]);
            console.log(JSON.stringify(this.custom));
            processedInput = this.custom[currentState.functions[i]](input);
        };
    };
    this.state.transfer(processedInput);
};