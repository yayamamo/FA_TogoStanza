class FaStanza < TogoStanza::Stanza::Base
  #endpoint = 'http://ep1.dbcls.jp:5820/mesh_lsd_fa/query'
  endpoint = 'http://tm.dbcls.jp/fa/mesh_lsd_fa/query'
  property :articles do |cpt|
    query(endpoint, <<-SPARQL_Q1.strip_heredoc)
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix lsd: <http://purl.jp/bio/10/lsd/ontology/201209#>

select ?jcode (str(?l) as ?lb) (str(?st) as ?title) (count(?url) as ?cnt) ?url {
  {
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
} group by ?jcode ?l ?st ?url order by desc (?cnt)
SPARQL_Q1
  end

  property :concept do |cpt|
    result = query(endpoint, <<-SPARQL_Q2.strip_heredoc)
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix owl: <http://www.w3.org/2002/07/owl#>

select (str(?l) AS ?jcpt) {
   ?s ?p <http://bioonto.de/mesh.owl##{cpt}> .
   ?s2 owl:sameAs ?s ;
       rdfs:label ?l .
  FILTER(lang(?l) = "ja")
}
SPARQL_Q2
result.first
  end

  property :children do |cpt|
    query(endpoint, <<-SPARQL_Q3.strip_heredoc)
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix lsd: <http://purl.jp/bio/10/lsd/ontology/201209#>

select distinct (str(?l) AS ?jcpt) (concat("/stanza/fa?cpt=",substr(str(?upper),28)) AS ?parent) {
   ?upper rdfs:subClassOf <http://bioonto.de/mesh.owl##{cpt}> .
   ?s2 owl:sameAs [rdfs:subClassOf ?upper] ;
       rdfs:label ?l .
   ?jcode lsd:MeSHUniqueID ?s2 ;
          a lsd:JapaneseCode .
  [] <http://purl.org/ao/hasTopic> ?jcode .
  FILTER(lang(?l) = "ja")
}
SPARQL_Q3
  end
end
