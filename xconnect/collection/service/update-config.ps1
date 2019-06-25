Param(
    $SiteName = "xconnect-collection"
)

"<?xml version=`"1.0`" encoding=`"utf-16`"?>
<connectionStrings>
  <add name=`"messaging`" connectionString=`"$env:MESSAGING_DB`" />
  <add name=`"xdb.marketingautomation`" connectionString=`"$env:MARKETING_AUTOMATION_DB`" />
  <add name=`"xdb.processing.pools`" connectionString=`"$env:PROCESSING_POOLS_DB`" />
  <add name=`"collection`" connectionString=`"$env:COLLECTION_DB`" />
</connectionStrings>
" | Out-File C:/inetpub/wwwroot/$SiteName/App_Config/ConnectionStrings.config

"<?xml version=`"1.0`" encoding=`"utf-16`"?>
<appSettings>
  <add key=`"configurationDirectoryRoot`" value=`"~/App_Data`" />
  <add key=`"configurationEnvironment`" value=`"$env:ENVIRONMENT_NAME`" />
  <add key=`"AllowInvalidClientCertificates`" value=`"false`" />
  <add key=`"validateCertificateThumbprint`" value=`"$env:CLIENT_CERT_THUMBPRINT`" />
  <add key=`"AppInsightsKey`" value=`"$env:APP_INSIGHTS_KEY`" />
</appSettings>
" | Out-File C:/inetpub/wwwroot/$SiteName/App_Config/AppSettings.config

"<?xml version=`"1.0`" encoding=`"utf-16`"?>
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
