"use strict";
Game.namespace("Game.StateManager");
(function(){
    var generateRegex = function(inputString){
        //TODO : refactor the next function's replace
        inputString = inputString.replace("*",".+").replace("*",".+").replace("*",".+").replace("*",".+");
        return new RegExp(inputString,"i");
        },
        //after deserialisation, creates circular refferences and transition lookups
        buildDefinition = function(raw_definition){
            var state_name,
                wild_card_transitions,
                target_state_name,
                transitions,
                transition_text_string,
                i,
                length;
            for(state_name in raw_definition){
                raw_definition[state_name].name = state_name;
                transitions = raw_definition[state_name].transitions;
                delete(raw_definition[state_name].transitions);

                if(transitions){
                    wild_card_transitions = [];
                    raw_definition[state_name].transitions = {};
                    for(target_state_name in transitions){
                        for(i=0,length=transitions[target_state_name].length;i<length;i+=1){
                            transition_text_string= transitions[target_state_name][i];
                            if(transition_text_string.search("\\*")!==-1){
                                wild_card_transitions.push({
                                    state: raw_definition[target_state_name],
                                    regex: generateRegex(transition_text_string)
                                });
                                continue;
                            };
                            raw_definition[state_name].transitions[transition_text_string] = raw_definition[target_state_name];
                        };
                    };
                    raw_definition[state_name].transitions.wildCards= wild_card_transitions;
                };
            };

            return raw_definition;
        };

    Game.StateManager = function() {
        var state_definition;

        if(typeof localStorage.persistantState === 'undefined') return;
        state_definition =  buildDefinition(JSON.parse(localStorage.persistantState));

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
}());