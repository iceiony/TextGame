knownCharacters = [
    "Farmer"
    "Mark"
    "Edd"

    "Chief"
    "Stevey"
    "Henry"

    "Anne"
    "David"
    "Paramedics"
]

knownEntities = [
    "Tractor"
    "Body"

    "Environment"
]


module.exports.getAllKnownEntities = ->
    knownEntities.concat(knownCharacters)

module.exports.getAllKnownCharacters = ->
    knownCharacters