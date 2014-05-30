util = require './util' 


class  Context
    constructor: ->
        @textRetrieved = false
        @characterDialog = {}
        @allPossibleActions = {}
        @currentText = ''
        @charactersNearby = []
        @objectsNearby = []

    location: (location)->
        @curentLocation = location

    characters: (characters...)->
        @charactersNearby = characters.map((name)-> name.trim().toLowerCase())

    say: (say)->
        for key,result of say
            characterName = util.extractRespondingCharacter(result)
            @characterDialog[characterName] = @characterDialog[characterName] || {}
            @characterDialog[characterName][key] = util.toDecorator(result)

    actions: (actions)->
        for key,result of actions
            @allPossibleActions[key] = util.toDecorator(result)

    walk: (destinations)->
        ##do nothing yet
        
    getDefaultCharacter :->
        return @charactersNearby[0]
        
    getAllCharacterDialogue: ->
        return @characterDialog
    getActions: ->
        return @allPossibleActions
    getCharactersNearby :->
        return @charactersNearby
    getObjectsNearby :->
        return @objectsNearby

    text: (text)->
        if(@textRetrieved == true)
            @currentText = ''
            @textRetrieved = false
        @currentText += text + "\n"

    getText: ->
        @textRetrieved = true
        return @currentText

module.exports = Context