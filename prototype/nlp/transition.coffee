natural = require 'natural'
wordnet = new natural.WordNet();

natural.PorterStemmer.attach();
natural.Metaphone.attach();


class Transition
  constructor: (transitionString,nonValidTransitions) ->
    classifier = new natural.LogisticRegressionClassifier();

    @transitionStrings = transitionString.split('/').map((element)->
      return element.trim().toLowerCase();
    )
    
    @transitionStrings = @transitionStrings.forEach((element)->
      element.tokenizeAndStem().forEach((token)->
        wordnet
      )
    )
    
    @transitionStrings.forEach((element)->
      classifier.addDocument(element,true);        
    )

    nonValidTransitions.forEach((nonTransition)->
      nonTransitionStrings = nonTransition.split('/').map((element)->
        return element.trim().toLowerCase();
      )
      nonTransitionStrings.forEach((element)->
        classifier.addDocument(element, false);
      )
    )
    
    classifier.train();
    @classifier = classifier 

  match: (input)->
    match = @classifier.getClassifications(input).filter((element)->
      return element.value > 0.5;
    )
    console.log "\n"+input+" : "+ JSON.stringify(@classifier.getClassifications(input)) + " match "+ JSON.stringify(match)
    return match.length > 0 && match[0].label;
    
    
module.exports = Transition