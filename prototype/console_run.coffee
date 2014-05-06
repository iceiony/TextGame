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
    matchedTransition = result.match || "default"
    
    console.log("[#{matchedTransition}]");
    
    decorator = context.__general[matchedTransition];

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