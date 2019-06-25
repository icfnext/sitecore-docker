Param(
    $SiteName = "local.sitecore.com"
)

"<?xml version=`"1.0`" encoding=`"utf-16`"?>
<connectionStrings>
  <!-- 
    Sitecore connection strings.
    All database connections for Sitecore are configured here.
  -->
  <add name=`"core`" connectionString=`"$env:CORE_DB`" />
  <add name=`"security`" connectionString=`"$env:SECURITY_DB`" />
  <add name=`"master`" connectionString=`"$env:MASTER_DB`" />
  <add name=`"web`" connectionString=`"$env:WEB_DB`" />
  <add name=`"reporting.apikey`" connectionString=`"$env:REPORTING_API_KEY`" />
  <add name=`"messaging`" connectionString=`"$env:MESSAGING_DB`" />
  <add name=`"xdb.referencedata`" connectionString=`"$env:REFERENCE_DATA_DB`" />
  <add name=`"experienceforms`" connectionString=`"$env:FORMS_DB`" />
  <add name=`"exm.master`" connectionString=`"$env:EXM_MASTER_DB`" />
  <add name=`"sitecore.reporting.client`" connectionString=`"https://CortexReporting`" />
  <add name=`"sitecore.reporting.client.certificate`" connectionString=`"StoreName=My;StoreLocation=LocalMachine;FindType=FindByThumbprint;FindValue=$env:CLIENT_CERT_THUMBPRINT`" />
  <add name=`"solr.search`" connectionString=`"$env:SOLR_SERVICE`" />
  <add name=`"sitecoreidentity.secret`" connectionString=`"`" />
  <add name=`"xconnect.collection`" connectionString=`"$env:XCONNECT_COLLECTION_SERVICE`" />
  <add name=`"xconnect.collection.certificate`" connectionString=`"StoreName=My;StoreLocation=LocalMachine;FindType=FindByThumbprint;FindValue=$env:CLIENT_CERT_THUMBPRINT`" />
  <add name=`"xdb.marketingautomation.operations.client`" connectionString=`"$env:XCONNECT_MARKETING_AUTOMATION_SERVICE`" />
  <add name=`"xdb.marketingautomation.operations.client.certificate`" connectionString=`"StoreName=My;StoreLocation=LocalMachine;FindType=FindByThumbprint;FindValue=$env:CLIENT_CERT_THUMBPRINT`" />
  <add name=`"xdb.marketingautomation.reporting.client`" connectionString=`"$env:XCONNECT_MARKETING_AUTOMATION_REPORTING_SERVICE`" />
  <add name=`"xdb.marketingautomation.reporting.client.certificate`" connectionString=`"StoreName=My;StoreLocation=LocalMachine;FindType=FindByThumbprint;FindValue=$env:CLIENT_CERT_THUMBPRINT`" />
  <add name=`"xdb.referencedata.client`" connectionString=`"$env:XCONNECT_REFERENCE_DATA_SERVICE`" />
  <add name=`"xdb.referencedata.client.certificate`" connectionString=`"StoreName=My;StoreLocation=LocalMachine;FindType=FindByThumbprint;FindValue=$env:CLIENT_CERT_THUMBPRINT`" />
  <add name=`"PackageManagementServiceUrl`" connectionString=`"https://updatecenter.cloud.sitecore.net/`" />
  <add name=`"EXM.CryptographicKey`" connectionString=`"SIF-Default`" />
  <add name=`"EXM.AuthenticationKey`" connectionString=`"SIF-Default`" />
  <add name=`"appinsights.instrumentationkey`" connectionString=`"$env:APP_INSIGHTS_KEY`" />
  <add name=`"cloud.search`" connectionString=`"`" />
</connectionStrings>
" | Out-File C:/inetpub/wwwroot/$SiteName/App_Config/ConnectionStrings.config

"<?xml version=`"1.0`" encoding=`"utf-16`"?>
<configuration xmlns:xdt=`"http://schemas.microsoft.com/XML-Document-Transform`">
  <appSettings>
    <add key=`"Telerik.AsyncUpload.ConfigurationEncryptionKey`" xdt:Transform=`"Remove`" xdt:Locator=`"Match(key)`"/>
    <add key=`"Telerik.AsyncUpload.ConfigurationEncryptionKey`" value=`"$env:TELERIK_UPLOAD_ENCRYPTION_KEY`" xdt:Transform=`"SetAttributes`" xdt:Locator=`"Match(key)`"/>

    <add key=`"Telerik.Upload.ConfigurationHashKey`" xdt:Transform=`"Remove`" xdt:Locator=`"Match(key)`"/>
    <add key=`"Telerik.Upload.ConfigurationHashKey`" value=`"$env:TELERIK_UPLOAD_HASH_KEY`" xdt:Transform=`"SetAttributes`" xdt:Locator=`"Match(key)`"/>

    <add key=`"Telerik.Web.UI.DialogParametersEncryptionKey`" xdt:Transform=`"Remove`" xdt:Locator=`"Match(key)`"/>
    <add key=`"Telerik.Web.UI.DialogParametersEncryptionKey`" value=`"$env:TELERIK_WEB_DIALOG_ENCRYPTION_KEY`" xdt:Transform=`"SetAttributes`" xdt:Locator=`"Match(key)`"/>

    <add key=`"storeSitecoreCountersInApplicationInsights:define`" xdt:Transform=`"Remove`" xdt:Locator=`"Match(key)`"/>
    <add key=`"storeSitecoreCountersInApplicationInsights:define`" value=`"$env:STORE_PERF_COUNTERS_IN_APPLICATION_INSIGHTS`" xdt:Transform=`"SetAttributes`" xdt:Locator=`"Match(key)`"/>

    <add key=`"useApplicationInsights:define`" xdt:Transform=`"Remove`" xdt:Locator=`"Match(key)`"/>
    <add key=`"useApplicationInsights:define`" value=`"$env:USE_APPLICATION_INSIGHTS`" xdt:Transform=`"SetAttributes`" xdt:Locator=`"Match(key)`"/>
  </appSettings>
<configuration>
" | Out-File C:/install/app-settings.xdt

./xml-transform `
  -xml C:/inetpub/wwwroot/$SiteName/web.config, `
  -xdt C:/install/app-settings.xdt

"<configuration xmlns:patch=`"http://www.sitecore.net/xmlconfig/`">
  <sitecore>
    <sc.variable name=`"dataFolder`">
      <patch:attribute name=`"value`">C:\inetpub\wwwroot\$SiteName\App_Data</patch:attribute>
    </sc.variable>
  </sitecore>
</configuration>
" | Out-File C:/inetpub/wwwroot/$SiteName/App_Config/Sitecore/Azure/Sitecore.Common.DataFolder.config


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
