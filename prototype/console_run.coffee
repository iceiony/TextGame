Context = require './context'
Transition = require './nlp/transition'


story = require './story/story'
events = require 'events'
prompt = require('./prompt-input')()

decorator = story.intro
context = new Context()
transition = null;

eventEmitter = new events.EventEmitter()
eventEmitter.on("userInput", (userInput)->
  userInput = userInput.toLowerCase().trim();

  transition.matchAsync(userInput).then((result)->
    console.log("[#{result.match}]");
    
    decorator = context.__general[result.match] || 
      context.__general["default"];

    promptForCurrentNode()
  )
)

promptForCurrentNode = ->
  decorator.call(context)
  nodeText = context.toString()+"\n-> "
  prompt(nodeText, (userInput)->
    eventEmitter.emit("userInput", userInput)
  )
  
  transition = new Transition(context.getAllTransitions())

promptForCurrentNode()