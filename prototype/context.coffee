class Context
  
  text: (textSection) -> 
    @currentText = textSection
    
  general: (generalTransitions) ->
    generalLinks = generalTransitions()
    for transitions, functionToRun of generalLinks
      transitions = transitions.replace(/\s+/g," ")
      @__general[transitions] = functionToRun
          
  constructor: ->
    @__general = {}

  getAllTransitions: ->
    allTransitions = [].concat.apply([],Object.keys(@__general))
    return allTransitions

  clearGeneral: ->
    delete @__general;
    @__general = {}
      
  toString: ->
    return @currentText;


module.exports = Context