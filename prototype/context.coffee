turnToDelegate = (argument)->
    switch typeof argument
        when 'function'
            return argument
        when 'string'
            return ->
                @text argument
        when 'object'
            if Array.isArray(argument)
                count = 0;
                return ->
                    @text argument[count];
                    if argument.length > count
                        count++
    return undefined;


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
            character[key] = turnToDelegate(result)

    actions: (actions)->
        @locationActions[@curentLocation] = @locationActions[@curentLocation] || {}
        location = @locationActions[@curentLocation]
        for key,result of actions
            location[key] = turnToDelegate(result)

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