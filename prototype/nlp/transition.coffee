q = require 'Q'
natural = require 'natural'
semanticCluster = require './semanticCluster'

class Transition
  constructor: (transitionString, nonValidTransitions) ->
    classifier = new natural.LogisticRegressionClassifier();

    @transitionStrings = transitionString.split('/').map((element)->
      return element.trim().toLowerCase();
    )

    nonValidTransitions.forEach((nonTransition)->
      nonTransitionStrings = nonTransition.split('/').map((element)->
        return element.trim().toLowerCase();
      )
      nonTransitionStrings.forEach((element)->
        classifier.addDocument(element, false);
      )
    )
    
    semanticCluster.generateFromAsync(@transitionStrings)
    .done((result,error)=>
      result.forEach((element)->
        classifier.addDocument(element, true);
      )
      classifier.train();
      @classifier = classifier
      
      if(@matchRequired)
        @__doClassification(@matchRequired.input,@matchRequired.deferred)
        
    )
    
  __doClassification: (input,deferred)->
    match = @classifier.getClassifications(input).filter((element)-> element.value > 0.81)
    deferred.resolve({
      input: input,
      match: match.length > 0 && match[0].label
    });
    console.log "\n" + input + " : " + JSON.stringify(@classifier.getClassifications(input)) + " match " + JSON.stringify(match)


  matchAsync: (input)->
    deferred = q.defer();

    setImmediate(=>
      if(@classifier)
        @__doClassification(input,deferred)
      else
        @matchRequired = {
          deferred : deferred,
          input: input
        };
    )

    return deferred.promise;

module.exports = Transition