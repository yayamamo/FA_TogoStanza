class FindSentenceStanza < TogoStanza::Stanza::Base
  endpoint = 'http://ep.dbcls.jp:18890/sparql'
  property :yogen do |yogen|
    yogen
  end

  property :kakuhead do |kakuhead|
    kakuhead
  end

  property :sentence do |yogen,kakuhead|
    query(endpoint, <<-SPARQL_Q1.strip_heredoc)
SELECT distinct ?stc (str(?l) as ?sentence)
FROM <http://purl.jp/bio/10/lsd2fa>
WHERE {
  [] <http://navi.first.lifesciencedb.jp/nlp/yogen> <http://navi.first.lifesciencedb.jp/nlp/#{yogen}> ;
    ?p "#{kakuhead}" ;
    <http://purl.org/dc/terms/isPartOf> ?stc .
  ?stc rdfs:label ?l .
  ?p a <http://navi.first.lifesciencedb.jp/nlp/joshi> .
}
SPARQL_Q1
  end
end
