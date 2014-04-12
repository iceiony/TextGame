story = require './story'
prompt = require('prompt-input')()
events = require('events')

currentNode = story.intro

eventEmitter = new events.EventEmitter()
eventEmitter.on("userInput", (userInput)->
  currentNode = currentNode.transition(userInput)
  promptForCurrentNode()
)

promptForCurrentNode = ->
  nodeText = "\n" + currentNode + "\n"
  prompt(nodeText, (userInput)->
    eventEmitter.emit("userInput", userInput)
  )

promptForCurrentNode()