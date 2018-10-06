class TopStanza < TogoStanza::Stanza::Base
  property :treetop do
    query('http://ep.dbcls.jp:18890/sparql', <<-SPARQL.strip_heredoc)
prefix rdfs: <http://www.w3.org/2000/01/rdf-schema#>
prefix owl: <http://www.w3.org/2002/07/owl#>

# <http://id.nlm.nih.gov/mesh/A01>
# http://sv01.dbcls.jp:9292/stanza/fa?cpt=G05

select (substr(str(?uri),28,1) AS ?top) (concat("/stanza/fa/",substr(str(?uri),28)) AS ?cpt) (str(?et) as ?elb) (str(?l) as ?jlb) 
FROM <http://purl.jp/bio/10/lsd2mesh>
{
?s <http://id.nlm.nih.gov/mesh/vocab#treeNumber> ?uri ;
    rdfs:label ?et .
?s2 owl:sameAs ?s ;
  a <http://purl.jp/bio/10/lsd/ontology/201209#MeSH-UniqueID> ;
  rdfs:label ?l .
FILTER (lang(?l) = "ja")
VALUES ?uri {
  <http://id.nlm.nih.gov/mesh/A01>
  <http://id.nlm.nih.gov/mesh/A02>
  <http://id.nlm.nih.gov/mesh/A03>
  <http://id.nlm.nih.gov/mesh/A04>
  <http://id.nlm.nih.gov/mesh/A05>
  <http://id.nlm.nih.gov/mesh/A06>
  <http://id.nlm.nih.gov/mesh/A07>
  <http://id.nlm.nih.gov/mesh/A08>
  <http://id.nlm.nih.gov/mesh/A09>
  <http://id.nlm.nih.gov/mesh/A10>
  <http://id.nlm.nih.gov/mesh/A11>
  <http://id.nlm.nih.gov/mesh/A12>
  <http://id.nlm.nih.gov/mesh/A13>
  <http://id.nlm.nih.gov/mesh/A14>
  <http://id.nlm.nih.gov/mesh/A15>
  <http://id.nlm.nih.gov/mesh/A16>
  <http://id.nlm.nih.gov/mesh/A17>
  <http://id.nlm.nih.gov/mesh/A18>
  <http://id.nlm.nih.gov/mesh/A21>
  <http://id.nlm.nih.gov/mesh/B01>
  <http://id.nlm.nih.gov/mesh/B02>
  <http://id.nlm.nih.gov/mesh/B03>
  <http://id.nlm.nih.gov/mesh/B04>
  <http://id.nlm.nih.gov/mesh/B05>
  <http://id.nlm.nih.gov/mesh/C01>
  <http://id.nlm.nih.gov/mesh/C02>
  <http://id.nlm.nih.gov/mesh/C03>
  <http://id.nlm.nih.gov/mesh/C04>
  <http://id.nlm.nih.gov/mesh/C05>
  <http://id.nlm.nih.gov/mesh/C06>
  <http://id.nlm.nih.gov/mesh/C07>
  <http://id.nlm.nih.gov/mesh/C08>
  <http://id.nlm.nih.gov/mesh/C09>
  <http://id.nlm.nih.gov/mesh/C10>
  <http://id.nlm.nih.gov/mesh/C11>
  <http://id.nlm.nih.gov/mesh/C12>
  <http://id.nlm.nih.gov/mesh/C13>
  <http://id.nlm.nih.gov/mesh/C14>
  <http://id.nlm.nih.gov/mesh/C15>
  <http://id.nlm.nih.gov/mesh/C16>
  <http://id.nlm.nih.gov/mesh/C17>
  <http://id.nlm.nih.gov/mesh/C18>
  <http://id.nlm.nih.gov/mesh/C19>
  <http://id.nlm.nih.gov/mesh/C20>
  <http://id.nlm.nih.gov/mesh/C22>
  <http://id.nlm.nih.gov/mesh/C23>
  <http://id.nlm.nih.gov/mesh/C25>
  <http://id.nlm.nih.gov/mesh/C26>
  <http://id.nlm.nih.gov/mesh/D01>
  <http://id.nlm.nih.gov/mesh/D02>
  <http://id.nlm.nih.gov/mesh/D03>
  <http://id.nlm.nih.gov/mesh/D04>
  <http://id.nlm.nih.gov/mesh/D05>
  <http://id.nlm.nih.gov/mesh/D06>
  <http://id.nlm.nih.gov/mesh/D08>
  <http://id.nlm.nih.gov/mesh/D09>
  <http://id.nlm.nih.gov/mesh/D10>
  <http://id.nlm.nih.gov/mesh/D12>
  <http://id.nlm.nih.gov/mesh/D13>
  <http://id.nlm.nih.gov/mesh/D20>
  <http://id.nlm.nih.gov/mesh/D23>
  <http://id.nlm.nih.gov/mesh/D25>
  <http://id.nlm.nih.gov/mesh/D26>
  <http://id.nlm.nih.gov/mesh/D27>
  <http://id.nlm.nih.gov/mesh/E01>
  <http://id.nlm.nih.gov/mesh/E02>
  <http://id.nlm.nih.gov/mesh/E03>
  <http://id.nlm.nih.gov/mesh/E04>
  <http://id.nlm.nih.gov/mesh/E05>
  <http://id.nlm.nih.gov/mesh/E06>
  <http://id.nlm.nih.gov/mesh/E07>
  <http://id.nlm.nih.gov/mesh/F01>
  <http://id.nlm.nih.gov/mesh/F02>
  <http://id.nlm.nih.gov/mesh/F03>
  <http://id.nlm.nih.gov/mesh/F04>
  <http://id.nlm.nih.gov/mesh/G01>
  <http://id.nlm.nih.gov/mesh/G02>
  <http://id.nlm.nih.gov/mesh/G03>
  <http://id.nlm.nih.gov/mesh/G04>
  <http://id.nlm.nih.gov/mesh/G05>
  <http://id.nlm.nih.gov/mesh/G06>
  <http://id.nlm.nih.gov/mesh/G07>
  <http://id.nlm.nih.gov/mesh/G08>
  <http://id.nlm.nih.gov/mesh/G09>
  <http://id.nlm.nih.gov/mesh/G10>
  <http://id.nlm.nih.gov/mesh/G11>
  <http://id.nlm.nih.gov/mesh/G12>
  <http://id.nlm.nih.gov/mesh/G13>
  <http://id.nlm.nih.gov/mesh/G14>
  <http://id.nlm.nih.gov/mesh/G15>
  <http://id.nlm.nih.gov/mesh/G16>
  <http://id.nlm.nih.gov/mesh/G17>
  <http://id.nlm.nih.gov/mesh/H01>
  <http://id.nlm.nih.gov/mesh/H02>
  <http://id.nlm.nih.gov/mesh/I01>
  <http://id.nlm.nih.gov/mesh/I02>
  <http://id.nlm.nih.gov/mesh/I03>
  <http://id.nlm.nih.gov/mesh/J01>
  <http://id.nlm.nih.gov/mesh/J02>
  <http://id.nlm.nih.gov/mesh/K01>
  <http://id.nlm.nih.gov/mesh/L01>
  <http://id.nlm.nih.gov/mesh/M01>
  <http://id.nlm.nih.gov/mesh/N01>
  <http://id.nlm.nih.gov/mesh/N02>
  <http://id.nlm.nih.gov/mesh/N03>
#  <http://id.nlm.nih.gov/mesh/N04>
  <http://id.nlm.nih.gov/mesh/N05>
  <http://id.nlm.nih.gov/mesh/N06>
  <http://id.nlm.nih.gov/mesh/V01>
  <http://id.nlm.nih.gov/mesh/V02>
  <http://id.nlm.nih.gov/mesh/V03>
  <http://id.nlm.nih.gov/mesh/Z01>
}
} ORDER BY ?uri
    SPARQL
  end
end
