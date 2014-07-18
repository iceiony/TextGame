assert = require ('assert')
intention = require '../model/intention'

describe('Dialogue instead of action when answerign a question',->

    it('Should classify "fine" as dialogue instead of action' , (done)->
        lastTextOutput = "Chief: Well...\n  How how are you ?"
        input = "fine"
        
        intention.interpretAsync(input,lastTextOutput)
        .then((res)->
            res = res.shift()
            assert.strictEqual(res.type , 'dialogue', "Input : 'fine'\n Previous Output : 'how are you ?'")
        )
        .done((res,err)->
            done(err);
        )
    )
)