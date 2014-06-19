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

    dialogue: (character)->
        character = character.toLowerCase()
        return (phrase)=>
            for input,output of phrase
                @characterDialog[character] = @characterDialog[character] || {}
                @characterDialog[character][input] = util.toDecorator(output)

    observation: (phrases)->
        for input,output of phrases
            @allPossibleActions[input] = util.toDecorator(output)

    movement: (destinations)->
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