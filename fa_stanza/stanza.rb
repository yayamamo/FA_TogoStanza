class FaStanza < TogoStanza::Stanza::Base
  #endpoint = 'http://ep1.dbcls.jp:5820/mesh_lsd_fa/query'
  #endpoint = 'http://tm.dbcls.jp/fa/mesh_lsd_fa/query'
  endpoint = 'http://ep1.dbcls.jp:8890/sparql'
  property :articles do |cpt|
    query(endpoint, <<-SPARQL_Q1.strip_heredoc)
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix lsd: <http://purl.jp/bio/10/lsd/ontology/201209#>

select ?jcode (str(?l) as ?lb) (str(?st) as ?title) (count(?url) as ?cnt) ?url
{
  graph <http://purl.jp/bio/10/lsd2mesh> {
    select distinct ?jcode ?l {
      ?s rdfs:subClassOf* <http://bioonto.de/mesh.owl##{cpt}> .
      ?s2 owl:sameAs ?s ;
        a lsd:MeSH-UniqueID .
      ?jcode lsd:MeSHUniqueID ?s2 ;
        a lsd:JapaneseCode ;
        rdfs:label ?l .
    FILTER(lang(?l) = "ja")
    }
  }
  graph <http://purl.jp/bio/10/lsd2fa> {
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
  }
} group by ?jcode ?l ?st ?url order by desc (?cnt)
SPARQL_Q1
  end

  property :concept do |cpt|
    result = query(endpoint, <<-SPARQL_Q2.strip_heredoc)
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix owl: <http://www.w3.org/2002/07/owl#>

select (str(?l) AS ?jcpt){
  graph <http://purl.jp/bio/10/lsd2mesh>
  {
    ?s ?p <http://bioonto.de/mesh.owl##{cpt}> .
    ?s2 owl:sameAs ?s ;
        rdfs:label ?l .
    FILTER(lang(?l) = "ja")
  }
}
SPARQL_Q2
result.first
  end

  property :children do |cpt|
    query(endpoint, <<-SPARQL_Q3.strip_heredoc)
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix lsd: <http://purl.jp/bio/10/lsd/ontology/201209#>

select distinct (str(?l) AS ?jcpt) (concat("/stanza/fa/",substr(str(?upper),28)) AS ?parent) {
  graph <http://purl.jp/bio/10/lsd2mesh>
  {
    ?upper rdfs:subClassOf <http://bioonto.de/mesh.owl##{cpt}> .
    ?s2 owl:sameAs [rdfs:subClassOf ?upper] ;
       rdfs:label ?l .
    ?z rdfs:subClassOf* ?upper.
    ?jcode lsd:MeSHUniqueID [owl:sameAs ?z] ;
       a lsd:JapaneseCode .
    FILTER(lang(?l) = "ja")
  }
  graph <http://purl.jp/bio/10/lsd2fa> {
    [] <http://purl.org/ao/hasTopic> ?jcode .
  }
}
SPARQL_Q3
  end
end
