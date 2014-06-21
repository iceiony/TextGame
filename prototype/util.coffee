characters = require('./story/characters').characters

module.exports.toDecorator = (argument)->
    switch typeof argument
        when 'function'
            wrapper = ->
                argument.call(@)
                wrapper.wasUsed = true
            return wrapper

        when 'string'
            stringDecorator = ->
                @text argument
                stringDecorator.wasUsed = true
            return stringDecorator

        when 'object'
            if Array.isArray(argument)
                count = 0;
                arrayDecorator = ->
                    @text argument[count];
                    if argument.length > count
                        count++
                    else
                        arrayDecorator.wasUsed = true
                return arrayDecorator

    return undefined