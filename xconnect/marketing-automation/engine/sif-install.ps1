$SiteName = "xconnect-marketing-automation"

# Install XP1 via combined partials file.
$XP1Parameters = @{
    Path = "./sif-params.json"
    Package = "./package.scwdp.zip"
    LicenseFile = "./license.xml"
    Sitename = $SiteName
    HostMappingName =  $SiteName
    DnsName = $SiteName

    SSLCert = "PLACE_HOLDER_THUMBPRINT"
    XConnectCert = "xconnect-client"
    XConnectEnvironment = "Development"
    XConnectLogLevel = "Information"

    SqlDbPrefix = $SqlDbPrefix
    SqlCollectionUser = "collection-user"
    SqlCollectionPassword = "collection-password"
    SqlAdminUser = "admin-user"
    SqlAdminPassword = "admin-password"
    SqlProcessingPoolsUser = "processing-pools-user"
    SqlProcessingPoolsPassword = "processing-pools-password"
    SqlReferenceDataUser = "reference-user"
    SqlReferenceDataPassword = "reference-password"
    SqlMarketingAutomationUser = "marketing-automation-user"
    SqlMarketingAutomationPassword = "marketing-automation-password"
    SqlMessagingUser = "messaging-user"
    SqlMessagingPassword = "messaging-password"
    SqlServer = "sql-server"

    XConnectCollectionSearchService = "COLLECTION_SEARCH_URL"
    XConnectReferenceDataService = "REFERENCE_DATA_URL"
}

Install-SitecoreConfiguration @XP1Parameters *>&1 | Tee-Object marketingautomation.log
