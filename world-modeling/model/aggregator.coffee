aggregate = (reaction)->
    text = reaction.text || ""
    if reaction.chain
        for react in reaction.chain 
            text += "\n" + aggregate(react) 
    return text

module.exports.aggregate = aggregate