q = require 'Q'
_ = require 'lodash'
natural = require 'natural'

EMPTY_STRING_TRANSITION = "empty string transition"

class Transition
  constructor: (allTransitionStrings) ->
    classifier = new natural.LogisticRegressionClassifier();

    for singleTransition in allTransitionStrings
      if(singleTransition.trim().length == 0 )
        singleTransition = EMPTY_STRING_TRANSITION
        
      transitionStrings = singleTransition.split('/').map((transitionString)->
        return transitionString.trim().toLowerCase();
      )
      
      transitionStrings.forEach((transitionString)->
        classifier.addDocument(transitionString, singleTransition);
      )

    classifier.train();
    @classifier = classifier

  matchAsync: (input)->
    deferred = q.defer();
    
    if (input.trim().length == 0 ) 
      input = EMPTY_STRING_TRANSITION

    setImmediate(=>
      matches = @classifier.getClassifications(input).filter((element)-> element.value > 0.8)
      topMatch = _(matches).sortBy((element)-> element.value).first();
      
      if(topMatch?.label == EMPTY_STRING_TRANSITION)
        topMatch.label = ""

      deferred.resolve({
        input: input,
        match: topMatch?.label,
        ratio: topMatch?.value
      });
      #      console.log "\n" + input + " : " + JSON.stringify(@classifier.getClassifications(input)) + " match " + JSON.stringify(match)
    )

    return deferred.promise;

module.exports = Transition