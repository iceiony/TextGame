Entity = require './entity'
environment = require './entities/environment'

upperCaseStart = (sentence) ->
    sentence[0].toUpperCase() + sentence[1..]

combineParts= (known,questions)->
    lines = []
    if(known.length + questions.length <= 3 && known.length > 0 && questions.length > 0)
        singleSentence = known.join(' , ')
        singleSentence += " and need to find out " + questions.join(' and ')
        singleSentence += '.'
        lines.push(singleSentence)
    else
        if known.length > 0
            binder = if known.length > 2 then ' , ' else ' and '
            lines.push("#{known.join(binder)}.")
        if questions.length > 0
            binder = if questions.length > 2 then ' , ' else ' or '
            lines.push("We don't know #{questions.join(binder)}.")
    return lines.map((sentence)-> upperCaseStart(sentence))

class Character extends Entity
    isCharacter: true

    constructor: (options)->
        @knowledge = {'unmatched':{}} 
        super options

    referredAs: ->
        capitalName = @name[0].toUpperCase() + @name[1..]
        return capitalName

    answerUnknown : (intention)->
        lines = []
        item = @knowledge['unmatched'][intention.concept] || { exhaustCount : 0 }
        @knowledge['unmatched'][intention.concept] = item

        switch item.exhaustCount
            when 0
                lines.push("What does that have to do with anything ?")
            when 1
                lines.push("What is it with you and the #{intention.concept} ?")
            else
                lines.push("No !")
                
        item.exhaustCount++
        return lines

    answerKnown: (intention)->
        lines = []
        item = @knowledge[intention.concept]
        item.exhaustCount = item.exhaustCount || 0

        if item.exhaustReset then  clearTimeout(item.exhaustReset)
        item.exhaustReset = setTimeout(->
            item.reminder = true;
            item.exhaustCount = 0
            item.knowIndex = 0
            item.questionIndex = 0
        , 5 * 60 * 1000)

        if(item.exhaustCount == 0 )
            knowIndex = item.knowIndex || 0
            knownParts = item.known.slice(knowIndex,knowIndex+3)
            item.knowIndex = knowIndex + knownParts.length

            questionIndex = item.questionIndex || 0
            questionParts = item.question.slice(questionIndex,questionIndex+3)
            item.questionIndex = questionIndex + questionParts.length

            if item.reminder
                lines.push("Like I said.")
                item.reminder = false

            lines = lines.concat( combineParts(knownParts, questionParts) )

            if (knownParts.length + questionParts.length == 0 )
                item.exhaustCount++
                lines.push("There isn't anything more I can tell you about it.")
        else
            switch item.exhaustCount
                when 1
                    lines.push("Listen, I don't know more about the #{intention.concept} than what I told you already")
                when 2
                    lines.push("Stop it with the darn #{intention.concept} already !")
                when 3
                    lines.push("If you ask me about the #{intention.concept} one more time you'll be dismissed !")
                when 4
                    lines.push("ignores the request.")
                else
                    lines.push("That's it Wildcard , you're off the case. Go home and take your medication and have a good rest.")
            item.exhaustCount++

        return lines

    answer : (intention)->
        if @knowledge[intention.concept] != undefined
            lines = @answerKnown(intention)
        else
            lines =  @answerUnknown(intention)

        text = @referredAs()+ " : " + lines[0]
        indentation = (new Array(@referredAs().length + 4 )).join(' ')
        for nextSentence in lines[1..]
            text += "\n" + indentation + nextSentence

        return {
            subject: @name
            type: "dialog"
            reason: "answer"
            text : text
        }
            
    greet: (characterName)->
        entity = environment.getObjectByName(characterName)
        if @isNear(entity)
            return {
                subject: @name
                object: entity.name
                type:"dialog"
                reason:"greet"
                text: "#{@referredAs()} : Hello #{entity.referredAs()}."
            }
            
    askAbout: (concept,characterName)->
        characterEntity = environment.getObjectByName(characterName)
        if @isNear(characterEntity)
            return {
                subject:@name
                object:characterEntity.name
                type:"dialog"
                reason: "ask"
                concept: concept
                text: "#{@referredAs()} : Tell me about the #{concept} #{characterEntity.referredAs()}."
            }

    move: (entityName)->
        entity = environment.getObjectByName(entityName)

        if not @isNear(entity)
            @location = entity.getLocation()
            return {
            subject: @name
            object: entity.name
            type: "movement"
            reason: "move"
            text: "#{@referredAs()} walks to #{entity.referredAs()}."
            }
        else
            return {
            subject: @name
            type: "nothing"
            text: "#{@referredAs()} is already next to #{entity.referredAs()}."
            }

module.exports = Character