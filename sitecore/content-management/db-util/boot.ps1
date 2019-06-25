$SiteName = "content-management"

. ./boot-utils.ps1

Ensure-Env -Name 'SQL_SERVER'
Ensure-Env -Name 'SQL_ADMIN_USER'
Ensure-Env -Name 'SQL_ADMIN_PASSWORD'

Ensure-Optional-Env -Name 'SQL_CORE_USER' -DefaultValue 'core-user'
Ensure-Optional-Env -Name 'SQL_FORMS_USER' -DefaultValue 'forms-user'
Ensure-Optional-Env -Name 'SQL_MASTER_USER' -DefaultValue 'master-user'
Ensure-Optional-Env -Name 'SQL_MESSAGING_USER' -DefaultValue 'messaging-user'
Ensure-Optional-Env -Name 'SQL_REFERENCE_USER' -DefaultValue 'reference-user'
Ensure-Optional-Env -Name 'SQL_REPORTING_USER' -DefaultValue 'reporting-user'
Ensure-Optional-Env -Name 'SQL_SECURITY_USER' -DefaultValue 'security-user'
Ensure-Optional-Env -Name 'SQL_PROCESSING_POOLS_USER' -DefaultValue 'tasks-user'
Ensure-Optional-Env -Name 'SQL_PROCESSING_TASKS_USER' -DefaultValue 'tasks-user'
Ensure-Optional-Env -Name 'SQL_WEB_USER' -DefaultValue 'web-user'

Ensure-Optional-Env -Name 'SQL_CORE_PASSWORD' -DefaultValue 'P@ssW0rd123'
Ensure-Optional-Env -Name 'SQL_FORMS_PASSWORD' -DefaultValue 'P@ssW0rd123'
Ensure-Optional-Env -Name 'SQL_MASTER_PASSWORD' -DefaultValue 'P@ssW0rd123'
Ensure-Optional-Env -Name 'SQL_MESSAGING_PASSWORD' -DefaultValue 'P@ssW0rd123'
Ensure-Optional-Env -Name 'SQL_REFERENCE_PASSWORD' -DefaultValue 'P@ssW0rd123'
Ensure-Optional-Env -Name 'SQL_REPORTING_PASSWORD' -DefaultValue 'P@ssW0rd123'
Ensure-Optional-Env -Name 'SQL_SECURITY_PASSWORD' -DefaultValue 'P@ssW0rd123'
Ensure-Optional-Env -Name 'SQL_PROCESSING_POOLS_PASSWORD' -DefaultValue 'P@ssW0rd123'
Ensure-Optional-Env -Name 'SQL_PROCESSING_TASKS_PASSWORD' -DefaultValue 'P@ssW0rd123'
Ensure-Optional-Env -Name 'SQL_WEB_PASSWORD' -DefaultValue 'P@ssW0rd123'

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
    SitecoreIdentityAuthority = "IDENTITY_AUTHORITY"
    XConnectCollectionSearchService = "COLLECTION_SEARCH_SERVICE"
    XConnectReferenceDataService = "REFERENCE_DATA_SERVICE"


    SqlDbPrefix = "sitecore"
    SqlServer = $env:SQL_SERVER
    SqlAdminUser = $env:SQL_ADMIN_USER
    SqlAdminPassword = $env:SQL_ADMIN_PASSWORD

    SqlCoreUser = $env:SQL_CORE_USER
    SqlCorePassword = $env:SQL_CORE_PASSWORD

    SqlFormsUser = $env:SQL_FORMS_USER
    SqlFormsPassword = $env:SQL_FORMS_PASSWORD

    SqlMasterUser = $env:SQL_MASTER_USER
    SqlMasterPassword = $env:SQL_MASTER_PASSWORD

    SqlMessagingUser = $env:SQL_MESSAGING_USER
    SqlMessagingPassword = $env:SQL_MESSAGING_PASSWORD

    SqlProcessingPoolsUser = $env:SQL_PROCESSING_POOLS_USER
    SqlProcessingPoolsPassword = $env:SQL_PROCESSING_POOLS_PASSWORD

    SqlProcessingTasksUser = $env:SQL_PROCESSING_TASKS_USER
    SqlProcessingTasksPassword = $env:SQL_PROCESSING_TASKS_PASSWORD

    SqlReferenceDataUser = $env:SQL_REFERENCE_USER
    SqlReferenceDataPassword = $env:SQL_REFERENCE_PASSWORD

    SqlReportingUser = $env:SQL_REPORTING_USER
    SqlReportingPassword = $env:SQL_REPORTING_PASSWORD

    SqlSecurityUser = $env:SQL_SECURITY_USER
    SqlSecurityPassword = $env:SQL_SECURITY_PASSWORD

    SqlWebUser = $env:SQL_WEB_USER
    SqlWebPassword = $env:SQL_WEB_PASSWORD
}

Install-SitecoreConfiguration @XP1Parameters -Skip InstallWDPNoData *>&1 | Tee-Object content-management.log

if ( Test-Path "C:/EnvVarOutput" ) 
{
    "
CORE_DB=user id=$env:SQL_CORE_USER;password=$env:SQL_CORE_PASSWORD;data source=$env:SQL_SERVER;Initial Catalog=sitecore_Core

COLLECTION_DB=user id=$env:SQL_COLLECTION_USER;password=$env:SQL_COLLECTION_PASSWORD;data source=$env:SQL_SERVER;Initial Catalog=sitecore_Xdb.Collection.ShardMapManager
FORMS_DB=user id=$env:SQL_FORMS_USER;password=$env:SQL_FORMS_PASSWORD;data source=$env:SQL_SERVER;Initial Catalog=sitecore_ExperienceForms
FORMS_MASTER_DB=user id=$env:SQL_CORE_USER;password=$env:SQL_CORE_PASSWORD;data source=$env:SQL_SERVER;Initial Catalog=sitecore_EXM.Master
MARKETING_AUTOMATION_DB=user id=$env:SQL_MARKETING_AUTOMATION_USER;password=$env:SQL_MARKETING_AUTOMATION_PASSWORD;data source=$env:SQL_SERVER;Initial Catalog=sitecore_MarketingAutomation
MASTER_DB=user id=$env:SQL_MASTER_USER;password=$env:SQL_MASTER_PASSWORD;data source=$env:SQL_SERVER;Initial Catalog=sitecore_Master
MESSAGING_DB=user id=$env:SQL_MESSAGING_USER;password=$env:SQL_MESSAGING_PASSWORD;data source=$env:SQL_SERVER;Initial Catalog=sitecore_Messaging
SECURITY_DB=user id=$env:SQL_SECURITY_USER;password=$env:SQL_SECURITY_PASSWORD;data source=$env:SQL_SERVER;Initial Catalog=sitecore_Security
PROCESSING_POOLS_DB=user id=$env:SQL_PROCESSING_POOLS_USER;password=$env:SQL_PROCESSING_POOLS_PASSWORD;data source=$env:SQL_SERVER;Initial Catalog=sitecore_Processing.Pools
REFERENCE_DATA_DB=user id=$env:SQL_REFERENCE_USER;password=$env:SQL_REFERENCE_PASSWORD;data source=$env:SQL_SERVER;Initial Catalog=sitecore_ReferenceData
REPORTING_DB=user id=$env:SQL_REPORTING_USER;password=$env:SQL_REPORTING_PASSWORD;data source=$env:SQL_SERVER;Initial Catalog=sitecore_Reporting
TASKS_DB=user id=$env:SQL_PROCESSING_TASKS_USER;password=$env:SQL_PROCESSING_TASKS_PASSWORD;data source=$env:SQL_SERVER;Initial Catalog=sitecore_Processing.Tasks
WEB_DB=user id=$env:SQL_WEB_USER;password=$env:SQL_WEB_PASSWORD;data source=$env:SQL_SERVER;Initial Catalog=sitecore_Core
    " | Out-File "C:/EnvVarOutput/content-management.out"
}

