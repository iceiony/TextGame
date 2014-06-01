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
            { input: "move north", distance: 'implicit'}
            { input: "go south", distance: 'implicit'}
            { input: "walk 10m to north", distance: 10, unit: "m"}
            { input: "walk north for 5feet", distance: 5, unit: "feet" }
        ]
        directions.forEach((direction)->
            it(direction.input, (done)->
                intention.interpretAsync(direction.input).done((res, err)->
                    if (err) then throw err
                    assert.strictEqual(res.type, 'movement', "For input : #{res.input}")
                    assert.strictEqual(res.distance, direction.distance)
                    assert.strictEqual(res.unit, direction.unit)
                    done()
                )
            ))
    )
)