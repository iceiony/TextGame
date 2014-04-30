"use strict";
Game.namespace("Game.Engine");
(function () {
    //decleare private functions withing scope
    var
        customFunctions,
        parentElement,
        inputElement,
        outputElement,
        prepareNewScene = function (state) {
            var prerender = state.atRender || (this.defaults && this.defaults.atRender),
                length = 0,
                i = 0;
            if (prerender) {
                for (i = 0, length = prerender.length; i < length; i += 1) {
                    state = customFunctions[prerender[i]].call(this, state);
                }
            }
            return state;
        },
        prepareDOM = function (engineInstance, DOMParent) {
            var jQuery = $,
                consoleForm;

            if (typeof DOMParent === 'string') {
                parentElement = jQuery("#" + DOMParent);
                // _parentElement = document.getElementById(params.DOMParent);
            } else {
                parentElement = DOMParent;
            }
            outputElement = jQuery("<div/>", { id: "output" });
            outputElement.appendTo(parentElement);

            consoleForm = jQuery("<form/>", { id: "consoleForm"});
            consoleForm.appendTo(parentElement);

            inputElement = jQuery("<input/>", { id: "input", type: "text" });
            inputElement.appendTo(consoleForm);

            consoleForm.submit(function (event) {
                event.preventDefault();
                engineInstance.process(inputElement.val());
                inputElement.val("");
                inputElement.focus();
                return false;
            });
        };

    //constructor
    Game.Engine = function (params) {
        this.state = new Game.StateManager();
        customFunctions = {};

        if (typeof params !== 'undefined') {

            if (typeof params.DOMParent !== 'undefined') {
                prepareDOM(this, params.DOMParent);
            }

            if (typeof params.atTransition !== 'undefined') {
                this.defaults = {};
                this.defaults.atTransition = params.atTransition;
            }
            if (typeof params.atRender !== 'undefined') {
                this.defaults = this.defaults || {};
                this.defaults.atRender = params.atRender;
            }
        }
    };

    //public members
    Game.Engine.prototype.loadStory = function (gameStory) {
        if(localStorage.currentStateKey === undefined ||
          (localStorage.persistantState !== undefined && JSON.parse(localStorage.persistantState).Title !== gameStory.Title)) {

            localStorage.currentStateKey = "initial";
            localStorage.persistantState = JSON.stringify(gameStory);
            this.state = new Game.StateManager();

        }
        prepareNewScene.call(this, this.state.getCurrent());
    };

    Game.Engine.prototype.process = function (input) {
        var processedInput = input,
            i,
            length,
            currentState = this.state.getCurrent(),
            preTransitions = currentState.atTransition || (this.defaults && this.defaults.atTransition);

        //execute preTransition functions
        if (preTransitions) {
            for (i = 0, length = preTransitions.length; i < length; i += 1) {
                processedInput = customFunctions[preTransitions[i]](processedInput);
            }
        }

        if(currentState !== this.state.transition(processedInput))
        {
            prepareNewScene.call(this, this.state.getCurrent());
        }
    };

    Game.Engine.prototype.loadCustomByNamespace = function (custom) {
        var i,
            length,
            getObjectFromNamespace = Game.namespace;

        for (i = 0, length = custom.length; i < length; i += 1) {
            customFunctions[custom[i]] = getObjectFromNamespace(custom[i]);
        }
    };

    Game.Engine.prototype.loadCustom = function (custom) {
        var functionName;

        if (Array.isArray(custom)) {
            return this.loadCustomByNamespace(custom);
        }

        for (functionName in custom) {
            if (typeof custom[functionName] === "function") {
                customFunctions[functionName] = custom[functionName];
            }
        }
    };

    Game.Engine.prototype.getInputElement = function () {
        return inputElement;
    };

    Game.Engine.prototype.getOutputElement = function () {
        return outputElement;
    };

    Game.Engine.prototype.getParentElement = function () {
        return parentElement;
    };

}());