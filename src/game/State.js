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
            for(transition_string in this.state_definition[state_name]){
                if(transition_string.search("\\*")!==-1){
                    wildcard_matches.push({
                        held_state: this.state_definition[this.state_definition[state_name][transition_string]],
                        regex:regexFromString(transition_string)
                    });
                    continue;
                };
                if( transition_string !== "content" && transition_string!== "functions"){
                   next_state_name = this.state_definition[state_name][transition_string];
                    this.state_definition[state_name][transition_string] = this.state_definition[next_state_name];
                };

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
        wildCardMatch;
    if( this.state_definition["current"][symbol]) {
        this.state_definition["current"] = this.state_definition["current"][symbol];
    }
    else {
        for(i=0,length=this.state_definition["current"]["WildCardMatches"].length ;i<length;i+=1) {
            wildCardMatch = this.state_definition["current"]["WildCardMatches"][i];
            if(symbol.search(wildCardMatch.regex)==0){
                this.state_definition["current"]= wildCardMatch.held_state;
                break;
            };
        };
    };
    localStorage.currentStateKey = this.state_definition["current"].name;
    return this.state_definition["current"].content
};

game.StateManager.prototype.getCurrent = function(){
    return this.state_definition["current"];
};