game.Engine = function(){
    this.state = new game.State();
    this.custom = {};
};

game.Engine.prototype.loadStory = function(gameStory) {
    gameStory.current="initial";
    localStorage.currentStateKey = "initial";
    localStorage.persistantState = JSON.stringify(gameStory);
    this.state = new game.State();
};

game.Engine.prototype.process = function(input){
    var processedInput = input;
    //execute custom attached functions
    var currentState = this.state.getCurrent();
    if(currentState.functions){
        for(var i=0;i <currentState.functions.length;i++){
            console.log(currentState.functions[i]);
            console.log(JSON.stringify(this.custom));
            processedInput = this.custom[currentState.functions[i]](input);
        };
    };
    this.state.transfer(processedInput);
};