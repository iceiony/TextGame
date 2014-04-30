"use strict";
Game.namespace("Game.Debug");

Game.Debug.expandForTest = function(story){
    var jQuery = $,
        resetTransitions = {},
        newTransition,
        newStoryString,
        state_name;

    for(state_name in story){
        if(state_name!== "Title"){
            resetTransitions[state_name] = state_name;
        }
    }
    resetTransitions.initial = [resetTransitions.initial ,"reset"];

    for(state_name in story){
        if(state_name!== "Title"){
            story[state_name].transitions = story[state_name].transitions || {};
            console.log(state_name+"-"+ story[state_name].transitions);
            for(newTransition in resetTransitions)
            {
                story[state_name].transitions[newTransition] = story[state_name].transitions[newTransition] || resetTransitions[newTransition];
            }
        }
    }

    newStoryString = JSON.stringify(story);
    if(localStorage.persistantState !== newStoryString){
        localStorage.persistantState = newStoryString;
    }

    return story;
};