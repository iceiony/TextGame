assert = require 'assert'
intention = require '../model/intention'

describe('Classifying movement intentions correctly', ->
    describe('by actions and objects that are known', ->
        movement = [
            "go to tractor"
            "walk to farmer"
        ]

        movement.forEach((input)->
            it(input, (done)->
                intention.interpretAsync(input).done((res, err)->
                    if (err) then throw err
                    assert.strictEqual(res.type, 'movement', "For input : #{res.input}")
                    done()
                )
            ))
    )


    describe('by actions and directions', ->
        directions = [
            "move north"
            "go south"
        ]
        directions.forEach((input)->
            it(input, (done)->
                intention.interpretAsync(input).done((res, err)->
                    if (err) then throw err
                    assert.strictEqual(res.type, 'movement', "For input : #{res.input}")
                    done()
                )
            ))
    )
)