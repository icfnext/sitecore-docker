
if ( -not (Test-Path Env:\EXPORT_PASSWORD) ) {
    throw "env EXPORT_PASSWORD required when creating certs"
}

if ( -not (Test-Path C:\Certificates) ) {
    throw "C:\Certificates moun required when creating certs"
}

$XConnectClientCertificateName = "xconnect-client"

$params = @{
    CertificateName = "local.sitecore.com"
    IdentityServerCertificateName = "identity-server"
    XConnectCertificateName = "xconnect"
    ExportPassword = $env:EXPORT_PASSWORD
    Path = ".\sif-params.json"
    XConnectClientCertificateName = $XConnectClientCertificateName
}

Install-SitecoreConfiguration @params *>&1 | Tee-Object create-cert.log

(Get-ChildItem -Path Cert:\LocalMachine\My | where-object { $_.Subject -like "*CN=$XConnectClientCertificateName*" }).Thumbprint | Out-File -FilePath C:/Certificates/xconnect-client-thumbprint.txt
