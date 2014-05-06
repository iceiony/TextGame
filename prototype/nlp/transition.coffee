q = require 'Q'
natural = require 'natural'

class Transition
  constructor: (allTransitionStrings) ->
    classifier = new natural.LogisticRegressionClassifier();

    for singleTransition in allTransitionStrings
      transitionStrings = singleTransition.split('/').map((element)->
        return element.trim().toLowerCase();
      )
      transitionStrings.forEach((element)->
        classifier.addDocument(element, singleTransition);
      )
    
    classifier.train();
    @classifier = classifier

  matchAsync: (input)->
    deferred = q.defer();

    setImmediate(=>
      match = @classifier.getClassifications(input).filter((element)->
        element.value > 0.8)
#      console.log "\n" + input + " : " + JSON.stringify(@classifier.getClassifications(input)) + " match " + JSON.stringify(match)
      deferred.resolve({
        input: input,
        match: match.length > 0 && match[0].label
      });
    )

    return deferred.promise;

module.exports = Transition