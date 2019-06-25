Param(
    $CertificateFile = "",
    $Secret = "",
    $StoreName = "Root",
    $StoreLocation = "LocalMachine"
)

$pwd = ConvertTo-SecureString -String $Secret -Force -AsPlainText; `
Import-PfxCertificate -FilePath $CertificateFile -CertStoreLocation Cert:\$StoreLocation\$StoreName -Password $pwd
