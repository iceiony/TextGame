assert = require 'assert'
intention = require '../model/intention'

describe('Extracting the verb and object from action',->
    actions = [
        {input:"punch Henry",verb:"punch",object:"henry"}
        {input:"turn around body",verb:"turn around",object:"body"}
        {input:"open fist",verb:"open",object:"fist"}
        {input:"check fist",verb:"check",object:"fist"}
    ]
    
    actions.forEach((action)->
        it(action.input,(done)->
            intention.interpretAsync(action.input)
            .done((result)->
                assert.strictEqual(result.type,'action',"For input: #{result.input}")
                assert.strictEqual(result.object, action.object)
                assert.strictEqual(result.verb, action.verb)
                done()
            )
            
        )
    )
)