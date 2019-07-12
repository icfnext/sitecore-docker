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

Install-SitecoreConfiguration @XP1Parameters -Skip InstallWDPNoData *>&1 | Tee-Object xp-collection.log

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

function Create-SecretJson {
  param (
      [string] $Name, 
      [String] $Key, 
      [parameter(ValueFromPipeline)][string]$Value)

    $Base64String = [Convert]::ToBase64String([System.Text.Encoding]::Unicode.GetBytes($Value))
    return  "
    {
        `"apiVersion`"`: `"v1`",
        `"kind`"`: `"Secret`",
        `"metadata`"`: {
            `"name`"`: `"$Name`"
        },
        `"type`"`: `"Opaque`",
        `"stringData`"`: {
            `"config.yaml`"`: `"$Key`: $Base64String`"
        }
    }"
}

function Create-SqlConnectionString-Secret {
    param (
        [string] $Name, 
        [string] $Server, 
        [string] $UserName, 
        [string] $Password, 
        [string] $Catalog)

    return "user id=$UserName;password=$Password;data source=$Server;Initial Catalog=$Catalog"
}

$SecretJson = Create-SqlConnectionString-Secret `
    -Name $env:SQL_COLLECTION_USER `
    -Server $env:SQL_SERVER `
    -UserName $env:SQL_COLLECTION_USER `
    -Password $env:SQL_COLLECTION_PASSWORD `
    -Catalog 'sitecore_Xdb.Collection.ShardMapManager' `
    | Create-SecretJson -Name "collection-db" -Key "connectionString"

Write-Host $SecretJson

# Check if we are in k8s
if ( Test-Path "Env:/KUBERNETES_SERVICE_HOST" ) {
    #/var/run/secrets/kubernetes.io/serviceaccount/token
    #/var/run/secrets/kubernetes.io/serviceaccount/ca.crt
    #/var/run/secrets/kubernetes.io/serviceaccount/namespace

    $callback = {
        param(
            $sender,
            [System.Security.Cryptography.X509Certificates.X509Certificate]$certificate,
            [System.Security.Cryptography.X509Certificates.X509Chain]$chain,
            [System.Net.Security.SslPolicyErrors]$sslPolicyErrors
        )

        # No need to retype this long type name
        $CertificateType = [System.Security.Cryptography.X509Certificates.X509Certificate2]

        # Read the CA cert from file
        $CACert = $CertificateType::CreateFromCertFile('C:/var/run/secrets/kubernetes.io/serviceaccount/ca.crt') -as $CertificateType

        # Add the CA cert from the file to the ExtraStore on the Chain object
        $null = $chain.ChainPolicy.ExtraStore.Add($CACert)

        # return the result of chain validation
        return $chain.Build($certificate)
    }

    # Assign your delegate to the ServicePointManager callback
    [System.Net.ServicePointManager]::ServerCertificateValidationCallback = $callback

    $namespace = [IO.File]::ReadAllText('C:/var/run/secrets/kubernetes.io/serviceaccount/namespace')
    $token = [IO.File]::ReadAllText('C:/var/run/secrets/kubernetes.io/serviceaccount/token')

    Invoke-WebRequest `
        -Uri="https://$env:KUBERNETES_SERVICE_HOST:$env:KUBERNETES_SERVICE_PORT/api/v1/namespaces/$namespace/secrets" `
        -Method 'POST' `
        -Headers @{
            'Authorization'="Bearer $token";
            'Accept'='application/json';
            'Content-Type'='application/json'
        }
        -Body $SecretJson
}