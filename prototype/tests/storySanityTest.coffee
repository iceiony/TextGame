assert = require ('assert')
events = require('events')
Context = require('../context')
story = require('../story/story')



clone = (obj) ->
  if not obj? or typeof obj isnt 'object'
    return obj

  if obj instanceof Date
    return new Date(obj.getTime())

  if obj instanceof RegExp
    flags = ''
    flags += 'g' if obj.global?
    flags += 'i' if obj.ignoreCase?
    flags += 'm' if obj.multiline?
    flags += 'y' if obj.sticky?
    return new RegExp(obj.source, flags)

  newInstance = new obj.constructor()

  for key of obj
    newInstance[key] = clone obj[key]

  return newInstance

  
  
describe('Executing all transitions in story to make sure it does not error any where', ->
  visitedDecoratorStrings = []
  eventEmitter = new events.EventEmitter()
  context = new Context()
  startTime =null

  before(->
    startTime = new Date();
  )
  
  after(->
    executionTime = (new Date() - startTime) / 1000 ;
    console.log """
    Story consistency test summary 
    Total number of nodes : #{visitedDecoratorStrings.length} 
    Total execution time : #{executionTime} ms"""
  )
  
  it("should make transitions correctly", ->
    
    executeTransition = (localContext,decorator,transitionName)->
      try
        visitedDecoratorStrings.push(decorator.toString())
        decorator.call(localContext)
        eventEmitter.emit("transition done",localContext);
      catch ex
        ex.message += " [#{transitionName}]" 
        throw ex

    eventEmitter.on("transition done",(localContext)->
      currentTransitions = localContext.getCurrentTransitions()
      currentTransitions.push("default")
      currentLocation = localContext._curentLocation
      
      for transitionName in currentTransitions
        decorator = localContext._locations[currentLocation]?[transitionName] ||
                    localContext._general[transitionName];
        if(visitedDecoratorStrings.indexOf(decorator.toString()) < 0 )
          executeTransition(clone(localContext),decorator,transitionName)   
    )

    executeTransition(context,story.intro,"intro")
  )
)
