class Context
  
  text: (textSection) -> 
    @currentText = textSection
    
  general: (generalTransitions) ->
    generalLinks = generalTransitions()
    for transitions, functionToRun of generalLinks
      transitions = transitions.replace(/\s+/g," ")
      @__general[transitions] = functionToRun
          
  actions: (actionTransitions) ->
    actionLinks = actionTransitions()
    for transitions, functionToRun of actionLinks
      transitions = transitions.replace(/\s+/g," ")
      @__actions[transitions] = functionToRun
    
  constructor: ->
    @__general = {}
    @__actions = {}

  getAllTransitions: ->
    allTransitions = [].concat.apply([],Object.keys(@__general))
    allTransitions = [].concat.apply(allTransitions,Object.keys(@__actions))
    return allTransitions

  clearGeneral: ->
    delete @__general;
    @__general = {}
      
  toString: ->
    return @currentText;


module.exports = Context