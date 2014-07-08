assert = require 'assert'
intention = require '../model/intention'

describe('Dialogue Statements - should be classified correctly',->
        statements =[
            {input:"i don't know"}
            {input:"he was a smoker"}
            {input:"he is guilty"}
        ]
        
        statements.forEach((statement)->
            it(statement.input,(done)->
            
                intention.interpretAsync(statement.input)
                .then((result)->
                    assert.strictEqual(result.type,'dialogue',"Input : #{statement.input}");
                    assert.strictEqual(result.subtype,'statement',"Input: #{statement.input}")
                )
                .done((res,err)->
                    done(err);
                )
            )
        );
)