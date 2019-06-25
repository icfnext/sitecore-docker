$params = @{
    Path = "./xconnect-solr.json"
    SolrUrl = "https://solr/solr"
    SolrRoot = "c:/solr/solr-7.2.1"
    SolrService = "Solr-7.2.1"
    CorePrefix = "sitecore"
}

Install-SitecoreConfiguration @params *>&1 | Tee-Object xconnect-solr.log
