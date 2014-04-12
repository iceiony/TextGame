class Paragraph
  constructor: (text, links) ->
    @text = text

    Paragraph::appendGeneralActions(links);
        
    for linkOptions, functionToRun of links?.actions
      for links in linkOptions.split('/')
        @[links.toLowerCase()] = functionToRun

  transition: (userInput)->
    if @[userInput.toLowerCase()]? == true
      return @[userInput.toLowerCase()]()
    else 
      return @["default"]()
  
  appendGeneralActions: (links) ->
    Paragraph::__general = Paragraph::__general || []
    for linkOptions, functionToRun of links?.general
      for links in linkOptions.split('/')
        Paragraph::[links.toLowerCase()] = functionToRun
        if links.toLowerCase() not in Paragraph::__general
          Paragraph::__general.push(links.toLowerCase())
      
  clearGeneral: ->
    for functionName in Paragraph::__general
      delete Paragraph::[functionName]
    delete Paragraph::__general
      
  toString: ->
    return @text;


module.exports = Paragraph