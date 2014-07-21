q = require 'Q'
natural = require 'natural'
thesaurus = require './thesaurus'

EMPTY_STRING_TRANSITION = "empty string transition"
#TODO see if instead of stripping it would be best to generate noise with common words
commonWordsToStrip = ["a", "what", "is", "i"];

_sanitiseForTransition = (transitionString)->
    if(transitionString.trim().length == 0 )
        return EMPTY_STRING_TRANSITION

    transitionString = transitionString.replace(/'s/g, ' is');
    transitionString = transitionString.replace(/'t/g, ' not');
    stringParts = transitionString.trim().toLowerCase().split(' ')

    newString = ""
    for word in stringParts
        if(commonWordsToStrip.indexOf(word) < 0)
            if word.length < 3
                word = word + word
            newString = newString + " " + word

    newString = newString.trim()
    return newString


class Transition
    constructor: (allTransitionStrings) ->
        deferred = q.defer()
        @clasdifierPromise = deferred.promise;

        setImmediate( ->
            try
                logisticClassifier = new natural.LogisticRegressionClassifier();
                for singleTransition in allTransitionStrings
                    if(singleTransition.trim().length == 0 )
                        singleTransition = EMPTY_STRING_TRANSITION
    
                    transitionStrings = singleTransition.split('/')
                    transitionStrings = transitionStrings.map((string)->
                        semanticRelated = thesaurus[string]?.split('/')
                        semanticRelated = semanticRelated || []
                        semanticRelated.push(string)
                        return semanticRelated
                    )
                    transitionStrings = [].concat.apply([], transitionStrings) # flatten 
                    transitionStrings = transitionStrings.map((transitionString)->
                        _sanitiseForTransition(transitionString))
    
                    transitionStrings.forEach((transitionString)->
                        logisticClassifier.addDocument(transitionString, singleTransition))
    
                logisticClassifier.train()
                deferred.resolve(logisticClassifier)
            catch exception
                deferred.reject(exception)
        )


    matchAsync: (input)->
        deferred = q.defer();
        @clasdifierPromise.done((classifier,error)->
            input = _sanitiseForTransition(input)

            matches = classifier.getClassifications(input)
            .filter((element)->
                element.value > 0.87)

#            console.log "\nlogistic: " + input
#            console.log classifier.getClassifications(input)

            topMatch = matches[0];

            if(topMatch?.label == EMPTY_STRING_TRANSITION)
                topMatch.label = ""

            deferred.resolve({
                input: input,
                match: topMatch?.label,
                ratio: topMatch?.value
                score: topMatch?.value
            });
        );

        return deferred.promise;

module.exports = Transition

    