Param(
    $SiteName = "local.sitecore.com"
)

# This feels backwards but we need it this way for runtime override
if ( -not (Test-Path Env:\ENVIRONMENT_NAME) ) {
    $env:ENVIRONMENT_NAME = "Development"
}

if ( -not (Test-Path Env:\LOG_LEVEL) ) {
    $env:LOG_LEVEL = "Information"
}

Write-Host "
<?xml version="1.0" encoding="utf-8"?>
<connectionStrings>
  <add name=`"xdb.referencedata`" connectionString=`"$env:REFERENCE_DATA_DB`" />
</connectionStrings>
" | Out-File C:/inetpub/wwwroot/$SiteName/App_Config/ConnectionStrings.config

Write-Host "
<?xml version="1.0" encoding="utf-8"?>
<appSettings>
  <add key=`"configurationDirectoryRoot`" value=`"~/App_Data`" />
  <add key=`"configurationEnvironment`" value=`"$env:ENVIRONMENT_NAME`" />
  <add key=`"AllowInvalidClientCertificates`" value=`"false`" />
  <add key=`"validateCertificateThumbprint`" value=`"$env:CLIENT_CERT_THUMBPRINT`" />
  <add key=`"AppInsightsKey`" value=`"$env:APP_INSIGHTS_KEY`" />
</appSettings>

" | Out-File C:/inetpub/wwwroot/$SiteName/App_Config/AppSettings.config

Write-Host "
<?xml version="1.0" encoding="utf-8"?>
<Settings xmlns:xdt=`"http://schemas.microsoft.com/XML-Document-Transform`">
  <Serilog>
    <MinimumLevel>
      <Default xdt:Transform=`"Remove`"></Default>
      <Default xdt:Transform=`"Insert`">$env:LOG_LEVEL</Default>
    </MinimumLevel>
  </Serilog>
</Settings>
" | Out-File C:/install/serilog.xdt

./xml-transform `
  -xml C:/inetpub/wwwroot/$SiteName/App_Data/Config/Sitecore/CoreServices/sc.Serilog.xml, `
  -xdt C:/install/serilog.xdt