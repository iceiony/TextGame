class Context
  constructor: ->
    @__general = {}
    @__locations = {}
  
  text: (textSection) ->
    @currentText = textSection

    
  everywhere: (transitions) ->
    generalLinks = transitions()
    for transitions, functionToRun of generalLinks
      transitions = transitions.replace(/\s+/g, " ")
      @__general[transitions] = functionToRun
      
      
  location: (locationName , transitions)->
    if transitions == undefined
      @__curentLocation = locationName
      return
    
    @__locations[locationName] = @__locations[locationName] || {}
    locationLinks = transitions()
    for transitions, functionToRun of locationLinks
      transitions = transitions.replace(/\s+/g, " ")
      @__locations[locationName][transitions] = functionToRun    

      
  getCurrentTransitions: ->
    allTransitions = [].concat.apply([], Object.keys(@__general))
    currentLocationTransitions = @__locations[@__curentLocation]
    if (currentLocationTransitions)
      allTransitions = [].concat.apply(allTransitions, Object.keys(currentLocationTransitions))
    return allTransitions

    
  clearGeneral: ->
    delete @__general;
    delete @__locations;
    @__general = {}
    @__locations = {}

    
  toString: ->
    return @currentText;


module.exports = Context