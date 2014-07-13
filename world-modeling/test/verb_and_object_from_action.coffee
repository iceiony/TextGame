assert = require 'assert'
intention = require '../model/intention'

describe('Extracting the verb and entity from action',->
    actions = [
        {input:"punch Henry",verb:"punch",entity:"henry"}
        {input:"turn around body",verb:"turn",entity:"body"}
        {input:"open fist",verb:"open",entity:"fist"}
    ]
    
    actions.forEach((action)->
        it(action.input,(done)->
            intention.interpretAsync(action.input)
            .done((intentions)->
                result = intentions.shift()
                assert.strictEqual(result.type,'action',"For input: #{result.input}")
                assert.strictEqual(result.entity, action.entity)
                assert.strictEqual(result.verb, action.verb)
                done()
            )
            
        )
    )
)