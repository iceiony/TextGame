q = require 'Q'

isQuestion = /\?|what|where|why|how|ask/
isExclamation = /(hi|hello|howdy|greetings)( .*|$)/

module.exports.interpretAsync = (input)->
    deferred = q.defer()

    setImmediate(->
        type = 'observation'

        if (isQuestion.test(input) || isExclamation.test(input))
            type = 'dialog'

        deferred.resolve({
            type: type
        });
    )
    return deferred.promise;
    
   