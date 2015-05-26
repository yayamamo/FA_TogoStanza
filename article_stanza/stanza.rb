class ArticleStanza < TogoStanza::Stanza::Base
  endpoint = 'http://ep.dbcls.jp:18890/sparql'
  property :keyterms do |uri|
  query(endpoint, <<-SPARQL1.strip_heredoc)
    prefix ao: <http://purl.org/ao/>
    prefix aof: <http://purl.org/ao/foaf/>
    prefix dcterms: <http://purl.org/dc/terms/>
    prefix lsd: <http://purl.jp/bio/10/lsd/ontology/201209#>

    select (count(?l) as ?jc) (str(?l) as ?jk) ?tp ?mt ?mth
    from <http://purl.jp/bio/10/lsd2fa>
    from <http://purl.jp/bio/10/lsd2mesh>
    {
      {
        <#{uri}> ^aof:annotatesDocument/ao:hasTopic ?tp .
        ?tp rdfs:label ?l .
      }
      UNION
      {
        <#{uri}> dcterms:hasPart ?pt .
        ?pt ^aof:annotatesDocument/ao:hasTopic ?tp .
        ?tp rdfs:label ?l .
      }
      FILTER(lang(?l) = "ja")
      OPTIONAL
      {
        ?tp lsd:MeSHUniqueID/owl:sameAs/rdfs:subClassOf ?mh .
      }
      BIND(substr(str(?mh),28) as ?mth)
      BIND(if(bound(?mth), concat("http://navi.first.lifesciencedb.jp/stanza/fa/",?mth), "") as ?mt)
    } order by desc (?jc)
    SPARQL1
  end

  property :citation do |uri|
  result = query(endpoint, <<-SPARQL2.strip_heredoc)
  prefix foaf: <http://xmlns.com/foaf/0.1/>
  prefix bibo: <http://purl.org/ontology/bibo/>

  select (str(?title) as ?ti) ?pubmed ?page (str(?authors) as ?au) {
    graph <http://purl.jp/bio/10/lsd2fa> {
      <#{uri}> rdfs:label ?title ;
        rdfs:seeAlso ?pubmed ;
        foaf:homepage ?page ;
        bibo:authorList ?authors .
  }}
  SPARQL2
  result.first
  end
end
