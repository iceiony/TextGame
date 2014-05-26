util = require './util' 


class  Context
    constructor: ->
        @textRetrieved = false
        @characterDialog = {}
        @locationActions = {}
        @currentText = ''

    location: (location)->
        @curentLocation = location

    characters: (characters...)->
        @charactersNearby = characters

    lookingAt: (character)->
        @currentFocus = character

    say: (say)->
        @characterDialog[@currentFocus] = @characterDialog[@currentFocus] || {}
        character = @characterDialog[@currentFocus]
        for key,result of say
            character[key] = util.toDecorator(result)

    actions: (actions)->
        @locationActions[@curentLocation] = @locationActions[@curentLocation] || {}
        location = @locationActions[@curentLocation]
        for key,result of actions
            location[key] = util.toDecorator(result)

    walk: (destinations)->
        ##do nothing yet
        
    getCurrentFocus :->
        return @currentFocus
    getAllCharacterDialogue: ->
        return @characterDialog
    getActions: ->
        return @locationActions[@curentLocation]

    text: (text)->
        if(@textRetrieved == true)
            @currentText = ''
            @textRetrieved = false
        @currentText += text + "\n"

    getText: ->
        @textRetrieved = true
        return @currentText

module.exports = Context