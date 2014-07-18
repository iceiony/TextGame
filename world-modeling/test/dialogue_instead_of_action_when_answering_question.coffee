assert = require ('assert')
intention = require '../model/intention'

describe('Dialogue instead of action when answerign a question',->

    it('Should classify "fine" as dialogue instead of action' , (done)->
    
        intention.interpretAsync("fine","Chief : how are you ?")
        .then((res)->
            res = res.shift()
            assert.strictEqual(res.type , 'dialogue', "Input : 'fine'\n Previous Output : 'how are you ?'")
        )
        .done((res,err)->
            done(err);
        )
    )
)