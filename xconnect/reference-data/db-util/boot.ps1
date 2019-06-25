$SiteName = "xconnect-reference-data"

. ./boot-utils.ps1

Ensure-Env -Name 'SQL_SERVER'
Ensure-Env -Name 'SQL_ADMIN_USER'
Ensure-Env -Name 'SQL_ADMIN_PASSWORD'

Ensure-Optional-Env -Name 'SQL_REFERENCE_DATA_USER' -DefaultValue 'reference-data-user'

Ensure-Optional-Env -Name 'SQL_REFERENCE_DATA_PASSWORD' -DefaultValue 'P@ssW0rd123'

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

    SqlDbPrefix = "sitecore"
    SqlServer = $env:SQL_SERVER
    SqlAdminUser = $env:SQL_ADMIN_USER
    SqlAdminPassword = $env:SQL_ADMIN_PASSWORD

    SqlReferenceDataUser = $env:SQL_REFERENCE_DATA_USER
    SqlReferenceDataPassword = $env:SQL_REFERENCE_DATA_PASSWORD
}

Install-SitecoreConfiguration @XP1Parameters -Skip InstallWDPNoData *>&1 | Tee-Object xp-collection.log

if ( Test-Path "C:/EnvVarOutput" ) 
{
    "
REFERENCE_DATA_DB=user id=$env:SQL_REFERENCE_DATA_USER;password=$env:SQL_REFERENCE_DATA_PASSWORD;data source=$env:SQL_SERVER;Initial Catalog=sitecore_ReferenceData
    " | Out-File "C:/EnvVarOutput/reference-data-service.out"
}

