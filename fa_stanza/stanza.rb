class FaStanza < TogoStanza::Stanza::Base
  property :articles do |cpt|
   query('http://ep1.dbcls.jp:5820/mesh_lsd_fa/query', <<-SPARQL.strip_heredoc)
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix owl: <http://www.w3.org/2002/07/owl#>

select ?jcode (str(?l) as ?lb) (str(?st) as ?title) (count(?url) as ?cnt) ?url {
  {
    select distinct ?jcode ?l {
      ?s rdfs:subClassOf* <http://bioonto.de/mesh.owl##{cpt}> .
      ?s2 owl:sameAs ?s ;
        a <http://purl.jp/bio/10/lsd/ontology/201209#MeSH-UniqueID> ;
        rdfs:label ?l .
      ?jcode <http://purl.jp/bio/10/lsd/ontology/201209#MeSHUniqueID> ?s2 ;
         a <http://purl.jp/bio/10/lsd/ontology/201209#JapaneseCode> .
    }
  }
[] <http://purl.org/ao/hasTopic> ?jcode ;
  <http://purl.org/ao/foaf/annotatesDocument> ?d .
{
 {
  ?pd <http://purl.org/dc/terms/hasPart> ?d;
   rdfs:label ?st.
   BIND (?pd AS ?url)
 }
UNION
{
  ?d a <http://purl.org/ontology/bibo/Document>;
      rdfs:label ?st.
   BIND (?d AS ?url)
}
}
FILTER (lang($l) = "ja")
} group by ?jcode ?l ?st ?url order by desc (?cnt)
SPARQL
  end
end
