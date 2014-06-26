_ = require 'lodash'
q = require 'Q'
helper = require './../pos_helper'

silence = require './silence'
movement = require './movement'
observation = require './observation'
action = require './action'
dialogue = require './dialogue'


module.exports.interpretAsync = (input)->
    deferred = q.defer()
    input = input.trim().toLowerCase()

    setImmediate(->
        if (silence.test(input))
            deferred.resolve(silence.analyse(input))
            return

        if (observation.test(input))
            deferred.resolve(observation.analyse(input))
            return

        if (movement.test(input))
            deferred.resolve(movement.analyse(input))
            return

        if dialogue.test(input)
            deferred.resolve(dialogue.analyse(input))
            return

        if action.test(input)
            deferred.resolve(action.analyse(input))
            return
            
    )
    return deferred.promise;
    
   