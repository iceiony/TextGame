"use strict";
Game.namespace("Game.Engine");
(function(){
    //decleare private functions withing scope
    var _prepareNewScene = function(state){
        var length=0,
            i=0;
        if(state.preRender){
            for(i=0,length=state.preRender.length;i<length;i+=1){
                state = this.custom[state.preRender[i]](state);
            }
        }
        return state;
    };

    //constructor
    Game.Engine = function(){
        this.state = new Game.StateManager();
        this.custom = {};
    }

    //public members
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

        _prepareNewScene.call(this,this.state.getCurrent());
    };

}());