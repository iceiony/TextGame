prompt = require('./prompt-input')()
runner = require('./runner')

console_loop = ->
    nodeText = runner.getCurrentText()

    prompt(nodeText, (userInput)->
        runner.processAsync(userInput)
        .done((result, error)->
            if error then throw error;
            setImmediate(console_loop))
        
    )

console_loop()