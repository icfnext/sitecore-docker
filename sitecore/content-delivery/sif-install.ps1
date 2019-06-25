$SiteName = "local.sitecore.com"

$XP1Parameters = @{
    Path = "./sif-params.json"
    Package = "./package.scwdp.zip"
    LicenseFile = "./license.xml"
    Sitename = $SiteName
    HostMappingName =  $SiteName
    DnsName = $SiteName

    XConnectCert = "xconnect-client"
    #XConnectEnvironment = "Development"
    #XConnectLogLevel = "Information"

    MarketingAutomationOperationsService = "MARKETING_AUTOMATION_SERVICE"
    MarketingAutomationReportingService = "MARKETING_AUTOMATION_REPORTING_SERVICE"
    SolrUrl = "SOLR_URL"
    SitecoreIdentityAuthority = "IDENTITY_AUTHORITY"
    XConnectReferenceDataService = "REFERENCE_DATA_SERVICE"

    SqlAdminUser = "admin-user"
    SqlAdminPassword = "admi-password"
    SqlFormsUser = "forms-user"
    SqlFormsPassword = "forms-password"
    SqlMessagingUser = "messaging-user"
    SqlMessagingPassword = "messaging-password"
    SqlReferenceDataUser = "reference-user"
    SqlReferenceDataPassword = "reference-password"
    SqlSecurityUser = "security-user"
    SqlSecurityPassword = "security-password"
    SqlServer = "sql-server"
    SqlWebUser = "web-user"
    SqlWebPassword = "web-password"
}

Install-SitecoreConfiguration @XP1Parameters *>&1 | Tee-Object content-management.log
