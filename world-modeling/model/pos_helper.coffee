_ = require 'lodash'
pos = require 'pos'
lex = new pos.Lexer()
tag = new pos.Tagger()

verbTags = ['VB'
            'VBD'
            'VBG'
            'VBN'
            'VBP'
            'VBZ']

nounTags = ['NN'
            'NNP'
            'NNPS'
            'NNS']

isVerb = (word)->
    _.find(tag.lexicon[word], (wordTag)-> wordTag in verbTags)
isNoun = (word)->
    _.find(tag.lexicon[word], (wordTag)-> wordTag in nounTags)

module.exports.getVerbs = (input)->
    result = []
    for word in lex.lex(input)
        if tag.lexicon[word] && isVerb(word)
            result.push(word)
    result

module.exports.getNouns = (input)->
    result = []
    for word in lex.lex(input)
        if tag.lexicon[word] && isNoun(word)
            result.push(word)
    result

module.exports.tag = (input)->
    input = input.replace(' ok', ' OK')
    result = ( { word: part[0], tag: part[1] } for part in tag.tag(lex.lex(input)))
    return result;

module.exports.isNoun = (wordOrTag) ->
    isWord = tag.lexicon[wordOrTag]
    if(isWord)
        return (isWord[0] in nounTags)
    else
        return (wordOrTag in nounTags)

isEnumeration = /(and|or|,)/
module.exports.splitPhrase = (input) ->
    if(input.indexOf(',') > 0 )
        #handle comma special case
        #wish i could make this simpler : move x < y < z as positions of the parts to select a potential sub sentence 
        parts = lex.lex(input)
        sentences = []
        chunkAlerted = false
        x = y = z = 0
        for part in parts
            if (not chunkAlerted && part == ',' && y - x >= 3 )
                chunkAlerted = true
            else
                z = Math.max(y, z)
                if (not chunkAlerted)
                    y++
                else
                    z++
                    if( z - y == 3 )
                        chunkAlerted = false
                        if isEnumeration.test(parts[y+1..z].join(' '))
                            y = z
                        else
                            sentences.push(parts[x..y-1].join(' '))
                            x = y + 1
                            y = z
        if (x<y)
            sentences.push(parts[x..y].join(' '))
        return sentences
    return [input]

module.exports.isVerb = (wordOrTag) ->
    isWord = tag.lexicon[wordOrTag]
    if(isWord)
        return (isWord[0] in verbTags)
    else
        return (wordOrTag in verbTags)