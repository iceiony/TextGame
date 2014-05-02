var natural = require('natural'),
    wordnet = new natural.WordNet();

wordnet.lookup("look at", function(results) {
    results.forEach(function(result) {
        console.log('---------wordnet-result-------------');
        console.log(result.synsetOffset);
        console.log(result.pos);
        console.log(result.lemma);
        console.log(result.synonyms);
        console.log(result.pos);
        console.log(result.gloss);
    });
});



var natural = require('natural'),
    assert = require('assert');


var matcher = function(userInput,transitionInput){
    var inputStem = userInput.tokenizeAndStem();

    var transitionStem = transitionInput.map(function(element){
        return element.trim().toLocaleLowerCase().tokenizeAndStem();
    });

    console.log("\ninput: "+inputStem + "\ntransition: "+transitionStem);
    return true;
}


var stemmer = natural.PorterStemmer;
stemmer.attach();

var transitionInput = "What is the situation? / What am I seeing / Details / what is going on / what have we got / where is the body / so / what happened ".split('/');

var inputToMatch = "what is the case?";
var inputNotMatched = "pick up body";


matcher(inputToMatch,transitionInput);
matcher(inputNotMatched,transitionInput);

