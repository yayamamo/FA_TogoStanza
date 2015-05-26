class FindSentenceFromTermStanza < TogoStanza::Stanza::Base
  endpoint = 'http://ep.dbcls.jp:18890/sparql'
  property :sentence do |jid|
    query(endpoint, <<-SPARQL_Q1.strip_heredoc)
PREFIX ao: <http://purl.org/ao/>
PREFIX aos: <http://purl.org/ao/selectors/>
PREFIX dcterms: <http://purl.org/dc/terms/>
PREFIX doco: <http://purl.org/spar/doco/>
PREFIX nlp: <http://navi.first.lifesciencedb.jp/nlp/>
PREFIX lsd: <http://purl.jp/bio/10/lsd/term/>

SELECT distinct (str(?h) as ?head) (str(?yl) as ?yogen) (encode_for_uri(?stc) as ?uristc) (str(?l) as ?sentence)
FROM <http://purl.jp/bio/10/lsd2fa>
WHERE {
  ?p a nlp:joshi .
  ?stc ^dcterms:isPartOf [
    ?p ?h ;
    nlp:yogen ?y ] ;
    ^doco:isContainedBy [
      aos:exact ?o ;
      ^ao:context/ao:hasTopic ?jid ] ;
    rdfs:label ?l .
  ?y rdfs:label ?yl .
  FILTER(contains(?o, ?h) || contains(?h, ?o))
  #VALUES ?h {"kakuhead"}
  #VALUES ?y {nlp:yogen}
  VALUES ?jid {lsd:#{jid}}
}
SPARQL_Q1
  end

  property :term do |jid|
    #jid = jid.gsub(/^http:.*\/([^\/]+)$/, '\1')
    result = query(endpoint, <<-SPARQL_Q2.strip_heredoc)
PREFIX ao: <http://purl.org/ao/>
PREFIX aos: <http://purl.org/ao/selectors/>
PREFIX lsd: <http://purl.jp/bio/10/lsd/term/>

SELECT distinct (str(?o) as ?ot) ?juri
FROM <http://purl.jp/bio/10/lsd2fa>
WHERE {
  [] aos:exact ?o ;
    ^ao:context/ao:hasTopic ?juri .
  VALUES ?juri { lsd:#{jid} }
}
SPARQL_Q2
    result.first
  end

end
