Param(
    $SiteName = "xconnect-collection-search"
)

"<?xml version=`"1.0`" encoding=`"utf-16`"?>
<connectionStrings>
  <add name=`"xconnect.collection`" connectionString=`"$env:XCONNECT_COLLECTION_SEARCH_SERVICE`" />
  <add name=`"messaging`" connectionString=`"$env:MESSAGING_DB`" />
  <add name=`"xdb.marketingautomation`" connectionString=`"$env:MARKETING_AUTOMATION_DB`" />
  <add name=`"xdb.referencedata`" connectionString=`"$env:REFERENCE_DATA_DB`" />
  <add name=`"xconnect.collection.certificate`" connectionString=`"StoreName=My;StoreLocation=LocalMachine;FindType=FindByThumbprint;FindValue=$env:CLIENT_CERT_THUMBPRINT`" />
</connectionStrings>
" | Out-File C:/inetpub/wwwroot/$SiteName/App_Data/jobs/continuous/AutomationEngine/App_Config/ConnectionStrings.config

"<?xml version=`"1.0`" encoding=`"utf-16`"?>
<appSettings>
  <add key=`"configurationDirectoryRoot`" value=`"~/App_Data`" />
  <add key=`"configurationEnvironment`" value=`"$env:ENVIRONMENT_NAME`" />
  <add key=`"logDirectory`" value=`"App_Data/logs`" />
  <add key=`"AllowInvalidClientCertificates`" value=`"false`" />
  <add key=`"instanceName`" value=`"MarketingAutomation`" />
  <add key=`"AppInsightsKey`" value=`"$env:APP_INSIGHTS_KEY`" />
</appSettings>
" | Out-File C:/inetpub/wwwroot/$SiteName/App_Data/jobs/continuous/AutomationEngine/App_Config/AppSettings.config

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
  -xml C:/inetpub/wwwroot/$SiteName/App_Data/jobs/continuous/AutomationEngine/App_Data/Config/Sitecore/CoreServices/sc.Serilog.xml, `
  -xdt C:/install/serilog.xdt
