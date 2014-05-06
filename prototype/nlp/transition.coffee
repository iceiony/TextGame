q = require 'Q'
_ = require 'lodash'
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
      matches = @classifier.getClassifications(input).filter((element)-> element.value > 0.8)
      topMatch = _(matches).sortBy((element)-> element.value).first();

      deferred.resolve({
        input: input,
        match: topMatch?.label,
        ratio: topMatch?.value
      });
      #      console.log "\n" + input + " : " + JSON.stringify(@classifier.getClassifications(input)) + " match " + JSON.stringify(match)
    )

    return deferred.promise;

module.exports = Transition