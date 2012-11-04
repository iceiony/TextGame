"use strict";
Game.namespace("Game.Render.Text");
Game.Render.Text.simpleFadeIn = function(scene){
    var jQuery = $,
        outputElement = this.getOutputElement(),
        sceneText = scene.content,
        delay = 1597;

    outputElement.hide();
    outputElement.html(sceneText);
    outputElement.fadeIn(delay);
};