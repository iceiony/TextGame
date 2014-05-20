colouriseDialog = require('./story/characters').colouriseDialog

_santise = (transitions)->
  return transitions.replace(/\s+/g, " ").replace(/\s*\/\s*/, "/")  

class Context
  constructor: ->
    @_general = {}
    @_locations = {}
    @_currentText = ""

  text: (textSection) ->
    @_currentText += textSection + "\n"


  everywhere: (transitions) ->
    generalLinks = transitions()
    for transitions, functionToRun of generalLinks
      transitions = _santise(transitions)
      @_general[transitions] = functionToRun


  location: (locationName, transitions)->
    if transitions == undefined
      @_curentLocation = locationName
      return

    @_locations[locationName] = @_locations[locationName] || {}
    locationLinks = transitions()
    for transitions, functionToRun of locationLinks
      transitions = _santise(transitions)
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
    setImmediate(=>
      @_currentText = "";
    )
    return colouriseDialog(@_currentText);


module.exports = Context