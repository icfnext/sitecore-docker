# XConnect Collection Service
This container holds the Sitecore xconnect collection service running on port 443.

## Building the Container Locally

Before building the container, copy a file named `license.xml` and `package.scwdp.zip` to this directory.  To build the container simply type

```docker build .```

## Building the Container in Azure Devops

The build steps are described in the file `azure-pipelines.yml`.  It builds the container and pushes it to an Azure Container Registry named `icfnext.azurecr.io`.

The Sitecore packages and license files are stored in Azure Devops Universal Artifacts.  To update the version of the packge that is build, update the the artifact in DevOps and then change the file name in yml file.

Builds to the registry are triggered off of commits to master.

## Running the container

The following environment variables and mount points are can be configured at runtime.

| Name                    |Config Type| Required  | Description |
|---                      |:-:        |:-:        |---          |
|`APP_INSIGHTS_KEY`       | Env Var | No  | The instrumentation key for AppInsights, defaults to ''.| 
|`C:/Certificates`        | Mount   | Yes | A directory mounted to `C:/Certificates` that contains two pfx files, one named `root-cert` and the other that matches the value in `$HOST_NAME` |
|`CLIENT_CERT_THUMBPRINT` | Env Var | Yes | The Thumbprint XConnect Client Cert for validation.| 
|`COLLECTION_DB`          | Env Var | Yes | The connection string to the collection database.  |
|`ENVIRONMENT_NAME`       | Env Var | No  | A name for the environment, defaults to 'Development'. |
|`LOG_LEVEL`              | Env Var | No  | Sets the logging level, defaults to 'Information' |
|`HOST_NAME`              | Env Var | Yes | The host name for the service to bind to.          |
|`MARKETING_AUTOMATION_DB`| Env Var | Yes | The connection string to the marketing automation database. |
|`MESSAGING_DB`          | Env Var | Yes | The connection string to the messaging database.   |
|`PROCESSING_POOLS_DB`    | Env Var | Yes | The connection string to the processing pools database. |
|`ROOT_CERT_PASSWORD`     | Env Var | Yes | The export password for the root cert. |
|`SITE_CERT_PASSWORD`     | Env Var | Yes | The export password for the website cert. |

*Note*: The `LOG_LEVEL` setting is not working in the current build.