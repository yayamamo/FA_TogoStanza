class GeneFeatureStanza < TogoStanza::Stanza::Base

  property :features do |uri|
    query('http://ep.dbcls.jp:18890/sparql', <<-SPARQL.strip_heredoc)
      SELECT *
      {
        {<#{uri}> ?p ?o }
        UNION
        {?s ?p2 <#{uri}> }
      }
    SPARQL
  end

end
