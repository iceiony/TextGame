runner = require('../runner')

input = ["hello"]

describe('Running with the predefined input', ->
    it('should not though any exception', (done)->
        console.log(runner.getCurrentText())
        
        executeNextInput = ->
            if input.length > 0 
                next = input.shift()    
                console.log next + "\n"
                runner.processAsync(next)
                .done( (res,err)->
                    text = runner.getCurrentText()
                    console.log(text)
                    executeNextInput()
                )
            else 
                done()

        executeNextInput()
    )
)