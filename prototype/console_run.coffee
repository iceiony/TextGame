Context = require './context'
Transition = require './nlp/transition'
server_logging = require './server_logging/logging_client'

story = require './story/story'
events = require 'events'
prompt = require('./prompt-input')()

decorator = story.intro
context = new Context()
transition = null

eventEmitter = new events.EventEmitter()
eventEmitter.on("userInput", (userInput)->
  userInput = userInput.toLowerCase().trim()
  server_logging.record(userInput + "\n")

  transition.matchAsync(userInput).then((result)->
    console.log("[#{result.match}]")
    server_logging.record("[#{result.match}]\n")
    
    currentLocation = context.__curentLocation;
    
    decorator = context.__locations[currentLocation]?[result.match] || 
      context.__general[result.match] ||
      context.__general["default"]

    promptForCurrentNode()
  )
)

promptForCurrentNode = ->
  setImmediate(->
    decorator.call(context)
    nodeText = context.toString() + "\n-> "
    server_logging.record((nodeText))
    prompt(nodeText, (userInput)->
      eventEmitter.emit("userInput", userInput)
    )
    transition = new Transition(context.getCurrentTransitions())
  )
  

promptForCurrentNode()

