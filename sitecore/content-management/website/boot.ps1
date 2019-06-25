# The site name needs to match what was configured when the container was built
$SiteName = "local.sitecore.com"

. ./boot-utils.ps1

Ensure-Mount -Name 'Certificates'

Ensure-Env -Name 'CLIENT_CERT_THUMBPRINT'
Ensure-Env -Name 'CORE_DB'
Ensure-Env -Name 'EXM_MASTER_DB'
Ensure-Env -Name 'FORMS_DB'
Ensure-Env -Name 'HOST_NAME'
Ensure-Env -Name 'MASTER_DB'
Ensure-Env -Name 'MESSAGING_DB'
Ensure-Env -Name 'REFERENCE_DATA_DB'
Ensure-Env -Name 'REPORTING_API_KEY'
Ensure-Env -Name 'ROOT_CERT_PASSWORD'
Ensure-Env -Name 'SECURITY_DB'
Ensure-Env -Name 'SITE_CERT_PASSWORD'
Ensure-Env -Name 'TELERIK_UPLOAD_ENCRYPTION_KEY'
Ensure-Env -Name 'TELERIK_UPLOAD_HASH_KEY'
Ensure-Env -Name 'TELERIK_WEB_DIALOG_ENCRYPTION_KEY'
Ensure-Env -Name 'WEB_DB'

Ensure-Optional-Env -Name 'SOLR_SERVICE' -DefaultValue 'https://solr/solr'
Ensure-Optional-Env -Name 'STORE_PERF_COUNTERS_IN_APPLICATION_INSIGHTS' -DefaultValue 'false'
Ensure-Optional-Env -Name 'USE_APPLICATION_INSIGHTS' -DefaultValue 'false'
Ensure-Optional-Env -Name 'XCONNECT_COLLECTION_SERVICE' -DefaultValue 'https://xconnect-collection'
Ensure-Optional-Env -Name 'XCONNECT_MARKETING_AUTOMATION_SERVICE' -DefaultValue 'https://xconnect-marketing-automation'
Ensure-Optional-Env -Name 'XCONNECT_MARKETING_AUTOMATION_REPORTING_SERVICE' -DefaultValue 'https://xconnect-marketing-automation-reporting'
Ensure-Optional-Env -Name 'XCONNECT_REFERENCE_DATA_SERVICE' -DefaultValue 'https://xconnect-reference-data'

./update-config.ps1 -SiteName $SiteName
./update-site-bindings.ps1 -SiteName $SiteName

C:\ServiceMonitor.exe w3svc
