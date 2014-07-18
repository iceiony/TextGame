q = require 'Q'
environment = require './environment'
Character = require '../character'


class Chief extends Character
    constructor: ->
        super
            name: "chief"
            location: { x: 20, y: 10 }
            
        @knowledge = 
            'case' : {known:["we have a body"] , question:["what happened"]}
            'body' : {known:["middle aged man","found in the middle of nowhere","half naked","he probably died last night"], question:["how the body got here","the cause of death"]}
            'fuck' : {known:["Hey! Watch your language"]}
            'dick' : {known:["You better watch your mouth boy !"]}
            'you' : 
                'think' : ['you should look at the body']
                'age' : ['57, boy']
                'are' : ['fine, thanks']
                'fuck': ['you if you keep swearing']
                'suck' : ['?']
                'dick' : ['not for you to see']

    react: (stimulus)->
        if stimulus.type == 'movement'
                if stimulus.character != 'wildcard' then return
                entity = environment.getObjectByName(stimulus.character)
                reaction = @move(entity)
                reaction.reason = 'follow'
                return reaction
            
        return super(stimulus)

module.exports.new = -> new Chief()