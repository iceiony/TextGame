"use strict";
/**
 * Contains the game story as a JSON object
 */
var Story={
    "initial":{
        content:"Where am I, but more importantly , WHO am I ?",
        transitions:{
            "I am Adrian": "remember"
        }
    },
    "remember":{
        content:"Yes, that's it, that is my name. How could I forget"
    }
};