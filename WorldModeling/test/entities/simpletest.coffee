assert = require 'assert'
environment = require '../../model/entities/environment'

characters = [
    "farmer"
    "mark"
    "edd"

    "chief"
    "stevey"
    "henry"

    "anne"
    "david"
]

objects = [
    "tractor"
    "body"
    "environment"
    "paramedics"
]

describe('Retrieving the list of characters and objects ', ->
    resultedCharacters = environment.getAllCharacterNames()
    resultedEntities = environment.getAllEntityNames()

    it('Should have at least the expected characters', ->
       for character in characters
           assert(character in resultedCharacters,"Missing #{character}")
    )
    
    it('Should have at least the expected objects',->
        for object in objects
            assert(object in resultedEntities,"Missing #{object}")
    )
)