$SiteName = "xconnect-collection"

# Install the collection service
$XP1Parameters = @{
    Path = "./sif-params.json"
    Package = "./package.scwdp.zip"
    LicenseFile = "./license.xml"
    Sitename = $SiteName
    HostMappingName =  $SiteName
    DnsName = $SiteName

    SSLCert= "PLACE_HOLDER_THUMBPRINT"
    XConnectCert = "xconnect-client"
    XConnectEnvironment = "Development"
    XConnectLogLevel = "Information"

    SqlDbPrefix = "sitecore"
    SqlServer = "sql-server"
    SqlAdminUser = "admin-user"
    SqlAdminPassword = "admi-password"
    SqlCollectionUser = "collection-user"
    SqlCollectionPassword = "collection-password"
    SqlProcessingPoolsUser = "processing-pools-user"
    SqlProcessingPoolsPassword = "processing-pools-password"
    SqlMarketingAutomationUser = "marketing-automation-user"
    SqlMarketingAutomationPassword = "marketing-automation-password"
    SqlMessagingUser = "messaging-user"
    SqlMessagingPassword = "messaging-password"
}

Install-SitecoreConfiguration @XP1Parameters -Skip InstallWDPWithData *>&1 | Tee-Object xp-collection.log
