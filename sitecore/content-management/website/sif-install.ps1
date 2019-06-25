$SiteName = "local.sitecore.com"

pushd 'C:/Program Files/Microsoft/Web Platform Installer'
.\WebpiCmd.exe /Install /Products:'UrlRewrite2' /AcceptEULA /Log:c:/install/WebpiCmd.log
popd

$XP1Parameters = @{
    Path = "./sif-params.json"
    Package = "./package.scwdp.zip"
    LicenseFile = "./license.xml"
    Sitename = $SiteName
    HostMappingName =  $SiteName
    DnsName = $SiteName

    SSLCert = "PLACE_HOLDER_THUMBPRINT"
    XConnectCert = "xconnect-client"
    #XConnectEnvironment = "Development"
    #XConnectLogLevel = "Information"

    MarketingAutomationOperationsService = "MARKETING_AUTOMATION_SERVICE"
    MarketingAutomationReportingService = "MARKETING_AUTOMATION_REPORTING_SERVICE"
    ProcessingService = "PROCESSING_SERVICE"
    ReportingService = "REPORTING_SERVICE"
    ReportingServiceApiKey = "groggy-squash-oily-platelet"
    SitecoreAdminPassword = "SITECORE_ADMIN_PW"
    SolrUrl = "SOLR_URL"
    SitecoreIdentityAuthority = "https://local.sitecore.com"
    XConnectCollectionSearchService = "COLLECTION_SEARCH_SERVICE"
    XConnectReferenceDataService = "REFERENCE_DATA_SERVICE"

    SqlAdminUser = "admin-user"
    SqlAdminPassword = "admi-password"
    SqlCoreUser = "core-user"
    SqlCorePassword = "core-password"
    SqlFormsUser = "forms-user"
    SqlFormsPassword = "forms-password"
    SqlMasterUser = "master-user"
    SqlMasterPassword = "master-password"
    SqlMessagingUser = "messaging-user"
    SqlMessagingPassword = "messaging-password"
    SqlReferenceDataUser = "reference-user"
    SqlReferenceDataPassword = "reference-password"
    SqlReportingUser = "reporting-user"
    SqlReportingPassword = "reporting-password"
    SqlSecurityUser = "security-user"
    SqlSecurityPassword = "security-password"
    SqlServer = "sql-server"
    SqlWebUser = "web-user"
    SqlWebPassword = "web-password"
}

Install-SitecoreConfiguration @XP1Parameters -Skip InstallWDPWithData *>&1 | Tee-Object content-management.log
