q = require 'Q'
Character = require '../character'

class Anne extends Character
    constructor: ->
        super
            name : "anne"
            location  : { x: 15, y: 20 }

        @knowledge =
            'case' : {known:["we have a body"]}
            'body' : {known:["we don't know much without an autopsy"]}
            'fuck' : {known:["Oi!"]}
            'tits' : {known:["Excuse me !?"]}
            'death' : {known:["broken internal"]}
            'you' :
                'tits' : ['... ? Not in your dreams']
                'age' : ['private']
                'are' : ['fine, thanks']
                'fuck': ['slap you, if you continue.']
                'suck' : ['?']
                'dick' : ['not for you to see']
                'death' : ['broken internals']

module.exports.new = -> new Anne()