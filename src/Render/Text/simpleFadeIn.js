"use strict";
Game.namespace("Game.Render.Text");
Game.Render.Text.simpleFadeIn = function(scene){
    var jQuery = $,
        outputElement = this.getOutputElement(),
        inputElement = this.getInputElement(),
        engine = this,
        sceneText = scene.content,
        sceneName = scene.name,
        enterHandler,
        delay = 1597;

    outputElement.hide();
    outputElement.addClass("whiteGlow");
    outputElement.html(sceneText);
    outputElement.fadeIn(delay);

    inputElement.bind("keydown",enterHandler = function(event){
        if(event.keyCode === 13 && engine.state.getCurrent().name !== sceneName){
            outputElement.html(sceneText);
            outputElement.removeClass("whiteGlow");
            inputElement.unbind("keydown",enterHandler);
        }
        return true;
    });
};