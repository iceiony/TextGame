util = require './util' 

class NodeBuilder
    constructor: ->
        @resetNode()        
        
    resetNode: ->
        @node = {
            dialogue: {}
            observation: {}
            movement: {}
            action: {}
            text : ""
        }

    text: (text)->
        @node.text += text + "\n"
    
    dialogue: (character)->
        character = character.toLowerCase()
        return (phrase)=>
            for input,output of phrase
                @node.dialogue[character] = @node.dialogue[character] || {}
                @node.dialogue[character][input] = util.toDecorator(output)

    observation: (phrases)->
        for input,output of phrases
            @node.observation[input] = util.toDecorator(output)

    movement: (phrases)->
        for input, output of phrases
            @node.movement[input] = util.toDecorator(output)

    extractNode:()->
        current_node = @node
        @resetNode()
        return current_node

module.exports.NodeBuilder = new NodeBuilder()