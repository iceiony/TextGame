"use strict";
Game.namespace("Game.StateManager");

Game.StateManager = function() {
    var generateRegex = function(inputString){
                        //TODO : refactor the next function's replace
                        inputString = inputString.replace("*",".+").replace("*",".+").replace("*",".+").replace("*",".+");
                        return new RegExp(inputString,"i");
                      },
        state_name,
        wild_card_transitions,
        transition_string,
        next_state_name,
        state_definition;

    if(typeof localStorage.persistantState === 'undefined') return;

    state_definition =  JSON.parse(localStorage.persistantState);

    //deserialisation step
    //create circular refferences in given state_definition
    for(state_name in state_definition){
        state_definition[state_name].name = state_name;

        if(state_definition[state_name].transitions){
            wild_card_transitions = [];
            for(transition_string in state_definition[state_name].transitions){
                if(transition_string.search("\\*")!==-1){
                    wild_card_transitions.push({
                        state: state_definition[state_definition[state_name].transitions[transition_string]],
                        regex: generateRegex(transition_string)
                    });
                    continue;
                };
                next_state_name = state_definition[state_name].transitions[transition_string];
                state_definition[state_name].transitions[transition_string] = state_definition[next_state_name];

            };
            state_definition[state_name].transitions.wildCards= wild_card_transitions;
        };
    };

   this.state_definition = state_definition;
   this.state_definition["current"] = state_definition[localStorage.currentStateKey];

};

Game.StateManager.prototype.transition = function(symbol){
    var i,
        length,
        wild_card_match,
        current_state = this.state_definition["current"];

    if(!current_state.transitions) return current_state;//if no transitions just return current content

    if( current_state.transitions[symbol] ) {
        current_state = current_state.transitions[symbol];
    }
    else {
        for(i=0,length=current_state.transitions.wildCards.length ;i<length;i+=1) {
            wild_card_match = current_state.transitions.wildCards[i];
            if(symbol.search(wild_card_match.regex)==0){
                current_state= wild_card_match.state;
                break;
            };
        };
    };

    this.state_definition["current"] = current_state;
    localStorage.currentStateKey = current_state.name;
    return current_state
};

Game.StateManager.prototype.getCurrent = function(){
    return this.state_definition["current"];
};