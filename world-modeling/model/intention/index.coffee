_ = require 'lodash'
q = require 'Q'
helper = require './../pos_helper'

silence = require './silence'
movement = require './movement'
observation = require './observation'
action = require './action'
dialogue = require './dialogue'

module.exports.interpretAsync = (input,lastTextOutput= "")->
    deferred = q.defer()
    input = input.trim()
                .toLowerCase()
                .replace("'m"," am")
                .replace("don't","do not")
                .replace("can't","can not")
    lastTextOutput = lastTextOutput.toLowerCase()

    setImmediate(-> 
        try
            intentions = [];
            sentences = helper.splitPhrase(input) 
            for part in sentences
                if (silence.test(part))
                    intentions.push(silence.analyse(part))
                    continue
        
                if (observation.test(part))
                    intentions.push(observation.analyse(part))
                    continue
        
                if (movement.test(part))
                    intentions.push(movement.analyse(part))
                    continue
        
                if dialogue.test(part,lastTextOutput)
                    intentions.push(dialogue.analyse(part,lastTextOutput))
                    continue
        
                if action.test(part)
                    intentions.push(action.analyse(part))
                    continue
                    
            if intentions.length > 0 
                deferred.resolve(intentions)
            else
                deferred.reject({Message:"Input should have matched an intention type"})
        catch exception
            deferred.reject(exception)
        
    )
    return deferred.promise;
    
   