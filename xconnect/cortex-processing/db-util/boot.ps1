$SiteName = "xconnect-cortex-processing"

. ./boot-utils.ps1

Ensure-Env -Name 'SQL_SERVER'
Ensure-Env -Name 'SQL_ADMIN_USER'
Ensure-Env -Name 'SQL_ADMIN_PASSWORD'

Ensure-Optional-Env -Name 'XCONNECT_COLLECTION_SERVICE' -DefaultValue 'XCONNECT_COLLECTION_SERVICE'
Ensure-Optional-Env -Name 'XCONNECT_COLLECTION_SEARCH_SERVICE' -DefaultValue 'XCONNECT_COLLECTION_SEARCH_SERVICE'

Ensure-Optional-Env -Name 'SQL_MESSAGING_USER' -DefaultValue 'messaging-user'
Ensure-Optional-Env -Name 'SQL_PROCESSING_ENGINE_USER' -DefaultValue 'processing-engine-user'
Ensure-Optional-Env -Name 'SQL_REPORTING_USER' -DefaultValue 'reporting-user'

Ensure-Optional-Env -Name 'SQL_MESSAGING_PASSWORD' -DefaultValue 'P@ssW0rd123'
Ensure-Optional-Env -Name 'SQL_PROCESSING_ENGINE_PASSWORD' -DefaultValue 'P@ssW0rd123'
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

    SqlMessagingUser = $env:SQL_MESSAGING_USER
    SqlMessagingPassword = $env:SQL_MESSAGING_PASSWORD

    SqlProcessingEngineUser = $env:SQL_PROCESSING_ENGINE_USER
    SqlProcessingEnginePassword = $env:SQL_PROCESSING_ENGINE_PASSWORD

    SqlReportingUser = $env:SQL_REPORTING_USER
    SqlReportingPassword = $env:SQL_REPORTING_PASSWORD

    XConnectCollectionService = $env:XCONNECT_COLLECTION_SERVICE
    XConnectSearchService = $env:XCONNECT_COLLECTION_SEARCH_SERVICE

    MachineLearningServerUrl = 'MACHINE_LEARNING_SERVER_URL'
    MachineLearningServerBlobEndpointCertificatePath = 'MACHINE_LEARNING_BLOB_ENDPOINT_CERT_PATH'
    MachineLearningServerBlobEndpointCertificatePassword = 'MACHINE_LEARNING_BLOB_ENDPOINT_CERT_PASSWORD'
    MachineLearningServerTableEndpointCertificatePath = 'MACHINE_LEARNING_TABLE_ENDPOINT_CERT_PATH'
    MachineLearningServerTableEndpointCertificatePassword = 'MACHINE_LEARNING_TABLE_ENDPOINT_CERT_PASSWORD'
    MachineLearningServerEndpointCertificationAuthorityCertificatePath = 'MACHINE_LEARNING_ENDPOINT_AUTHORITY_CERT_PASSWORD'
}

#-Skip InstallWDPNoData

Install-SitecoreConfiguration @XP1Parameters *>&1 | Tee-Object xp-collection.log
