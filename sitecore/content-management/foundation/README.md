# XConnect Reference Data Service
This container holds the Sitecore xconnect makreting automation service running on port 443.

## Building the Reference Data Locally

Before building the container, copy a file named `license.xml` and `package.scwdp.zip` to this directory.  To build the container simply type

```docker build .```

## Building the Container in Azure Devops

The build steps are described in the file `azure-pipelines.yml`.  It builds the container and pushes it to an Azure Container Registry named `icfnext.azurecr.io`.

The Sitecore packages and license files are stored in Azure Devops Universal Artifacts.  To update the version of the packge that is build, update the the artifact in DevOps and then change the file name in yml file.

Builds to the registry are triggered off of commits to master.

## Running the container

The following environment variables and mount points are can be configured at runtime.

| Name                                             |Config Type| Required  | Description |
|---                                               |:-:        |:-:        |---          |
|`APP_INSIGHTS_KEY`                                | Env Var | No  | The instrumentation key for AppInsights, defaults to ''.| 
|`C:/Certificates`                                 | Mount   | Yes | A directory mounted to `C:/Certificates` that contains two pfx files, one named `root-cert` and the other that matches the value in `$HOST_NAME` |
|`CLIENT_CERT_THUMBPRINT`                          | Env Var | Yes | The Thumbprint XConnect Client Cert for validation.| 
|`CORE_DB`                                         | Env Var | Yes | The connection string for the core db. |
|`ENVIRONMENT_NAME`                                | Env Var | No  | A name for the environment, defaults to 'Development'. |
|`EXM_MASTER_DB`                                   | Env Var | Yes | The connection string for the exm master db. |
|`LOG_LEVEL`                                       | Env Var | No  | Sets the logging level, defaults to 'Information' |
|`FORMS_DB`                                        | Env Var | Yes | The connection string for the forms db. |
|`HOST_NAME`                                       | Env Var | Yes | The host name for the service to bind to.          |
|`MASTER_DB`                                       | Env Var | Yes | The connection string to the master db. |
|`REFERENCE_DATA_DB`                               | Env Var | Yes | The connection string to the reference data database. |
|`REPORTING_API_KEY`                               | Env Var | Yes | The api key for the marketing automation reporting service.|
|`ROOT_CERT_PASSWORD`                              | Env Var | Yes | The export password for the root cert. |
|`SECURITY_DB`                                     | Env Var | Yes | The connection string for the security db. |
|`SITE_CERT_PASSWORD`                              | Env Var | Yes | The export password for the website cert. |
|`SOLR_SERVICE`                                    | Env Var | No  | The url for the solr search service, defauls to 'https://solr:8983/solr' |
|`STORE_PERF_COUNTERS_IN_APPLICATION_INSIGHTS`     | Env Var | No  | Should we store perf counters in app insights? Defaults to 'false' |
|`TELERIK_UPLOAD_ENCRYPTION_KEY`                   | Env Var | Yes | Unsure |
|`TELERIK_UPLOAD_HASH_KEY`                         | Env Var | Yes | Unsure |
|`TELERIK_WEB_DIALOG_ENCRYPTION_KEY`               | Env Var | Yes | Unsure |
|`USE_APPLICATION_INSIGHTS`                        | Env Var | No  | Indicates if we should use application insights, defaults to 'false' |
|`WEB_DB`                                          | Env Var | Yes | The connection string for the web db. |
|`XCONNECT_COLLECTION_SERVICE`                     | Env Var | No  | The url for the xconnect collection service, defaults to 'https://xconnect-collection' |
|`XCONNECT_MARKETING_AUTOMATION_SERVICE`           | Env Var | No  | The url for the xconnect marketing automation service, defaults to 'https://xconnect-marketing-automation' |
|`XCONNECT_MARKETING_AUTOMATION_REPORTING_SERVICE` | Env Var | No  | The url for the xconnect marketing automation reporting service, defaults to 'https://xconnect-marketing-automation-reporting' |
|`XCONNECT_REFERENCE_DATA_SERVICE`                 | Env Var | No  | The url for the xconnect collection reference data service, defaults to 'https://xconnect-reference-data' |

*Note*: The `LOG_LEVEL` setting is not working in the current build.