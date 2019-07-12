$SiteName = "xconnect-cortex-reporting"

. ./boot-utils.ps1

Ensure-Env -Name 'SQL_SERVER'
Ensure-Env -Name 'SQL_ADMIN_USER'
Ensure-Env -Name 'SQL_ADMIN_PASSWORD'

Ensure-Optional-Env -Name 'SQL_REPORTING_USER' -DefaultValue 'reporting-user'

Ensure-Optional-Env -Name 'SQL_REPORTING_PASSWORD' -DefaultValue 'P@ssW0rd123'

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
    SqlServer = $env:SQL_SERVER
    SqlAdminUser = $env:SQL_ADMIN_USER
    SqlAdminPassword = $env:SQL_ADMIN_PASSWORD

    SqlReportingUser = $env:SQL_REPORTING_USER
    SqlReportingPassword = $env:SQL_REPORTING_PASSWORD
}

Install-SitecoreConfiguration @XP1Parameters -Skip InstallWDPNoData *>&1 | Tee-Object xp-collection.log
