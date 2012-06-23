game = {};

game.State = function() {
       this.stateObj =  JSON.parse(localStorage.persistateState);

        //create circular refferences in given stateObj
        for(var property in this.stateObj){
            if(property!=="current"){
                for(var child in this.stateObj[property]){
                    if(child!=="content"){
                      var propertyTopKey = this.stateObj[property][child];
                        this.stateObj[property][child] = this.stateObj[propertyTopKey];
                    }
                }
                this.stateObj[property]["name"] = property;
            }
        }
       this.stateObj["current"] = this.stateObj[this.stateObj["current"]]
       this.stateObj["current"] = this.stateObj[localStorage.currentStateKey];
};

game.State.prototype.transfer = function(symbol){
    this.stateObj["current"] = this.stateObj["current"][symbol];
    localStorage.currentStateKey = this.stateObj["current"].name;
    return this.stateObj["current"].content
};
