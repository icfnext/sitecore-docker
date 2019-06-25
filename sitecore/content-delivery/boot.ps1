# The site name needs to match what was configured when the container was built
$SiteName = "local.sitecore.com"

if ( -not (Test-Path C:/Certificates) ) 
{
    throw 'C:/Certificates mount point is required.'
}

if ( -not (Test-Path Env:/CLIENT_CERT_THUMBPRINT) ) 
{
    throw 'Environment Variablbe CLIENT_CERT_THUMBPRINT is required'
}

if ( -not (Test-Path Env:/XCONNECT_COLLECTION_SEARCH_SERVICE) ) 
{
    throw 'Environment Variablbe XCONNECT_COLLECTION_SEARCH_SERVICE is required'
}

if ( -not (Test-Path Env:/HOST_NAME) ) 
{
    throw 'Environment Variablbe HOST_NAME is required'
}

if ( -not (Test-Path Env:/MARKETING_AUTOMATION_DB) ) 
{
    throw 'Environment Variablbe MARKETING_AUTOMATION_DB is required'
}

if ( -not (Test-Path Env:/MESSAGING_DB) ) 
{
    throw 'Environment Variablbe MESSAGING_DB is required'
}

if ( -not (Test-Path Env:/REFERENCE_DATA_DB) ) 
{
    throw 'Environment Variablbe REFERENCE_DATA_DB is required'
}

./re-configure.ps1 -SiteName $SiteName
./update-site-bindings.ps1 -SiteName $SiteName

C:\ServiceMonitor.exe w3svc
