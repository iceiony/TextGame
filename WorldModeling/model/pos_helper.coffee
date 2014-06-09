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
    input = input.replace(' ok',' OK')
    result =  ( { word:part[0] , tag:part[1] } for part in tag.tag(lex.lex(input))) 
    return result ; 
    
module.exports.isNoun = (tag)->
    return (tag in nounTags)