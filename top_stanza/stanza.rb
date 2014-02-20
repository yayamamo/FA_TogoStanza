class TopStanza < TogoStanza::Stanza::Base
  property :treetop do
    #query('http://ep1.dbcls.jp:5820/mesh_lsd_fa/query', <<-SPARQL.strip_heredoc)
    query('http://tm.dbcls.jp/fa/mesh_lsd_fa/query', <<-SPARQL.strip_heredoc)
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix owl: <http://www.w3.org/2002/07/owl#>

# <http://bioonto.de/mesh.owl#A01>
# http://sv01.dbcls.jp:9292/stanza/fa?cpt=G05

select (substr(str(?uri),28,1) AS ?top) (concat("/stanza/fa?cpt=",substr(str(?uri),28)) AS ?cpt) (str(?et) as ?elb) (str(?l) as ?jlb) {
?uri rdfs:label ?et .
?s rdfs:subClassOf ?uri .
?s2 owl:sameAs ?s ;
  a <http://purl.jp/bio/10/lsd/ontology/201209#MeSH-UniqueID> ;
  rdfs:label ?l .
FILTER (lang(?l) = "ja")
VALUES ?uri {
  <http://bioonto.de/mesh.owl#A01>
  <http://bioonto.de/mesh.owl#A02>
  <http://bioonto.de/mesh.owl#A03>
  <http://bioonto.de/mesh.owl#A04>
  <http://bioonto.de/mesh.owl#A05>
  <http://bioonto.de/mesh.owl#A06>
  <http://bioonto.de/mesh.owl#A07>
  <http://bioonto.de/mesh.owl#A08>
  <http://bioonto.de/mesh.owl#A09>
  <http://bioonto.de/mesh.owl#A10>
  <http://bioonto.de/mesh.owl#A11>
  <http://bioonto.de/mesh.owl#A12>
  <http://bioonto.de/mesh.owl#A13>
  <http://bioonto.de/mesh.owl#A14>
  <http://bioonto.de/mesh.owl#A15>
  <http://bioonto.de/mesh.owl#A16>
  <http://bioonto.de/mesh.owl#A17>
  <http://bioonto.de/mesh.owl#A18>
  <http://bioonto.de/mesh.owl#A21>
  <http://bioonto.de/mesh.owl#B01>
  <http://bioonto.de/mesh.owl#B02>
  <http://bioonto.de/mesh.owl#B03>
  <http://bioonto.de/mesh.owl#B04>
  <http://bioonto.de/mesh.owl#B05>
  <http://bioonto.de/mesh.owl#C01>
  <http://bioonto.de/mesh.owl#C02>
  <http://bioonto.de/mesh.owl#C03>
  <http://bioonto.de/mesh.owl#C04>
  <http://bioonto.de/mesh.owl#C05>
  <http://bioonto.de/mesh.owl#C06>
  <http://bioonto.de/mesh.owl#C07>
  <http://bioonto.de/mesh.owl#C08>
  <http://bioonto.de/mesh.owl#C09>
  <http://bioonto.de/mesh.owl#C10>
  <http://bioonto.de/mesh.owl#C11>
  <http://bioonto.de/mesh.owl#C12>
  <http://bioonto.de/mesh.owl#C13>
  <http://bioonto.de/mesh.owl#C14>
  <http://bioonto.de/mesh.owl#C15>
  <http://bioonto.de/mesh.owl#C16>
  <http://bioonto.de/mesh.owl#C17>
  <http://bioonto.de/mesh.owl#C18>
  <http://bioonto.de/mesh.owl#C19>
  <http://bioonto.de/mesh.owl#C20>
  <http://bioonto.de/mesh.owl#C22>
  <http://bioonto.de/mesh.owl#C23>
  <http://bioonto.de/mesh.owl#C25>
  <http://bioonto.de/mesh.owl#C26>
  <http://bioonto.de/mesh.owl#D01>
  <http://bioonto.de/mesh.owl#D02>
  <http://bioonto.de/mesh.owl#D03>
  <http://bioonto.de/mesh.owl#D04>
  <http://bioonto.de/mesh.owl#D05>
  <http://bioonto.de/mesh.owl#D06>
  <http://bioonto.de/mesh.owl#D08>
  <http://bioonto.de/mesh.owl#D09>
  <http://bioonto.de/mesh.owl#D10>
  <http://bioonto.de/mesh.owl#D12>
  <http://bioonto.de/mesh.owl#D13>
  <http://bioonto.de/mesh.owl#D20>
  <http://bioonto.de/mesh.owl#D23>
  <http://bioonto.de/mesh.owl#D25>
  <http://bioonto.de/mesh.owl#D26>
  <http://bioonto.de/mesh.owl#D27>
  <http://bioonto.de/mesh.owl#E01>
  <http://bioonto.de/mesh.owl#E02>
  <http://bioonto.de/mesh.owl#E03>
  <http://bioonto.de/mesh.owl#E04>
  <http://bioonto.de/mesh.owl#E05>
  <http://bioonto.de/mesh.owl#E06>
  <http://bioonto.de/mesh.owl#E07>
  <http://bioonto.de/mesh.owl#F01>
  <http://bioonto.de/mesh.owl#F02>
  <http://bioonto.de/mesh.owl#F03>
  <http://bioonto.de/mesh.owl#F04>
  <http://bioonto.de/mesh.owl#G01>
  <http://bioonto.de/mesh.owl#G02>
  <http://bioonto.de/mesh.owl#G03>
  <http://bioonto.de/mesh.owl#G04>
  <http://bioonto.de/mesh.owl#G05>
  <http://bioonto.de/mesh.owl#G06>
  <http://bioonto.de/mesh.owl#G07>
  <http://bioonto.de/mesh.owl#G08>
  <http://bioonto.de/mesh.owl#G09>
  <http://bioonto.de/mesh.owl#G10>
  <http://bioonto.de/mesh.owl#G11>
  <http://bioonto.de/mesh.owl#G12>
  <http://bioonto.de/mesh.owl#G13>
  <http://bioonto.de/mesh.owl#G14>
  <http://bioonto.de/mesh.owl#G15>
  <http://bioonto.de/mesh.owl#G16>
  <http://bioonto.de/mesh.owl#G17>
  <http://bioonto.de/mesh.owl#H01>
  <http://bioonto.de/mesh.owl#H02>
  <http://bioonto.de/mesh.owl#I01>
  <http://bioonto.de/mesh.owl#I02>
  <http://bioonto.de/mesh.owl#I03>
  <http://bioonto.de/mesh.owl#J01>
  <http://bioonto.de/mesh.owl#J02>
  <http://bioonto.de/mesh.owl#K01>
  <http://bioonto.de/mesh.owl#L01>
  <http://bioonto.de/mesh.owl#M01>
  <http://bioonto.de/mesh.owl#N01>
  <http://bioonto.de/mesh.owl#N02>
  <http://bioonto.de/mesh.owl#N03>
  <http://bioonto.de/mesh.owl#N04>
  <http://bioonto.de/mesh.owl#N05>
  <http://bioonto.de/mesh.owl#N06>
  <http://bioonto.de/mesh.owl#V01>
  <http://bioonto.de/mesh.owl#V02>
  <http://bioonto.de/mesh.owl#V03>
  <http://bioonto.de/mesh.owl#Z01>
}
} ORDER BY ?uri
    SPARQL
  end
end
