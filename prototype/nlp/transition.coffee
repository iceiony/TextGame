q = require 'Q'
_ = require 'lodash'
natural = require 'natural'

EMPTY_STRING_TRANSITION = "empty string transition"

__processString = (transitionString)->
  if(transitionString.trim().length == 0 )
    return EMPTY_STRING_TRANSITION

  transitionString = transitionString.replace(/'s/g, ' is');
  stringParts = transitionString.trim().toLowerCase().split(' ')

  newString = ""
  for word in stringParts
    if word.length < 3
      word = word + word
    newString = newString + " " + word
  newString = newString.trim()

#  console.log "old: #{transitionString}\nnew: #{newString}\n"
  return newString

class Transition
  constructor: (allTransitionStrings) ->
    logisticClassifier = new natural.LogisticRegressionClassifier();

    for singleTransition in allTransitionStrings
      if(singleTransition.trim().length == 0 )
        singleTransition = EMPTY_STRING_TRANSITION

      transitionStrings = singleTransition.split('/').map((transitionString)->
        return __processString(transitionString);
      )
      
      transitionStrings.forEach((transitionString)->
        logisticClassifier.addDocument(transitionString, singleTransition);
      )

    logisticClassifier.train()

    @logisticClassifier = logisticClassifier

  matchAsync: (input)->
    deferred = q.defer();

    input = __processString(input)

    setImmediate(=>
      matches = @logisticClassifier.getClassifications(input).filter((element)->
        element.value > 0.8)
      console.log "\nlogistic: "+ input
      console.log @logisticClassifier.getClassifications(input)

      topMatch = _(matches).sortBy((element)->
        element.value).first();

      if(topMatch?.label == EMPTY_STRING_TRANSITION)
        topMatch.label = ""

      deferred.resolve({
        input: input,
        match: topMatch?.label,
        ratio: topMatch?.value
      });
    )

    return deferred.promise;

module.exports = Transition