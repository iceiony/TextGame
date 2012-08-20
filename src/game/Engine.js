"use strict";
Game.namespace("Game.Engine");
(function(){
    //decleare private functions withing scope
    var _customFunctions ,
        _parentElement,
        _inputElement,
        _outputElement,
        _prepareNewScene = function(state){
        var prerender = state.preRender || (this.defaults && this.defaults.preRender),
            length=0,
            i=0;
        if(prerender){
            for(i=0,length=prerender.length;i<length;i+=1){
                state = _customFunctions[prerender[i]].call(this,state);
            }
        }
        return state;
    };

    //constructor
    Game.Engine = function(params){
        var jQuery = $;


        this.state = new Game.StateManager();
        _customFunctions = {};

        if(typeof params !== 'undefined'){
            if(typeof params.DOMParent !=='undefined'){
                if(typeof params.DOMParent ==='string'){
                    _parentElement = jQuery("#"+ params.DOMParent);
                   // _parentElement = document.getElementById(params.DOMParent);
                } else {
                    _parentElement = params.DOMParent;
                };
                _outputElement = jQuery("<div/>",{ id:"output" });
                _outputElement.appendTo(_parentElement);

                _inputElement = jQuery("<input/>",{ id:"input", type:"text" });
                _inputElement.appendTo(_parentElement);
            };

            if(typeof params.preTransition !== 'undefined'){
                this.defaults = {};
                this.defaults.preTransition = params.preTransition;
            };
            if(typeof params.preRender !=='undefined'){
                this.defaults = this.defaults||{};
                this.defaults.preRender = params.preRender;
            };
        };
    };

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
            currentState = this.state.getCurrent(),
            preTransitions = currentState.preTransition || (this.defaults && this.defaults.preTransition);

        //execute preTransition functions
        if(preTransitions){
            for(i=0,length=preTransitions.length;i <length;i+=1){
                processedInput = _customFunctions[preTransitions[i]](processedInput);
            };
        };
        this.state.transition(processedInput);

        _prepareNewScene.call(this,this.state.getCurrent());
    };

    Game.Engine.prototype.loadCustomByNamespace = function(custom){
        var i,
            length,
            getObjectFromNamespace = Game.namespace;

        for(i=0,length=custom.length;i<length;i+=1){
            _customFunctions[custom[i]] = getObjectFromNamespace(custom[i]);
        };
    };

    Game.Engine.prototype.loadCustom = function(custom){
        var functionName;

        if(Array.isArray(custom)) {
            return this.loadCustomByNamespace(custom);
        };

        for(functionName in custom){
            if(typeof custom[functionName] == "function"){
                _customFunctions[functionName] = custom[functionName];
            };
        };
    };

    Game.Engine.prototype.getInputElement = function(){
        return _inputElement;
    };

    Game.Engine.prototype.getOutputElement = function(){
        return _outputElement;
    };

    Game.Engine.prototype.getParentElement = function(){
        return _parentElement;
    }

}());