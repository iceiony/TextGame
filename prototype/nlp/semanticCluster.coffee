q = require 'Q'
natural = require 'natural'
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


generateFromAsync = (sentences)->
  deferLookup = q.defer();
  searchTerms = sentences;

  singleWords = sentences.map((s)->
    s.split(/\s/));

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
      key = result.term+ " "+result.synsetOffset
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
          
      links[key] = hit_count / ((result.synonyms.length - 1)||1) + reverse_hits;

    console.log(links);
    console.log(results);
    deferLookup.resolve(results);
  )
  return deferLookup.promise;


module.exports = {
  generateFromAsync: generateFromAsync
} 