assert = require 'assert'
intention = require '../model/intention'

describe('Classifying movement intentions correctly', ->
    describe('by actions and known entities ', ->
        movements = [
            {input: "go to tractor", entity: "tractor"}
            {input: "walk to farmer", entity: "farmer"}
            {input: "go to body", entity: "body"}
        ]

        movements.forEach((movement)->
            it(movement.input, (done)->
                intention.interpretAsync(movement.input)
                .then((intentions)->
                    res = intentions.shift()
                    assert.strictEqual(res.type, 'movement', "For input : #{res.input}")
                    assert.strictEqual(res.entity, movement.entity, "For input : #{res.input}")
                )
                .done((res, err)->
                    done(err))
            )
        )
    )

    describe('by actions and unpredicted entities ( unknown ) ', ->
        movements = [
            {input :"walk to the car", entity : "car"}
            {input :"go to the moon", entity : "moon"}
        ]

        movements.forEach((movement)->
            it(movement.input, (done)->
                intention.interpretAsync(movement.input)
                .then((intentions)->
                    res = intentions.shift()
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
            { input: "move north", distance: 10}
            { input: "go south", distance: 10 }
            { input: "walk 10m to north", distance: 10, unit: "m"}
            { input: "walk north for 5feet", distance: 5, unit: "feet" }
        ]
        directions.forEach((direction)->
            it(direction.input, (done)->
                intention.interpretAsync(direction.input)
                .then((intentions)->
                    res = intentions.shift()
                    assert.strictEqual(res.type, 'movement', "For input : #{res.input}")
                    assert.strictEqual(res.distance, direction.distance)
                    if (direction.unit)
                        assert.strictEqual(res.unit, direction.unit)
                )
                .done((res,err)->
                    done(err)
                )
            ))
    )
)