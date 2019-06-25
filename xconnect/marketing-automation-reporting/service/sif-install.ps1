$SiteName = "xconnect-marketing-reporting"

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
    SqlReferenceDataUser = "reference-user"
    SqlReferenceDataPassword = "reference-password"
    SqlMarketingAutomationUser = "marketing-automation-user"
    SqlMarketingAutomationPassword = "marketing-automation-password"
    SqlServer =  "sql-server"
}

Install-SitecoreConfiguration @XP1Parameters *>&1 | Tee-Object marketingautomationreporting.log
