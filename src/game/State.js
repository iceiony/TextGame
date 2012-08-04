"use strict";
game.State = function() {

   //desereliase state from localStorage
   this.stateObj =  JSON.parse(localStorage.persistantState);

    //TODO : refactor the next function's replace
    var createRegex = function(input){
        input = input.replace("*",".+").replace("*",".+").replace("*",".+").replace("*",".+");
        return new RegExp(input,"i");
    };

    //deserialisation step
    //create circular refferences in given stateObj
    for(var property in this.stateObj){
        if(property!=="current"){
            var matches = [];
            for(var child in this.stateObj[property]){
                if(child.search("\\*")!==-1){
                    var regObjPair = {
                                        obj: this.stateObj[this.stateObj[property][child]],
                                        reg:createRegex(child)
                                      };
                    matches.push(regObjPair);
                    continue;
                };
                if( child !== "content" && child!== "functions"){
                  var propertyTopKey = this.stateObj[property][child];
                    this.stateObj[property][child] = this.stateObj[propertyTopKey];
                };

            };
            this.stateObj[property]["name"] = property;
            this.stateObj[property]["WildCardMatches"]= matches;
        };
    };
   this.stateObj["current"] = this.stateObj[this.stateObj["current"]];
   this.stateObj["current"] = this.stateObj[localStorage.currentStateKey];

};

game.State.prototype.transfer = function(symbol){
    var index;
    if( this.stateObj["current"][symbol]) {
        this.stateObj["current"] = this.stateObj["current"][symbol];
    }
    else {
        for(index=0;index<this.stateObj["current"]["WildCardMatches"].length;index++) {
            var regObjPair = this.stateObj["current"]["WildCardMatches"][index];
            if(symbol.search(regObjPair.reg)==0){
                this.stateObj["current"]= regObjPair.obj;
                break;
            };
        };
    };
    localStorage.currentStateKey = this.stateObj["current"].name;
    return this.stateObj["current"].content
};

game.State.prototype.getCurrent = function(){
    return this.stateObj["current"];
};