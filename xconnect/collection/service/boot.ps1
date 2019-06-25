# The site name needs to match what was configured when the container was built
$SiteName = "xconnect-collection"

. ./boot-utils.ps1

Ensure-Mount -Name 'Certificates'

Ensure-Env -Name 'CLIENT_CERT_THUMBPRINT'
Ensure-Env -Name 'COLLECTION_DB'
Ensure-Env -Name 'HOST_NAME'
Ensure-Env -Name 'MARKETING_AUTOMATION_DB'
Ensure-Env -Name 'MESSAGING_DB'
Ensure-Env -Name 'PROCESSING_POOLS_DB'
Ensure-Env -Name 'ROOT_CERT_PASSWORD'
Ensure-Env -Name 'SITE_CERT_PASSWORD'

Ensure-Optional-Env -Name 'APP_INSIGHTS_KEY' -DefaultValue ''
Ensure-Optional-Env -Name 'ENVIRONMENT_NAME' -DefaultValue 'Development'
Ensure-Optional-Env -Name 'LOG_LEVEL' -DefaultValue 'Information'

./update-config.ps1 -SiteName $SiteName
./update-site-bindings.ps1 -SiteName $SiteName

C:\ServiceMonitor.exe w3svc
