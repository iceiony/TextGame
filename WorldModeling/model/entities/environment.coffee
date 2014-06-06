q = require 'Q'

composingEntities = [
    wildcard = require('./wildcard').new()
    body = require('./body').new()
    mark = require('./mark').new()
    tractor = require('./tractor').new()
    paramedics = require('./paramedics').new()
    policeman = require('./policeman').new()
]

extractAllNamesAndAliases = (entities, filter = -> true) ->
    result = []
    if(entities.length > 0)
        for entity in entities
            sub_names = extractAllNamesAndAliases(entity.composing)
            result = [].concat.apply(result, sub_names)
            if not filter(entity)
                continue
            result = [].concat.apply(result, entity.aliases)
            result.push(entity.name)
    result

getChain = (stimuli) ->
    chain_reactions = []
    for entity in composingEntities
        if stimuli.subject != entity.name
            entity_reactions = entity.react(stimuli)
            chain_reactions = [].concat.apply(chain_reactions,entity_reactions)
    chain_reactions 

module.exports.getAllEntityNames = ->
    extractAllNamesAndAliases(composingEntities).concat('environment')

module.exports.getAllCharacterNames = ->
    extractAllNamesAndAliases(composingEntities, (entity)->
        entity.isCharacter)

module.exports.getObjectByName = (name)->
    for entity in composingEntities
        if entity.name == name
            return entity

module.exports.composing = composingEntities

module.exports.reactAsync = (intention)->
    deferred = q.defer()

    reaction = wildcard.execute(intention)
    reaction.chain = getChain(reaction)

    deferred.resolve(reaction)

    deferred.promise;