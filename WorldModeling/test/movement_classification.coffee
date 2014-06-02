assert = require 'assert'
intention = require '../model/intention'

describe('Classifying movement intentions correctly', ->
    describe('by actions and objects that are known', ->
        movements = [
            {input :"go to tractor", object : "tractor"}
            {input :"walk to farmer", object : "farmer"}
            {input :"go to body" , object : "body"}
        ]

        movements.forEach((movement)->
            it(movement.input, (done)->
                intention.interpretAsync(movement.input).done((res, err)->
                    if (err) then throw err
                    assert.strictEqual(res.type, 'movement', "For input : #{res.input}")
                    assert.strictEqual(res.object , movement.object, "For input : #{res.input}")
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