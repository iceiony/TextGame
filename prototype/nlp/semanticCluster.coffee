q = require 'Q'
natural = require 'natural'
_ = require 'lodash'
wordnet = new natural.WordNet()

lookupSingle = (term)->
  deferSingle = q.defer();
  wordnet.lookup(term, (results)->
    results = results.map((r)->
      {
      term: term.toLowerCase(),
      synsetOffset: r.synsetOffset.toString(),
      lemma: r.lemma,
      synonyms: r.synonyms,
      gloss: r.gloss,
      def: r.def,
      exp: r.exp
      })
    deferSingle.resolve(results);
  )
  return deferSingle.promise;

lookup = (terms) ->
  allDeferred = []
  for term in terms
    allDeferred.push(lookupSingle(term))
  return allDeferred;
  
generateSentencesFrom = (originalSentences,termsSynonyms)->
  allSentences = [].concat.apply([],originalSentences)
  currentIndex = originalSentences.length - 1  ;
  lastIndex = 0;
  
  while lastIndex<currentIndex
    for term of termsSynonyms 
      index = lastIndex
      while( index  <= currentIndex )
        sentence = allSentences[index]
        index++
        if sentence.search(term)>=0
          for synonym in termsSynonyms[term]
            if sentence != synonym && term != synonym
              newSentence = sentence.replace(term,synonym)
              if(allSentences.indexOf(newSentence)<0) 
                allSentences.push(newSentence)
    lastIndex = currentIndex
    currentIndex = allSentences.length - 1 
    
  return allSentences


generateFromAsync = (sentences)->
  deferLookup = q.defer();

  sentences = sentences.map((s)->s.toLowerCase());
  searchTerms = sentences;
  singleWords = sentences.map((s)-> s.split(/\s/));

  searchTerms = [].concat.apply(searchTerms, singleWords);
  searchTerms = searchTerms.filter((t)->
    t.trim().length > 0)

  q.all(lookup(searchTerms))
  .done((results)->
    
    recordsPerTerm = {}
    for singleTermResults in results.filter((r)-> r.length > 0 ) 
      recordsPerTerm[singleTermResults[0].term] = singleTermResults.length
        
    results = [].concat.apply([], results);
    links = {};
    for result in results
      links[result.term] = links[result.term] || [];
      hit_count = 0;
      reverse_hits = 0;
      for unrelated in results.filter((r)-> result.term.search(r.term)<0)
        for synonym in result.synonyms.map((s)->s.replace(/_/g,' '))
          if synonym != result.term
            hit_count += (unrelated.gloss.split(synonym).length - 1)
          else 
            hit_count += (unrelated.gloss.split(synonym).length - 1) / recordsPerTerm[result.term]
        for synonym in unrelated.synonyms.map((s)-> s.replace(/_/g,' '))
          if synonym!= unrelated.term
            reverse_hits += (result.gloss.split(synonym).length - 1)
          else
            reverse_hits += (result.gloss.split(synonym).length - 1) / recordsPerTerm[unrelated.term]
        reverse_hits /= ((unrelated.synonyms.length - 1) || 1);
      links[result.term].push({
        synsetOffset:result.synsetOffset , 
        score : hit_count / ((result.synonyms.length - 1)||1) + reverse_hits
      });

    termsSynonyms = {}
    for term of recordsPerTerm
      topSynsetOffset = _.max(links[term],(r)->r.score).synsetOffset;
      synonyms = results.filter((r)-> r.synsetOffset == topSynsetOffset )[0].synonyms
      termsSynonyms[term] = synonyms.map((s)-> s.replace(/_/g,' '))
      
    allSentences = generateSentencesFrom(sentences,termsSynonyms)
      
#    console.log(links);
#    console.log(results);
    
    
    deferLookup.resolve(allSentences);
  )
  return deferLookup.promise;


module.exports = {
  generateFromAsync: generateFromAsync
} 