q = require 'Q'
_ = require 'lodash'

previousIntention = undefined
composingEntities = [
    wildcard = require('./wildcard').new()
    body = require('./body').new()
    mark = require('./mark').new()
    tractor = require('./tractor').new()
    paramedics = require('./paramedics').new()
    Policemen = require('./policemen').new()
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
        if stimuli.character != entity.name
            entity_reactions = entity.react(stimuli)
            if !entity_reactions then continue
            if(!Array.isArray(entity_reactions))
                entity_reactions = [entity_reactions]
            chain_reactions = [].concat.apply(chain_reactions, entity_reactions)
    chain_reactions
    
retrieveEntityByName = (name, entityTree = composingEntities)->
    for entity in entityTree
        if entity.name == name or name in entity.aliases then return entity
        result = retrieveEntityByName(name, entity.composing)
        if result then return result

getDialogueDefaultByPriority = ()->
    namesByPriority = ['anne', 'mark', 'chief'] 
    for name in namesByPriority 
        entity = retrieveEntityByName(name)
        if wildcard.isNear(entity) then return name
    

module.exports.getAllEntityNames = ->
    extractAllNamesAndAliases(composingEntities).concat('environment')
        
module.exports.getAllNonCharacterNames = ->
    extractAllNamesAndAliases(composingEntities, (entity)-> not entity.isCharacter)
    
module.exports.getAllCharacterNames = ->
    extractAllNamesAndAliases(composingEntities, (entity)-> entity.isCharacter)
    
module.exports.getObjectByName = retrieveEntityByName
module.exports.composing = composingEntities

module.exports.reset = ->
    previousIntention = undefined
    composingEntities = [
        wildcard = require('./wildcard').new()
        body = require('./body').new()
        mark = require('./mark').new()
        tractor = require('./tractor').new()
        paramedics = require('./paramedics').new()
        Policemen = require('./policemen').new()
    ]

module.exports.reactAsync = (intention)->
    deferred = q.defer()

    if intention.type == 'dialogue'
        for key,value of intention  when value == 'implicit'
            if previousIntention?.type == 'dialogue'
                intention[key] = previousIntention[key]
            else
                intention.entity = getDialogueDefaultByPriority()
    previousIntention = intention
    
    reactions = []
    react = wildcard.execute(intention)
    if react.requires
        reactions.push(wildcard.execute(react.requires))
        react = wildcard.execute(intention)
    reactions.push(react)
    
    for react in reactions 
        react.chain = getChain(react)
        
    deferred.resolve(reactions)
    
    deferred.promise;