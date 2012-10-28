"use strict";
Game.namespace("Game.Render.Text");
/*
 "this" will point to Game.Engine instance;
 Element returned will be a JQuery object;
 */
Game.Render.Text.typeWriterDisplay = function (scene) {
    var jQuery = $,
        outputElement = this.getOutputElement(),
        inputElement = this.getInputElement(),
        sceneText = scene.content,
        partialContent = "",
        segment,
        delay = 21,
        contentSize = sceneText.length,
        index=0,
        t,
        enterHandler,
        isBound = true;

    t = setInterval(function(){
        if( index === contentSize) {
            clearInterval(t);
            isBound = false;
            return;
        }

        segment=""+sceneText[index];
        if(segment === "<"){
            segment = sceneText.substr(index,sceneText.indexOf('>',index)-index+1);
            index += segment.length;
        }
        else{
            index += 1;
        }
        partialContent += segment;
        outputElement.html(partialContent);
    },delay);

    inputElement.bind("keydown",enterHandler = function(event){
        if(event.keyCode === 13){
            if(isBound){
                clearInterval(t);
                isBound=false;
                event.preventDefault();
                outputElement.html(sceneText);
                return false;
            }
            inputElement.unbind("keydown",enterHandler);
        }
        return true;
    });
};