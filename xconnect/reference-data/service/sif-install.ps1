$SiteName = "xconnect-reference-data"

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

    SqlAdminUser = "admin-user"
    SqlAdminPassword = "admi-password"
    SqlReferenceDataUser = "reference-user"
    SqlReferenceDataPassword = "reference-password"
    SqlServer = "sql-server"
}

Install-SitecoreConfiguration @XP1Parameters -Skip InstallWDPWithData *>&1 | Tee-Object referencedata.log
