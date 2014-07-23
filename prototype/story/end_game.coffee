endings = {
    accident: "A freak accident"
    murder: "A witness in middle of nowhere ?"
#    silence: "The consequence of silence"
    tractor: "A bumpy ride and messy outcome"
#    worldEnd : "Close to the edge of the world"
    dream : "Hidden name. Reality is only what you perceive it to be."
}
totalEndings = Object.keys(endings).length

module.exports.getEndingStatus = ()->
    endingLeft = Object.keys(endings).length
    result = "\n[ #{totalEndings - endingLeft}/#{totalEndings} total endings achieved ]"
    if (endingLeft > 0)
        nextEnding = Object.keys(endings)[0]
        result += "\n[ Can you find the others ? ] \nHint: #{endings[nextEnding]}"
    
    return result
    
module.exports.solveEnding = (endingName)->
    delete endings[endingName]