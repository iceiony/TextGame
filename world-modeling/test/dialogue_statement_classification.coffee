assert = require 'assert'
intention = require '../model/intention'

describe('Dialogue Statements - should be classified correctly',->
        statements =[
            {input:"i don't know"}
            {input:"he was a smoker"}
            {input:"he is guilty"}
            {input:"this is brilliant"}
            {input:"i don't know what to do"}
            {input:"I can't tell"}
        ]
        
        statements.forEach((statement)->
            it(statement.input,(done)->
            
                intention.interpretAsync(statement.input)
                .then((intentions)->
                    result = intentions.shift()
                    assert.strictEqual(result.type,'dialogue',"Input : #{statement.input}");
                    assert.strictEqual(result.subtype,'statement',"Input: #{statement.input}")
                )
                .done((res,err)->
                    done(err);
                )
            )
        );
)