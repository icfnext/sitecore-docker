Param(
    $SiteName
)

if ( !$SiteName ) 
{
    throw 'SiteName is required'
}

New-WebBinding -name $SiteName -Protocol https -HostHeader $env:HOST_NAME -Port 443 -SslFlags 1

./import-cert.ps1 -CertificateFile "c:/certificates/root-cert.pfx" -Secret $env:ROOT_CERT_PASSWORD
./import-cert.ps1 -CertificateFile "c:/certificates/$env:HOST_NAME.pfx" -Secret $env:SITE_CERT_PASSWORD -storeName "My"

Get-ChildItem -Path Cert:\LocalMachine\My | where-object { $_.Subject -like "*CN=$env:HOST_NAME*" } | new-item iis:\SslBindings\0.0.0.0!443

Start-WebSite -Name $SiteName