class Paragraph
  constructor: (text, links) ->
    @text = text
    for linkOptions, functionToRun of links?.general
      for links in linkOptions.split('/')
        Paragraph::[links.toLowerCase] = functionToRun
    for linkOptions, functionToRun of links?.actions
      for links in linkOptions.split('/')
        @[links.toLowerCase] = functionToRun

  transition: (userInput)->
    return @[userInput.toLowerCase]()

  toString: ->
    return @text;


module.exports = Paragraph