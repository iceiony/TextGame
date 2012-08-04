"use strict";
game.StateManager = function() {
    var regexFromString = function(input){
                        //TODO : refactor the next function's replace
                        input = input.replace("*",".+").replace("*",".+").replace("*",".+").replace("*",".+");
                        return new RegExp(input,"i");
                      },
        state_name,
        wildcard_matches,
        transition_string,
        next_state_name;

   //desereliase state from localStorage
   this.state_definition =  JSON.parse(localStorage.persistantState);

    //deserialisation step
    //create circular refferences in given stateObj
    for(state_name in this.state_definition){
        if(state_name!=="current"){
            wildcard_matches = [];
            this.state_definition[state_name].transitions = this.state_definition[state_name].transitions || {};

            for(transition_string in this.state_definition[state_name].transitions){
                if(transition_string.search("\\*")!==-1){
                    wildcard_matches.push({
                        matching_state: this.state_definition[this.state_definition[state_name].transitions[transition_string]],
                        regex:regexFromString(transition_string)
                    });
                    continue;
                };
                next_state_name = this.state_definition[state_name].transitions[transition_string];
                this.state_definition[state_name].transitions[transition_string] = this.state_definition[next_state_name];

            };
            this.state_definition[state_name]["name"] = state_name;
            this.state_definition[state_name]["WildCardMatches"]= wildcard_matches;
        };
    };
   this.state_definition["current"] = this.state_definition[this.state_definition["current"]];
   this.state_definition["current"] = this.state_definition[localStorage.currentStateKey];
};

game.StateManager.prototype.transfer = function(symbol){
    var i,
        length,
        wild_card_match,
        current_state = this.state_definition["current"];

    if( current_state.transitions[symbol] ) {
        current_state = current_state.transitions[symbol];
    }
    else {
        for(i=0,length=current_state["WildCardMatches"].length ;i<length;i+=1) {
            wild_card_match = current_state["WildCardMatches"][i];
            if(symbol.search(wild_card_match.regex)==0){
                current_state= wild_card_match.matching_state;
                break;
            };
        };
    };

    this.state_definition["current"] = current_state;
    localStorage.currentStateKey = current_state.name;
    return current_state.content
};

game.StateManager.prototype.getCurrent = function(){
    return this.state_definition["current"];
};