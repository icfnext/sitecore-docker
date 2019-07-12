$SiteName = "xconnect-collection"

. ./boot-utils.ps1

Ensure-Env -Name 'SQL_SERVER'
Ensure-Env -Name 'SQL_ADMIN_USER'
Ensure-Env -Name 'SQL_ADMIN_PASSWORD'

Ensure-Optional-Env -Name 'SQL_COLLECTION_USER' -DefaultValue 'collection-user'
Ensure-Optional-Env -Name 'SQL_PROCESSING_POOLS_USER' -DefaultValue 'processinig-pools-user'
Ensure-Optional-Env -Name 'SQL_MARKETING_AUTOMATION_USER' -DefaultValue 'marketing-automation-user'
Ensure-Optional-Env -Name 'SQL_MESSAGING_USER' -DefaultValue 'messaging-user'

Ensure-Optional-Env -Name 'SQL_COLLECTION_PASSWORD' -DefaultValue 'P@ssW0rd123'
Ensure-Optional-Env -Name 'SQL_PROCESSING_POOLS_PASSWORD' -DefaultValue 'P@ssW0rd123'
Ensure-Optional-Env -Name 'SQL_MARKETING_AUTOMATION_PASSWORD' -DefaultValue 'P@ssW0rd123'
Ensure-Optional-Env -Name 'SQL_MESSAGING_PASSWORD' -DefaultValue 'P@ssW0rd123'

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

    SqlCollectionUser = $env:SQL_COLLECTION_USER
    SqlCollectionPassword = $env:SQL_COLLECTION_PASSWORD

    SqlProcessingPoolsUser = $env:SQL_PROCESSING_POOLS_USER
    SqlProcessingPoolsPassword = $env:SQL_PROCESSING_POOLS_PASSWORD

    SqlMarketingAutomationUser = $env:SQL_MARKETING_AUTOMATION_USER
    SqlMarketingAutomationPassword =$env:SQL_MARKETING_AUTOMATION_PASSWORD

    SqlMessagingUser = $env:SQL_MESSAGING_USER
    SqlMessagingPassword = $env:SQL_MESSAGING_PASSWORD
}

#Install-SitecoreConfiguration @XP1Parameters -Skip InstallWDPNoData *>&1 | Tee-Object xp-collection.log

if ( Test-Path "C:/EnvVarOutput" ) 
{
    pushd 'C:/EnvVarOutput'
   
    "
COLLECTION_DB=$CollectionDb
MARKETING_AUTOMATION_DB=user id=$env:SQL_MARKETING_AUTOMATION_USER;password=$env:SQL_MARKETING_AUTOMATION_PASSWORD;data source=$env:SQL_SERVER;Initial Catalog=sitecore_MarketingAutomation
MESSAGING_DB=user id=$env:SQL_MESSAGING_USER;password=$env:SQL_MESSAGING_PASSWORD;data source=$env:SQL_SERVER;Initial Catalog=sitecore_Messaging
PROCESSING_POOLS_DB=user id=$env:SQL_PROCESSING_POOLS_USER;password=$env:SQL_PROCESSING_POOLS_PASSWORD;data source=$env:SQL_SERVER;Initial Catalog=sitecore_Processing.Pools
    " | Out-File "C:/EnvVarOutput/collection-service.out"
    popd
}

ipconfig /all
nslookup "kubernetes"
