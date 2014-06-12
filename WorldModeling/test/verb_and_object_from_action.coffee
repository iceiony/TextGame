assert = require 'assert'
intention = require '../model/intention'

describe('Extracting the verb and entity from action',->
    actions = [
        {input:"punch Henry",verb:"punch",entity:"henry"}
        {input:"turn around body",verb:"turn",entity:"body"}
        {input:"open fist",verb:"open",entity:"fist"}
        {input:"check fist",verb:"check",entity:"fist"}
    ]
    
    actions.forEach((action)->
        it(action.input,(done)->
            intention.interpretAsync(action.input)
            .done((result)->
                assert.strictEqual(result.type,'action',"For input: #{result.input}")
                assert.strictEqual(result.entity, action.entity)
                assert.strictEqual(result.verb, action.verb)
                done()
            )
            
        )
    )
)