"use strict";
Game.namespace("Game.Render.Text");
Game.Render.Text.simpleFadeIn = function(scene){
    var jQuery = $,
        outputElement = this.getOutputElement(),
        inputElement = this.getInputElement(),
        engine = this,
        sceneText = scene.content,
        sceneName = scene.name,
        glowHandler,
        delay = 1597,
        glowColor = outputElement.css("color");

    outputElement.hide();
    outputElement.css({textShadow : "0 0 10px "+glowColor});
    outputElement.html(sceneText);
    outputElement.fadeIn(delay);

    inputElement.bind("keydown",glowHandler = function(event){
        if(event.keyCode === 13){
            outputElement.css({textShadow : ""});
            inputElement.unbind("keydown",glowHandler);
        }
    });
};