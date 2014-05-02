Q = require 'Q'
natural = require 'natural'
wordnet = new natural.WordNet()


class Transition
  constructor: (transitionString, nonValidTransitions) ->
    classifier = new natural.LogisticRegressionClassifier();

    @transitionStrings = transitionString.split('/').map((element)->
      return element.trim().toLowerCase();
    )

    @transitionStrings.forEach((element)->
      classifier.addDocument(element, true);
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

  matchAsync: (input)->
    deferred = Q.defer();

    setImmediate(=>
      match = @classifier.getClassifications(input).filter((element)-> element.value > 0.8 )
#      console.log "\n" + input + " : " + JSON.stringify(@classifier.getClassifications(input)) + " match " + JSON.stringify(match)
      deferred.resolve({
        input: input,
        match: match.length > 0 && match[0].label
      });
    )

    return deferred.promise;

module.exports = Transition