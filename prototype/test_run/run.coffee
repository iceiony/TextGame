runner = require('../runner')

input = [
    "hello"
    "go to body"
    "go to tractor"
    "hello"
]

describe('Running with the predefined input', ->
    it('should not though any exception', (done)->
        console.log(runner.getCurrentText())
        
        executeNextInput = ->
            if input.length > 0 
                next = input.shift()    
                console.log next + "\n"
                runner.processAsync(next)
                .done( (res,err)->
                    if err then done(err)
                    
                    text = runner.getCurrentText()
                    console.log(text)
                    executeNextInput()
                )
            else 
                done()

        executeNextInput()
    )
)