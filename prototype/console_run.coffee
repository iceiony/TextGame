Context = require './context'
story = require './story'
events = require 'events'
prompt = require('prompt-input')()

decorator = story.intro
context = new Context()

eventEmitter = new events.EventEmitter()
eventEmitter.on("userInput", (userInput)->
  lowerCase = userInput.toLowerCase()
  
  decorator = context.__actions[lowerCase] ||
    context.__general[lowerCase] ||
    context.__actions["default"] ||
    context.__general["default"];
  
  promptForCurrentNode()
)

promptForCurrentNode = ->
  delete context.__actions;
  context.__actions = {};
  
  decorator.call(context)
  nodeText = context.toString()+"\n"
  prompt(nodeText, (userInput)->
    eventEmitter.emit("userInput", userInput)
  )

promptForCurrentNode()