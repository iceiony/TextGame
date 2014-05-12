class Context
  constructor: ->
    @_general = {}
    @_locations = {}
  
  text: (textSection) ->
    @currentText = textSection

    
  everywhere: (transitions) ->
    generalLinks = transitions()
    for transitions, functionToRun of generalLinks
      transitions = transitions.replace(/\s+/g, " ")
      @_general[transitions] = functionToRun
      
      
  location: (locationName , transitions)->
    if transitions == undefined
      @_curentLocation = locationName
      return
    
    @_locations[locationName] = @_locations[locationName] || {}
    locationLinks = transitions()
    for transitions, functionToRun of locationLinks
      transitions = transitions.replace(/\s+/g, " ")
      @_locations[locationName][transitions] = functionToRun    

      
  getCurrentTransitions: ->
    allTransitions = [].concat.apply([], Object.keys(@_general))
    currentLocationTransitions = @_locations[@_curentLocation]
    if (currentLocationTransitions)
      allTransitions = [].concat.apply(allTransitions, Object.keys(currentLocationTransitions))
    return allTransitions

    
  clearGeneral: ->
    delete @_general;
    delete @_locations;
    @_general = {}
    @_locations = {}

    
  toString: ->
    return @currentText;


module.exports = Context