class Context
  
  text: (textSection) -> 
    @currentText = textSection
    
  general: (getGeneral) ->
    generalLinks = getGeneral()
    for linkOptions, functionToRun of generalLinks
      for links in linkOptions.split('/')
        @__general[links.toLowerCase().trim()] = functionToRun
          
  actions: (getActions) ->
    actionLinks = getActions()
    for linkOptions, functionToRun of actionLinks
      for links in linkOptions.split('/')        
        @__actions[links.toLowerCase().trim()] = functionToRun
    
  constructor: ->
    @__general = {}
    @__actions = {}

  clearGeneral: ->
    delete @__general;
    @__general = {}
      
  toString: ->
    return @currentText;


module.exports = Context