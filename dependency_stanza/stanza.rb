class DependencyStanza < TogoStanza::Stanza::Base
  endpoint = 'http://ep.dbcls.jp:18890/sparql'
  property :yogen do |yogen|
    yogen
  end

  property :list do |yogen|
    query(endpoint, <<-SPARQL_Q1.strip_heredoc)
PREFIX : <>
SELECT (str(?o) as ?head) (count(?o) as ?oc) (str(:#{yogen}) as ?yogen)
FROM <http://purl.jp/bio/10/lsd2fa>
WHERE {
  [] <http://navi.first.lifesciencedb.jp/nlp/yogen> <http://navi.first.lifesciencedb.jp/nlp/#{yogen}> ;
  ?p ?o .
  ?p a <http://navi.first.lifesciencedb.jp/nlp/joshi> .
} ORDER BY DESC(?oc)
SPARQL_Q1
  end
end
