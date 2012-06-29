game.State = function(hashFunction) {
    this.hash = hashFunction;

   //desereliase state from localStorage
   this.stateObj =  JSON.parse(localStorage.persistantState);

    //deserialisation step
    //create circular refferences in given stateObj
    for(var property in this.stateObj){
        if(property!=="current"){
            for(var child in this.stateObj[property]){
                if(child!=="content"){
                  var propertyTopKey = this.stateObj[property][child];
                    this.stateObj[property][child] = this.stateObj[propertyTopKey];
                };
            };
            this.stateObj[property]["name"] = property;
        };
    };
   this.stateObj["current"] = this.stateObj[this.stateObj["current"]]
   this.stateObj["current"] = this.stateObj[localStorage.currentStateKey];

};

game.State.prototype.transfer = function(symbol){
    var symbolHash = this.hash(symbol);
    if( this.stateObj["current"][symbolHash]) {
        this.stateObj["current"] = this.stateObj["current"][symbolHash];
    }
    else if(this.stateObj["current"]["*"]){
        console.log("badum");
        this.stateObj["current"]= this.stateObj["current"]["*"];
    }
    localStorage.currentStateKey = this.stateObj["current"].name;
    return this.stateObj["current"].content
};
