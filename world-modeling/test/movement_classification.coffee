assert = require 'assert'
intention = require '../model/intention'

describe('Classifying movement intentions correctly', ->
    describe('by actions and known entities ', ->
        movements = [
            {input :"go to tractor", entity : "tractor"}
            {input :"walk to farmer", entity : "farmer"}
            {input :"go to body" , entity : "body"}
        ]

        movements.forEach((movement)->
            it(movement.input, (done)->
                intention.interpretAsync(movement.input).done((res, err)->
                    if (err) then throw err
                    assert.strictEqual(res.type, 'movement', "For input : #{res.input}")
                    assert.strictEqual(res.entity , movement.entity, "For input : #{res.input}")
                    done()
                )
            ))
    )

    describe('by actions and unpredicted entities ( unknown ) ', ->
        movements = [
            {input :"walk to the car", entity : "car"}
            {input :"go to the moon", entity : "moon"}
        ]

        movements.forEach((movement)->
            it(movement.input, (done)->
                intention.interpretAsync(movement.input)
                .then((res)->
                    assert.strictEqual(res.type, 'movement', "For input : #{res.input}")
                    assert.strictEqual(res.entity , movement.entity, "For input : #{res.input}")
                )
                .done((res,err)->
                    done(err)
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