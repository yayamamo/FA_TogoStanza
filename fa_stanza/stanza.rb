class FaStanza < TogoStanza::Stanza::Base
  endpoint = 'http://ep.dbcls.jp:18890/sparql'
  property :articles do |cpt|
    query(endpoint, <<-SPARQL_Q1.strip_heredoc)
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix lsd: <http://purl.jp/bio/10/lsd/ontology/201209#>
prefix dcterms: <http://purl.org/dc/terms/>
prefix mesh_v: <http://id.nlm.nih.gov/mesh/vocab#>
prefix mesh: <http://id.nlm.nih.gov/mesh/>

#select ?jcode (substr(str(?jcode),32) as ?jid) (str(?l) as ?lb) (str(?st) as ?title) (count(?url) as ?cnt) ?url (substr(str(?pubmed),36) as ?pmid) ?pj
#select ?jcode (substr(str(?jcode),32) as ?jid) (str(?l) as ?lb) (str(?st) as ?title) (count(?url) as ?cnt) ?url (substr(str(?pubmed),36) as ?pmid) (replace(?pj, "^([^,]+).*", "$1") as ?jnl)
select (encode_for_uri(?jcode) as ?encoded_jcode) (substr(str(?jcode),32) as ?jid) (str(?l) as ?lb) (str(?st) as ?title) (count(?url) as ?cnt) ?url (substr(str(?pubmed),36) as ?pmid) (replace(?pj, "^([^,]+).*", "$1") as ?jnl)
{
  graph <http://purl.jp/bio/10/lsd2mesh> {
    select distinct ?jcode ?l {
      ?s2 owl:sameAs/mesh_v:treeNumber/mesh_v:parentTreeNumber* mesh:#{cpt} ;
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
          dcterms:provenance ?pj;
          rdfs:label ?st;
          rdfs:seeAlso ?pubmed .
      BIND (?pd AS ?url)
    }
    UNION
    {
      ?d a <http://purl.org/ontology/bibo/Document>;
         dcterms:provenance ?pj;
         rdfs:label ?st;
         rdfs:seeAlso ?pubmed .
      BIND (?d AS ?url)
    }
  }
  }
} group by ?jcode ?l ?st ?url ?pubmed ?pj order by desc (?cnt) offset 0 limit 200
SPARQL_Q1
  end

# 現在表示している概念の取得
  property :concept do |cpt|
    result = query(endpoint, <<-SPARQL_Q2.strip_heredoc)
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix mesh_v: <http://id.nlm.nih.gov/mesh/vocab#>
prefix mesh: <http://id.nlm.nih.gov/mesh/>

select (str(?l) AS ?jcpt) (str(?s2) AS ?dmh) {
  graph <http://purl.jp/bio/10/lsd2mesh>
  {
    ?s2 owl:sameAs/mesh_v:treeNumber mesh:#{cpt} ;
        rdfs:label ?l .
    FILTER(lang(?l) = "ja")
  }
}
SPARQL_Q2
    result.first
  end

# 下位概念の取得
  property :children do |cpt|
    query(endpoint, <<-SPARQL_Q3.strip_heredoc)
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix lsd: <http://purl.jp/bio/10/lsd/ontology/201209#>
prefix mesh_v: <http://id.nlm.nih.gov/mesh/vocab#>
prefix mesh: <http://id.nlm.nih.gov/mesh/>

select distinct (str(?l) AS ?jcpt) (concat("/stanza/fa/",?concept) AS ?parent) (count(?jcode) AS ?jc) {
  graph <http://purl.jp/bio/10/lsd2mesh> {
    select distinct ?l ?concept ?jcode {
      ?upper mesh_v:parentTreeNumber mesh:#{cpt} .
      [] owl:sameAs/mesh_v:treeNumber ?upper ;
        rdfs:label ?l .
      ?jcode lsd:MeSHUniqueID/owl:sameAs/mesh_v:treeNumber/mesh_v:parentTreeNumber* ?upper .
      BIND(substr(str(?upper),28) AS ?concept)
      FILTER(contains(?concept,".") && lang(?l) = "ja")
    }
  }
  graph <http://purl.jp/bio/10/lsd2fa> {
    [] <http://purl.org/ao/hasTopic> ?jcode .
  }
} ORDER BY desc(?jc)
SPARQL_Q3
  end

# トップ概念からのパスの取得
  property :ancestor do |cpt|
    query(endpoint, <<-SPARQL_Q4.strip_heredoc)
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix owl: <http://www.w3.org/2002/07/owl#>
prefix mesh_v: <http://id.nlm.nih.gov/mesh/vocab#>
prefix mesh: <http://id.nlm.nih.gov/mesh/>

select ?c (substr(str(?u),28) AS ?ac) (str(?l) AS ?lb) {
  graph <http://purl.jp/bio/10/lsd2mesh>
  {
    mesh:#{cpt} mesh_v:parentTreeNumber+ ?u.
    ?c owl:sameAs/mesh_v:treeNumber ?u ;
       rdfs:label ?l .
    FILTER(lang(?l) = "ja")
  }
} ORDER BY ?u
SPARQL_Q4
  end

  property :current do |cpt|
    cpt
  end
end
