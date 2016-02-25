class YogenStanza < TogoStanza::Stanza::Base
  endpoint = 'http://ep.dbcls.jp:18890/sparql'
  property :list do
    query(endpoint, <<-SPARQL_Q1.strip_heredoc)
SELECT ?label ?ycount
FROM <http://purl.jp/bio/10/lsd2fa>
WHERE {
  SELECT  (str(?l) as ?label) (count(?y) as ?ycount)
  WHERE {
    [] <http://navi.first.lifesciencedb.jp/nlp/yogen> ?y .
    ?y rdfs:label ?l .
  } 
} GROUP BY ?ycount HAVING  (?ycount > 10) ORDER BY desc(?ycount)
SPARQL_Q1
  end
end
